# define Vulkan types locally, so we don't need to add VulkanCore.jl as dependency
const VkResult = Cuint
const VkInstance = Ptr{Cvoid}
const VkSurfaceKHR = Ptr{Cvoid}
const VkPhysicalDevice = Ptr{Cvoid}

struct VkAllocationCallbacks
    pUserData::Ptr{Cvoid}
    pfnAllocation::Ptr{Cvoid}
    pfnReallocation::Ptr{Cvoid}
    pfnFree::Ptr{Cvoid}
    pfnInternalAllocation::Ptr{Cvoid}
    pfnInternalFree::Ptr{Cvoid}
end

"""
    VulkanSupported()
Return whether the Vulkan loader has been found.
"""
VulkanSupported() = Bool(ccall((:glfwVulkanSupported, libglfw), Cint, ())) # any thread

"""
    GetRequiredInstanceExtensions() -> Vector{String}
Return a vector of names of Vulkan instance extensions.
"""
function GetRequiredInstanceExtensions()
    count = Ref{Cuint}(0)
    ptr = GetRequiredInstanceExtensions(count)
    return GC.@preserve ptr unsafe_string.(unsafe_wrap(Array, ptr, count[]))
end

"""
    GetRequiredInstanceExtensions(count::Ref) -> Ptr{Cstring}
Return a Cstring pointer that can be directly passed to `VkInstanceCreateInfo`.
"""
function GetRequiredInstanceExtensions(count::Ref)
    ptr = ccall((:glfwGetRequiredInstanceExtensions, libglfw), Ptr{Cstring}, (Ref{Cuint},), count) # any thread
end

"""
    GetInstanceProcAddress(instance, procname) -> funcptr
Return the address of the specified Vulkan core or extension function for the specified instance.
`funcptr` can be used directly as the first argument of `ccall`: ccall(funcptr, ...).
"""
function GetInstanceProcAddress(instance, procname)
    # any thread
    ccall((:glfwGetInstanceProcAddress, libglfw), Ptr{Cvoid}, (VkInstance, Cstring), instance, procname)
end

"""
    GetPhysicalDevicePresentationSupport(instance, device, queuefamily)
Return whether the specified queue family of the specified physical device supports presentation to the platform GLFW was built for.
"""
function GetPhysicalDevicePresentationSupport(instance, device, queuefamily)
    # any thread
    Bool(ccall((:glfwGetPhysicalDevicePresentationSupport, libglfw), Cint, (VkInstance, VkPhysicalDevice, Cuint), instance, device, queuefamily))
end

"""
    CreateWindowSurface(instance, window, allocator=C_NULL)
Create a Vulkan surface for the specified window.
"""
function CreateWindowSurface(instance, window, allocator=C_NULL)
    # any thread
    surface = Ref{VkSurfaceKHR}(C_NULL)
    ccall((:glfwCreateWindowSurface, libglfw), VkResult, (VkInstance, Window, Ptr{VkAllocationCallbacks}, Ref{VkSurfaceKHR}), instance, window, allocator, surface)
    return surface[]
end
