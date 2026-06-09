local ImpactGUI = {}
ImpactGUI.__index = ImpactGUI

-- Services
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Constants
local WHITE = Color3.fromRGB(255, 255, 255)
local BLACK = Color3.fromRGB(0, 0, 0)
local TRANSPARENT = Color3.fromRGB(0, 0, 0)

-- Utility Functions
local function CreateHexColor(hex)
    local r, g, b = hex:match("(%w%w)(%w%w)(%w%w)")
    return Color3.fromRGB(tonumber(r, 16), tonumber(g, 16), tonumber(b, 16))
end

local function Round(number)
    return math.floor(number + 0.5)
end

local function GetRandomString(length)
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local result = {}
    for i = 1, length do
        result[i] = chars:sub(math.random(1, #chars), math.random(1, #chars))
    end
    return table.concat(result)
end

-- ═══════════════════════════════════════════════════════════════════
--                            THEMES
-- ═══════════════════════════════════════════════════════════════════

ImpactGUI.Themes = {
    Dark = {
        Name = "Dark",
        Background = Color3.fromRGB(15, 15, 15),
        BackgroundAlt = Color3.fromRGB(20, 20, 20),
        Accent = Color3.fromRGB(85, 85, 255),
        AccentAlt = Color3.fromRGB(65, 65, 205),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(150, 150, 150),
        Border = Color3.fromRGB(40, 40, 40),
        ToggleOn = Color3.fromRGB(85, 170, 85),
        ToggleOff = Color3.fromRGB(100, 100, 100),
        Button = Color3.fromRGB(30, 30, 30),
        ButtonHover = Color3.fromRGB(40, 40, 40),
        Slider = Color3.fromRGB(50, 50, 50),
        SliderFill = Color3.fromRGB(85, 85, 255),
        Input = Color3.fromRGB(25, 25, 25),
        Dropdown = Color3.fromRGB(30, 30, 30),
        TabActive = Color3.fromRGB(85, 85, 255),
        TabInactive = Color3.fromRGB(25, 25, 25),
        Section = Color3.fromRGB(35, 35, 35),
        Success = Color3.fromRGB(85, 200, 85),
        Warning = Color3.fromRGB(255, 180, 50),
        Error = Color3.fromRGB(255, 85, 85),
    },
    Light = {
        Name = "Light",
        Background = Color3.fromRGB(240, 240, 240),
        BackgroundAlt = Color3.fromRGB(230, 230, 230),
        Accent = Color3.fromRGB(0, 100, 255),
        AccentAlt = Color3.fromRGB(0, 80, 200),
        Text = Color3.fromRGB(0, 0, 0),
        TextSecondary = Color3.fromRGB(100, 100, 100),
        Border = Color3.fromRGB(200, 200, 200),
        ToggleOn = Color3.fromRGB(0, 150, 0),
        ToggleOff = Color3.fromRGB(180, 180, 180),
        Button = Color3.fromRGB(220, 220, 220),
        ButtonHover = Color3.fromRGB(210, 210, 210),
        Slider = Color3.fromRGB(200, 200, 200),
        SliderFill = Color3.fromRGB(0, 100, 255),
        Input = Color3.fromRGB(235, 235, 235),
        Dropdown = Color3.fromRGB(220, 220, 220),
        TabActive = Color3.fromRGB(0, 100, 255),
        TabInactive = Color3.fromRGB(210, 210, 210),
        Section = Color3.fromRGB(215, 215, 215),
        Success = Color3.fromRGB(0, 180, 0),
        Warning = Color3.fromRGB(255, 150, 0),
        Error = Color3.fromRGB(255, 50, 50),
    },
    Synthwave = {
        Name = "Synthwave",
        Background = Color3.fromRGB(25, 15, 35),
        BackgroundAlt = Color3.fromRGB(35, 20, 45),
        Accent = Color3.fromRGB(255, 0, 160),
        AccentAlt = Color3.fromRGB(255, 50, 150),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(180, 150, 180),
        Border = Color3.fromRGB(80, 40, 80),
        ToggleOn = Color3.fromRGB(255, 0, 160),
        ToggleOff = Color3.fromRGB(80, 80, 80),
        Button = Color3.fromRGB(45, 25, 55),
        ButtonHover = Color3.fromRGB(55, 30, 65),
        Slider = Color3.fromRGB(50, 30, 60),
        SliderFill = Color3.fromRGB(255, 0, 160),
        Input = Color3.fromRGB(40, 25, 50),
        Dropdown = Color3.fromRGB(45, 25, 55),
        TabActive = Color3.fromRGB(255, 0, 160),
        TabInactive = Color3.fromRGB(30, 20, 40),
        Section = Color3.fromRGB(40, 25, 50),
        Success = Color3.fromRGB(255, 100, 200),
        Warning = Color3.fromRGB(255, 150, 0),
        Error = Color3.fromRGB(255, 50, 100),
    },
    Midnight = {
        Name = "Midnight",
        Background = Color3.fromRGB(10, 10, 20),
        BackgroundAlt = Color3.fromRGB(15, 15, 25),
        Accent = Color3.fromRGB(100, 150, 255),
        AccentAlt = Color3.fromRGB(80, 130, 235),
        Text = Color3.fromRGB(220, 220, 255),
        TextSecondary = Color3.fromRGB(120, 120, 160),
        Border = Color3.fromRGB(30, 30, 50),
        ToggleOn = Color3.fromRGB(100, 150, 255),
        ToggleOff = Color3.fromRGB(60, 60, 80),
        Button = Color3.fromRGB(20, 20, 35),
        ButtonHover = Color3.fromRGB(25, 25, 40),
        Slider = Color3.fromRGB(35, 35, 55),
        SliderFill = Color3.fromRGB(100, 150, 255),
        Input = Color3.fromRGB(20, 20, 35),
        Dropdown = Color3.fromRGB(20, 20, 35),
        TabActive = Color3.fromRGB(100, 150, 255),
        TabInactive = Color3.fromRGB(18, 18, 30),
        Section = Color3.fromRGB(22, 22, 38),
        Success = Color3.fromRGB(100, 200, 255),
        Warning = Color3.fromRGB(255, 200, 100),
        Error = Color3.fromRGB(255, 100, 120),
    },
    Emerald = {
        Name = "Emerald",
        Background = Color3.fromRGB(15, 20, 15),
        BackgroundAlt = Color3.fromRGB(20, 28, 20),
        Accent = Color3.fromRGB(50, 200, 100),
        AccentAlt = Color3.fromRGB(40, 180, 90),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(150, 180, 150),
        Border = Color3.fromRGB(35, 50, 35),
        ToggleOn = Color3.fromRGB(50, 200, 100),
        ToggleOff = Color3.fromRGB(70, 70, 70),
        Button = Color3.fromRGB(25, 35, 25),
        ButtonHover = Color3.fromRGB(30, 42, 30),
        Slider = Color3.fromRGB(40, 55, 40),
        SliderFill = Color3.fromRGB(50, 200, 100),
        Input = Color3.fromRGB(22, 30, 22),
        Dropdown = Color3.fromRGB(25, 35, 25),
        TabActive = Color3.fromRGB(50, 200, 100),
        TabInactive = Color3.fromRGB(20, 28, 20),
        Section = Color3.fromRGB(28, 38, 28),
        Success = Color3.fromRGB(100, 255, 150),
        Warning = Color3.fromRGB(255, 200, 100),
        Error = Color3.fromRGB(255, 100, 100),
    },
    Blood = {
        Name = "Blood",
        Background = Color3.fromRGB(20, 5, 5),
        BackgroundAlt = Color3.fromRGB(28, 8, 8),
        Accent = Color3.fromRGB(200, 30, 30),
        AccentAlt = Color3.fromRGB(180, 25, 25),
        Text = Color3.fromRGB(255, 200, 200),
        TextSecondary = Color3.fromRGB(150, 100, 100),
        Border = Color3.fromRGB(50, 20, 20),
        ToggleOn = Color3.fromRGB(200, 30, 30),
        ToggleOff = Color3.fromRGB(80, 30, 30),
        Button = Color3.fromRGB(35, 10, 10),
        ButtonHover = Color3.fromRGB(45, 15, 15),
        Slider = Color3.fromRGB(50, 15, 15),
        SliderFill = Color3.fromRGB(200, 30, 30),
        Input = Color3.fromRGB(30, 10, 10),
        Dropdown = Color3.fromRGB(35, 10, 10),
        TabActive = Color3.fromRGB(200, 30, 30),
        TabInactive = Color3.fromRGB(25, 8, 8),
        Section = Color3.fromRGB(40, 12, 12),
        Success = Color3.fromRGB(200, 80, 80),
        Warning = Color3.fromRGB(255, 150, 50),
        Error = Color3.fromRGB(255, 50, 50),
    },
    Galaxy = {
        Name = "Galaxy",
        Background = Color3.fromRGB(20, 10, 30),
        BackgroundAlt = Color3.fromRGB(30, 15, 45),
        Accent = Color3.fromRGB(180, 80, 255),
        AccentAlt = Color3.fromRGB(160, 60, 235),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(170, 150, 200),
        Border = Color3.fromRGB(60, 30, 90),
        ToggleOn = Color3.fromRGB(180, 80, 255),
        ToggleOff = Color3.fromRGB(70, 40, 80),
        Button = Color3.fromRGB(40, 20, 60),
        ButtonHover = Color3.fromRGB(50, 25, 70),
        Slider = Color3.fromRGB(55, 30, 80),
        SliderFill = Color3.fromRGB(180, 80, 255),
        Input = Color3.fromRGB(35, 18, 55),
        Dropdown = Color3.fromRGB(40, 20, 60),
        TabActive = Color3.fromRGB(180, 80, 255),
        TabInactive = Color3.fromRGB(32, 18, 50),
        Section = Color3.fromRGB(48, 25, 72),
        Success = Color3.fromRGB(200, 120, 255),
        Warning = Color3.fromRGB(255, 180, 80),
        Error = Color3.fromRGB(255, 100, 150),
    },
    Ocean = {
        Name = "Ocean",
        Background = Color3.fromRGB(10, 20, 30),
        BackgroundAlt = Color3.fromRGB(15, 28, 42),
        Accent = Color3.fromRGB(50, 180, 255),
        AccentAlt = Color3.fromRGB(40, 160, 235),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(130, 170, 200),
        Border = Color3.fromRGB(30, 50, 70),
        ToggleOn = Color3.fromRGB(50, 180, 255),
        ToggleOff = Color3.fromRGB(60, 70, 80),
        Button = Color3.fromRGB(22, 38, 52),
        ButtonHover = Color3.fromRGB(28, 45, 62),
        Slider = Color3.fromRGB(35, 55, 70),
        SliderFill = Color3.fromRGB(50, 180, 255),
        Input = Color3.fromRGB(20, 35, 48),
        Dropdown = Color3.fromRGB(22, 38, 52),
        TabActive = Color3.fromRGB(50, 180, 255),
        TabInactive = Color3.fromRGB(18, 30, 42),
        Section = Color3.fromRGB(28, 45, 60),
        Success = Color3.fromRGB(80, 220, 255),
        Warning = Color3.fromRGB(255, 190, 80),
        Error = Color3.fromRGB(255, 100, 120),
    },
}

-- ═══════════════════════════════════════════════════════════════════
--                         SCREEN GUI SETUP
-- ═══════════════════════════════════════════════════════════════════

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ImpactGUI_" .. GetRandomString(8)
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 6)
    corner.Parent = parent
    return corner
end

local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(60, 60, 60)
    stroke.Thickness = thickness or 1
    stroke.Parent = parent
    return stroke
end

local function CreatePadding(parent, left, top, right, bottom)
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, left or 4)
    padding.PaddingTop = UDim.new(0, top or 4)
    padding.PaddingRight = UDim.new(0, right or 4)
    padding.PaddingBottom = UDim.new(0, bottom or 4)
    padding.Parent = parent
    return padding
end

local function CreateLayout(parent, fillDirection, horizontalAlignment, verticalAlignment, padding)
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = fillDirection or Enum.FillDirection.Vertical
    layout.HorizontalAlignment = horizontalAlignment or Enum.HorizontalAlignment.Center
    layout.VerticalAlignment = verticalAlignment or Enum.VerticalAlignment.Top
    layout.Padding = UDim.new(0, padding or 2)
    layout.Parent = parent
    return layout
end

-- ═══════════════════════════════════════════════════════════════════
--                          TOGGLE CLASS
-- ═══════════════════════════════════════════════════════════════════

local Toggle = {}
Toggle.__index = Toggle

function Toggle:Update(value)
    self.Value = value
    self.StateIndicator.BackgroundColor3 = self.Parent.Theme.ToggleOn:Lerp(self.Parent.Theme.ToggleOff, value and 0 or 1)
    self.StateIndicator.Position = UDim2.new(value and 1 or 0, value and -18 or 2, 0.5, 0)
end

function Toggle:Set(value, callback)
    self:Update(value)
    if callback then
        callback(value)
    end
    if self.Callback then
        self.Callback(value)
    end
end

function Toggle:Destroy()
    self.Object:Destroy()
end

function Toggle:Disable()
    self.Object:Destroy()
end

-- ═══════════════════════════════════════════════════════════════════
--                          SLIDER CLASS
-- ═══════════════════════════════════════════════════════════════════

local Slider = {}
Slider.__index = Slider

function Slider:Update(value, fromInput)
    value = math.clamp(value, self.Min, self.Max)
    self.Value = value
    
    local percent = (value - self.Min) / (self.Max - self.Min)
    self.Fill.Size = UDim2.new(percent, 0, 1, 0)
    self.ValueText.Text = tostring(Round(value))
    
    if fromInput and self.Callback then
        self.Callback(value)
    end
end

function Slider:Set(value, callback)
    self:Update(value, false)
    if callback then
        callback(value)
    end
    if self.Callback then
        self.Callback(value)
    end
end

function Slider:Destroy()
    self.Object:Destroy()
end

-- ═══════════════════════════════════════════════════════════════════
--                          DROPDOWN CLASS
-- ═══════════════════════════════════════════════════════════════════

local Dropdown = {}
Dropdown.__index = Dropdown

function Dropdown:Open()
    self.IsOpen = true
    self.Container.Visible = true
    
    local height = math.min(#self.Options, 10) * 22 + 4
    local maxY = workspace.CurrentCamera.ViewportSize.Y
    local posY = self.Container.AbsolutePosition.Y
    
    if posY + 100 + height > maxY then
        self.Container.Position = UDim2.new(0, 0, 0, -height - 2)
    end
end

function Dropdown:Close()
    self.IsOpen = false
    self.Container.Visible = false
end

function Dropdown:Select(option)
    self.Selected = option
    self.ButtonText.Text = option
    self:Close()
    
    if self.Callback then
        self.Callback(option)
    end
end

function Dropdown:Refresh(options, callback)
    self.Options = options
    self.Container:ClearAllChildren()
    
    CreateCorner(self.Container, 6)
    
    for _, option in ipairs(options) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 20)
        btn.BackgroundColor3 = self.Parent.Theme.Button
        btn.BorderSizePixel = 0
        btn.Text = option
        btn.TextColor3 = self.Parent.Theme.Text
        btn.TextSize = 14
        btn.Font = Enum.Font.Gotham
        btn.Parent = self.Container
        
        local optionCopy = option
        btn.MouseButton1Click:Connect(function()
            self:Select(optionCopy)
            if callback then callback(optionCopy) end
        end)
        
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = self.Parent.Theme.ButtonHover}):Play()
        end)
        
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = self.Parent.Theme.Button}):Play()
        end)
    end
    
    if options[1] and not self.Selected then
        self.Selected = options[1]
        self.ButtonText.Text = options[1]
    end
end

function Dropdown:Destroy()
    self.Object:Destroy()
end

-- ═══════════════════════════════════════════════════════════════════
--                          KEYBIND CLASS
-- ═══════════════════════════════════════════════════════════════════

local Keybind = {}
Keybind.__index = Keybind

function Keybind:Listen()
    self.Listening = true
    self.ButtonText.Text = "..."
    
    local connection
    connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.Escape then
            self.Listening = false
            self.ButtonText.Text = "None"
            self.CurrentKey = nil
            connection:Disconnect()
            return
        end
        
        local key = input.KeyCode
        self.CurrentKey = key
        self.ButtonText.Text = key.Name
        self.Listening = false
        connection:Disconnect()
        
        if self.Callback then
            self.Callback(key)
        end
    end)
end

function Keybind:Destroy()
    self.Object:Destroy()
end

-- ═══════════════════════════════════════════════════════════════════
--                          TEXTBOX CLASS
-- ═══════════════════════════════════════════════════════════════════

local TextBox = {}
TextBox.__index = TextBox

function TextBox:Set(value)
    self.Input.Text = value
    self.Value = value
    if self.Callback then
        self.Callback(value)
    end
end

function TextBox:Destroy()
    self.Object:Destroy()
end

-- ═══════════════════════════════════════════════════════════════════
--                          LABEL CLASS
-- ═══════════════════════════════════════════════════════════════════

local Label = {}
Label.__index = Label

function Label:Set(text)
    self.Object.Text = text
end

function Label:Destroy()
    self.Object:Destroy()
end

-- ═══════════════════════════════════════════════════════════════════
--                          BUTTON CLASS
-- ═══════════════════════════════════════════════════════════════════

local Button = {}
Button.__index = Button

function Button:Click()
    if self.Callback then
        self.Callback()
    end
end

function Button:Destroy()
    self.Object:Destroy()
end

-- ═══════════════════════════════════════════════════════════════════
--                          TAB CLASS
-- ═══════════════════════════════════════════════════════════════════

local Tab = {}
Tab.__index = Tab

function Tab:AddSection(name)
    local Section = {}
    Section.Parent = self
    Section.Elements = {}
    
    local sectionFrame = Instance.new("Frame")
    sectionFrame.Name = name
    sectionFrame.Size = UDim2.new(1, -20, 0, 30)
    sectionFrame.BackgroundColor3 = self.Parent.Theme.Section
    sectionFrame.BorderSizePixel = 0
    sectionFrame.AutoSize = Enum.AutoSizeMode.Y
    sectionFrame.Parent = self.Content
    
    CreateCorner(sectionFrame, 8)
    CreatePadding(sectionFrame, 10, 8, 10, 8)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 20)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = name
    titleLabel.TextColor3 = self.Parent.Theme.Accent
    titleLabel.TextSize = 15
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = sectionFrame
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.BackgroundTransparency = 1
    container.AutoSize = Enum.AutoSizeMode.Y
    container.Parent = sectionFrame
    
    local layout = CreateLayout(container, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Top, 6)
    
    Section.Object = sectionFrame
    Section.Container = container
    
    -- Element creation methods
    function Section:AddToggle(name, default, callback)
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Size = UDim2.new(1, 0, 0, 26)
        toggleFrame.BackgroundTransparency = 1
        toggleFrame.Parent = container
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, -60, 1, 0)
        nameLabel.Position = UDim2.new(0, 0, 0, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = name
        nameLabel.TextColor3 = self.Parent.Parent.Theme.Text
        nameLabel.TextSize = 14
        nameLabel.Font = Enum.Font.Gotham
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Parent = toggleFrame
        
        local toggleBg = Instance.new("Frame")
        toggleBg.Size = UDim2.new(0, 40, 0, 20)
        toggleBg.Position = UDim2.new(1, -42, 0.5, 0)
        toggleBg.BackgroundColor3 = self.Parent.Parent.Theme.ToggleOff
        toggleBg.BorderSizePixel = 0
        toggleBg.Parent = toggleFrame
        
        CreateCorner(toggleBg, 6)
        
        local stateIndicator = Instance.new("Frame")
        stateIndicator.Size = UDim2.new(0, 16, 0, 16)
        stateIndicator.Position = UDim2.new(0, 2, 0.5, 0)
        stateIndicator.AnchorPoint = Vector2.new(0, 0.5)
        stateIndicator.BackgroundColor3 = self.Parent.Parent.Theme.ToggleOff
        stateIndicator.BorderSizePixel = 0
        stateIndicator.Parent = toggleBg
        
        CreateCorner(stateIndicator, 5)
        
        local toggleObj = setmetatable({
            Object = toggleFrame,
            StateIndicator = stateIndicator,
            Parent = self.Parent.Parent,
            Value = default or false,
            Callback = callback,
        }, Toggle)
        
        toggleObj:Update(default or false)
        
        toggleBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                toggleObj:Set(not toggleObj.Value)
            end
        end)
        
        table.insert(Section.Elements, toggleObj)
        return toggleObj
    end
    
    function Section:AddSlider(name, min, max, default, callback, suffix)
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Size = UDim2.new(1, 0, 0, 46)
        sliderFrame.BackgroundTransparency = 1
        sliderFrame.Parent = container
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, -50, 0, 20)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = name
        nameLabel.TextColor3 = self.Parent.Parent.Theme.Text
        nameLabel.TextSize = 14
        nameLabel.Font = Enum.Font.Gotham
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Parent = sliderFrame
        
        local valueLabel = Instance.new("TextLabel")
        valueLabel.Size = UDim2.new(0, 45, 0, 20)
        valueLabel.Position = UDim2.new(1, -47, 0, 0)
        valueLabel.BackgroundTransparency = 1
        valueLabel.Text = tostring(Round(default or min))
        valueLabel.TextColor3 = self.Parent.Parent.Theme.TextSecondary
        valueLabel.TextSize = 14
        valueLabel.Font = Enum.Font.Gotham
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right
        valueLabel.Parent = sliderFrame
        
        local sliderBg = Instance.new("Frame")
        sliderBg.Size = UDim2.new(1, 0, 0, 10)
        sliderBg.Position = UDim2.new(0, 0, 0, 28)
        sliderBg.BackgroundColor3 = self.Parent.Parent.Theme.Slider
        sliderBg.BorderSizePixel = 0
        sliderBg.Parent = sliderFrame
        
        CreateCorner(sliderBg, 5)
        
        local sliderFill = Instance.new("Frame")
        sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        sliderFill.BackgroundColor3 = self.Parent.Parent.Theme.SliderFill
        sliderFill.BorderSizePixel = 0
        sliderFill.Parent = sliderBg
        
        CreateCorner(sliderFill, 5)
        
        local sliderObj = setmetatable({
            Object = sliderFrame,
            Fill = sliderFill,
            ValueText = valueLabel,
            Parent = self.Parent.Parent,
            Min = min,
            Max = max,
            Value = default or min,
            Callback = callback,
        }, Slider)
        
        local dragging = false
        
        sliderBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        
        sliderBg.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local relativePos = (input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X
                local value = min + (max - min) * math.clamp(relativePos, 0, 1)
                sliderObj:Update(value, true)
            end
        end)
        
        table.insert(Section.Elements, sliderObj)
        return sliderObj
    end
    
    function Section:AddDropdown(name, options, default, callback)
        local dropdownFrame = Instance.new("Frame")
        dropdownFrame.Size = UDim2.new(1, 0, 0, 30)
        dropdownFrame.BackgroundTransparency = 1
        dropdownFrame.Parent = container
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0, 20)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = name
        nameLabel.TextColor3 = self.Parent.Parent.Theme.Text
        nameLabel.TextSize = 14
        nameLabel.Font = Enum.Font.Gotham
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Parent = dropdownFrame
        
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 120, 0, 24)
        button.Position = UDim2.new(1, -122, 0, 24)
        button.BackgroundColor3 = self.Parent.Parent.Theme.Dropdown
        button.BorderSizePixel = 0
        button.Text = default or (options and options[1]) or "Select"
        button.TextColor3 = self.Parent.Parent.Theme.Text
        button.TextSize = 14
        button.Font = Enum.Font.Gotham
        button.Parent = dropdownFrame
        
        CreateCorner(button, 6)
        
        local container_dropdown = Instance.new("Frame")
        container_dropdown.Size = UDim2.new(1, 0, 0, 0)
        container_dropdown.Position = UDim2.new(0, 0, 0, 50)
        container_dropdown.BackgroundColor3 = self.Parent.Parent.Theme.Dropdown
        container_dropdown.BorderSizePixel = 0
        container_dropdown.Visible = false
        container_dropdown.ZIndex = 10
        container_dropdown.AutoSize = Enum.AutoSizeMode.Y
        container_dropdown.Parent = dropdownFrame
        
        CreateCorner(container_dropdown, 6)
        
        local dropdownObj = setmetatable({
            Object = dropdownFrame,
            Container = container_dropdown,
            ButtonText = button,
            Parent = self.Parent.Parent,
            Options = options or {},
            Selected = default or (options and options[1]) or nil,
            Callback = callback,
            IsOpen = false,
        }, Dropdown)
        
        if options then
            dropdownObj:Refresh(options, callback)
        end
        
        button.MouseButton1Click:Connect(function()
            if dropdownObj.IsOpen then
                dropdownObj:Close()
            else
                dropdownObj:Open()
            end
        end)
        
        table.insert(Section.Elements, dropdownObj)
        return dropdownObj
    end
    
    function Section:AddKeybind(name, default, callback)
        local keybindFrame = Instance.new("Frame")
        keybindFrame.Size = UDim2.new(1, 0, 0, 26)
        keybindFrame.BackgroundTransparency = 1
        keybindFrame.Parent = container
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, -60, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = name
        nameLabel.TextColor3 = self.Parent.Parent.Theme.Text
        nameLabel.TextSize = 14
        nameLabel.Font = Enum.Font.Gotham
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Parent = keybindFrame
        
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 60, 0, 22)
        button.Position = UDim2.new(1, -62, 0.5, 0)
        button.BackgroundColor3 = self.Parent.Parent.Theme.Button
        button.BorderSizePixel = 0
        button.Text = default and default.Name or "None"
        button.TextColor3 = self.Parent.Parent.Theme.Text
        button.TextSize = 14
        button.Font = Enum.Font.Gotham
        button.Parent = keybindFrame
        
        CreateCorner(button, 6)
        
        local keybindObj = setmetatable({
            Object = keybindFrame,
            ButtonText = button,
            Parent = self.Parent.Parent,
            CurrentKey = default,
            Callback = callback,
            Listening = false,
        }, Keybind)
        
        button.MouseButton1Click:Connect(function()
            keybindObj:Listen()
        end)
        
        table.insert(Section.Elements, keybindObj)
        return keybindObj
    end
    
    function Section:AddTextBox(name, default, placeholder, callback)
        local textboxFrame = Instance.new("Frame")
        textboxFrame.Size = UDim2.new(1, 0, 0, 30)
        textboxFrame.BackgroundTransparency = 1
        textboxFrame.Parent = container
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0, 20)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = name
        nameLabel.TextColor3 = self.Parent.Parent.Theme.Text
        nameLabel.TextSize = 14
        nameLabel.Font = Enum.Font.Gotham
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Parent = textboxFrame
        
        local input = Instance.new("TextBox")
        input.Size = UDim2.new(0, 120, 0, 22)
        input.Position = UDim2.new(1, -122, 0, 26)
        input.BackgroundColor3 = self.Parent.Parent.Theme.Input
        input.BorderSizePixel = 0
        input.Text = default or ""
        input.PlaceholderText = placeholder or ""
        input.PlaceholderColor3 = self.Parent.Parent.Theme.TextSecondary
        input.TextColor3 = self.Parent.Parent.Theme.Text
        input.TextSize = 14
        input.Font = Enum.Font.Gotham
        input.ClearTextOnFocus = false
        input.Parent = textboxFrame
        
        CreateCorner(input, 6)
        
        local textboxObj = setmetatable({
            Object = textboxFrame,
            Input = input,
            Parent = self.Parent.Parent,
            Value = default or "",
            Callback = callback,
        }, TextBox)
        
        input.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                textboxObj:Set(input.Text)
            end
        end)
        
        table.insert(Section.Elements, textboxObj)
        return textboxObj
    end
    
    function Section:AddLabel(text, color)
        local labelFrame = Instance.new("TextLabel")
        labelFrame.Size = UDim2.new(1, 0, 0, 20)
        labelFrame.BackgroundTransparency = 1
        labelFrame.Text = text
        labelFrame.TextColor3 = color or self.Parent.Parent.Theme.Text
        labelFrame.TextSize = 14
        labelFrame.Font = Enum.Font.Gotham
        labelFrame.TextXAlignment = Enum.TextXAlignment.Left
        labelFrame.Parent = container
        
        local labelObj = setmetatable({
            Object = labelFrame,
        }, Label)
        
        table.insert(Section.Elements, labelObj)
        return labelObj
    end
    
    function Section:AddButton(name, callback)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 0, 30)
        button.BackgroundColor3 = self.Parent.Parent.Theme.Button
        button.BorderSizePixel = 0
        button.Text = name
        button.TextColor3 = self.Parent.Parent.Theme.Text
        button.TextSize = 14
        button.Font = Enum.Font.Gotham
        button.Parent = container
        
        CreateCorner(button, 6)
        
        local btnObj = setmetatable({
            Object = button,
            Callback = callback,
        }, Button)
        
        button.MouseButton1Click:Connect(function()
            btnObj:Click()
        end)
        
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = self.Parent.Parent.Theme.ButtonHover}):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = self.Parent.Parent.Theme.Button}):Play()
        end)
        
        table.insert(Section.Elements, btnObj)
        return btnObj
    end
    
    function Section:AddSeparator()
        local sep = Instance.new("Frame")
        sep.Size = UDim2.new(1, 0, 0, 1)
        sep.BackgroundColor3 = self.Parent.Parent.Theme.Border
        sep.BorderSizePixel = 0
        sep.Parent = container
        table.insert(Section.Elements, {Object = sep})
        return sep
    end
    
    function Section:AddColorPicker(name, default, callback)
        local pickerFrame = Instance.new("Frame")
        pickerFrame.Size = UDim2.new(1, 0, 0, 30)
        pickerFrame.BackgroundTransparency = 1
        pickerFrame.Parent = container
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, -60, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = name
        nameLabel.TextColor3 = self.Parent.Parent.Theme.Text
        nameLabel.TextSize = 14
        nameLabel.Font = Enum.Font.Gotham
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Parent = pickerFrame
        
        local colorDisplay = Instance.new("Frame")
        colorDisplay.Size = UDim2.new(0, 50, 0, 22)
        colorDisplay.Position = UDim2.new(1, -52, 0.5, 0)
        colorDisplay.BackgroundColor3 = default or Color3.fromRGB(255, 85, 255)
        colorDisplay.BorderSizePixel = 0
        colorDisplay.Parent = pickerFrame
        
        CreateCorner(colorDisplay, 6)
        CreateStroke(colorDisplay, self.Parent.Parent.Theme.Border, 1)
        
        return {
            Set = function(color)
                colorDisplay.BackgroundColor3 = color
                if callback then callback(color) end
            end
        }
    end
    
    function Section:AddInfoBox(text, boxType, callback)
        local infoFrame = Instance.new("Frame")
        infoFrame.Size = UDim2.new(1, 0, 0, 40)
        infoFrame.BackgroundColor3 = boxType == "warning" and self.Parent.Parent.Theme.Warning * 0.2 + Color3.fromRGB(15, 15, 15)
            or boxType == "error" and self.Parent.Parent.Theme.Error * 0.2 + Color3.fromRGB(15, 15, 15)
            or self.Parent.Parent.Theme.Accent * 0.2 + Color3.fromRGB(15, 15, 15)
        infoFrame.BorderSizePixel = 0
        infoFrame.Parent = container
        
        CreateCorner(infoFrame, 8)
        
        local infoLabel = Instance.new("TextLabel")
        infoLabel.Size = UDim2.new(1, -20, 1, 0)
        infoLabel.Position = UDim2.new(0, 10, 0, 0)
        infoLabel.BackgroundTransparency = 1
        infoLabel.Text = text
        infoLabel.TextColor3 = self.Parent.Parent.Theme.Text
        infoLabel.TextSize = 13
        infoLabel.Font = Enum.Font.Gotham
        infoLabel.TextWrapped = true
        infoLabel.TextXAlignment = Enum.TextXAlignment.Left
        infoLabel.Parent = infoFrame
        
        return infoFrame
    end
    
    return Section
end

function Tab:Select()
    for _, tab in ipairs(self.Parent.Tabs) do
        tab.Button.BackgroundColor3 = self.Parent.Theme.TabInactive
    end
    self.Button.BackgroundColor3 = self.Parent.Theme.TabActive
    
    for _, content in ipairs(self.Parent.ContentContainer:GetChildren()) do
        content.Visible = false
    end
    self.Content.Visible = true
end

function Tab:Destroy()
    self.Object:Destroy()
end

-- ═══════════════════════════════════════════════════════════════════
--                          WINDOW CLASS
-- ═══════════════════════════════════════════════════════════════════

local Window = {}
Window.__index = Window

function Window:AddTab(name, icon)
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0, icon and 110 or 100, 0, 36)
    tabButton.BackgroundColor3 = self.Theme.TabInactive
    tabButton.BorderSizePixel = 0
    tabButton.Text = (icon or "") .. (icon and " " or "") .. name
    tabButton.TextColor3 = self.Theme.Text
    tabButton.TextSize = 14
    tabButton.Font = Enum.Font.GothamSemibold
    tabButton.Parent = self.TabContainer
    
    CreateCorner(tabButton, 8)
    
    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.Position = UDim2.new(0, 10, 0, 10)
    tabContent.BackgroundTransparency = 1
    tabContent.BorderSizePixel = 0
    tabContent.ScrollBarThickness = 4
    tabContent.ScrollBarImageColor3 = self.Theme.Accent
    tabContent.ScrollBarImageTransparency = 0.5
    tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabContent.Visible = false
    tabContent.Parent = self.ContentContainer
    
    local tabObj = setmetatable({
        Object = tabButton,
        Content = tabContent,
        Button = tabButton,
        Parent = self,
        Sections = {},
    }, Tab)
    
    tabButton.MouseButton1Click:Connect(function()
        tabObj:Select()
    end)
    
    table.insert(self.Tabs, tabObj)
    
    if #self.Tabs == 1 then
        tabObj:Select()
    end
    
    return tabObj
end

function Window:Show()
    self.Main.Visible = true
end

function Window:Hide()
    self.Main.Visible = false
end

function Window:Close()
    self.Main:Destroy()
end

function Window:Destroy()
    self.Main:Destroy()
end

function Window:SetTheme(theme)
    self.Theme = theme
    
    self.Main.BackgroundColor3 = theme.Background
    self.TitleBar.BackgroundColor3 = theme.BackgroundAlt
    self.TitleText.TextColor3 = theme.Text
    self.CloseButton.TextColor3 = theme.Text
    self.MinimizeButton.TextColor3 = theme.Text
    
    for _, tab in ipairs(self.Tabs) do
        tab.Button.BackgroundColor3 = theme.TabInactive
        for _, section in ipairs(tab.Sections) do
            section.Object.BackgroundColor3 = theme.Section
        end
    end
    
    if self.Tabs[1] then
        self.Tabs[1]:Select()
    end
end

function Window:LoadConfig(name)
    local success, data = pcall(function()
        return game:GetService("HttpService"):JSONDecode(readfile(name .. ".json"))
    end)
    
    if success and data then
        -- Config loading implementation
    end
end

function Window:SaveConfig(name)
    local config = {}
    -- Save all toggle, slider, dropdown values
    
    local success = pcall(function()
        writefile(name .. ".json", game:GetService("HttpService"):JSONEncode(config))
    end)
    
    return success
end

function Window:Notify(title, message, duration)
    duration = duration or 3
    
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, 280, 0, 70)
    notification.Position = UDim2.new(1, -300, 1, -100)
    notification.BackgroundColor3 = self.Theme.Background
    notification.BorderSizePixel = 0
    notification.Parent = ScreenGui
    
    CreateCorner(notification, 10)
    CreateStroke(notification, self.Theme.Accent, 1)
    
    local notifTitle = Instance.new("TextLabel")
    notifTitle.Size = UDim2.new(1, -20, 0, 20)
    notifTitle.Position = UDim2.new(0, 10, 0, 10)
    notifTitle.BackgroundTransparency = 1
    notifTitle.Text = title
    notifTitle.TextColor3 = self.Theme.Accent
    notifTitle.TextSize = 14
    notifTitle.Font = Enum.Font.GothamBold
    notifTitle.TextXAlignment = Enum.TextXAlignment.Left
    notifTitle.Parent = notification
    
    local notifMsg = Instance.new("TextLabel")
    notifMsg.Size = UDim2.new(1, -20, 0, 20)
    notifMsg.Position = UDim2.new(0, 10, 0, 35)
    notifMsg.BackgroundTransparency = 1
    notifMsg.Text = message
    notifMsg.TextColor3 = self.Theme.Text
    notifMsg.TextSize = 13
    notifMsg.Font = Enum.Font.Gotham
    notifMsg.TextXAlignment = Enum.TextXAlignment.Left
    notifMsg.Parent = notification
    
    notification:TweenPosition(UDim2.new(1, -300, 1, -100), "Out", "Quart", 0.3, true)
    
    task.delay(duration, function()
        notification:TweenPosition(UDim2.new(1, 20, 1, 100), "In", "Quart", 0.3, true, function()
            notification:Destroy()
        end)
    end)
    
    return notification
end

-- ═══════════════════════════════════════════════════════════════════
--                       MAIN CREATE FUNCTION
-- ═══════════════════════════════════════════════════════════════════

function ImpactGUI:CreateWindow(options)
    options = options or {}
    
    local window = setmetatable({
        Name = options.Name or "Impact GUI",
        Key = options.Key or Enum.KeyCode.RightControl,
        ToggleKey = options.ToggleKey,
        Theme = ImpactGUI.Themes[options.Theme] or ImpactGUI.Themes.Dark,
        Tabs = {},
        Visible = true,
    }, Window)
    
    ScreenGui.Parent = game:GetService("CoreGui")
    
    local mainWindow = Instance.new("Frame")
    mainWindow.Name = "MainWindow"
    mainWindow.Size = UDim2.new(0, options.Width or 550, 0, options.Height or 400)
    mainWindow.Position = options.Position or UDim2.new(0.5, -(options.Width or 550) / 2, 0.5, -(options.Height or 400) / 2)
    mainWindow.BackgroundColor3 = window.Theme.Background
    mainWindow.BorderSizePixel = 0
    mainWindow.Parent = ScreenGui
    
    CreateCorner(mainWindow, 12)
    CreateStroke(mainWindow, window.Theme.Border, 1)
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = window.Theme.BackgroundAlt
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainWindow
    
    CreateCorner(titleBar, 12, 12, 0, 0)
    
    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, -80, 1, 0)
    titleText.Position = UDim2.new(0, 15, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = window.Name
    titleText.TextColor3 = window.Theme.Text
    titleText.TextSize = 16
    titleText.Font = Enum.Font.GothamBold
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = titleBar
    
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -35, 0.5, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    closeButton.BorderSizePixel = 0
    closeButton.Text = "×"
    closeButton.TextColor3 = WHITE
    closeButton.TextSize = 20
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = titleBar
    
    CreateCorner(closeButton, 6)
    
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 30, 0, 30)
    minimizeButton.Position = UDim2.new(1, -70, 0.5, 0)
    minimizeButton.BackgroundColor3 = window.Theme.Button
    minimizeButton.BorderSizePixel = 0
    minimizeButton.Text = "−"
    minimizeButton.TextColor3 = window.Theme.Text
    minimizeButton.TextSize = 20
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.Parent = titleBar
    
    CreateCorner(minimizeButton, 6)
    
    -- Tab Container
    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Size = UDim2.new(1, -20, 0, 44)
    tabContainer.Position = UDim2.new(0, 10, 0, 48)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = mainWindow
    
    local tabLayout = CreateLayout(tabContainer, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Top, 8)
    
    -- Content Container
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "ContentContainer"
    contentContainer.Size = UDim2.new(1, -20, 1, -100)
    contentContainer.Position = UDim2.new(0, 10, 0, 100)
    contentContainer.BackgroundTransparency = 1
    contentContainer.Parent = mainWindow
    
    window.Main = mainWindow
    window.TitleBar = titleBar
    window.TitleText = titleText
    window.CloseButton = closeButton
    window.MinimizeButton = minimizeButton
    window.TabContainer = tabContainer
    window.ContentContainer = contentContainer
    
    -- Close Button
    closeButton.MouseButton1Click:Connect(function()
        window:Close()
    end)
    
    -- Minimize Button
    minimizeButton.MouseButton1Click:Connect(function()
        window:Hide()
    end)
    
    -- Dragging
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainWindow.Position
        end
    end)
    
    titleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    titleBar.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            mainWindow.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Toggle Key
    if window.ToggleKey then
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == window.ToggleKey then
                if window.Visible then
                    window:Hide()
                else
                    window:Show()
                end
            end
        end)
    end
    
    -- Main Key
    if window.Key then
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == window.Key then
                window:Show()
            end
        end)
    end
    
    return window
end

-- Final setup
ScreenGui.Parent = game:GetService("CoreGui")

return ImpactGUI