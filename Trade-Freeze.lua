-- Grow a Garden: Freeze GUI with Draggable + Temporary Text Change
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local StarterGui = player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

-- GUI Setup
local screenGui = Instance.new("ScreenGui", StarterGui)
screenGui.Name = "FreezeUI"
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Size = UDim2.new(0, 230, 0, 80)
mainFrame.Position = UDim2.new(0.5, -115, 0.1, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0)
mainFrame.BackgroundTransparency = 0.1
mainFrame.ClipsDescendants = true
mainFrame.Active = true
mainFrame.Draggable = true

-- Rounded corners
local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 10)

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Text = "😈 TRADE FREEZING"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 50, 50)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, -10, 0, 35)
title.Position = UDim2.new(0, 10, 0, 0)
title.TextXAlignment = Enum.TextXAlignment.Left

-- Freeze Button
local button = Instance.new("TextButton", mainFrame)
button.Text = "🧊Freeze Victim"
button.Font = Enum.Font.GothamBlack
button.TextSize = 16
button.TextColor3 = Color3.new(1, 1, 1)
button.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
button.Size = UDim2.new(0.9, 0, 0, 30)
button.Position = UDim2.new(0.05, 0, 0, 40)
button.AutoButtonColor = true

local buttonCorner = Instance.new("UICorner", button)
buttonCorner.CornerRadius = UDim.new(0, 8)

-- Stroke
local uiStroke = Instance.new("UIStroke", mainFrame)
uiStroke.Thickness = 1.5
uiStroke.Color = Color3.fromRGB(255, 0, 0)
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Button Click Logic
button.MouseButton1Click:Connect(function()
	button.Text = "⚠️Freezing..."
	wait(2) -- Simulate action
	button.Text = "Freeze Victim" -- Reset text back
	print("❄️ Freeze Victim triggered!")
end)
