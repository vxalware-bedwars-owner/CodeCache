local Version = "1.6.61"
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/" .. Version .. "/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "CodeCache V3",
    Icon = "moon-star",
    Author = "Unreleased",
    Folder = "CCV3",
    
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = false,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            print("user check")
        end,
    },
})

Window:SetToggleKey(Enum.KeyCode.K)
Window:SetIconSize(26)
Window:EditOpenButton({
    Title = "Open CodeCache",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("FFFFFF"), 
        Color3.fromHex("FFFFFF")
    ),
    OnlyMobile = true,
    Enabled = true,
    Draggable = true,
})

-- safeWriteConfig API
local HttpService = game:GetService("HttpService")
local folderName = "Vxalware"
local configFilePath = folderName .. "/VXConfig.json"

local hasFileApi = (type(isfolder) == "function")
               and (type(makefolder) == "function")
               and (type(isfile) == "function")
               and (type(readfile) == "function")
               and (type(writefile) == "function")

local config = {
    dropdown = {},
    toggle = {},
    slider = {},
}

local function safeWriteConfig()
    if not hasFileApi then return false end
    local ok, err = pcall(function()
        writefile(configFilePath, HttpService:JSONEncode(config))
    end)
    return ok
end

local function loadConfig()
    if not hasFileApi then return end
    if not isfolder(folderName) then
        pcall(makefolder, folderName)
    end
    if isfile(configFilePath) then
        local ok, data = pcall(readfile, configFilePath)
        if ok and data then
            local succ, decoded = pcall(HttpService.JSONDecode, HttpService, data)
            if succ and type(decoded) == "table" then
                -- keep defaults
                config.dropdown = decoded.dropdown or config.dropdown
                config.toggle = decoded.toggle or config.toggle
                config.slider = decoded.slider or config.slider
            end
        end
    else
        safeWriteConfig()
    end
end

loadConfig()

if not hasFileApi then
    WindUI:Notify({
        Title = "Config Disabled",
        Content = "API Unreachable — config will not be saved.",
        Duration = 5,
        Icon = "x",
    })
end

-- runWithNotify API
local _runWithNotify_firstRun = {}
local function runWithNotify(title, fn, opts)
    -- API Directions:
    -- kind = "dropdown", "toggle", or "slider"
    -- getLabel = function() -> string  (for dropdowns)
    -- getState = function() -> boolean (for toggles)
    -- getValue = function() -> value (for sliders)
    -- suppressNone = true/false (for dropdowns)
    opts = opts or {}
    local kind = opts.kind
    local getLabel = opts.getLabel
    local getState = opts.getState
    local getValue = opts.getValue
    local suppressNone = opts.suppressNone

    -- Silent run | Error run
    if not _runWithNotify_firstRun[title] then
        _runWithNotify_firstRun[title] = true

        if kind == "dropdown" or kind == "toggle" then
            local ok, err = pcall(fn)
            if not ok then
                WindUI:Notify({
                    Title = "Error",
                    Content = "Failed to run "..tostring(title).."\n"..tostring(err),
                    Duration = 5,
                    Icon = "x",
                })
            end
            return
        end
    end

    -- Normal run | Error run
    local ok, err = pcall(fn)
    if not ok then
        WindUI:Notify({
            Title = "Error",
            Content = "Failed to run "..tostring(title).."\n"..tostring(err),
            Duration = 5,
            Icon = "x",
        })
        return
    end

    -- Success run | Dropdown
    if kind == "dropdown" and type(getLabel) == "function" then
        local label = getLabel()
        if suppressNone and tostring(label) == "None" then
            return
        end
        WindUI:Notify({
            Title = "Success",
            Content = "Successfully executed "..tostring(label),
            Duration = 1.5,
        })
        return
    end

    -- Success run | Toggle
    if kind == "toggle" and type(getState) == "function" then
        local state = getState()
        if state then
            WindUI:Notify({
                Title = "Success",
                Content = "Successfully executed "..tostring(title),
                Duration = 1.5,
            })
        else
            WindUI:Notify({
                Title = "Success",
                Content = "Successfully unexecuted "..tostring(title),
                Duration = 1.5,
            })
        end
        return
    end

    -- Success run | Slider
    if kind == "slider" and type(getValue) == "function" then
        local value = getValue()
        local valueStr = tostring(value)
        if type(value) == "number" then
            valueStr = tostring(tonumber(string.format("%.6f", value))):gsub("%.?0+$", "")
        end
        WindUI:Notify({
            Title = "Success",
            Content = tostring(title) .. " set to " .. valueStr,
            Duration = 1.5,
        })
        return
    end

    -- Success run | Universal
    WindUI:Notify({
        Title = "Success",
        Content = "Successfully ran "..tostring(title),
        Duration = 1.5,
    })
end

-- Universal
local UniverTab = Window:Tab({ Title = "Universal", Icon = "earth" })
local Button = UniverTab:Button({
    Title = "Universal Button",
    Callback = function()
        runWithNotify("Universal Button", function()
            print("Universal Button")
        end)
    end
})

Window:Divider() -- Divider | Fisch
local FischTab = Window:Tab({ Title = "Fisch", Icon = "fish-symbol" })
local Button = FischTab:Button({
    Title = "Fisch Button",
    Callback = function()
        runWithNotify("Fisch Button", function()
            print("Fisch Button")
        end)
    end
})

-- Credits tab
local CreditsTab = Window:Tab({ Title = "Credits", Icon = "star" })
local Paragraph = CreditsTab:Paragraph({
    Title = "Wind UI",
    Desc = "This script is made by SynthX. All credits go to footagesus for making the UI Library",
    Locked = false,
})

local Paragraph = CreditsTab:Paragraph({
    Title = "Scripts",
    Desc = "All credits go to the various owners of the given scripts used in this script",
    Locked = false,
})

local Paragraph = CreditsTab:Paragraph({
    Title = "Keybind",
    Desc = "If you didn't read the message at the start of the script execution, press 'K' to toggle the GUI",
    Locked = false,
})

-- Notification
WindUI:Notify({
    Title = "Successfully Loaded!",
    Content = "Thank you for using CodeCache. Press 'K' to toggle GUI",
    Duration = 5,
    Icon = "check"
})
