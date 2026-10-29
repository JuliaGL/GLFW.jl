# define Vulkan types locally, so we don't need to add VulkanCore.jl as dependency
const VkResult = Cint
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
This does not guarantee a usable physical device or window surface support.
Check physical devices through your Vulkan binding before constructing a renderer;
`GetRequiredInstanceExtensions` only describes GLFW window surface requirements.
"""
function VulkanSupported()
    ensure_initialized()
    return Bool(ccall((:glfwVulkanSupported, libglfw), Cint, ()))
end

"""
    GetRequiredInstanceExtensions() -> Vector{String}
Return the Vulkan instance extensions required for window surface creation.
Returns an empty vector if Vulkan is available but window surfaces are not
supported (for example, on the NULL platform). Offscreen Vulkan can still be used.
"""
function GetRequiredInstanceExtensions()
    count = Ref{Cuint}(0)
    ptr = GetRequiredInstanceExtensions(count)
    ptr == C_NULL && return String[]
    return unsafe_string.(unsafe_wrap(Array, ptr, count[]))
end

"""
    GetRequiredInstanceExtensions(count::Ref) -> Ptr{Cstring}
Return a Cstring pointer that can be directly passed to `VkInstanceCreateInfo`.
"""
function GetRequiredInstanceExtensions(count::Ref)
    ensure_initialized()
    ptr = ccall((:glfwGetRequiredInstanceExtensions, libglfw), Ptr{Cstring}, (Ref{Cuint},), count) # any thread
end

"""
    GetInstanceProcAddress(instance, procname) -> funcptr
Return the address of the specified Vulkan core or extension function for the specified instance.
`funcptr` can be used directly as the first argument of `ccall`: ccall(funcptr, ...).
"""
function GetInstanceProcAddress(instance, procname)
    # any thread after initialization
    ensure_initialized()
    ccall((:glfwGetInstanceProcAddress, libglfw), Ptr{Cvoid}, (VkInstance, Cstring), instance, procname)
end

"""
    GetPhysicalDevicePresentationSupport(instance, device, queuefamily)
Return whether the specified queue family of the specified physical device supports presentation to the platform GLFW was built for.
"""
function GetPhysicalDevicePresentationSupport(instance, device, queuefamily)
    # any thread after initialization
    ensure_initialized()
    Bool(ccall((:glfwGetPhysicalDevicePresentationSupport, libglfw), Cint, (VkInstance, VkPhysicalDevice, Cuint), instance, device, queuefamily))
end

"""
    CreateWindowSurface(instance, window, allocator=C_NULL)
Create a Vulkan surface for the specified window. Throws if the returned
`VkResult` is not `VK_SUCCESS`, even when the GLFW error callback does not throw.
"""
function CreateWindowSurface(instance, window, allocator=C_NULL)
    instance == C_NULL && throw(ArgumentError("CreateWindowSurface requires a valid Vulkan instance"))
    # any thread after initialization
    ensure_initialized()
    surface = Ref{VkSurfaceKHR}(C_NULL)
    result = ccall((:glfwCreateWindowSurface, libglfw), VkResult, (VkInstance, Window, Ptr{VkAllocationCallbacks}, Ref{VkSurfaceKHR}), instance, window, allocator, surface)
    result == 0 || error("glfwCreateWindowSurface failed with VkResult $result")
    return surface[]
end
