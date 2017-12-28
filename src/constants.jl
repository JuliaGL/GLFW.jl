#************************************************************************
# Global definitions
#************************************************************************

# Key and button actions
const RELEASE                = 0
const PRESS                  = 1
const REPEAT                 = 2

# Unknown key
const KEY_UNKNOWN            = -1

# Printable keys
const KEY_SPACE              = 32
const KEY_APOSTROPHE         = 39  # '
const KEY_COMMA              = 44  # ,
const KEY_MINUS              = 45  # -
const KEY_PERIOD             = 46  # .
const KEY_SLASH              = 47  # /
const KEY_0                  = 48
const KEY_1                  = 49
const KEY_2                  = 50
const KEY_3                  = 51
const KEY_4                  = 52
const KEY_5                  = 53
const KEY_6                  = 54
const KEY_7                  = 55
const KEY_8                  = 56
const KEY_9                  = 57
const KEY_SEMICOLON          = 59  # ;
const KEY_EQUAL              = 61  # =
const KEY_A                  = 65
const KEY_B                  = 66
const KEY_C                  = 67
const KEY_D                  = 68
const KEY_E                  = 69
const KEY_F                  = 70
const KEY_G                  = 71
const KEY_H                  = 72
const KEY_I                  = 73
const KEY_J                  = 74
const KEY_K                  = 75
const KEY_L                  = 76
const KEY_M                  = 77
const KEY_N                  = 78
const KEY_O                  = 79
const KEY_P                  = 80
const KEY_Q                  = 81
const KEY_R                  = 82
const KEY_S                  = 83
const KEY_T                  = 84
const KEY_U                  = 85
const KEY_V                  = 86
const KEY_W                  = 87
const KEY_X                  = 88
const KEY_Y                  = 89
const KEY_Z                  = 90
const KEY_LEFT_BRACKET       = 91  # [
const KEY_BACKSLASH          = 92  # \
const KEY_RIGHT_BRACKET      = 93  # ]
const KEY_GRAVE_ACCENT       = 96  # `
const KEY_WORLD_1            = 161 # non-US #1
const KEY_WORLD_2            = 162 # non-US #2

# Function keys
const KEY_ESCAPE             = 256
const KEY_ENTER              = 257
const KEY_TAB                = 258
const KEY_BACKSPACE          = 259
const KEY_INSERT             = 260
const KEY_DELETE             = 261
const KEY_RIGHT              = 262
const KEY_LEFT               = 263
const KEY_DOWN               = 264
const KEY_UP                 = 265
const KEY_PAGE_UP            = 266
const KEY_PAGE_DOWN          = 267
const KEY_HOME               = 268
const KEY_END                = 269
const KEY_CAPS_LOCK          = 280
const KEY_SCROLL_LOCK        = 281
const KEY_NUM_LOCK           = 282
const KEY_PRINT_SCREEN       = 283
const KEY_PAUSE              = 284
const KEY_F1                 = 290
const KEY_F2                 = 291
const KEY_F3                 = 292
const KEY_F4                 = 293
const KEY_F5                 = 294
const KEY_F6                 = 295
const KEY_F7                 = 296
const KEY_F8                 = 297
const KEY_F9                 = 298
const KEY_F10                = 299
const KEY_F11                = 300
const KEY_F12                = 301
const KEY_F13                = 302
const KEY_F14                = 303
const KEY_F15                = 304
const KEY_F16                = 305
const KEY_F17                = 306
const KEY_F18                = 307
const KEY_F19                = 308
const KEY_F20                = 309
const KEY_F21                = 310
const KEY_F22                = 311
const KEY_F23                = 312
const KEY_F24                = 313
const KEY_F25                = 314
const KEY_KP_0               = 320
const KEY_KP_1               = 321
const KEY_KP_2               = 322
const KEY_KP_3               = 323
const KEY_KP_4               = 324
const KEY_KP_5               = 325
const KEY_KP_6               = 326
const KEY_KP_7               = 327
const KEY_KP_8               = 328
const KEY_KP_9               = 329
const KEY_KP_DECIMAL         = 330
const KEY_KP_DIVIDE          = 331
const KEY_KP_MULTIPLY        = 332
const KEY_KP_SUBTRACT        = 333
const KEY_KP_ADD             = 334
const KEY_KP_ENTER           = 335
const KEY_KP_EQUAL           = 336
const KEY_LEFT_SHIFT         = 340
const KEY_LEFT_CONTROL       = 341
const KEY_LEFT_ALT           = 342
const KEY_LEFT_SUPER         = 343
const KEY_RIGHT_SHIFT        = 344
const KEY_RIGHT_CONTROL      = 345
const KEY_RIGHT_ALT          = 346
const KEY_RIGHT_SUPER        = 347
const KEY_MENU               = 348
const KEY_LAST               = KEY_MENU

# Modifier key bit flags
const MOD_SHIFT              = 0x0001
const MOD_CONTROL            = 0x0002
const MOD_ALT                = 0x0004
const MOD_SUPER              = 0x0008

# Mouse buttons
const MOUSE_BUTTON_1         = 0
const MOUSE_BUTTON_2         = 1
const MOUSE_BUTTON_3         = 2
const MOUSE_BUTTON_4         = 3
const MOUSE_BUTTON_5         = 4
const MOUSE_BUTTON_6         = 5
const MOUSE_BUTTON_7         = 6
const MOUSE_BUTTON_8         = 7
const MOUSE_BUTTON_LAST      = MOUSE_BUTTON_8
const MOUSE_BUTTON_LEFT      = MOUSE_BUTTON_1
const MOUSE_BUTTON_RIGHT     = MOUSE_BUTTON_2
const MOUSE_BUTTON_MIDDLE    = MOUSE_BUTTON_3

# Joysticks
const JOYSTICK_1             = 0
const JOYSTICK_2             = 1
const JOYSTICK_3             = 2
const JOYSTICK_4             = 3
const JOYSTICK_5             = 4
const JOYSTICK_6             = 5
const JOYSTICK_7             = 6
const JOYSTICK_8             = 7
const JOYSTICK_9             = 8
const JOYSTICK_10            = 9
const JOYSTICK_11            = 10
const JOYSTICK_12            = 11
const JOYSTICK_13            = 12
const JOYSTICK_14            = 13
const JOYSTICK_15            = 14
const JOYSTICK_16            = 15
const JOYSTICK_LAST          = JOYSTICK_16

# Error codes
@enum(ErrorCode,
	NOT_INITIALIZED        = 0x00010001,  # GLFW has not been initialized.
	NO_CURRENT_CONTEXT     = 0x00010002,  # No context is current for this thread.
	INVALID_ENUM           = 0x00010003,  # One of the arguments to the function was an invalid enum value.
	INVALID_VALUE          = 0x00010004,  # One of the arguments to the function was an invalid value.
	OUT_OF_MEMORY          = 0x00010005,  # A memory allocation failed.
	API_UNAVAILABLE        = 0x00010006,  # GLFW could not find support for the requested API on the system.
	VERSION_UNAVAILABLE    = 0x00010007,  # The requested OpenGL or OpenGL ES version is not available.
	PLATFORM_ERROR         = 0x00010008,  # A platform-specific error occurred that does not match any of the more specific categories.
	FORMAT_UNAVAILABLE     = 0x00010009,  # The requested format is not supported or available.
	NO_WINDOW_CONTEXT      = 0x0001000A   # The specified window does not have an OpenGL or OpenGL ES context.
)

const FOCUSED                = 0x00020001
const ICONIFIED              = 0x00020002
const RESIZABLE              = 0x00020003
const VISIBLE                = 0x00020004
const DECORATED              = 0x00020005
const AUTO_ICONIFY           = 0x00020006
const FLOATING               = 0x00020007

const RED_BITS               = 0x00021001
const GREEN_BITS             = 0x00021002
const BLUE_BITS              = 0x00021003
const ALPHA_BITS             = 0x00021004
const DEPTH_BITS             = 0x00021005
const STENCIL_BITS           = 0x00021006
const ACCUM_RED_BITS         = 0x00021007
const ACCUM_GREEN_BITS       = 0x00021008
const ACCUM_BLUE_BITS        = 0x00021009
const ACCUM_ALPHA_BITS       = 0x0002100A
const AUX_BUFFERS            = 0x0002100B
const STEREO                 = 0x0002100C
const SAMPLES                = 0x0002100D
const SRGB_CAPABLE           = 0x0002100E
const REFRESH_RATE           = 0x0002100F
const DOUBLEBUFFER           = 0x00021010

const CLIENT_API             = 0x00022001
const CONTEXT_VERSION_MAJOR  = 0x00022002
const CONTEXT_VERSION_MINOR  = 0x00022003
const CONTEXT_REVISION       = 0x00022004
const CONTEXT_ROBUSTNESS     = 0x00022005
const OPENGL_FORWARD_COMPAT  = 0x00022006
const OPENGL_DEBUG_CONTEXT   = 0x00022007
const OPENGL_PROFILE         = 0x00022008
const CONTEXT_RELEASE_BEHAVIOR = 0x00022009

const OPENGL_API             = 0x00030001
const OPENGL_ES_API          = 0x00030002

const NO_ROBUSTNESS          =          0
const NO_RESET_NOTIFICATION  = 0x00031001
const LOSE_CONTEXT_ON_RESET  = 0x00031002

const OPENGL_ANY_PROFILE     =          0
const OPENGL_CORE_PROFILE    = 0x00032001
const OPENGL_COMPAT_PROFILE  = 0x00032002

const CURSOR                 = 0x00033001
const STICKY_KEYS            = 0x00033002
const STICKY_MOUSE_BUTTONS   = 0x00033003

const CURSOR_NORMAL          = 0x00034001
const CURSOR_HIDDEN          = 0x00034002
const CURSOR_DISABLED        = 0x00034003

const ANY_RELEASE_BEHAVIOR   =          0
const RELEASE_BEHAVIOR_FLUSH = 0x00035001
const RELEASE_BEHAVIOR_NONE  = 0x00035002

# Standard cursor shapes
const ARROW_CURSOR           = 0x00036001
const IBEAM_CURSOR           = 0x00036002
const CROSSHAIR_CURSOR       = 0x00036003
const HAND_CURSOR            = 0x00036004
const HRESIZE_CURSOR         = 0x00036005
const VRESIZE_CURSOR         = 0x00036006

const CONNECTED              = 0x00040001
const DISCONNECTED           = 0x00040002

const DONT_CARE              = -1


