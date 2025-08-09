workspace "OpenGLTemplate"
    architecture "x64"
    configurations { "Debug", "Release" }
    startproject "App"

-- GLFW
project "GLFW"
    kind "StaticLib"
    language "C"
    staticruntime "on"
    architecture "x64"

    targetdir ("Binaries/%{cfg.buildcfg}")
    objdir ("Intermediate/%{cfg.buildcfg}")

    files { "Vendor/GLFW/src/**.c" }
    includedirs { "Vendor/GLFW/include" }

    filter "system:windows"
        systemversion "latest"
        architecture "x64"
        defines { "_GLFW_WIN32", "_CRT_SECURE_NO_WARNINGS" }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "On"

    filter "configurations:Release"
        runtime "Release"
        optimize "On"

-- GLAD
project "GLAD"
    kind "StaticLib"
    language "C"
    staticruntime "on"
    architecture "x64"

    targetdir ("Binaries/%{cfg.buildcfg}")
    objdir ("Intermediate/%{cfg.buildcfg}")

    files { "Vendor/GLAD/src/glad.c" }
    includedirs { "Vendor/GLAD/include" }

    filter "system:windows"
        systemversion "latest"
        architecture "x64"

    filter "configurations:Debug"
        runtime "Debug"
        symbols "On"

    filter "configurations:Release"
        runtime "Release"
        optimize "On"

-- App
project "App"
    location "App"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++20"
    staticruntime "on"
    architecture "x64"

    targetdir ("Binaries/%{cfg.buildcfg}")
    objdir ("Intermediate/%{cfg.buildcfg}")

    files {
        "Source/**.h",
        "Source/**.cpp"
    }

    includedirs {
        "Vendor/GLAD/include",
        "Vendor/GLFW/include"
    }

    links {
        "GLAD",     -- Must be before GLFW
        "GLFW",
        "opengl32"  -- Windows only; use "GL" on Linux
    }

    filter "system:windows"
        systemversion "latest"
        architecture "x64"

    filter "configurations:Debug"
        defines { "DEBUG" }
        runtime "Debug"
        symbols "On"

    filter "configurations:Release"
        defines { "NDEBUG" }
        runtime "Release"
        optimize "On"
