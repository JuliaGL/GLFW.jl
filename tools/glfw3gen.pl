#!/usr/bin/perl

my $lib = "libglfw3";
my $what = "?";
my %ali;
my %imm;

sub marshal_type {
	my $t = $_[0] =~ s/^\s+//r;
	my $x;

	$t =~ s/^(const\s+)?void/Void/;
	$t =~ s/^(const\s+)?int/Cint/;
	$t =~ s/^(const\s+)?unsigned int/Cuint/;
	$t =~ s/^(const\s+)?short/Cshort/;
	$t =~ s/^(const\s+)?unsigned short/Cushort/;
	$t =~ s/^(const\s+)?long long/Clonglong/;
	$t =~ s/^(const\s+)?unsigned long long/Culonglong/;
	$t =~ s/^(const\s+)?long/Clong/;
	$t =~ s/^(const\s+)?unsigned long/Culong/;
	$t =~ s/^(const\s+)?float/Cfloat/;
	$t =~ s/^(const\s+)?double/Cdouble/;
	$t =~ s/^(const\s+)?(unsigned\s+)?char/Cuchar/;

	if ($t =~ /(\w+)\*/) {
		if (exists $ali{$1}) {
			$x = $ali{$1};
			$t =~ s/\s*$1\*/$x/x;
		}
	}

	$t =~ s/^(const\s+)?GLFW\w+(fun|\*)/Ptr{Void}/;

	if ($t =~ /^([\w\s]+)\*/) {
		$t = "Ptr{$1}";
	}

	return $t;
}

sub julia_type {
	my $t = $_[0] =~ s/^\s+//r;

	$t =~ s/^const\s+//;

	$t =~ s/^int/Integer/;
	$t =~ s/^float/FloatingPoint/;
	$t =~ s/^double/FloatingPoint/;
	$t =~ s/^(const\s+)?char\s*\*/String/;
	$t =~ s/^\w+fun/Function/;

	if ($t =~ /(\w+)\*/) {
		if (exists $ali{$1}) {
			my $x = $ali{$1};
			$t =~ s/\s*$1\*/$x/x;
		} elsif (exists $imm{$1}) {
			my $x = $imm{$1};
			$t =~ s/\s*$1\*/$x/x;
		} else {
			$t = marshal_type($t);
		}
	}

	return $t;
}

print "\nmodule GLFW3\n";

while (<>) {
	if ($str) {
		if ($_ =~ /^\s*}\s+$str\s*;\s*$/x) {
			print "end\n";
			$str = "";
		} elsif ($_ =~ /^\s*([\w\s\*]+)\s+(\w+)\s*;\s*$/) {
			my $n = $2;
			my $r = marshal_type($1);

			print "\t${n}::$r\n";
		}
	} elsif ($_ =~ /^typedef\s+struct\s+(\w+)\s*$/) {
		$what = "i";
		$str = $1;

		my $m = $1;
		my $n = ucfirst($m =~ s/^GLFW//r);
		$imm{"$m"} = $n;
		print "\nimmutable $n\n";
	} elsif ($_ =~ /^typedef\s+struct\s+GLFW(\w+)\s+\w+\s*;\s*$/) {
		print "\n" if ($what ne "a");
		$what = 'a';

		$ali{"GLFW$1"} = ucfirst($1);
		print "typealias ".ucfirst($1)." Ptr{Void}\n";
	} elsif ($_ =~ /^typedef\s+(\w+)\s+\(\s*\*\s*(\w+)\)\s*\(([^\)]+)\)\s*;\s*$/) {
		$what = 'm';

		my $r = $1;
		my $n = $2;
		my $a = $3;
		my @av = ();

		if ($a ne "void") {
			foreach $i (split(',', $a)) {
				push(@av, marshal_type($i));
			}
		}

		print "\nmacro ".($n =~ s/^GLFW//r)."(cb)\n";
		print "\t:(cfunction(\$cb, ".marshal_type($r).", (".join(', ', @av).")))\n";
		print "end\n";

	} elsif ($_ =~ /^#define\s+(\w+)\s+(\w+)\s*$/) {
		print "\n" if ($what ne "c");
		$what = "c";

		my $a = $1;
		my $b = $2;

		print "const ".($a =~ s/GLFW_//r)." = ".($b =~ s/GLFW_//r)."\n";
	} elsif ($_ =~ /^GLFWAPI\s+([^\s]+)\s+(\w+)\(([^\)]+)\)\s*;\s*$/) {
		$what = 'f';

		my $r = $1 =~ s/^\s+|\s+$//r;
		my $n = $2 =~ s/^\s+|\s+$//r;
		my $a = $3 =~ s/^\s+|\s+$//r;
		my @av = ();
		my @mav = ();
		my @riv = ();
		my @rav = ();

		if ($a ne "void") {
			foreach $i (split(',', $a)) {
				push(@riv, scalar @av) if (julia_type($i) =~ /Ptr{[\w\{\}]+}/);
				push(@av, $i);
				push(@mav, marshal_type($i) =~ s/\s*\w+$//r);
			}
		}

		if (scalar @riv > 1) {
			foreach $i (reverse @riv) {
				unshift(@rav, $av[$i]);
				splice(@av, $i, 1);
			}
		} elsif ($r =~ /\*/ && @riv == 1) {
			my $i = $riv[0];
			unshift(@rav, $av[$i]);
			splice(@av, $i, 1);
		}

		print "\nfunction ".($n =~ s/^glfw//r);
		print "(".join(', ', map {/^(.+)\s+(\w+)$/ ? "$2::".julia_type($1) : "?"} @av).")\n";

		if (scalar @rav > 0) {
			foreach $i (@rav) {
				$i =~ /^(.+)\s*\*\s*(\w+)$/;
				print "\t$2 = ".marshal_type($1)."[0]\n";
			}
		}

		if (scalar @rav == 0 && $r ne "void") {
			print "\treturn ";
		} elsif (scalar @rav == 1 && $r =~ /\*/) {
			print "\tr = ";
		} else {
			print "\t";
		}

		print "ccall((:$n, \"$lib\"), ".marshal_type($r);
		print ", (".(join(', ', @mav) =~ s/^([A-Za-z0-9\{\}]+)$/\1,/r).")";

		if ($a ne "void") {
			foreach $i (@av) {
				print ', ';

				if ($i =~ /^\s*GLFW(\w+fun)\s+(\w+$)/) {
					print "\@$1($2)";
				} elsif ($i =~ /char\s*\*\s*(\w+)/) {
					print "bytestring($1)";
				} elsif ($i =~ /^\s*const\s+\w+\s*\*\s*(\w+)$/) {
					print "&$1";
				} elsif ($i =~ /(\w+)$/) {
					print $1;
				}
			}

			foreach $i (@rav) {
				print ', ';

				if ($i =~ /(\w+)$/) {
					print $1;
				}
			}
		}

		print ")\n";

		if (scalar @rav > 0) {
			print "\treturn (".join(', ', map {/(\w+)$/ ? $1 : ''} @rav).")\n";
		}

		print "end\n";
	}
}

print "\nend # module\n";

