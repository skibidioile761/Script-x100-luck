--[[
X100 LUCKY SCRIPT - UI DEMO ONLY
- UI + visual effects only
- No remote, no gameplay interaction
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("X100LuckyUI")
if old then old:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "X100LuckyUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local function tween(obj, t, props, style, direction)
	local tw = TweenService:Create(
		obj,
		TweenInfo.new(t, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out),
		props
	)
	tw:Play()
	return tw
end

local function playTone(soundId, vol, speed)
	local s = Instance.new("Sound")
	s.SoundId = soundId
	s.Volume = vol or 0.3
	s.PlaybackSpeed = speed or 1
	s.Parent = SoundService
	s:Play()
	Debris:AddItem(s, 2)
end

local SND_OPEN = "rbxasset://sounds/action_get.wav"
local SND_ON_1 = "rbxasset://sounds/electronicpingshort.wav"
local SND_ON_2 = "rbxasset://sounds/button.wav"
local SND_OFF = "rbxasset://sounds/electronicpingshort.wav"
local SND_CLOSE = "rbxasset://sounds/button.wav"

-- =========================================================
-- LOADING PANEL (same size as main menu, not full screen)
-- =========================================================
local loadingPanel = Instance.new("Frame")
loadingPanel.Size = UDim2.new(0, 350, 0, 270)
loadingPanel.Position = UDim2.new(0.5, -175, 0.16, 0)
loadingPanel.BackgroundColor3 = Color3.fromRGB(16, 20, 30)
loadingPanel.BackgroundTransparency = 0.18
loadingPanel.BorderSizePixel = 0
loadingPanel.Parent = screenGui
Instance.new("UICorner", loadingPanel).CornerRadius = UDim.new(0, 20)

local loadingGrad = Instance.new("UIGradient")
loadingGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 30, 44)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 20, 30)),
})
loadingGrad.Rotation = 130
loadingGrad.Parent = loadingPanel

local loadingStroke = Instance.new("UIStroke")
loadingStroke.Color = Color3.fromRGB(120, 240, 185)
loadingStroke.Transparency = 0.65
loadingStroke.Thickness = 1.2
loadingStroke.Parent = loadingPanel

local loadTitle = Instance.new("TextLabel")
loadTitle.Size = UDim2.new(1, -24, 0, 42)
loadTitle.Position = UDim2.new(0, 12, 0, 38)
loadTitle.BackgroundTransparency = 1
loadTitle.Font = Enum.Font.GothamBold
loadTitle.TextSize = 28
loadTitle.TextColor3 = Color3.fromRGB(244, 248, 255)
loadTitle.Text = "X100 Lucky Script"
loadTitle.Parent = loadingPanel

local loadSub = Instance.new("TextLabel")
loadSub.Size = UDim2.new(1, -24, 0, 20)
loadSub.Position = UDim2.new(0, 12, 0, 76)
loadSub.BackgroundTransparency = 1
loadSub.Font = Enum.Font.Gotham
loadSub.TextSize = 13
loadSub.TextColor3 = Color3.fromRGB(157, 183, 214)
loadSub.Text = "Initializing visual demo..."
loadSub.Parent = loadingPanel

local barTrack = Instance.new("Frame")
barTrack.Size = UDim2.new(0, 240, 0, 10)
barTrack.Position = UDim2.new(0.5, -120, 0, 126)
barTrack.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
barTrack.BackgroundTransparency = 0.9
barTrack.BorderSizePixel = 0
barTrack.Parent = loadingPanel
Instance.new("UICorner", barTrack).CornerRadius = UDim.new(1, 0)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 232, 176)
barFill.BorderSizePixel = 0
barFill.Parent = barTrack
Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

local barGrad = Instance.new("UIGradient")
barGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 236, 166)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(62, 217, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(175, 120, 255)),
})
barGrad.Parent = barFill

local percent = Instance.new("TextLabel")
percent.Size = UDim2.new(0, 80, 0, 20)
percent.Position = UDim2.new(0.5, -40, 0, 144)
percent.BackgroundTransparency = 1
percent.Font = Enum.Font.GothamMedium
percent.TextSize = 14
percent.TextColor3 = Color3.fromRGB(181, 234, 206)
percent.Text = "0%"
percent.Parent = loadingPanel

-- =========================================================
-- MAIN MENU
-- =========================================================
local main = Instance.new("Frame")
main.Name = "MainMenu"
main.Size = UDim2.new(0, 350, 0, 270)
main.Position = UDim2.new(0.5, -175, 0.16, 0)
main.BackgroundColor3 = Color3.fromRGB(16, 20, 30)
main.BackgroundTransparency = 0.2
main.BorderSizePixel = 0
main.Visible = false
main.Parent = screenGui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 20)

local mainGrad = Instance.new("UIGradient")
mainGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 30, 45)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 19, 29)),
})
mainGrad.Rotation = 135
mainGrad.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(129, 255, 203)
mainStroke.Transparency = 0.62
mainStroke.Thickness = 1.2
mainStroke.Parent = main

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 48)
header.BackgroundTransparency = 1
header.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 14, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(248, 252, 255)
title.Text = "X100 Lucky Script"
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0, 9)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 97, 97)
closeBtn.BackgroundTransparency = 0.75
closeBtn.Text = "x"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.TextColor3 = Color3.fromRGB(255, 200, 200)
closeBtn.AutoButtonColor = false
closeBtn.Parent = header
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 9)

local row = Instance.new("Frame")
row.Size = UDim2.new(1, -24, 0, 52)
row.Position = UDim2.new(0, 12, 0, 56)
row.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
row.BackgroundTransparency = 0.92
row.BorderSizePixel = 0
row.Parent = main
Instance.new("UICorner", row).CornerRadius = UDim.new(0, 14)

local rowText = Instance.new("TextLabel")
rowText.Size = UDim2.new(1, -90, 1, 0)
rowText.Position = UDim2.new(0, 14, 0, 0)
rowText.BackgroundTransparency = 1
rowText.Font = Enum.Font.GothamSemibold
rowText.TextSize = 15
rowText.TextXAlignment = Enum.TextXAlignment.Left
rowText.TextColor3 = Color3.fromRGB(235, 247, 255)
rowText.Text = "Boost Luck"
rowText.Parent = row

local switch = Instance.new("TextButton")
switch.Size = UDim2.new(0, 54, 0, 30)
switch.Position = UDim2.new(1, -66, 0.5, -15)
switch.BackgroundColor3 = Color3.fromRGB(52, 58, 70)
switch.BorderSizePixel = 0
switch.Text = ""
switch.AutoButtonColor = false
switch.Parent = row
Instance.new("UICorner", switch).CornerRadius = UDim.new(1, 0)

local knob = Instance.new("Frame")
knob.Size = UDim2.new(0, 24, 0, 24)
knob.Position = UDim2.new(0, 3, 0.5, -12)
knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
knob.BorderSizePixel = 0
knob.Parent = switch
Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

local status = Instance.new("Frame")
status.Size = UDim2.new(1, -24, 0, 132)
status.Position = UDim2.new(0, 12, 0, 116)
status.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
status.BackgroundTransparency = 0.72
status.BorderSizePixel = 0
status.ClipsDescendants = true
status.Parent = main
Instance.new("UICorner", status).CornerRadius = UDim.new(0, 14)

local orb = Instance.new("Frame")
orb.Size = UDim2.new(0, 56, 0, 56)
orb.Position = UDim2.new(0.5, -28, 0, 10)
orb.BackgroundColor3 = Color3.fromRGB(130, 255, 85)
orb.BackgroundTransparency = 0.25
orb.BorderSizePixel = 0
orb.Parent = status
Instance.new("UICorner", orb).CornerRadius = UDim.new(1, 0)

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 0, 24)
statusText.Position = UDim2.new(0, 0, 0, 68)
statusText.BackgroundTransparency = 1
statusText.Font = Enum.Font.GothamBold
statusText.TextSize = 14
statusText.TextColor3 = Color3.fromRGB(140, 147, 160)
statusText.Text = "Boost Luck: OFF"
statusText.Parent = status

local msg = Instance.new("TextLabel")
msg.Size = UDim2.new(1, -16, 0, 32)
msg.Position = UDim2.new(0, 8, 0, 95)
msg.BackgroundTransparency = 1
msg.Font = Enum.Font.Gotham
msg.TextSize = 12
msg.TextWrapped = true
msg.TextColor3 = Color3.fromRGB(205, 190, 255)
msg.Text = ""
msg.Parent = status

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, -20, 0, 16)
footer.Position = UDim2.new(0, 10, 1, -20)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.Gotham
footer.TextSize = 10
footer.TextColor3 = Color3.fromRGB(94, 104, 118)
footer.Text = "Visual demo only - no real game interaction"
footer.Parent = main

-- drag
local function makeDraggable(frame, handle)
	local dragging = false
	local dragStart, startPos

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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

	handle.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)
end
makeDraggable(main, header)

-- effects
local isOn = false
local effectConn
local pulseTween

local function spawnParticle()
	local p = Instance.new("Frame")
	local s = math.random(3, 7)
	p.Size = UDim2.new(0, s, 0, s)
	p.Position = UDim2.new(0.5, math.random(-18, 18), 1, -20)
	p.BackgroundColor3 = Color3.fromRGB(math.random(130, 190), 255, math.random(170, 235))
	p.BackgroundTransparency = 0.05
	p.BorderSizePixel = 0
	p.Parent = status
	Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)

	local dx = math.random(-60, 60)
	local dur = math.random(85, 145) / 100
	local tw = tween(p, dur, {
		Position = UDim2.new(0.5, dx, 0, -24),
		BackgroundTransparency = 1
	}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	tw.Completed:Connect(function()
		p:Destroy()
	end)
end

local function startEffects()
	statusText.Text = "Boost Luck: ON"
	statusText.TextColor3 = Color3.fromRGB(146, 255, 120)
	msg.Text = "Boost 100% luck for your next roll (visual preview only)"

	tween(orb, 0.2, {BackgroundTransparency = 0.05})
	tween(mainStroke, 0.25, {Transparency = 0.35})

	if pulseTween then pulseTween:Cancel() end
	pulseTween = TweenService:Create(
		orb,
		TweenInfo.new(0.85, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
		{Size = UDim2.new(0, 62, 0, 62), Position = UDim2.new(0.5, -31, 0, 7)}
	)
	pulseTween:Play()

	if effectConn then effectConn:Disconnect() end
	effectConn = RunService.RenderStepped:Connect(function(dt)
		if math.random() < (dt * 7.0) then
			spawnParticle()
		end
	end)
end

local function stopEffects()
	statusText.Text = "Boost Luck: OFF"
	statusText.TextColor3 = Color3.fromRGB(140, 147, 160)
	msg.Text = ""

	tween(orb, 0.2, {
		BackgroundTransparency = 0.25,
		Size = UDim2.new(0, 56, 0, 56),
		Position = UDim2.new(0.5, -28, 0, 10),
	})
	tween(mainStroke, 0.25, {Transparency = 0.62})

	if pulseTween then
		pulseTween:Cancel()
		pulseTween = nil
	end
	if effectConn then
		effectConn:Disconnect()
		effectConn = nil
	end
end

switch.MouseButton1Click:Connect(function()
	isOn = not isOn
	if isOn then
		playTone(SND_ON_1, 0.35, 1.15)
		task.delay(0.03, function() playTone(SND_ON_2, 0.2, 1.32) end)
		tween(switch, 0.2, {BackgroundColor3 = Color3.fromRGB(0, 214, 166)})
		tween(knob, 0.2, {Position = UDim2.new(0, 27, 0.5, -12)}, Enum.EasingStyle.Back)
		startEffects()
	else
		playTone(SND_OFF, 0.32, 0.85)
		tween(switch, 0.2, {BackgroundColor3 = Color3.fromRGB(52, 58, 70)})
		tween(knob, 0.2, {Position = UDim2.new(0, 3, 0.5, -12)}, Enum.EasingStyle.Back)
		stopEffects()
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	playTone(SND_CLOSE, 0.24, 0.95)
	stopEffects()
	local tw = tween(main, 0.22, {
		Size = UDim2.new(0, 320, 0, 238),
		BackgroundTransparency = 1
	}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	tween(mainStroke, 0.22, {Transparency = 1})
	tw.Completed:Connect(function()
		main.Visible = false
	end)
end)

closeBtn.MouseEnter:Connect(function()
	tween(closeBtn, 0.12, {BackgroundTransparency = 0.58})
end)
closeBtn.MouseLeave:Connect(function()
	tween(closeBtn, 0.12, {BackgroundTransparency = 0.75})
end)

-- =========================================================
-- LOADING FLOW
-- - smooth 1 -> 100
-- - loading panel shrinks, then main menu pops
-- =========================================================
task.spawn(function()
	for i = 1, 100 do
		percent.Text = tostring(i) .. "%"
		tween(barFill, 0.03, {Size = UDim2.new(i / 100, 0, 1, 0)}, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
		task.wait(0.02)
	end

	playTone(SND_OPEN, 0.25, 1.05)
	task.wait(0.08)

	-- shrink loading
	local shrink = tween(loadingPanel, 0.2, {
		Size = UDim2.new(0, 280, 0, 216),
		Position = UDim2.new(0.5, -140, 0.18, 0),
		BackgroundTransparency = 0.45
	}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

	tween(loadTitle, 0.18, {TextTransparency = 1})
	tween(loadSub, 0.18, {TextTransparency = 1})
	tween(percent, 0.18, {TextTransparency = 1})
	tween(barTrack, 0.18, {BackgroundTransparency = 1})
	tween(barFill, 0.18, {BackgroundTransparency = 1})
	tween(loadingStroke, 0.18, {Transparency = 1})

	shrink.Completed:Wait()
	loadingPanel.Visible = false

	-- main menu pop
	main.Visible = true
	main.Size = UDim2.new(0, 250, 0, 190)
	main.Position = UDim2.new(0.5, -125, 0.2, 0)
	main.BackgroundTransparency = 0.35
	mainStroke.Transparency = 0.8

	tween(main, 0.34, {
		Size = UDim2.new(0, 350, 0, 270),
		Position = UDim2.new(0.5, -175, 0.16, 0),
		BackgroundTransparency = 0.2
	}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	tween(mainStroke, 0.3, {Transparency = 0.62})
end)
