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
VulkanSupported() = Bool(ccall((:glfwVulkanSupported, lib), Cint, ()))

"""
    GetRequiredInstanceExtensions()
Return a vector of names of Vulkan instance extensions.
"""
function GetRequiredInstanceExtensions()
    count = Ref{Cuint}(0)
    ptr = ccall((:glfwGetRequiredInstanceExtensions, lib), Ptr{Ptr{Cchar}}, (Ref{Cuint},), count)
    return unsafe_string.(unsafe_wrap(Array, ptr, count[]))
end

"""
    GetInstanceProcAddress(instance, procname) -> funcptr
Return the address of the specified Vulkan core or extension function for the specified instance.
`funcptr` can be used directly as the first argument of `ccall`: ccall(funcptr, ...).
"""
GetInstanceProcAddress(instance, procname) = ccall((:glfwGetInstanceProcAddress, lib), Ptr{Cvoid}, (VkInstance, Cstring), instance, procname)

"""
    GetPhysicalDevicePresentationSupport(instance, device, queuefamily)
Return whether the specified queue family of the specified physical device supports presentation to the platform GLFW was built for.
"""
GetPhysicalDevicePresentationSupport(instance, device, queuefamily) = Bool(ccall((:glfwGetPhysicalDevicePresentationSupport, lib), Cint, (VkInstance, VkPhysicalDevice, Cuint), instance, device, queuefamily))

"""
    CreateWindowSurface(instance, window, allocator=C_NULL)
Create a Vulkan surface for the specified window.
"""
function CreateWindowSurface(instance, window, allocator=C_NULL)
    surface = Ref{VkSurfaceKHR}(C_NULL)
    ccall((:glfwCreateWindowSurface, lib), VkResult, (VkInstance, Window, Ptr{VkAllocationCallbacks}, Ref{VkSurfaceKHR}), instance, window, allocator, surface)
    return surface[]
end
