local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "CodeCache Lite",
    Icon = "moon-star",
    Author = "Unreleased",
    Folder = "Lite",

    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = false,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
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

-- runWithNotify API
local _runWithNotify_firstRun = {}
local function runWithNotify(title, fn, opts)
    -- API Directions:
    -- kind = "dropdown" | "toggle" | nil
    -- getLabel = function() -> string  (for dropdowns)
    -- getState = function() -> boolean (for toggles)
    -- suppressNone = true|false (for dropdowns)
    opts = opts or {}
    local kind = opts.kind
    local getLabel = opts.getLabel
    local getState = opts.getState
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

    -- Success run | Universal
    WindUI:Notify({
        Title = "Success",
        Content = "Successfully ran "..tostring(title),
        Duration = 1.5,
    })
end

-- place support loadstring here

local gameName = game.PlaceId
local gameInfo = supportedGames[placeId]

local GameTab
if gameInfo then
    GameTab = Window:Tab({
        Title = gameInfo.Title,
        Icon = gameInfo.Icon,
        Locked = false,
    })
else
    GameTab = Window:Tab({
        Title = "Unknown",
        Icon = "boxes",
        Locked = false,
    })
end

if gameName == "" then
    GameTab:Button({
        Title = "",
        Desc = "The Best Free, Keyless  Script",
        Locked = false,
        Callback = function()
            runWithNotify("", function()
                loadstring(game:HttpGet("",true))()
            end)
        end
    })
elseif gameName == "" then
    GameTab:Button({
        Title = "",
        Desc = "The Best Free, Keyless  Script",
        Locked = false,
        Callback = function()
            runWithNotify("", function()
                loadstring(game:HttpGet("",true))()
            end)
        end
    })
else
    GameTab:Button({
        Title = "Unknown",
        Desc = "Game Not Supported!",
        Locked = false,
        Callback = function()
            print("Game Not Supported!")
        end
    })
end

local UniversalTab = Window:Tab({
    Title = "Universal",
    Icon = "atom",
    Locked = false,
})

UniversalTab:Button({
    Title = "",
    Locked = false,
    Callback = function()
        print("")
    end
})

local StuffsTab = Window:Tab({
    Title = "Stuffs",
    Icon = "circle-user",
    Locked = false,
})

local Paragraph = StuffsTab:Paragraph({
    Title = "CodeCache Lite",
    Desc = "You are running this script on the Lite edition. Please use V3 or Premium for a wider range of scripts",
    Locked = false,
})

local Paragraph = StuffsTab:Paragraph({
    Title = "Credits",
    Desc = "Credits to people who made this script possible",
    Locked = false,
})

local Paragraph = StuffsTab:Paragraph({
    Title = "Keybind",
    Desc = "If you didn't read the message at the start of the script execution, press 'K' to toggle the GUI",
    Locked = false,
})

WindUI:Notify({
    Title = "Successfully Loaded!",
    Content = "Thank you for using CodeCache. Press 'K' to toggle GUI",
    Duration = 5,
    Icon = "check"
})
