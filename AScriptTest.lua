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
