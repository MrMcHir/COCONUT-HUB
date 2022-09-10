local lib = {RainbowColorValue = 0, HueSelectionPosition = 0}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local PresetColor = Color3.fromRGB(44, 120, 224)
local CloseBind = Enum.KeyCode.RightControl
local SectionPreset = game:GetObjects("rbxassetid://7121846230")[1]
local WhitelistedMouse = {
    Enum.UserInputType.MouseButton1,
    Enum.UserInputType.MouseButton2,
    Enum.UserInputType.MouseButton3
}
local BlacklistedKeys = {
    Enum.KeyCode.Unknown,
    Enum.KeyCode.W,
    Enum.KeyCode.A,
    Enum.KeyCode.S,
    Enum.KeyCode.D,
    Enum.KeyCode.Up,
    Enum.KeyCode.Left,
    Enum.KeyCode.Down,
    Enum.KeyCode.Right,
    Enum.KeyCode.Slash,
    Enum.KeyCode.Tab,
    Enum.KeyCode.Backspace,
    Enum.KeyCode.Escape
}

local function CheckKey(tab, key)
    for i, v in next, tab do
        if v == key then
            return true
        end
    end
end

local ui = Instance.new("ScreenGui")
ui.Name = "ui"
ui.Parent = game.CoreGui
ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

coroutine.wrap(
    function()
        while wait() do
            lib.RainbowColorValue = lib.RainbowColorValue + 1 / 255
            lib.HueSelectionPosition = lib.HueSelectionPosition + 1

            if lib.RainbowColorValue >= 1 then
                lib.RainbowColorValue = 0
            end

            if lib.HueSelectionPosition == 80 then
                lib.HueSelectionPosition = 0
            end
        end
    end
)()

local function MakeDraggable(topbarobject, object)
    local Dragging = nil
    local DragInput = nil
    local DragStart = nil
    local StartPosition = nil

    local function Update(input)
        local Delta = input.Position - DragStart
        local pos =
            UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
        object.Position = pos
    end

    topbarobject.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                DragStart = input.Position
                StartPosition = object.Position

                input.Changed:Connect(
                    function()
                        if input.UserInputState == Enum.UserInputState.End then
                            Dragging = false
                        end
                    end
                )
            end
        end
    )

    topbarobject.InputChanged:Connect(
        function(input)
            if
                input.UserInputType == Enum.UserInputType.MouseMovement or
                    input.UserInputType == Enum.UserInputType.Touch
             then
                DragInput = input
            end
        end
    )

    UserInputService.InputChanged:Connect(
        function(input)
            if input == DragInput and Dragging then
                Update(input)
            end
        end
    )
end

function lib:Window(text, preset, closebind)
    CloseBind = closebind or Enum.KeyCode.RightControl
    PresetColor = preset or Color3.fromRGB(44, 120, 224)
    fs = false
    local Main = Instance.new("Frame")
    local TabHold = Instance.new("Frame")
    local TabHoldLayout = Instance.new("UIListLayout")
    local Title = Instance.new("TextLabel")
    local TabFolder = Instance.new("Folder")
    local DragFrame = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")

    Main.Name = "Main"
    Main.Parent = ui
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.ClipsDescendants = true
    Main.Visible = true

    MainCorner.CornerRadius = UDim.new(0, 3)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    TabHold.Name = "TabHold"
    TabHold.Parent = Main
    TabHold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabHold.BackgroundTransparency = 1.000
    TabHold.Position = UDim2.new(0.0339285731, 0, 0.147335425, 0)
    TabHold.Size = UDim2.new(0, 107, 0, 254)

    TabHoldLayout.Name = "TabHoldLayout"
    TabHoldLayout.Parent = TabHold
    TabHoldLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabHoldLayout.Padding = UDim.new(0, 11)

    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0.0339285731, 0, 0.0564263314, 0)
    Title.Size = UDim2.new(0, 200, 0, 23)
    Title.Font = Enum.Font.GothamSemibold
    Title.Text = text
    Title.TextColor3 = Color3.fromRGB(68, 68, 68)
    Title.TextSize = 12.000
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.RichText = true

    DragFrame.Name = "DragFrame"
    DragFrame.Parent = Main
    DragFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DragFrame.BackgroundTransparency = 1.000
    DragFrame.Size = UDim2.new(0, 560, 0, 41)

    Main:TweenSize(UDim2.new(0, 560, 0, 319), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)

    MakeDraggable(DragFrame, Main)

    local uitoggled = false
    UserInputService.InputBegan:Connect(
        function(io, p)
            if io.KeyCode == CloseBind then
                if uitoggled == false then
                    Main:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
                    uitoggled = true
                    wait(.5)
                    Main.Visible = false
                else
                    Main:TweenSize(
                        UDim2.new(0, 560, 0, 319),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .6,
                        true
                    )
                    wait(.5)
                    Main.Visible = true
                    uitoggled = false
                end
            end
        end
    )

    function lib:AddToolTip(InfoStr, HoverInstance)
        local X, Y = lib:GetTextBounds(InfoStr, Enum.Font.Code, 14);
        local Tooltip = lib:Create('Frame', {
            Size = UDim2.fromOffset(X + 5, Y + 4),
            ZIndex = 100,
            Parent = lib.ScreenGui,
    
            Visible = false,
        })
    
        local Label = lib:CreateLabel({
            Position = UDim2.fromOffset(3, 1),
            Size = UDim2.fromOffset(X, Y);
            TextSize = 14;
            Text = InfoStr,
            TextColor3 = Color3.fromRGB(255,255,255),
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = Tooltip.ZIndex + 1,
    
            Parent = Tooltip;
        });
    
        lib:AddToRegistry(Tooltip, {
            BackgroundColor3 = Color3.fromRGB(25, 25, 25);
            BorderColor3 = Color3.fromRGB(68, 68, 68);
        });
    
        lib:AddToRegistry(Label, {
            TextColor3 = Color3.fromRGB(255,255,255),
        });
        
        local IsHovering = false
        HoverInstance.MouseEnter:Connect(function()
            IsHovering = true
            
            Tooltip.Position = UDim2.fromOffset(Mouse.X + 15, Mouse.Y + 12)
            Tooltip.Visible = true
    
            while IsHovering do
                RunService.Heartbeat:Wait()
                Tooltip.Position = UDim2.fromOffset(Mouse.X + 15, Mouse.Y + 12)
            end
        end)
    
        HoverInstance.MouseLeave:Connect(function()
            IsHovering = false
            Tooltip.Visible = false
        end)
    end

    TabFolder.Name = "TabFolder"
    TabFolder.Parent = Main

    function lib:ChangePresetColor(toch)
        PresetColor = toch
    end

    function lib:Notification(texttitle, textdesc, textbtn)
        local NotificationHold = Instance.new("TextButton")
        local NotificationFrame = Instance.new("Frame")
        local OkayBtn = Instance.new("TextButton")
        local OkayBtnCorner = Instance.new("UICorner")
        local OkayBtnTitle = Instance.new("TextLabel")
        local NotificationTitle = Instance.new("TextLabel")
        local NotificationDesc = Instance.new("TextLabel")

        NotificationHold.Name = "NotificationHold"
        NotificationHold.Parent = Main
        NotificationHold.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        NotificationHold.BackgroundTransparency = 1.000
        NotificationHold.BorderSizePixel = 0
        NotificationHold.Size = UDim2.new(0, 560, 0, 319)
        NotificationHold.AutoButtonColor = false
        NotificationHold.Font = Enum.Font.SourceSans
        NotificationHold.Text = ""
        NotificationHold.TextColor3 = Color3.fromRGB(0, 0, 0)
        NotificationHold.TextSize = 14.000

        TweenService:Create(
            NotificationHold,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.7}
        ):Play()
        wait(0.4)

        NotificationFrame.Name = "NotificationFrame"
        NotificationFrame.Parent = NotificationHold
        NotificationFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        NotificationFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        NotificationFrame.BorderSizePixel = 0
        NotificationFrame.ClipsDescendants = true
        NotificationFrame.Position = UDim2.new(0.5, 0, 0.498432577, 0)

        NotificationFrame:TweenSize(
            UDim2.new(0, 164, 0, 193),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            .6,
            true
        )

        OkayBtn.Name = "OkayBtn"
        OkayBtn.Parent = NotificationFrame
        OkayBtn.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
        OkayBtn.Position = UDim2.new(0.0609756112, 0, 0.720207274, 0)
        OkayBtn.Size = UDim2.new(0, 144, 0, 42)
        OkayBtn.AutoButtonColor = false
        OkayBtn.Font = Enum.Font.SourceSans
        OkayBtn.Text = ""
        OkayBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        OkayBtn.TextSize = 14.000

        OkayBtnCorner.CornerRadius = UDim.new(0, 5)
        OkayBtnCorner.Name = "OkayBtnCorner"
        OkayBtnCorner.Parent = OkayBtn

        OkayBtnTitle.Name = "OkayBtnTitle"
        OkayBtnTitle.Parent = OkayBtn
        OkayBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.BackgroundTransparency = 1.000
        OkayBtnTitle.Position = UDim2.new(0.0763888881, 0, 0, 0)
        OkayBtnTitle.Size = UDim2.new(0, 181, 0, 42)
        OkayBtnTitle.Font = Enum.Font.Gotham
        OkayBtnTitle.Text = textbtn
        OkayBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.TextSize = 14.000
        OkayBtnTitle.TextXAlignment = Enum.TextXAlignment.Left

        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Parent = NotificationFrame
        NotificationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.BackgroundTransparency = 1.000
        NotificationTitle.Position = UDim2.new(0.0670731738, 0, 0.0829015523, 0)
        NotificationTitle.Size = UDim2.new(0, 143, 0, 26)
        NotificationTitle.Font = Enum.Font.Gotham
        NotificationTitle.Text = texttitle
        NotificationTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.TextSize = 18.000
        NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left

        NotificationDesc.Name = "NotificationDesc"
        NotificationDesc.Parent = NotificationFrame
        NotificationDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationDesc.BackgroundTransparency = 1.000
        NotificationDesc.Position = UDim2.new(0.0670000017, 0, 0.218999997, 0)
        NotificationDesc.Size = UDim2.new(0, 143, 0, 91)
        NotificationDesc.Font = Enum.Font.Gotham
        NotificationDesc.Text = textdesc
        NotificationDesc.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotificationDesc.TextSize = 15.000
        NotificationDesc.TextWrapped = true
        NotificationDesc.TextXAlignment = Enum.TextXAlignment.Left
        NotificationDesc.TextYAlignment = Enum.TextYAlignment.Top

        OkayBtn.MouseEnter:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(37, 37, 37)}
                ):Play()
            end
        )

        OkayBtn.MouseLeave:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(34, 34, 34)}
                ):Play()
            end
        )

        OkayBtn.MouseButton1Click:Connect(
            function()
                NotificationFrame:TweenSize(
                    UDim2.new(0, 0, 0, 0),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .6,
                    true
                )

                wait(0.4)

                TweenService:Create(
                    NotificationHold,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 1}
                ):Play()

                wait(.3)

                NotificationHold:Destroy()
            end
        )
    end

    local tabhold = {}
    function tabhold:Tab(text)
        local TabBtn = Instance.new("TextButton")
        local TabTitle = Instance.new("TextLabel")
        local TabBtnIndicator = Instance.new("Frame")
        local TabBtnIndicatorCorner = Instance.new("UICorner")

        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabHold
        TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.BackgroundTransparency = 1.000
        TabBtn.Size = UDim2.new(0, 107, 0, 21)
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000

        TabTitle.Name = "TabTitle"
        TabTitle.Parent = TabBtn
        TabTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabTitle.BackgroundTransparency = 1.000
        TabTitle.Size = UDim2.new(0, 107, 0, 21)
        TabTitle.Font = Enum.Font.Gotham
        TabTitle.Text = text
        TabTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabTitle.TextSize = 14.000
        TabTitle.TextXAlignment = Enum.TextXAlignment.Left

        TabBtnIndicator.Name = "TabBtnIndicator"
        TabBtnIndicator.Parent = TabBtn
        TabBtnIndicator.BackgroundColor3 = PresetColor
        TabBtnIndicator.BorderSizePixel = 0
        TabBtnIndicator.Position = UDim2.new(0, 0, 1, 0)
        TabBtnIndicator.Size = UDim2.new(0, 0, 0, 2)

        TabBtnIndicatorCorner.Name = "TabBtnIndicatorCorner"
        TabBtnIndicatorCorner.Parent = TabBtnIndicator

        coroutine.wrap(
            function()
                while wait() do
                    TabBtnIndicator.BackgroundColor3 = PresetColor
                end
            end
        )()

        local Tab = Instance.new("ScrollingFrame")
        local TabLayout = Instance.new("UIListLayout")

        Tab.Name = "Tab"
        Tab.Parent = TabFolder
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tab.BackgroundTransparency = 1.000
        Tab.BorderSizePixel = 0
        Tab.Position = UDim2.new(0.31400001, 0, 0.147, 0)
        Tab.Size = UDim2.new(0, 373, 0, 254)
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.ScrollBarThickness = 3
        Tab.Visible = false

        TabLayout.Name = "TabLayout"
        TabLayout.Parent = Tab
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 6)

        if fs == false then
            fs = true
            TabBtnIndicator.Size = UDim2.new(0, 13, 0, 2)
            TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            Tab.Visible = true
        end

        TabBtn.MouseButton1Click:Connect(
            function()
                for i, v in next, TabFolder:GetChildren() do
                    if v.Name == "Tab" then
                        v.Visible = false
                    end
                    Tab.Visible = true
                end
                for i, v in next, TabHold:GetChildren() do
                    if v.Name == "TabBtn" then
                        v.TabBtnIndicator:TweenSize(
                            UDim2.new(0, 0, 0, 2),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TabBtnIndicator:TweenSize(
                            UDim2.new(0, 13, 0, 2),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            v.TabTitle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(150, 150, 150)}
                        ):Play()
                        TweenService:Create(
                            TabTitle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                    end
                end
            end
        )
        local SectionHold = {}
        function SectionHold:Section(text)
            local Section = SectionPreset:Clone()
            Section.Parent = Tab
            Section.SectionTitle.Text = text
            Section.SectionTitle.TextColor3 = Color3.fromRGB(155, 155, 155)

            spawn(
                function()
                    while wait() do
                        Section.Size = UDim2.new(0.9, 0, 0, Section.UIListLayout.AbsoluteContentSize.Y)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    end
                end
            )
            local ItemHold = {}
            function ItemHold:Button(text, callback)
                local Button = Instance.new("TextButton")
                local ButtonCorner = Instance.new("UICorner")
                local ButtonTitle = Instance.new("TextLabel")

                Button.Name = "Button"
                Button.Parent = Section
                Button.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                Button.Size = UDim2.new(0, 363, 0, 42)
                Button.AutoButtonColor = false
                Button.Font = Enum.Font.SourceSans
                Button.Text = ""
                Button.TextColor3 = Color3.fromRGB(0, 0, 0)
                Button.TextSize = 14.000

                ButtonCorner.CornerRadius = UDim.new(0, 5)
                ButtonCorner.Name = "ButtonCorner"
                ButtonCorner.Parent = Button

                ButtonTitle.Name = "ButtonTitle"
                ButtonTitle.Parent = Button
                ButtonTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ButtonTitle.BackgroundTransparency = 1.000
                ButtonTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
                ButtonTitle.Size = UDim2.new(0, 187, 0, 42)
                ButtonTitle.Font = Enum.Font.Gotham
                ButtonTitle.Text = text
                ButtonTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                ButtonTitle.TextSize = 14.000
                ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left

                Button.MouseEnter:Connect(
                    function()
                        TweenService:Create(
                            Button,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(37, 37, 37)}
                        ):Play()
                    end
                )

                Button.MouseLeave:Connect(
                    function()
                        TweenService:Create(
                            Button,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(34, 34, 34)}
                        ):Play()
                    end
                )

                Button.MouseButton1Click:Connect(
                    function()
                        pcall(callback)
                    end
                )

                Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)

                local Button = {}

                function Button:AddTooltip(tip)
                    if type(tip) == 'string' then
                        lib:AddToolTip(tip, Outer)
                    end
                    return Button
                end
            end

            function ItemHold:Toggle(text, default, callback)
                local toggled = false

                local Toggle = Instance.new("TextButton")
                local ToggleCorner = Instance.new("UICorner")
                local ToggleTitle = Instance.new("TextLabel")
                local FrameToggle1 = Instance.new("Frame")
                local FrameToggle1Corner = Instance.new("UICorner")
                local FrameToggle2 = Instance.new("Frame")
                local FrameToggle2Corner = Instance.new("UICorner")
                local FrameToggle3 = Instance.new("Frame")
                local FrameToggle3Corner = Instance.new("UICorner")
                local FrameToggleCircle = Instance.new("Frame")
                local FrameToggleCircleCorner = Instance.new("UICorner")

                Toggle.Name = "Toggle"
                Toggle.Parent = Section
                Toggle.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                Toggle.Position = UDim2.new(0.215625003, 0, 0.446271926, 0)
                Toggle.Size = UDim2.new(0, 363, 0, 42)
                Toggle.AutoButtonColor = false
                Toggle.Font = Enum.Font.SourceSans
                Toggle.Text = ""
                Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
                Toggle.TextSize = 14.000

                ToggleCorner.CornerRadius = UDim.new(0, 5)
                ToggleCorner.Name = "ToggleCorner"
                ToggleCorner.Parent = Toggle

                ToggleTitle.Name = "ToggleTitle"
                ToggleTitle.Parent = Toggle
                ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleTitle.BackgroundTransparency = 1.000
                ToggleTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
                ToggleTitle.Size = UDim2.new(0, 187, 0, 42)
                ToggleTitle.Font = Enum.Font.Gotham
                ToggleTitle.Text = text
                ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleTitle.TextSize = 14.000
                ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

                FrameToggle1.Name = "FrameToggle1"
                FrameToggle1.Parent = Toggle
                FrameToggle1.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                FrameToggle1.Position = UDim2.new(0.859504104, 0, 0.285714298, 0)
                FrameToggle1.Size = UDim2.new(0, 37, 0, 18)

                FrameToggle1Corner.Name = "FrameToggle1Corner"
                FrameToggle1Corner.Parent = FrameToggle1

                FrameToggle2.Name = "FrameToggle2"
                FrameToggle2.Parent = FrameToggle1
                FrameToggle2.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                FrameToggle2.Position = UDim2.new(0.0489999987, 0, 0.0930000022, 0)
                FrameToggle2.Size = UDim2.new(0, 33, 0, 14)

                FrameToggle2Corner.Name = "FrameToggle2Corner"
                FrameToggle2Corner.Parent = FrameToggle2

                FrameToggle3.Name = "FrameToggle3"
                FrameToggle3.Parent = FrameToggle1
                FrameToggle3.BackgroundColor3 = PresetColor
                FrameToggle3.BackgroundTransparency = 1.000
                FrameToggle3.Size = UDim2.new(0, 37, 0, 18)

                FrameToggle3Corner.Name = "FrameToggle3Corner"
                FrameToggle3Corner.Parent = FrameToggle3

                FrameToggleCircle.Name = "FrameToggleCircle"
                FrameToggleCircle.Parent = FrameToggle1
                FrameToggleCircle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                FrameToggleCircle.Position = UDim2.new(0.127000004, 0, 0.222000003, 0)
                FrameToggleCircle.Size = UDim2.new(0, 10, 0, 10)

                FrameToggleCircleCorner.Name = "FrameToggleCircleCorner"
                FrameToggleCircleCorner.Parent = FrameToggleCircle

                coroutine.wrap(
                    function()
                        while wait() do
                            FrameToggle3.BackgroundColor3 = PresetColor
                        end
                    end
                )()

                Toggle.MouseButton1Click:Connect(
                    function()
                        if toggled == false then
                            TweenService:Create(
                                Toggle,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundColor3 = Color3.fromRGB(37, 37, 37)}
                            ):Play()
                            TweenService:Create(
                                FrameToggle1,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundTransparency = 1}
                            ):Play()
                            TweenService:Create(
                                FrameToggle2,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundTransparency = 1}
                            ):Play()
                            TweenService:Create(
                                FrameToggle3,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundTransparency = 0}
                            ):Play()
                            TweenService:Create(
                                FrameToggleCircle,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                            ):Play()
                            FrameToggleCircle:TweenPosition(
                                UDim2.new(0.587, 0, 0.222000003, 0),
                                Enum.EasingDirection.Out,
                                Enum.EasingStyle.Quart,
                                .2,
                                true
                            )
                        else
                            TweenService:Create(
                                Toggle,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundColor3 = Color3.fromRGB(34, 34, 34)}
                            ):Play()
                            TweenService:Create(
                                FrameToggle1,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundTransparency = 0}
                            ):Play()
                            TweenService:Create(
                                FrameToggle2,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundTransparency = 0}
                            ):Play()
                            TweenService:Create(
                                FrameToggle3,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundTransparency = 1}
                            ):Play()
                            TweenService:Create(
                                FrameToggleCircle,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                            ):Play()
                            FrameToggleCircle:TweenPosition(
                                UDim2.new(0.127000004, 0, 0.222000003, 0),
                                Enum.EasingDirection.Out,
                                Enum.EasingStyle.Quart,
                                .2,
                                true
                            )
                        end
                        toggled = not toggled
                        pcall(callback, toggled)

                        
                    end
                )

                if default == true then
                    TweenService:Create(
                        Toggle,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(37, 37, 37)}
                    ):Play()
                    TweenService:Create(
                        FrameToggle1,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 1}
                    ):Play()
                    TweenService:Create(
                        FrameToggle2,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 1}
                    ):Play()
                    TweenService:Create(
                        FrameToggle3,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0}
                    ):Play()
                    TweenService:Create(
                        FrameToggleCircle,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                    ):Play()
                    FrameToggleCircle:TweenPosition(
                        UDim2.new(0.587, 0, 0.222000003, 0),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .2,
                        true
                    )
                    toggled = not toggled
                end

                local Toggle = {}

                function Toggle:AddTooltip(tip)
                    if type(tip) == 'string' then
                        lib:AddToolTip(tip, Outer)
                    end
                    return Toggle
                end

                Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
            end

            function ItemHold:Slider(text, min, max, start, inc, callback)
                local Slider = {Value = start}
                local dragging = false
                Value = start
                local Slider = Instance.new("TextButton")
                local SliderCorner = Instance.new("UICorner")
                local SliderTitle = Instance.new("TextLabel")
                local SliderValue = Instance.new("TextLabel")
                local SlideFrame = Instance.new("Frame")
                local CurrentValueFrame = Instance.new("Frame")

                Slider.Name = "Slider"
                Slider.Parent = Section
                Slider.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                Slider.Position = UDim2.new(-0.48035714, 0, -0.570532918, 0)
                Slider.Size = UDim2.new(0, 363, 0, 60)
                Slider.AutoButtonColor = false
                Slider.Font = Enum.Font.SourceSans
                Slider.Text = ""
                Slider.TextColor3 = Color3.fromRGB(0, 0, 0)
                Slider.TextSize = 14.000

                SliderCorner.CornerRadius = UDim.new(0, 5)
                SliderCorner.Name = "SliderCorner"
                SliderCorner.Parent = Slider

                SliderTitle.Name = "SliderTitle"
                SliderTitle.Parent = Slider
                SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderTitle.BackgroundTransparency = 1.000
                SliderTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
                SliderTitle.Size = UDim2.new(0, 187, 0, 42)
                SliderTitle.Font = Enum.Font.Gotham
                SliderTitle.Text = text
                SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderTitle.TextSize = 14.000
                SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

                SliderValue.Name = "SliderValue"
                SliderValue.Parent = Slider
                SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderValue.BackgroundTransparency = 1.000
                SliderValue.Position = UDim2.new(0.0358126722, 0, 0, 0)
                SliderValue.Size = UDim2.new(0, 335, 0, 42)
                SliderValue.Font = Enum.Font.Gotham
                SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderValue.TextSize = 14.000
                SliderValue.Text = Value
                SliderValue.TextXAlignment = Enum.TextXAlignment.Right

                SlideFrame.Name = "SlideFrame"
                SlideFrame.Parent = Slider
                SlideFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                SlideFrame.BorderSizePixel = 0
                SlideFrame.Position = UDim2.new(0.0342647657, 0, 0.686091602, 0)
                SlideFrame.Size = UDim2.new(0, 335, 0, 5)

                CurrentValueFrame.Name = "CurrentValueFrame"
                CurrentValueFrame.Parent = SlideFrame
                CurrentValueFrame.BackgroundColor3 = PresetColor
                CurrentValueFrame.BorderSizePixel = 0
                CurrentValueFrame.Size = UDim2.new((start or 0) / max, 0, 0, 5)

                coroutine.wrap(
                    function()
                        while wait() do
                            CurrentValueFrame.BackgroundColor3 = PresetColor
                        end
                    end
                )()

                local function move(Input)
                    local XSize =
                        math.clamp((Input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1)
                    local Increment =
                        inc and (max / ((max - min) / (inc * 4))) or (max >= 50 and max / ((max - min) / 4)) or
                        (max >= 25 and max / ((max - min) / 2)) or
                        (max / (max - min))
                    local SizeRounded =
                        UDim2.new((math.round(XSize * ((max / Increment) * 4)) / ((max / Increment) * 4)), 0, 1, 0)
                    TweenService:Create(
                        CurrentValueFrame,
                        TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Size = SizeRounded}
                    ):Play()
                    local Val = math.round((((SizeRounded.X.Scale * max) / max) * (max - min) + min) * 20) / 20
                    SliderValue.Text = tostring(Val)
                    Value = Val
                    callback(Value)
                end

                SlideFrame.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                        end
                    end
                )
                SlideFrame.InputEnded:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end
                )
                game:GetService("UserInputService").InputChanged:Connect(
                    function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            move(input)
                        end
                    end
                )

                Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)

                function Slider:Set(val)
                    local a = tostring(val and (val / max) * (max - min) + min) or 0
					SliderValue.Text = tostring(a)
                    SlideFrame.Size = UDim2.new((val or 0) / max, 0, 1, 0)
                    Slider.Value = val
					return callback(Slider.Value)
				end
                Slider:Set(start)

                function Slider:AddTooltip(tip)
                    if type(tip) == 'string' then
                        lib:AddToolTip(tip, Outer)
                    end
                end
                return Slider
            end

            function ItemHold:Dropdown(text, list, def, callback)
                local Dropdown, DropMain, OptionPreset =
                    {Value = nil, Toggled = false, Options = list},
                    game:GetObjects("rbxassetid://7027964359")[1],
                    game:GetObjects("rbxassetid://7021432326")[1]
                DropMain.Parent = Section
                DropMain.Btn.Title.Text = text
                DropMain.Name = text .. "element"
                DropMain.Size = UDim2.new(0, 363, 0, 38)
                Dropdown.Size = UDim2.new(0, 363, 0, 38)

                local function ToggleDrop()
                    Dropdown.Toggled = not Dropdown.Toggled
                    DropMain.Holder.Size =
                        Dropdown.Toggled and UDim2.new(0, 363, 0, 6 + DropMain.Holder.Layout.AbsoluteContentSize.Y) or
                        UDim2.new(0, 363, 0, 0)
                    TweenService:Create(
                        DropMain,
                        TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {
                            Size = Dropdown.Toggled and
                                UDim2.new(0, 363, 0, 38 + DropMain.Holder.Layout.AbsoluteContentSize.Y) or
                                UDim2.new(0, 363, 0, 32)
                        }
                    ):Play()
                    TweenService:Create(
                        DropMain.Btn.Ico,
                        TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Rotation = Dropdown.Toggled and 180 or 0}
                    ):Play()
                    DropMain.Holder.Visible = Dropdown.Toggled
                end

                local function AddOptions(opts)
                    for _, option in pairs(opts) do
                        local Option = OptionPreset:Clone()
                        Option.Parent = DropMain.Holder
                        Option.ItemText.Text = option
                        Option.ClipsDescendants = true

                        Option.MouseButton1Click:Connect(
                            function()
                                Dropdown.Value = option
                                DropMain.Btn.Title.Text = text .. " - " .. option
                                Ripple(Option)
                                return callback(Dropdown.Value)
                            end
                        )

                        spawn(
                            function()
                                while wait() do
                                    Option.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                                    DropMain.Btn.Title.TextColor3 = Color3.fromRGB(155, 155, 155)
                                end
                            end
                        )
                    end
                end

                function Dropdown:Refresh(opts, del)
                    if del then
                        for _, v in pairs(DropMain.Holder:GetChildren()) do
                            if v:IsA "TextButton" then
                                v:Destroy()
                                DropMain.Holder.Size =
                                    Dropdown.Toggled and
                                    UDim2.new(0, 363, 0, 6 + DropMain.Holder.Layout.AbsoluteContentSize.Y) or
                                    UDim2.new(0, 363, 0, 0)
                                DropMain.Size =
                                    Dropdown.Toggled and
                                    UDim2.new(0, 363, 0, 38 + DropMain.Holder.Layout.AbsoluteContentSize.Y) or
                                    UDim2.new(0, 363, 0, 32)
                            end
                        end
                    end
                    AddOptions(opts)
                end

                DropMain.Btn.MouseButton1Click:Connect(
                    function()
                        ToggleDrop()
                    end
                )

                function Dropdown:Set(val)
                    Dropdown.Value = val
                    DropMain.Btn.Title.Text = text .. " - " .. val
                    return callback(Dropdown.Value)
                end

                spawn(
                    function()
                        while wait() do
                            DropMain.Btn.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                            DropMain.Btn.Ico.ImageColor3 = Color3.fromRGB(255, 255, 255)
                        end
                    end
                )

                Dropdown:Refresh(list, false)
                Dropdown:Set(def)

                function Dropdown:AddTooltip(tip)
                    if type(tip) == 'string' then
                        lib:AddToolTip(tip, Outer)
                    end
                end
                return Dropdown
            end

            function ItemHold:MultiDropdown(text, list, def, flag, callback)
                local Dropdown, DropMain, OptionPreset =
                    {Value = {}, Toggled = false, Options = list},
                    game:GetObjects("rbxassetid://7027964359")[1],
                    game:GetObjects("rbxassetid://7021432326")[1]
                DropMain.Parent = Section
                DropMain.Btn.Title.Text = text
                DropMain.Name = text .. "element"
                DropMain.Size = UDim2.new(0, 363, 0, 38)
                Dropdown.Size = UDim2.new(0, 363, 0, 38)

                local function ToggleDrop()
                    Dropdown.Toggled = not Dropdown.Toggled
                    DropMain.Holder.Size =
                        Dropdown.Toggled and UDim2.new(0, 363, 0, 6 + DropMain.Holder.Layout.AbsoluteContentSize.Y) or
                        UDim2.new(0, 363, 0, 0)
                    TweenService:Create(
                        DropMain,
                        TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {
                            Size = Dropdown.Toggled and
                                UDim2.new(0, 363, 0, 38 + DropMain.Holder.Layout.AbsoluteContentSize.Y) or
                                UDim2.new(0, 363, 0, 32)
                        }
                    ):Play()
                    TweenService:Create(
                        DropMain.Btn.Ico,
                        TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Rotation = Dropdown.Toggled and 180 or 0}
                    ):Play()
                    DropMain.Holder.Visible = Dropdown.Toggled
                end

                local function AddOptions(opts)
                    for _, option in pairs(opts) do
                        local Option = OptionPreset:Clone()
                        Option.Parent = DropMain.Holder
                        Option.ItemText.Text = option
                        Option.ClipsDescendants = true

                        Option.MouseButton1Click:Connect(
                            function()
                                if table.find(Dropdown.Value, option) then
                                    table.remove(Dropdown.Value, table.find(Dropdown.Value, option))
                                    DropMain.Btn.Title.Text = text .. " - " .. table.concat(Dropdown.Value, ", ")
                                    callback(Dropdown.Value)
                                else
                                    table.insert(Dropdown.Value, option)
                                    DropMain.Btn.Title.Text = text .. " - " .. table.concat(Dropdown.Value, ", ")
                                    callback(Dropdown.Value)
                                end
                                Ripple(Option)
                            end
                        )

                        spawn(
                            function()
                                while wait() do
                                    Option.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                                    DropMain.Btn.Title.TextColor3 = Color3.fromRGB(155, 155, 155)
                                end
                            end
                        )
                    end
                end

                function Dropdown:Refresh(opts, del)
                    if del then
                        for _, v in pairs(DropMain.Holder:GetChildren()) do
                            if v:IsA "TextButton" then
                                v:Destroy()
                                DropMain.Holder.Size =
                                    Dropdown.Toggled and
                                    UDim2.new(0, 363, 0, 6 + DropMain.Holder.Layout.AbsoluteContentSize.Y) or
                                    UDim2.new(0, 363, 0, 0)
                                DropMain.Size =
                                    Dropdown.Toggled and
                                    UDim2.new(0, 363, 0, 38 + DropMain.Holder.Layout.AbsoluteContentSize.Y) or
                                    UDim2.new(0, 363, 0, 32)
                            end
                        end
                    end
                    AddOptions(opts)
                end

                DropMain.Btn.MouseButton1Click:Connect(
                    function()
                        ToggleDrop()
                    end
                )

                function Dropdown:Set(val)
                    Dropdown.Value = val
                    DropMain.Btn.Title.Text = text .. " - " .. table.concat(Dropdown.Value, ", ")
                    return callback(Dropdown.Value)
                end

                spawn(
                    function()
                        while wait() do
                            DropMain.Btn.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                            DropMain.Btn.Ico.ImageColor3 = Color3.fromRGB(255, 255, 255)
                        end
                    end
                )

                function Dropdown:AddTooltip(tip)
                    if type(tip) == 'string' then
                        lib:AddToolTip(tip, Outer)
                    end
                end

                Dropdown:Refresh(list, false)
                return Dropdown
            end

            function ItemHold:Colorpicker(text, preset, callback)
                local ColorPickerToggled = false
                local OldToggleColor = Color3.fromRGB(0, 0, 0)
                local OldColor = Color3.fromRGB(0, 0, 0)
                local OldColorSelectionPosition = nil
                local OldHueSelectionPosition = nil
                local ColorH, ColorS, ColorV = 1, 1, 1
                local RainbowColorPicker = false
                local ColorPickerInput = nil
                local ColorInput = nil
                local HueInput = nil

                local Colorpicker = Instance.new("Frame")
                local ColorpickerCorner = Instance.new("UICorner")
                local ColorpickerTitle = Instance.new("TextLabel")
                local BoxColor = Instance.new("Frame")
                local BoxColorCorner = Instance.new("UICorner")
                local ConfirmBtn = Instance.new("TextButton")
                local ConfirmBtnCorner = Instance.new("UICorner")
                local ConfirmBtnTitle = Instance.new("TextLabel")
                local ColorpickerBtn = Instance.new("TextButton")
                local RainbowToggle = Instance.new("TextButton")
                local RainbowToggleCorner = Instance.new("UICorner")
                local RainbowToggleTitle = Instance.new("TextLabel")
                local FrameRainbowToggle1 = Instance.new("Frame")
                local FrameRainbowToggle1Corner = Instance.new("UICorner")
                local FrameRainbowToggle2 = Instance.new("Frame")
                local FrameRainbowToggle2_2 = Instance.new("UICorner")
                local FrameRainbowToggle3 = Instance.new("Frame")
                local FrameToggle3 = Instance.new("UICorner")
                local FrameRainbowToggleCircle = Instance.new("Frame")
                local FrameRainbowToggleCircleCorner = Instance.new("UICorner")
                local Color = Instance.new("ImageLabel")
                local ColorCorner = Instance.new("UICorner")
                local ColorSelection = Instance.new("ImageLabel")
                local Hue = Instance.new("ImageLabel")
                local HueCorner = Instance.new("UICorner")
                local HueGradient = Instance.new("UIGradient")
                local HueSelection = Instance.new("ImageLabel")

                Colorpicker.Name = "Colorpicker"
                Colorpicker.Parent = Section
                Colorpicker.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                Colorpicker.ClipsDescendants = true
                Colorpicker.Position = UDim2.new(-0.541071415, 0, -0.532915354, 0)
                Colorpicker.Size = UDim2.new(0, 363, 0, 42)

                ColorpickerCorner.CornerRadius = UDim.new(0, 5)
                ColorpickerCorner.Name = "ColorpickerCorner"
                ColorpickerCorner.Parent = Colorpicker

                ColorpickerTitle.Name = "ColorpickerTitle"
                ColorpickerTitle.Parent = Colorpicker
                ColorpickerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorpickerTitle.BackgroundTransparency = 1.000
                ColorpickerTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
                ColorpickerTitle.Size = UDim2.new(0, 187, 0, 42)
                ColorpickerTitle.Font = Enum.Font.Gotham
                ColorpickerTitle.Text = text
                ColorpickerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                ColorpickerTitle.TextSize = 14.000
                ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left

                BoxColor.Name = "BoxColor"
                BoxColor.Parent = ColorpickerTitle
                BoxColor.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
                BoxColor.Position = UDim2.new(1.60427809, 0, 0.214285716, 0)
                BoxColor.Size = UDim2.new(0, 41, 0, 23)

                BoxColorCorner.CornerRadius = UDim.new(0, 5)
                BoxColorCorner.Name = "BoxColorCorner"
                BoxColorCorner.Parent = BoxColor

                ConfirmBtn.Name = "ConfirmBtn"
                ConfirmBtn.Parent = ColorpickerTitle
                ConfirmBtn.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                ConfirmBtn.Position = UDim2.new(1.25814295, 0, 1.09037197, 0)
                ConfirmBtn.Size = UDim2.new(0, 105, 0, 32)
                ConfirmBtn.AutoButtonColor = false
                ConfirmBtn.Font = Enum.Font.SourceSans
                ConfirmBtn.Text = ""
                ConfirmBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                ConfirmBtn.TextSize = 14.000

                ConfirmBtnCorner.CornerRadius = UDim.new(0, 5)
                ConfirmBtnCorner.Name = "ConfirmBtnCorner"
                ConfirmBtnCorner.Parent = ConfirmBtn

                ConfirmBtnTitle.Name = "ConfirmBtnTitle"
                ConfirmBtnTitle.Parent = ConfirmBtn
                ConfirmBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ConfirmBtnTitle.BackgroundTransparency = 1.000
                ConfirmBtnTitle.Size = UDim2.new(0, 33, 0, 32)
                ConfirmBtnTitle.Font = Enum.Font.Gotham
                ConfirmBtnTitle.Text = "Confirm"
                ConfirmBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                ConfirmBtnTitle.TextSize = 14.000
                ConfirmBtnTitle.TextXAlignment = Enum.TextXAlignment.Left

                ColorpickerBtn.Name = "ColorpickerBtn"
                ColorpickerBtn.Parent = ColorpickerTitle
                ColorpickerBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorpickerBtn.BackgroundTransparency = 1.000
                ColorpickerBtn.Size = UDim2.new(0, 363, 0, 42)
                ColorpickerBtn.Font = Enum.Font.SourceSans
                ColorpickerBtn.Text = ""
                ColorpickerBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                ColorpickerBtn.TextSize = 14.000

                RainbowToggle.Name = "RainbowToggle"
                RainbowToggle.Parent = ColorpickerTitle
                RainbowToggle.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                RainbowToggle.Position = UDim2.new(1.26349044, 0, 2.12684202, 0)
                RainbowToggle.Size = UDim2.new(0, 104, 0, 32)
                RainbowToggle.AutoButtonColor = false
                RainbowToggle.Font = Enum.Font.SourceSans
                RainbowToggle.Text = ""
                RainbowToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
                RainbowToggle.TextSize = 14.000

                RainbowToggleCorner.CornerRadius = UDim.new(0, 5)
                RainbowToggleCorner.Name = "RainbowToggleCorner"
                RainbowToggleCorner.Parent = RainbowToggle

                RainbowToggleTitle.Name = "RainbowToggleTitle"
                RainbowToggleTitle.Parent = RainbowToggle
                RainbowToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                RainbowToggleTitle.BackgroundTransparency = 1.000
                RainbowToggleTitle.Size = UDim2.new(0, 33, 0, 32)
                RainbowToggleTitle.Font = Enum.Font.Gotham
                RainbowToggleTitle.Text = "Rainbow"
                RainbowToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                RainbowToggleTitle.TextSize = 14.000
                RainbowToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

                FrameRainbowToggle1.Name = "FrameRainbowToggle1"
                FrameRainbowToggle1.Parent = RainbowToggle
                FrameRainbowToggle1.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                FrameRainbowToggle1.Position = UDim2.new(0.649999976, 0, 0.186000004, 0)
                FrameRainbowToggle1.Size = UDim2.new(0, 37, 0, 18)

                FrameRainbowToggle1Corner.Name = "FrameRainbowToggle1Corner"
                FrameRainbowToggle1Corner.Parent = FrameRainbowToggle1

                FrameRainbowToggle2.Name = "FrameRainbowToggle2"
                FrameRainbowToggle2.Parent = FrameRainbowToggle1
                FrameRainbowToggle2.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                FrameRainbowToggle2.Position = UDim2.new(0.0590000004, 0, 0.112999998, 0)
                FrameRainbowToggle2.Size = UDim2.new(0, 33, 0, 14)

                FrameRainbowToggle2_2.Name = "FrameRainbowToggle2"
                FrameRainbowToggle2_2.Parent = FrameRainbowToggle2

                FrameRainbowToggle3.Name = "FrameRainbowToggle3"
                FrameRainbowToggle3.Parent = FrameRainbowToggle1
                FrameRainbowToggle3.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                FrameRainbowToggle3.BackgroundTransparency = 1.000
                FrameRainbowToggle3.Size = UDim2.new(0, 37, 0, 18)

                FrameToggle3.Name = "FrameToggle3"
                FrameToggle3.Parent = FrameRainbowToggle3

                FrameRainbowToggleCircle.Name = "FrameRainbowToggleCircle"
                FrameRainbowToggleCircle.Parent = FrameRainbowToggle1
                FrameRainbowToggleCircle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                FrameRainbowToggleCircle.Position = UDim2.new(0.127000004, 0, 0.222000003, 0)
                FrameRainbowToggleCircle.Size = UDim2.new(0, 10, 0, 10)

                FrameRainbowToggleCircleCorner.Name = "FrameRainbowToggleCircleCorner"
                FrameRainbowToggleCircleCorner.Parent = FrameRainbowToggleCircle

                Color.Name = "Color"
                Color.Parent = ColorpickerTitle
                Color.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
                Color.Position = UDim2.new(0, 0, 0, 42)
                Color.Size = UDim2.new(0, 194, 0, 80)
                Color.ZIndex = 10
                Color.Image = "rbxassetid://4155801252"

                ColorCorner.CornerRadius = UDim.new(0, 3)
                ColorCorner.Name = "ColorCorner"
                ColorCorner.Parent = Color

                ColorSelection.Name = "ColorSelection"
                ColorSelection.Parent = Color
                ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
                ColorSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorSelection.BackgroundTransparency = 1.000
                ColorSelection.Position = UDim2.new(preset and select(3, Color3.toHSV(preset)))
                ColorSelection.Size = UDim2.new(0, 18, 0, 18)
                ColorSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
                ColorSelection.ScaleType = Enum.ScaleType.Fit
                ColorSelection.Visible = false

                Hue.Name = "Hue"
                Hue.Parent = ColorpickerTitle
                Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Hue.Position = UDim2.new(0, 202, 0, 42)
                Hue.Size = UDim2.new(0, 25, 0, 80)

                HueCorner.CornerRadius = UDim.new(0, 3)
                HueCorner.Name = "HueCorner"
                HueCorner.Parent = Hue

                HueGradient.Color =
                    ColorSequence.new {
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)),
                    ColorSequenceKeypoint.new(0.20, Color3.fromRGB(234, 255, 0)),
                    ColorSequenceKeypoint.new(0.40, Color3.fromRGB(21, 255, 0)),
                    ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)),
                    ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 17, 255)),
                    ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 251)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))
                }
                HueGradient.Rotation = 270
                HueGradient.Name = "HueGradient"
                HueGradient.Parent = Hue

                HueSelection.Name = "HueSelection"
                HueSelection.Parent = Hue
                HueSelection.AnchorPoint = Vector2.new(0.5, 0.5)
                HueSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                HueSelection.BackgroundTransparency = 1.000
                HueSelection.Position = UDim2.new(0.48, 0, 1 - select(1, Color3.toHSV(preset)))
                HueSelection.Size = UDim2.new(0, 18, 0, 18)
                HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
                HueSelection.Visible = false

                coroutine.wrap(
                    function()
                        while wait() do
                            FrameRainbowToggle3.BackgroundColor3 = PresetColor
                        end
                    end
                )()

                ColorpickerBtn.MouseButton1Click:Connect(
                    function()
                        if ColorPickerToggled == false then
                            ColorSelection.Visible = true
                            HueSelection.Visible = true
                            Colorpicker:TweenSize(
                                UDim2.new(0, 363, 0, 132),
                                Enum.EasingDirection.Out,
                                Enum.EasingStyle.Quart,
                                .2,
                                true
                            )
                            wait(.2)
                            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                        else
                            ColorSelection.Visible = false
                            HueSelection.Visible = false
                            Colorpicker:TweenSize(
                                UDim2.new(0, 363, 0, 42),
                                Enum.EasingDirection.Out,
                                Enum.EasingStyle.Quart,
                                .2,
                                true
                            )
                            wait(.2)
                            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                        end
                        ColorPickerToggled = not ColorPickerToggled
                    end
                )

                local function UpdateColorPicker()
                    BoxColor.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
                    Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)

                    pcall(callback, BoxColor.BackgroundColor3)
                end

                ColorH =
                    1 -
                    (math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
                        Hue.AbsoluteSize.Y)
                ColorS =
                    (math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) /
                    Color.AbsoluteSize.X)
                ColorV =
                    1 -
                    (math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) /
                        Color.AbsoluteSize.Y)

                BoxColor.BackgroundColor3 = preset
                Color.BackgroundColor3 = preset
                pcall(callback, BoxColor.BackgroundColor3)

                Color.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if RainbowColorPicker then
                                return
                            end

                            if ColorInput then
                                ColorInput:Disconnect()
                            end

                            ColorInput =
                                RunService.RenderStepped:Connect(
                                function()
                                    local ColorX =
                                        (math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) /
                                        Color.AbsoluteSize.X)
                                    local ColorY =
                                        (math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) /
                                        Color.AbsoluteSize.Y)

                                    ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
                                    ColorS = ColorX
                                    ColorV = 1 - ColorY

                                    UpdateColorPicker(true)
                                end
                            )
                        end
                    end
                )

                Color.InputEnded:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if ColorInput then
                                ColorInput:Disconnect()
                            end
                        end
                    end
                )

                Hue.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if RainbowColorPicker then
                                return
                            end

                            if HueInput then
                                HueInput:Disconnect()
                            end

                            HueInput =
                                RunService.RenderStepped:Connect(
                                function()
                                    local HueY =
                                        (math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
                                        Hue.AbsoluteSize.Y)

                                    HueSelection.Position = UDim2.new(0.48, 0, HueY, 0)
                                    ColorH = 1 - HueY

                                    UpdateColorPicker(true)
                                end
                            )
                        end
                    end
                )

                Hue.InputEnded:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if HueInput then
                                HueInput:Disconnect()
                            end
                        end
                    end
                )

                RainbowToggle.MouseButton1Down:Connect(
                    function()
                        RainbowColorPicker = not RainbowColorPicker

                        if ColorInput then
                            ColorInput:Disconnect()
                        end

                        if HueInput then
                            HueInput:Disconnect()
                        end

                        if RainbowColorPicker then
                            TweenService:Create(
                                FrameRainbowToggle1,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundTransparency = 1}
                            ):Play()
                            TweenService:Create(
                                FrameRainbowToggle2,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundTransparency = 1}
                            ):Play()
                            TweenService:Create(
                                FrameRainbowToggle3,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundTransparency = 0}
                            ):Play()
                            TweenService:Create(
                                FrameRainbowToggleCircle,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                            ):Play()
                            FrameRainbowToggleCircle:TweenPosition(
                                UDim2.new(0.587, 0, 0.222000003, 0),
                                Enum.EasingDirection.Out,
                                Enum.EasingStyle.Quart,
                                .2,
                                true
                            )

                            OldToggleColor = BoxColor.BackgroundColor3
                            OldColor = Color.BackgroundColor3
                            OldColorSelectionPosition = ColorSelection.Position
                            OldHueSelectionPosition = HueSelection.Position

                            while RainbowColorPicker do
                                BoxColor.BackgroundColor3 = Color3.fromHSV(lib.RainbowColorValue, 1, 1)
                                Color.BackgroundColor3 = Color3.fromHSV(lib.RainbowColorValue, 1, 1)

                                ColorSelection.Position = UDim2.new(1, 0, 0, 0)
                                HueSelection.Position = UDim2.new(0.48, 0, 0, lib.HueSelectionPosition)

                                pcall(callback, BoxColor.BackgroundColor3)
                                wait()
                            end
                        elseif not RainbowColorPicker then
                            TweenService:Create(
                                FrameRainbowToggle1,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundTransparency = 0}
                            ):Play()
                            TweenService:Create(
                                FrameRainbowToggle2,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundTransparency = 0}
                            ):Play()
                            TweenService:Create(
                                FrameRainbowToggle3,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundTransparency = 1}
                            ):Play()
                            TweenService:Create(
                                FrameRainbowToggleCircle,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                            ):Play()
                            FrameRainbowToggleCircle:TweenPosition(
                                UDim2.new(0.127000004, 0, 0.222000003, 0),
                                Enum.EasingDirection.Out,
                                Enum.EasingStyle.Quart,
                                .2,
                                true
                            )

                            BoxColor.BackgroundColor3 = OldToggleColor
                            Color.BackgroundColor3 = OldColor

                            ColorSelection.Position = OldColorSelectionPosition
                            HueSelection.Position = OldHueSelectionPosition

                            pcall(callback, BoxColor.BackgroundColor3)
                        end
                    end
                )

                ConfirmBtn.MouseButton1Click:Connect(
                    function()
                        ColorSelection.Visible = false
                        HueSelection.Visible = false
                        Colorpicker:TweenSize(
                            UDim2.new(0, 363, 0, 42),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    end
                )
                Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
            end

            function ItemHold:Label(text, color)
                local Label = {}
                Colorr = color or Color3.fromRGB(255,255,255)
                local Label = Instance.new("TextButton")
                local LabelCorner = Instance.new("UICorner")
                local LabelTitle = Instance.new("TextLabel")

                Label.Name = "Button"
                Label.Parent = Section
                Label.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                Label.Size = UDim2.new(0, 363, 0, 42)
                Label.AutoButtonColor = false
                Label.Font = Enum.Font.SourceSans
                Label.Text = ""
                Label.TextColor3 = Color3.fromRGB(0, 0, 0)
                Label.TextSize = 14.000

                LabelCorner.CornerRadius = UDim.new(0, 5)
                LabelCorner.Name = "ButtonCorner"
                LabelCorner.Parent = Label

                LabelTitle.Name = "ButtonTitle"
                LabelTitle.Parent = Label
                LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelTitle.BackgroundTransparency = 1.000
                LabelTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
                LabelTitle.Size = UDim2.new(0, 187, 0, 42)
                LabelTitle.Font = Enum.Font.Gotham
                LabelTitle.Text = text
                LabelTitle.TextColor3 = color
                LabelTitle.TextSize = 14.000
                LabelTitle.TextXAlignment = Enum.TextXAlignment.Left
                LabelTitle.RichText = true
                Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)

                function Label:Set(totext)
                    LabelTitle.Text = totext
                end
                return Label
            end

            function ItemHold:Textbox(text, disapper, callback)
                local Textbox = Instance.new("Frame")
                local TextboxCorner = Instance.new("UICorner")
                local TextboxTitle = Instance.new("TextLabel")
                local TextboxFrame = Instance.new("Frame")
                local TextboxFrameCorner = Instance.new("UICorner")
                local TextBox = Instance.new("TextBox")

                Textbox.Name = "Textbox"
                Textbox.Parent = Section
                Textbox.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                Textbox.ClipsDescendants = true
                Textbox.Position = UDim2.new(-0.541071415, 0, -0.532915354, 0)
                Textbox.Size = UDim2.new(0, 363, 0, 42)

                TextboxCorner.CornerRadius = UDim.new(0, 5)
                TextboxCorner.Name = "TextboxCorner"
                TextboxCorner.Parent = Textbox

                TextboxTitle.Name = "TextboxTitle"
                TextboxTitle.Parent = Textbox
                TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxTitle.BackgroundTransparency = 1.000
                TextboxTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
                TextboxTitle.Size = UDim2.new(0, 187, 0, 42)
                TextboxTitle.Font = Enum.Font.Gotham
                TextboxTitle.Text = text
                TextboxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextboxTitle.TextSize = 14.000
                TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

                TextboxFrame.Name = "TextboxFrame"
                TextboxFrame.Parent = TextboxTitle
                TextboxFrame.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
                TextboxFrame.Position = UDim2.new(1.28877008, 0, 0.214285716, 0)
                TextboxFrame.Size = UDim2.new(0, 100, 0, 23)

                TextboxFrameCorner.CornerRadius = UDim.new(0, 5)
                TextboxFrameCorner.Name = "TextboxFrameCorner"
                TextboxFrameCorner.Parent = TextboxFrame

                TextBox.Parent = TextboxFrame
                TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.BackgroundTransparency = 1.000
                TextBox.Size = UDim2.new(0, 100, 0, 23)
                TextBox.Font = Enum.Font.Gotham
                TextBox.Text = ""
                TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.TextSize = 14.000

                TextBox.FocusLost:Connect(
                    function(ep)
                        if ep then
                            if #TextBox.Text > 0 then
                                pcall(callback, TextBox.Text)
                                if disapper then
                                    TextBox.Text = ""
                                end
                            end
                        end
                    end
                )

                local TextBox = {}

                function TextBox:AddTooltip(tip)
                    if type(tip) == 'string' then
                        lib:AddToolTip(tip, Outer)
                    end
                    return TextBox
                end

                Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
            end

            function ItemHold:Bind(text, preset, holdmode, callback)
                local Bind, BindFrame =
                    {Value, Binding = false, Holding = false},
                    game:GetObjects("rbxassetid://7126874744")[1]
                BindFrame.Parent = Section
                BindFrame.Title.Text = text
                BindFrame.Name = text .. "element"
                BindFrame.Size = UDim2.new(0, 363, 0, 32)
                Bind.Size = UDim2.new(0, 363, 0, 38)

                BindFrame.InputEnded:Connect(
                    function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if Bind.Binding then
                                return
                            end
                            Bind.Binding = true
                            BindFrame.BText.Text = "..."
                        end
                    end
                )

                UserInputService.InputBegan:Connect(
                    function(Input)
                        if UserInputService:GetFocusedTextBox() then
                            return
                        end
                        if
                            (Input.KeyCode.Name == Bind.Value or Input.UserInputType.Name == Bind.Value) and
                                not Bind.Binding
                         then
                            if holdmode then
                                Holding = true
                                callback(Holding)
                            else
                                callback()
                            end
                        elseif Bind.Binding then
                            local Key
                            pcall(
                                function()
                                    if not CheckKey(BlacklistedKeys, Input.KeyCode) then
                                        Key = Input.KeyCode
                                    end
                                end
                            )
                            pcall(
                                function()
                                    if CheckKey(WhitelistedMouse, Input.UserInputType) and not Key then
                                        Key = Input.UserInputType
                                    end
                                end
                            )
                            Key = Key or Bind.Value
                            Bind:Set(Key)
                        end
                    end
                )

                UserInputService.InputEnded:Connect(
                    function(Input)
                        if Input.KeyCode.Name == Bind.Value or Input.UserInputType.Name == Bind.Value then
                            if holdmode and Holding then
                                Holding = false
                                callback(Holding)
                            end
                        end
                    end
                )

                function Bind:AddTooltip(tip)
                    if type(tip) == 'string' then
                        lib:AddToolTip(tip, Outer)
                    end
                    return Bind
                end

                function Bind:Set(key)
                    self.Binding = false
                    self.Value = key or self.Value
                    self.Value = self.Value.Name or self.Value
                    BindFrame.BText.Text = self.Value
                end

                spawn(
                    function()
                        while wait() do
                            BindFrame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                            BindFrame.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                            BindFrame.BText.TextColor3 = Color3.fromRGB(255, 255, 255)
                        end
                    end
                )

                Bind:Set(preset)
                return Bind
            end

            return ItemHold
        end

        return SectionHold
    end

    return tabhold
end

return lib
