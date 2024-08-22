-- Create GUI Elements
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local titleLabel = Instance.new("TextLabel")
local toggleButton = Instance.new("TextButton")
local minimizeButton = Instance.new("TextButton")
local closeButton = Instance.new("TextButton")
local creatorLabel = Instance.new("TextLabel")

-- Set Parent
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
frame.Parent = screenGui
titleLabel.Parent = frame
toggleButton.Parent = frame
minimizeButton.Parent = frame
closeButton.Parent = frame
creatorLabel.Parent = frame

-- Frame Properties
frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100) -- Centered on screen
frame.Active = true
frame.Draggable = true

-- Title Label Properties
titleLabel.BackgroundTransparency = 1
titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
titleLabel.Text = "Pet Duper/Changer"
titleLabel.Font = Enum.Font.SourceSans
titleLabel.TextSize = 24
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.TextStrokeTransparency = 0

-- Creator Label Properties
creatorLabel.BackgroundTransparency = 1
creatorLabel.Size = UDim2.new(1, 0, 0.1, 0)
creatorLabel.Position = UDim2.new(0, 0, 0.9, 0) -- Bottom of the frame
creatorLabel.Text = "Made by @Zappy453"
creatorLabel.Font = Enum.Font.SourceSans
creatorLabel.TextSize = 18
creatorLabel.TextColor3 = Color3.new(1, 1, 1)
creatorLabel.TextStrokeTransparency = 0

-- Toggle Button Properties
toggleButton.Size = UDim2.new(0.5, 0, 0.2, 0)
toggleButton.Position = UDim2.new(0.25, 0, 0.4, 0) -- Centered horizontally
toggleButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
toggleButton.Text = "Enable Duping"
toggleButton.Font = Enum.Font.SourceSans
toggleButton.TextSize = 20
toggleButton.TextColor3 = Color3.new(1, 1, 1)

-- Minimize Button Properties
minimizeButton.Size = UDim2.new(0.1, 0, 0.2, 0)
minimizeButton.Position = UDim2.new(0.9, -10, 0, 5)
minimizeButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
minimizeButton.Text = "-"
minimizeButton.Font = Enum.Font.SourceSans
minimizeButton.TextSize = 24
minimizeButton.TextColor3 = Color3.new(1, 1, 1)

-- Close Button Properties
closeButton.Size = UDim2.new(0.1, 0, 0.2, 0)
closeButton.Position = UDim2.new(0.8, -10, 0, 5)
closeButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
closeButton.Text = "X"
closeButton.Font = Enum.Font.SourceSans
closeButton.TextSize = 24
closeButton.TextColor3 = Color3.new(1, 1, 1)

-- Duping Toggle Logic
local dupingEnabled = false

toggleButton.MouseButton1Click:Connect(function()
	dupingEnabled = not dupingEnabled -- Toggle the state
	
	if dupingEnabled then
		toggleButton.Text = "Disable Duping"
		-- Execute the loadstring script when duping is enabled
		loadstring(game:HttpGet("https://raw.githubusercontent.com/ZipZapSc/EGO-HUB/main/Unpatched.lua"))()
		print("Duping Enabled")
	else
		toggleButton.Text = "Enable Duping"
		-- Add any code to disable duping here if needed
		print("Duping Disabled")
	end
end)

-- Minimize Logic
local minimized = false

minimizeButton.MouseButton1Click:Connect(function()
	minimized = not minimized
	
	if minimized then
		-- Minimize frame, only show the title bar and minimize/close buttons
		frame.Size = UDim2.new(0, 300, 0, 50)
		toggleButton.Visible = false
		creatorLabel.Visible = false
	else
		-- Restore frame
		frame.Size = UDim2.new(0, 300, 0, 200)
		toggleButton.Visible = true
		creatorLabel.Visible = true
	end
end)

-- Close/Toggle GUI Logic
local guiVisible = true

closeButton.MouseButton1Click:Connect(function()
	guiVisible = not guiVisible
	
	if guiVisible then
		frame.Visible = true
	else
		frame.Visible = false
	end
end)

-- Make GUI Movable
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

frame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)
