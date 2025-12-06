local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Configurable
local PLAYER_COLOR = Color3.fromRGB(202, 203, 209) -- Desired color
local ENABLE_MODEL_SEARCH = true              -- true = look for the model, false = skip
local MODEL_NAME = "Life2"                        -- The model inside the character

-- R6 main body parts
local BODY_PARTS = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}

-- Recolor function (only top-level body parts, ignores children)
local function recolorParts(root)
	for _, partName in ipairs(BODY_PARTS) do
		local part = root:FindFirstChild(partName)
		if part and part:IsA("BasePart") then
			part.Color = PLAYER_COLOR
			part.Material = Enum.Material.SmoothPlastic

			-- Remove "Graphic" object from Torso
			if partName == "Torso" then
				local graphic = part:FindFirstChild("graphic")
				if graphic then
					graphic:Destroy()
				end
			end
		end
	end
end

-- Handle character spawn
local function onCharacterAdded(character)
	-- Wait for main body parts
	for _, partName in ipairs(BODY_PARTS) do
		character:WaitForChild(partName)
	end

	-- Recolor player body and remove Torso Graphic
	recolorParts(character)

	-- Optionally recolor a model inside the character
	if ENABLE_MODEL_SEARCH then
		local model = character:FindFirstChild(MODEL_NAME)
		if model then
			recolorParts(model)
		end
	end
end

-- Apply immediately if character exists
if player.Character then
	onCharacterAdded(player.Character)
end

-- Apply on respawn
player.CharacterAdded:Connect(onCharacterAdded)
-- UPDATED GUI CREATOR
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- SETTINGS ----
local DISPLAY_TEXT = "Notice: get two time ms1 and your good to go lol might be sus"
local FRAME_COLOR = Color3.fromRGB(40, 40, 40)
local TEXT_COLOR = Color3.fromRGB(255, 255, 255)
local FONT = Enum.Font.Arcade
local CORNER_RADIUS = 12
-----------------

-- Prevent duplicates
if player:WaitForChild("PlayerGui"):FindFirstChild("CustomUI") then
    return
end

-- ScreenGui
local screen = Instance.new("ScreenGui")
screen.Name = "CustomUI"
screen.ResetOnSpawn = false
screen.Parent = player:WaitForChild("PlayerGui")

-- Main Frame (bigger now)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 100)  -- bigger frame
frame.Position = UDim2.fromOffset(150, 150)
frame.BackgroundColor3 = FRAME_COLOR
frame.Active = true
frame.Draggable = true
frame.Parent = screen

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, CORNER_RADIUS)
corner.Parent = frame

-- LARGE Text Label
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, -50, 1, -20) -- MUCH bigger text area
label.Position = UDim2.new(0, 15, 0, 10)
label.BackgroundTransparency = 1
label.Text = DISPLAY_TEXT
label.Font = FONT
label.TextColor3 = TEXT_COLOR
label.TextScaled = true
label.TextWrapped = true
label.Parent = frame

-- X Button (now closes the GUI properly)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 35, 0, 35)
closeButton.Position = UDim2.new(1, -45, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(90, 0, 0)
closeButton.Text = "X"
closeButton.TextScaled = true
closeButton.TextColor3 = TEXT_COLOR
closeButton.Font = FONT
closeButton.Parent = frame

local corner2 = Instance.new("UICorner")
corner2.CornerRadius = UDim.new(0, CORNER_RADIUS)
corner2.Parent = closeButton

-- CLOSE WORKING NOW
closeButton.MouseButton1Click:Connect(function()
    frame:Destroy()
end)