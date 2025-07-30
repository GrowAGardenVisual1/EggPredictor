-- Pet Changer by Zen | Fully Working Version with Gradient, Rounded UI & ESP
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- 🐣 Egg-to-Pet Mapping
local eggToPets = {
	["Common Egg"]     = {"Dog","Golden Lab","Bunny"},
	["Uncommon Egg"]   = {"Black Bunny","Cat","Chicken","Deer"},
	["Rare Egg"]       = {"Monkey","Orange Tabby","Pig","Rooster","Spotted Deer"},
	["Legendary Egg"]  = {"Cow","Silver Monkey","Sea Otter","Turtle","Polar Bear"},
	["Mythical Egg"]   = {"Grey Mouse","Brown Mouse","Squirrel","Red Giant Ant","Red Fox"},
	["Bug Egg"]        = {"Snail","Giant Ant","Caterpillar","Praying Mantis","Dragonfly"},
	["Bee Egg"]        = {"Bee","Honey Bee","Bear Bee","Petal Bee","Queen Bee"},
	["Paradise Egg"]   = {"Ostrich","Peacock","Capybara","Scarlet Macaw","Mimic Octopus"},
	["Oasis Egg"]      = {"Meerkat","Sand Snake","Axolotl","Hyacinth Macaw"},
	["Dinosaur Egg"]   = {
		{"Pterodactyl", 3},{"Raptor", 35},{"Triceratops", 32.5},
		{"Stegosaurus", 28},{"Brontosaurus", 1},{"T-Rex", 0.5}
	},
	["Primal Egg"]     = {
		{"Parasaurolophus", 35},{"Iguanodon", 32.5},{"Pachycephalosaurus", 28},
		{"Dilophosaurus", 3},{"Ankylosaurus", 1},{"Spinosaurus", 0.5}
	},
	["Zen Egg"]        = {
		{"Shiba Inu", 40},{"Nihonzaru", 32},{"Tanuki", 20.82},
		{"Tanchozuru", 4.6},{"Kappa", 3.5},{"Kitsune", 0.08}
	}
}

-- 🎯 Weighted Pet Picker
local function choosePet(eggName)
	local pets = eggToPets[eggName]
	if not pets then return nil end
	if typeof(pets[1]) == "string" then
		return pets[math.random(1, #pets)]
	else
		local roll, sum = math.random() * 100, 0
		for _, entry in ipairs(pets) do
			sum += entry[2]
			if roll <= sum then return entry[1] end
		end
		return pets[#pets][1]
	end
end

-- 🪞 ESP Creator
local function createESP(part, petName)
	if not part then return end
	local old = part:FindFirstChild("EggESP")
	if old then old:Destroy() end

	local gui = Instance.new("BillboardGui")
	gui.Name = "EggESP"
	gui.Size = UDim2.new(0,120,0,40)
	gui.StudsOffset = Vector3.new(0,2.5,0)
	gui.AlwaysOnTop = true
	gui.Parent = part

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1,0,1,0)
	label.BackgroundTransparency = 1
	label.Text = petName
	label.TextColor3 = Color3.new(1,1,1)
	label.TextStrokeTransparency = 0.4
	label.Font = Enum.Font.GothamBold
	label.TextScaled = true
	label.Parent = gui
end

-- 🔁 ESP Refresher
local function randomizeESP()
	for _, egg in ipairs(Workspace:GetDescendants()) do
		if egg:IsA("Model") and eggToPets[egg.Name] then
			local part = egg:FindFirstChildWhichIsA("BasePart")
			if part then
				local pet = choosePet(egg.Name)
				if pet then
					createESP(part, pet)
				end
			end
		end
	end
end

-- 🧩 UI Setup
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "PetChangerUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,280,0,130)
frame.Position = UDim2.new(0,20,0.4,0)
frame.BackgroundColor3 = Color3.fromRGB(24,24,24)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame)

-- 🌈 Gradient Background
local gradient = Instance.new("UIGradient", frame)
gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 180)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 180, 255))
}
gradient.Rotation = 45

-- 🏷 Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0.3,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.new(1,1,1)
title.Text = "Pet Changer by Zen"

-- 🔘 Randomize Button
local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.9,0,0.25,0)
button.Position = UDim2.new(0.05,0,0.35,0)
button.Font = Enum.Font.GothamBold
button.TextSize = 16
button.TextColor3 = Color3.new(1,1,1)
button.BackgroundColor3 = Color3.fromRGB(0,170,90)
button.TextStrokeTransparency = 0.8
button.Text = "Randomize Pet"
Instance.new("UICorner", button)

-- 🔁 Auto Toggle Button
local autoButton = Instance.new("TextButton", frame)
autoButton.Size = UDim2.new(0.9,0,0.25,0)
autoButton.Position = UDim2.new(0.05,0,0.65,0)
autoButton.Font = Enum.Font.GothamBold
autoButton.TextSize = 16
autoButton.TextColor3 = Color3.new(1,1,1)
autoButton.BackgroundColor3 = Color3.fromRGB(0,90,170)
autoButton.Text = "Auto Randomize: OFF"
Instance.new("UICorner", autoButton)

-- 🛠 Toggle Logic
local autoActive = false
autoButton.MouseButton1Click:Connect(function()
	autoActive = not autoActive
	autoButton.Text = "Auto Randomize: " .. (autoActive and "ON" or "OFF")
end)

-- 🖱️ Manual Click
button.MouseButton1Click:Connect(function()
	randomizeESP()
end)

-- 🔁 Fast Auto ESP Loop
task.spawn(function()
	while true do
		task.wait(0.2)
		if autoActive then
			randomizeESP()
		end
	end
end)
