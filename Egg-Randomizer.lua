-- LocalScript (StarterGui or StarterPlayerScripts)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local playerGui = player:WaitForChild("PlayerGui")

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZenAgeChanger"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 140)
frame.Position = UDim2.new(0.5, -140, 0.5, -70)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BackgroundTransparency = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

-- Styling
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(0, 200, 255)
stroke.Thickness = 1.5
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Gradient Background
local gradient = Instance.new("UIGradient", frame)
gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 170, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))
}
gradient.Rotation = 45

-- Title
local title = Instance.new("TextLabel")
title.Text = "🎯 Pet Age Changer"
title.Font = Enum.Font.FredokaOne
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 28)
title.Parent = frame

-- Pet Info
local petInfo = Instance.new("TextLabel")
petInfo.Text = "Equipped: [None]"
petInfo.Font = Enum.Font.Gotham
petInfo.TextSize = 15
petInfo.TextColor3 = Color3.fromRGB(255, 255, 200)
petInfo.BackgroundTransparency = 1
petInfo.Position = UDim2.new(0, 0, 0, 26)
petInfo.Size = UDim2.new(1, 0, 0, 20)
petInfo.Parent = frame

-- Percentage Label
local percentLabel = Instance.new("TextLabel")
percentLabel.Text = "0%"
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextSize = 14
percentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
percentLabel.BackgroundTransparency = 1
percentLabel.Size = UDim2.new(1, 0, 0, 18)
percentLabel.Position = UDim2.new(0, 0, 0, 48)
percentLabel.Parent = frame

-- Progress Bar BG
local progressBG = Instance.new("Frame")
progressBG.Size = UDim2.new(0, 220, 0, 8)
progressBG.Position = UDim2.new(0.5, -110, 0, 68)
progressBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
progressBG.Parent = frame
Instance.new("UICorner", progressBG)

-- Progress Fill
local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
progressBar.Parent = progressBG
Instance.new("UICorner", progressBar)

-- Action Button
local button = Instance.new("TextButton")
button.Text = "⚡ Set Age to 50"
button.Font = Enum.Font.GothamBold
button.TextSize = 16
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.Size = UDim2.new(0, 220, 0, 28)
button.Position = UDim2.new(0.5, -110, 0, 85)
button.Parent = frame
Instance.new("UICorner", button)

-- "Made by Zen" Footer
local credit = Instance.new("TextLabel")
credit.Text = "Made by Zen"
credit.Font = Enum.Font.Gotham
credit.TextSize = 12
credit.TextColor3 = Color3.fromRGB(160, 160, 160)
credit.BackgroundTransparency = 1
credit.Position = UDim2.new(1, -75, 1, -16)
credit.Size = UDim2.new(0, 70, 0, 14)
credit.TextXAlignment = Enum.TextXAlignment.Right
credit.Parent = frame

-- Pet Tool Finder
local function getEquippedPet()
	character = player.Character or player.CharacterAdded:Wait()
	for _, tool in ipairs(character:GetChildren()) do
		if tool:IsA("Tool") and tool.Name:find("%[Age%s%d+%]") then
			return tool
		end
	end
	return nil
end

-- UI Updater
local function updateGUI()
	local pet = getEquippedPet()
	petInfo.Text = pet and ("Equipped: " .. pet.Name) or "Equipped: [None]"
end

-- Animated Progress
local function animateProgress(seconds)
	progressBar.Size = UDim2.new(0, 0, 1, 0)
	local steps = 100
	for i = 1, steps do
		progressBar:TweenSize(
			UDim2.new(i / 100, 0, 1, 0),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Linear,
			seconds / steps,
			true
		)
		percentLabel.Text = i .. "%"
		task.wait(seconds / steps)
	end
end

-- Main Button Logic
button.MouseButton1Click:Connect(function()
	local pet = getEquippedPet()
	if pet then
		button.Text = "🔁 Updating..."
		animateProgress(10)

		local updatedName = pet.Name:gsub("%[Age%s%d+%]", "[Age 50]")
		pet.Name = updatedName
		petInfo.Text = "Equipped: " .. pet.Name
		button.Text = "⚡ Set Age to 50"
		percentLabel.Text = "100%"
	else
		button.Text = "❌ No Pet Found"
		task.wait(2)
		button.Text = "⚡ Set Age to 50"
		progressBar.Size = UDim2.new(0, 0, 1, 0)
		percentLabel.Text = "0%"
	end
end)

-- Constant GUI Update
while true do
	task.wait(1)
	updateGUI()
end
local button = Instance.new("TextButton", frame)
button.Text = "Set Age to 50"
button.Font = Enum.Font.GothamBold
button.TextSize = 18
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.Size = UDim2.new(0, 240, 0, 40)
button.Position = UDim2.new(0.5, -120, 1, -50)
Instance.new("UICorner", button)

-- Function to find the equipped pet Tool
local function getEquippedPetTool()
	character = player.Character or player.CharacterAdded:Wait()
	for _, child in pairs(character:GetChildren()) do
		if child:IsA("Tool") and child.Name:find("Age") then
			return child
		end
	end
	return nil
end

-- Update the GUI with the currently equipped pet
local function updateGUI()
	local pet = getEquippedPetTool()
	if pet then
		petInfo.Text = "Equipped Pet: " .. pet.Name
	else
		petInfo.Text = "Equipped Pet: [None]"
	end
end

-- Click to visually update the name after a 20-second countdown
button.MouseButton1Click:Connect(function()
	local tool = getEquippedPetTool()
	if tool then
		-- Countdown before changing age
		for i = 20, 1, -1 do
			button.Text = "Changing Age in " .. i .. "..."
			wait(1)
		end

		-- Change name visually
		local newName = tool.Name:gsub("%[Age%s%d+%]", "[Age 50]")
		tool.Name = newName
		petInfo.Text = "Equipped Pet: " .. tool.Name
		button.Text = "Set Age to 50"
	else
		button.Text = "No Pet Equipped!"
		wait(2)
		button.Text = "Set Age to 50"
	end
end)

-- Periodically update GUI
while true do
	task.wait(1)
	updateGUI()
end
