local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

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
Title.Size = UDim2.new(1, -20, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "Player Teleporter"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = Frame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -20, 0, 0)
CloseButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 14
CloseButton.Parent = Frame
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local SearchBar = Instance.new("TextBox")
SearchBar.Size = UDim2.new(1, -10, 0, 25)
SearchBar.Position = UDim2.new(0, 5, 0, 35)
SearchBar.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
SearchBar.TextColor3 = Color3.new(1, 1, 1)
SearchBar.PlaceholderText = "Search players..."
SearchBar.Font = Enum.Font.SourceSans
SearchBar.TextSize = 14
SearchBar.Parent = Frame

local RefreshButton = Instance.new("TextButton")
RefreshButton.Size = UDim2.new(0, 60, 0, 25)
RefreshButton.Position = UDim2.new(1, -65, 0, 35)
RefreshButton.BackgroundColor3 = Color3.new(0.3, 0.6, 0.3)
RefreshButton.TextColor3 = Color3.new(1, 1, 1)
RefreshButton.Text = "Refresh"
RefreshButton.Font = Enum.Font.SourceSans
RefreshButton.TextSize = 14
RefreshButton.Parent = Frame

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -10, 1, -70)
ScrollingFrame.Position = UDim2.new(0, 5, 0, 65)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ScrollBarThickness = 8
ScrollingFrame.Parent = Frame

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

local function updatePlayerList()
    for _, child in ipairs(ScrollingFrame:GetChildren()) do
        child:Destroy()
    end

    local searchText = string.lower(SearchBar.Text)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and (searchText == "" or string.find(string.lower(player.Name), searchText)) then
            createPlayerButton(player)
        end
    end

    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #ScrollingFrame:GetChildren() * 35)
end

updatePlayerList()
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
SearchBar:GetPropertyChangedSignal("Text"):Connect(updatePlayerList)
RefreshButton.MouseButton1Click:Connect(updatePlayerList)
