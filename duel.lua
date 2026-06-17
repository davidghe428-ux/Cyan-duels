-- Cyan Duels - Exact Visual Match Layout
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

-- Color Scheme Matching the Image
local STYLE = {
    MainBg = Color3.fromRGB(11, 14, 24),
    InnerBg = Color3.fromRGB(7, 9, 16),
    CardBg = Color3.fromRGB(15, 18, 32),
    AccentCyan = Color3.fromRGB(0, 160, 255),
    TextMain = Color3.fromRGB(230, 235, 255),
    TextHeader = Color3.fromRGB(0, 130, 255),
    TextDim = Color3.fromRGB(90, 95, 115)
}

-- --- MAIN PANEL ---
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 440, 0, 280)
MainFrame.Position = UDim2.new(0.5, -220, 0.5, -140)
MainFrame.BackgroundColor3 = STYLE.MainBg
MainFrame.BorderSizePixel = 0
MainFrame.Parent = MainFrame

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = STYLE.AccentCyan
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Top Left Status and Title
local StatusDot = Instance.new("Frame")
StatusDot.Size = UDim2.new(0, 6, 0, 6)
StatusDot.Position = UDim2.new(0, 14, 0, 16)
StatusDot.BackgroundColor3 = STYLE.AccentCyan
StatusDot.BorderSizePixel = 0
StatusDot.Parent = MainFrame

local StatusDotCorner = Instance.new("UICorner")
StatusDotCorner.CornerRadius = UDim.new(1, 0)
StatusDotCorner.Parent = StatusDot

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 120, 0, 35)
TitleLabel.Position = UDim2.new(0, 26, 0, 2)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "CYAN DUELS"
TitleLabel.TextColor3 = STYLE.AccentCyan
TitleLabel.TextSize = 14
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainFrame

-- --- SIDEBAR NAVIGATION ---
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 100, 1, -50)
Sidebar.Position = UDim2.new(0, 10, 0, 45)
Sidebar.BackgroundTransparency = 1
Sidebar.Parent = MainFrame

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Parent = Sidebar
SidebarLayout.Padding = UDim.new(0, 2)

local Tabs = {"Speed", "Steal", "Movement", "Visual"}
for i, tabName in ipairs(Tabs) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 28)
    TabBtn.BackgroundTransparency = 1
    TabBtn.Text = tabName:upper()
    TabBtn.TextColor3 = (i == 1) and STYLE.AccentCyan or STYLE.TextDim
    TabBtn.TextSize = 11
    TabBtn.Font = Enum.Font.GothamMedium
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.Parent = Sidebar
end

-- --- INNER VALUE CONTENT CONTAINER ---
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -135, 0, 160)
ContentFrame.Position = UDim2.new(0, 120, 0, 45)
ContentFrame.BackgroundColor3 = STYLE.InnerBg
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 6)
ContentCorner.Parent = ContentFrame

-- Header Category Label
local SectionHeader = Instance.new("TextLabel")
SectionHeader.Size = UDim2.new(1, -20, 0, 25)
SectionHeader.Position = UDim2.new(0, 12, 0, 8)
SectionHeader.BackgroundTransparency = 1
SectionHeader.Text = "SPEED VALUES"
SectionHeader.TextColor3 = STYLE.TextHeader
SectionHeader.TextSize = 10
SectionHeader.Font = Enum.Font.GothamBold
SectionHeader.TextXAlignment = Enum.TextXAlignment.Left
SectionHeader.Parent = ContentFrame

-- Helper function to generate rows (Normal Speed / Lagger Speed)
local function CreateValueRow(labelName, descText, carryVal, normalVal, yPos)
    local RowFrame = Instance.new("Frame")
    RowFrame.Size = UDim2.new(1, -24, 0, 50)
    RowFrame.Position = UDim2.new(0, 12, 0, yPos)
    RowFrame.BackgroundTransparency = 1
    RowFrame.Parent = ContentFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 120, 0, 18)
    Title.BackgroundTransparency = 1
    Title.Text = labelName
    Title.TextColor3 = STYLE.TextMain
    Title.TextSize = 12
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = RowFrame

    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(0, 120, 0, 14)
    Desc.Position = UDim2.new(0, 0, 0, 16)
    Desc.BackgroundTransparency = 1
    Desc.Text = descText
    Desc.TextColor3 = STYLE.TextDim
    Desc.TextSize = 9
    Desc.Font = Enum.Font.GothamMedium
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.Parent = RowFrame

    -- Labels for Carry / Normal column headers
    local CarryLbl = Instance.new("TextLabel")
    CarryLbl.Size = UDim2.new(0, 45, 0, 12)
    CarryLbl.Position = UDim2.new(1, -100, 0, 2)
    CarryLbl.BackgroundTransparency = 1
    CarryLbl.Text = "CARRY"
    CarryLbl.TextColor3 = STYLE.TextDim
    CarryLbl.TextSize = 8
    CarryLbl.Font = Enum.Font.GothamBold
    CarryLbl.Parent = RowFrame

    local NormalLbl = Instance.new("TextLabel")
    NormalLbl.Size = UDim2.new(0, 45, 0, 12)
    NormalLbl.Position = UDim2.new(1, -45, 0, 2)
    NormalLbl.BackgroundTransparency = 1
    NormalLbl.Text = "NORMAL"
    NormalLbl.TextColor3 = STYLE.TextDim
    NormalLbl.TextSize = 8
    NormalLbl.Font = Enum.Font.GothamBold
    NormalLbl.Parent = RowFrame

    -- Display boxes for values
    local CarryBox = Instance.new("TextLabel")
    CarryBox.Size = UDim2.new(0, 45, 0, 24)
    CarryBox.Position = UDim2.new(1, -100, 0, 16)
    CarryBox.BackgroundColor3 = STYLE.CardBg
    CarryBox.Text = carryVal
    CarryBox.TextColor3 = STYLE.TextMain
    CarryBox.TextSize = 11
    CarryBox.Font = Enum.Font.GothamBold
    CarryBox.Parent = RowFrame
    Instance.new("UICorner", CarryBox).CornerRadius = UDim.new(0, 4)

    local NormalBox = Instance.new("TextLabel")
    NormalBox.Size = UDim2.new(0, 45, 0, 24)
    NormalBox.Position = UDim2.new(1, -45, 0, 16)
    NormalBox.BackgroundColor3 = STYLE.CardBg
    NormalBox.Text = normalVal
    NormalBox.TextColor3 = STYLE.TextMain
    NormalBox.TextSize = 11
    NormalBox.Font = Enum.Font.GothamBold
    NormalBox.Parent = RowFrame
    Instance.new("UICorner", NormalBox).CornerRadius = UDim.new(0, 4)
end

CreateValueRow("Normal Speed", "Standard movement", "30", "60", 35)
CreateValueRow("Lagger Speed", "Low-ping lagger", "13", "13", 95)

-- --- BOTTOM PROGRESS BAR PANEL ---
local BottomPanel = Instance.new("Frame")
BottomPanel.Size = UDim2.new(1, -135, 0, 50)
BottomPanel.Position = UDim2.new(0, 120, 0, 215)
BottomPanel.BackgroundColor3 = STYLE.InnerBg
BottomPanel.BorderSizePixel = 0
BottomPanel.Parent = MainFrame

local BottomCorner = Instance.new("UICorner")
BottomCorner.CornerRadius = UDim.new(0, 6)
BottomCorner.Parent = BottomPanel

local ProgressPercent = Instance.new("TextLabel")
ProgressPercent.Size = UDim2.new(0, 50, 1, 0)
ProgressPercent.Position = UDim2.new(0, 12, 0, 0)
ProgressPercent.BackgroundTransparency = 1
ProgressPercent.Text = "0%"
ProgressPercent.TextColor3 = STYLE.AccentCyan
ProgressPercent.TextSize = 14
ProgressPercent.Font = Enum.Font.GothamBold
ProgressPercent.TextXAlignment = Enum.TextXAlignment.Left
ProgressPercent.Parent = BottomPanel

local RadiusDisplay = Instance.new("TextLabel")
RadiusDisplay.Size = UDim2.new(0, 100, 1, 0)
RadiusDisplay.Position = UDim2.new(1, -120, 0, 0)
RadiusDisplay.BackgroundTransparency = 1
RadiusDisplay.Text = "Radius: 20"
RadiusDisplay.TextColor3 = STYLE.TextMain
RadiusDisplay.TextSize = 11
RadiusDisplay.Font = Enum.Font.GothamMedium
RadiusDisplay.TextXAlignment = Enum.TextXAlignment.Right
RadiusDisplay.Parent = BottomPanel

-- --- DRAG SETUP ---
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
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
