-- // Sttar Custom Loader GUI - Mobile Friendly + Dark/Light + HWID

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SttarLoader"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Smaller size for mobile
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 340, 0, 460)  -- Maliit na para sa mobile
mainFrame.Position = UDim2.new(0.5, -170, 0.5, -230)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundTransparency = 0.05
mainFrame.Parent = screenGui

local uicorner = Instance.new("UICorner")
uicorner.CornerRadius = UDim.new(0, 16)
uicorner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(90, 90, 120)
stroke.Thickness = 1.5
stroke.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 0, 50)
title.Position = UDim2.new(0, 15, 0, 10)
title.BackgroundTransparency = 1
title.Text = "Sttar Loader"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 26
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

-- Close Button (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0, 5)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
closeBtn.TextSize = 28
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Theme Toggle
local isDark = true
local themeBtn = Instance.new("TextButton")
themeBtn.Size = UDim2.new(0, 40, 0, 40)
themeBtn.Position = UDim2.new(1, -90, 0, 5)
themeBtn.BackgroundTransparency = 1
themeBtn.Text = "☀"
themeBtn.TextColor3 = Color3.fromRGB(255, 220, 100)
themeBtn.TextSize = 24
themeBtn.Font = Enum.Font.GothamBold
themeBtn.Parent = mainFrame

local function toggleTheme()
    isDark = not isDark
    if isDark then
        mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
        stroke.Color = Color3.fromRGB(90, 90, 120)
        themeBtn.Text = "☀"
    else
        mainFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
        stroke.Color = Color3.fromRGB(180, 180, 200)
        themeBtn.Text = "☽"
    end
end

themeBtn.MouseButton1Click:Connect(toggleTheme)

-- HWID Display
local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
local hwidLabel = Instance.new("TextLabel")
hwidLabel.Size = UDim2.new(1, -30, 0, 20)
hwidLabel.Position = UDim2.new(0, 15, 0, 55)
hwidLabel.BackgroundTransparency = 1
hwidLabel.Text = "HWID: " .. hwid:sub(1, 20) .. "..."
hwidLabel.TextColor3 = Color3.fromRGB(160, 160, 170)
hwidLabel.TextSize = 13
hwidLabel.Font = Enum.Font.Gotham
hwidLabel.TextXAlignment = Enum.TextXAlignment.Left
hwidLabel.Parent = mainFrame

-- Key Input
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.9, 0, 0, 52)
keyBox.Position = UDim2.new(0.05, 0, 0.22, 0)
keyBox.PlaceholderText = "Paste key here..."
keyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
keyBox.TextColor3 = Color3.fromRGB(240, 240, 240)
keyBox.TextSize = 17
keyBox.Font = Enum.Font.Gotham
keyBox.Parent = mainFrame

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 12)
boxCorner.Parent = keyBox

-- Validate Button
local validateBtn = Instance.new("TextButton")
validateBtn.Size = UDim2.new(0.9, 0, 0, 52)
validateBtn.Position = UDim2.new(0.05, 0, 0.38, 0)
validateBtn.BackgroundColor3 = Color3.fromRGB(110, 60, 255)
validateBtn.Text = "VALIDATE KEY"
validateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
validateBtn.TextSize = 18
validateBtn.Font = Enum.Font.GothamBold
validateBtn.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 12)
btnCorner.Parent = validateBtn

-- Status
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.9, 0, 0, 45)
statusLabel.Position = UDim2.new(0.05, 0, 0.55, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.TextSize = 15
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = mainFrame

-- Loading Bar
local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0.9, 0, 0, 8)
barBg.Position = UDim2.new(0.05, 0, 0.72, 0)
barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
barBg.Parent = mainFrame

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(130, 80, 255)
bar.Parent = barBg

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = barBg
barCorner:Clone().Parent = bar

-- Get Key Button
local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Size = UDim2.new(0.9, 0, 0, 45)
getKeyBtn.Position = UDim2.new(0.05, 0, 0.8, 0)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 58)
getKeyBtn.Text = "🌐 Get Key (Website)"
getKeyBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
getKeyBtn.TextSize = 15
getKeyBtn.Font = Enum.Font.Gotham
getKeyBtn.Parent = mainFrame

local getCorner = Instance.new("UICorner")
getCorner.CornerRadius = UDim.new(0, 12)
getCorner.Parent = getKeyBtn

-- Backend
local BACKEND_URL = "https://sttar-key-system.onrender.com/validate-key"  -- Palitan

local function tween(obj, prop, goal, time)
    TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quint), {[prop] = goal}):Play()
end

local function validateKey(key)
    statusLabel.Text = "Checking..."
    tween(bar, "Size", UDim2.new(0.45, 0, 1, 0), 0.4)

    local success, response = pcall(function()
        return game:HttpPost(BACKEND_URL, HttpService:JSONEncode({key = key}))
    end)

    if success then
        local data = HttpService:JSONDecode(response)
        tween(bar, "Size", UDim2.new(1, 0, 1, 0), 0.6)

        if data.valid then
            statusLabel.Text = "✅ Success! Loading Hub..."
            statusLabel.TextColor3 = Color3.fromRGB(80, 255, 130)

            -- Loading animation while loading main hub
            for i = 1, 8 do
                tween(bar, "Size", UDim2.new(0.6 + (i*0.05), 0, 1, 0), 0.15)
                wait(0.15)
            end

            screenGui:Destroy()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/sttaralbiola123/sttar-system-loader/refs/heads/main/keysystem.lua"))()  -- Main hub link
        else
            statusLabel.Text = "❌ " .. (data.msg or "Invalid")
            statusLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
            tween(bar, "Size", UDim2.new(0,0,1,0), 0.4)
        end
    else
        statusLabel.Text = "❌ Connection failed"
        statusLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
    end
end

validateBtn.MouseButton1Click:Connect(function()
    local key = keyBox.Text:match("^%s*(.-)%s*$")
    if key == "" then return end
    validateKey(key)
end)

getKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://sttar-key-system.onrender.com/")
    statusLabel.Text = "✅ Link copied!"
end)

-- Draggable (works on mobile too)
local dragging = false
mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Open Animation
mainFrame.Position = UDim2.new(0.5, -170, 1.2, -230)
tween(mainFrame, "Position", UDim2.new(0.5, -170, 0.5, -230), 0.7)
