-- Grow a Garden: Freeze GUI with Draggable + Temporary Text Change + Toggle Button + Fade
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local StarterGui = player:WaitForChild("PlayerGui")

-- GUI Setup
local screenGui = Instance.new("ScreenGui", StarterGui)
screenGui.Name = "FreezeUI"
screenGui.ResetOnSpawn = false

-- Main Frame
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

local uiStroke = Instance.new("UIStroke", mainFrame)
uiStroke.Thickness = 1.5
uiStroke.Color = Color3.fromRGB(255, 0, 0)
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Button Click Logic
button.MouseButton1Click:Connect(function()
	button.Text = "⚠️Freezing..."
	wait(2)
	button.Text = "🧊Freeze Victim"
	print("❄️ Freeze Victim triggered!")
end)

-- Floating Toggle Button
local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0.2, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleButton.Text = "☠️" -- Default when visible
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 20
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.AutoButtonColor = true
toggleButton.Active = true
toggleButton.Draggable = true

local toggleCorner = Instance.new("UICorner", toggleButton)
toggleCorner.CornerRadius = UDim.new(1, 0)

local toggleStroke = Instance.new("UIStroke", toggleButton)
toggleStroke.Thickness = 1.5
toggleStroke.Color = Color3.fromRGB(255, 0, 0)

-- Toggle Logic with Fade Animation
local isVisible = true
local function fadeGui(show)
	if show then
		mainFrame.Visible = true
		TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0.1}):Play()
		for _, obj in ipairs(mainFrame:GetDescendants()) do
			if obj:IsA("TextLabel") or obj:IsA("TextButton") then
				TweenService:Create(obj, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
				if obj:IsA("TextButton") then
					TweenService:Create(obj, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
				end
			end
		end
	else
		TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
		for _, obj in ipairs(mainFrame:GetDescendants()) do
			if obj:IsA("TextLabel") or obj:IsA("TextButton") then
				TweenService:Create(obj, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
				if obj:IsA("TextButton") then
					TweenService:Create(obj, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
				end
			end
		end
		wait(0.4)
		mainFrame.Visible = false
	end
end

toggleButton.MouseButton1Click:Connect(function()
	isVisible = not isVisible
	toggleButton.Text = isVisible and "☠️" or "💀"
	toggleButton.BackgroundColor3 = isVisible and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(100, 0, 0)
	fadeGui(isVisible)
end)
