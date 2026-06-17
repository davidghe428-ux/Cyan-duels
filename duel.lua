-- Cyan Duels - Interactive Components UI
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

if CoreGui:FindFirstChild("CyanDuelsHub") then
    CoreGui.CyanDuelsHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CyanDuelsHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local STYLE = {
    MainBg = Color3.fromRGB(11, 14, 24),
    InnerBg = Color3.fromRGB(7, 9, 16),
    CardBg = Color3.fromRGB(15, 18, 32),
    AccentCyan = Color3.fromRGB(0, 160, 255),
    TextMain = Color3.fromRGB(230, 235, 255),
    TextHeader = Color3.fromRGB(0, 130, 255),
    TextDim = Color3.fromRGB(90, 95, 115)
}

-- Main Window Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 440, 0, 320)
MainFrame.Position = UDim2.new(0.5, -220, 0.5, -160)
MainFrame.BackgroundColor3 = STYLE.MainBg
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = STYLE.AccentCyan
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Panel Content Window
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -30, 1, -50)
ContentFrame.Position = UDim2.new(0, 15, 0, 40)
ContentFrame.BackgroundColor3 = STYLE.InnerBg
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 6)
ContentCorner.Parent = ContentFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = ContentFrame
ListLayout.Padding = UDim.new(0, 10)
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 15)
Padding.Parent = ContentFrame

-- --- CUSTOM INTERACTIVE FRONTEND OBJECTS ---

-- 1. Input Box Builder
local function CreateTextBox(labelText, defaultPlaceholder)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -30, 0, 40)
    Container.BackgroundTransparency = 1
    Container.Parent = ContentFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, 150, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = labelText
    Label.TextColor3 = STYLE.TextMain
    Label.TextSize = 12
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container

    local InputBox = Instance.new("TextBox")
    InputBox.Size = UDim2.new(0, 120, 0, 26)
    InputBox.Position = UDim2.new(1, -120, 0.5, -13)
    InputBox.BackgroundColor3 = STYLE.CardBg
    InputBox.Text = ""
    InputBox.PlaceholderText = defaultPlaceholder
    InputBox.TextColor3 = STYLE.TextMain
    InputBox.PlaceholderColor3 = STYLE.TextDim
    InputBox.TextSize = 11
    InputBox.Font = Enum.Font.GothamMedium
    InputBox.Parent = Container

    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 4)
    BoxCorner.Parent = InputBox

    local BoxStroke = Instance.new("UIStroke")
    BoxStroke.Color = Color3.fromRGB(35, 40, 55)
    BoxStroke.Thickness = 1
    BoxStroke.Parent = InputBox

    InputBox.FocusLost:Connect(function(enterPressed)
        print("Input updated to: " .. InputBox.Text)
    end)
end

-- 2. Dropdown Menu Builder
local function CreateDropdown(labelText, itemsList)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -30, 0, 40)
    Container.BackgroundTransparency = 1
    Container.Parent = ContentFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, 150, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = labelText
    Label.TextColor3 = STYLE.TextMain
    Label.TextSize = 12
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container

    local DropBtn = Instance.new("TextButton")
    DropBtn.Size = UDim2.new(0, 120, 0, 26)
    DropBtn.Position = UDim2.new(1, -120, 0.5, -13)
    DropBtn.BackgroundColor3 = STYLE.CardBg
    DropBtn.Text = itemsList[1] or "Select..."
    DropBtn.TextColor3 = STYLE.TextMain
    DropBtn.TextSize = 11
    DropBtn.Font = Enum.Font.GothamMedium
    DropBtn.Parent = Container

    Instance.new("UICorner", DropBtn).CornerRadius = UDim.new(0, 4)

    -- Dropdown Open List Panel
    local DropList = Instance.new("Frame")
    DropList.Size = UDim2.new(0, 120, 0, 0)
    DropList.Position = UDim2.new(1, -120, 0.5, 15)
    DropList.BackgroundColor3 = STYLE.MainBg
    DropList.BorderSizePixel = 0
    DropList.Visible = false
    DropList.ZIndex = 5
    DropList.Parent = Container

    local ListCorner = Instance.new("UICorner")
    ListCorner.CornerRadius = UDim.new(0, 4)
    ListCorner.Parent = DropList

    local DropLayout = Instance.new("UIListLayout")
    DropLayout.Parent = DropList

    local isOpen = false
    DropBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        DropList.Visible = isOpen
        DropList.Size = isOpen and UDim2.new(0, 120, 0, #itemsList * 24) or UDim2.new(0, 120, 0, 0)
    end)

    for _, itemName in ipairs(itemsList) do
        local ItemBtn = Instance.new("TextButton")
        ItemBtn.Size = UDim2.new(1, 0, 0, 24)
        ItemBtn.BackgroundTransparency = 1
        ItemBtn.Text = itemName
        ItemBtn.TextColor3 = STYLE.TextMain
        ItemBtn.TextSize = 10
        ItemBtn.Font = Enum.Font.GothamMedium
        ItemBtn.ZIndex = 6
        ItemBtn.Parent = DropList

        ItemBtn.MouseButton1Click:Connect(function()
            DropBtn.Text = itemName
            isOpen = false
            DropList.Visible = false
            print("Selected configuration mode: " .. itemName)
        end)
    end
end

-- Generate the design controls
CreateTextBox("Target Range Value", "e.g. 50")
CreateDropdown("Preset Layout Theme", {"Cyan Neon", "Deep Midnight", "Sleek Stealth"})

-- Simple dragging script
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)
