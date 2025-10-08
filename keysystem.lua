--// Key System Config
local CorrectKey = "KeyIsWOWOWOWOWOOWO"
local KeyLink = "https://workink.net/25Pw/6d8mldcu"

--// Load UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/XeFrostz/FHub-Lib/refs/heads/main/hub.lua"))()
local HttpService = game:GetService("HttpService")
local config = {}

--// Save / Load Config
local function saveConfig()
    local json = HttpService:JSONEncode(config)
    writefile("FrxserHub_Config.json", json)
end

local function loadConfig()
    if isfile("FrxserHub_Config.json") then
        local json = readfile("FrxserHub_Config.json")
        config = HttpService:JSONDecode(json)
    end
end

loadConfig()

---------------------------------------------------------
-- Main Hub
---------------------------------------------------------
local function LoadMainHub()
    local Window = Library:Window({
        Title = "Frxser Hub",
        Desc = "Frxser Hub on top",
        Icon = 112372000395096,
        Theme = "Dark",
        Config = {
            Keybind = Enum.KeyCode.LeftControl,
            Size = UDim2.new(0, 500, 0, 400)
        },
        CloseUIButton = {
            Enabled = true,
            Text = "Frxser Hub"
        }
    })

    local Tab = Window:Tab({Title = "Main", Icon = "star"}) do
        Tab:Section({Title = "All UI Components"})

        Tab:Button({
            Title = "Test Notify",
            Desc = "Click to show a test message",
            Callback = function()
                Window:Notify({
                    Title = "Frxser Hub",
                    Desc = "Everything works perfectly!",
                    Time = 3
                })
            end
        })
    end

    Window:Notify({
        Title = "Frxser Hub",
        Desc = "Loaded Successfully!",
        Time = 3
    })
end

---------------------------------------------------------
-- Key System
---------------------------------------------------------
local function KeySystem()
    local KeyWindow = Library:Window({
        Title = "Frxser Hub | Key System",
        Desc = "Please enter your access key",
        Icon = 112372000395096,
        Theme = "Dark",
        Config = {
            Keybind = Enum.KeyCode.LeftControl,
            Size = UDim2.new(0, 400, 0, 250)
        },
        CloseUIButton = {
            Enabled = true,
            Text = "Close"
        }
    })

    -- เก็บ reference ของ GUI ไว้
    local keyGui = KeyWindow.Gui or (gethui and gethui()) or game:GetService("CoreGui")

    local Tab = KeyWindow:Tab({Title = "Key System", Icon = "lock"}) do
        Tab:Section({Title = "Verification"})

        local InputKey = ""

        Tab:Textbox({
            Title = "Your Key",
            Desc = "Enter your key here",
            Placeholder = "Paste your key...",
            ClearTextOnFocus = false,
            Callback = function(value)
                InputKey = value
            end
        })

        Tab:Button({
            Title = "Copy Key Link",
            Desc = "Click to copy the key link",
            Callback = function()
                setclipboard(KeyLink)
                KeyWindow:Notify({
                    Title = "Copied!",
                    Desc = "Key link copied to clipboard.",
                    Time = 3
                })
            end
        })

        Tab:Button({
            Title = "Submit Key",
            Desc = "Verify your key",
            Callback = function()
                if InputKey == CorrectKey then
                    KeyWindow:Notify({
                        Title = "Access Granted",
                        Desc = "Correct key! Loading Frxser Hub...",
                        Time = 2
                    })
                    config.savedkey = InputKey
                    saveConfig()

            
                    task.delay(1, function()
                        pcall(function()
                            if KeyWindow.Gui then
                                KeyWindow.Gui:Destroy()
                            else
                                for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
                                    if v.Name:find("Frxser Hub | Key System") then
                                        v:Destroy()
                                    end
                                end
                            end
                        end)
                        task.wait(0.2)
                        LoadMainHub()
                    end)
                else
                    KeyWindow:Notify({
                        Title = "Access Denied",
                        Desc = "Invalid key! Please check again.",
                        Time = 3
                    })
                end
            end
        })
    end
end

---------------------------------------------------------
-- Auto Key Check
---------------------------------------------------------
if config.savedkey == CorrectKey then
    LoadMainHub()
else
    task.wait(0.5)
    KeySystem()
end
