local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Create the main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer.PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 300)
Frame.Position = UDim2.new(0.5, -100, 0.5, -150)
Frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Frame.BorderSizePixel = 2
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "Player Teleporter"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = Frame

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -10, 1, -40)
ScrollingFrame.Position = UDim2.new(0, 5, 0, 35)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ScrollBarThickness = 8
ScrollingFrame.Parent = Frame

-- Function to create a button for a player
local function createPlayerButton(player)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 0, 30)
    Button.Position = UDim2.new(0, 5, 0, (#ScrollingFrame:GetChildren() * 35))
    Button.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.Text = player.Name
    Button.Font = Enum.Font.SourceSans
    Button.TextSize = 14
    Button.Parent = ScrollingFrame

    Button.MouseButton1Click:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame)
        end
    end)
end

-- Function to update the player list
local function updatePlayerList()
    for _, child in ipairs(ScrollingFrame:GetChildren()) do
        child:Destroy()
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            createPlayerButton(player)
        end
    end

    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #ScrollingFrame:GetChildren() * 35)
end

-- Update the player list initially and when players join or leave
updatePlayerList()
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
