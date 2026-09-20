--[[
====================================================================
X100 LUCKY SCRIPT — UI DEMO ONLY
Chỉ tạo giao diện + hiệu ứng hình ảnh giả lập.
KHÔNG đọc/ghi dữ liệu game, KHÔNG gửi Remote, KHÔNG can thiệp gameplay.
====================================================================
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Xóa GUI cũ nếu chạy lại script (tránh trùng)
local old = playerGui:FindFirstChild("X100LuckyUI")
if old then old:Destroy() end

----------------------------------------------------------------
-- MODULE 0: ROOT GUI
----------------------------------------------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "X100LuckyUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

----------------------------------------------------------------
-- MODULE 1: LOADING SCREEN
----------------------------------------------------------------
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(5, 6, 10)
loadingFrame.BorderSizePixel = 0
loadingFrame.Parent = screenGui

local loadTitle = Instance.new("TextLabel")
loadTitle.Size = UDim2.new(0, 320, 0, 40)
loadTitle.Position = UDim2.new(0.5, -160, 0.42, 0)
loadTitle.BackgroundTransparency = 1
loadTitle.Text = "✨ X100 Lucky Script"
loadTitle.Font = Enum.Font.GothamBold
loadTitle.TextSize = 26
loadTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
loadTitle.Parent = loadingFrame

local barTrack = Instance.new("Frame")
barTrack.Size = UDim2.new(0, 280, 0, 10)
barTrack.Position = UDim2.new(0.5, -140, 0.5, 0)
barTrack.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
barTrack.BackgroundTransparency = 0.9
barTrack.Parent = loadingFrame
Instance.new("UICorner", barTrack).CornerRadius = UDim.new(1, 0)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 255, 176)
barFill.BorderSizePixel = 0
barFill.Parent = barTrack
Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 176)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 195, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(178, 107, 255)),
})
gradient.Parent = barFill

local percentLabel = Instance.new("TextLabel")
percentLabel.Size = UDim2.new(0, 100, 0, 20)
percentLabel.Position = UDim2.new(0.5, -50, 0.5, 20)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "0%"
percentLabel.Font = Enum.Font.Gotham
percentLabel.TextSize = 14
percentLabel.TextColor3 = Color3.fromRGB(157, 247, 208)
percentLabel.Parent = loadingFrame

----------------------------------------------------------------
-- MODULE 2: MAIN MENU (Glassmorphism style bằng Frame bo góc)
----------------------------------------------------------------
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainMenu"
mainFrame.Size = UDim2.new(0, 300, 0, 230)
mainFrame.Position = UDim2.new(0.5, -150, 0.15, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
mainFrame.BackgroundTransparency = 0.25
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 18)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(120, 255, 180)
stroke.Transparency = 0.6
stroke.Thickness = 1.2
stroke.Parent = mainFrame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 44)
header.BackgroundTransparency = 1
header.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 14, 0, 0)
title.BackgroundTransparency = 1
title.Text = "✨ X100 Lucky Script"
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -36, 0, 9)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.BackgroundTransparency = 0.85
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 140, 140)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Parent = header
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

-- Toggle Row
local toggleRow = Instance.new("Frame")
toggleRow.Size = UDim2.new(1, -28, 0, 46)
toggleRow.Position = UDim2.new(0, 14, 0, 54)
toggleRow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleRow.BackgroundTransparency = 0.95
toggleRow.Parent = mainFrame
Instance.new("UICorner", toggleRow).CornerRadius = UDim.new(0, 14)

local toggleLabel = Instance.new("TextLabel")
toggleLabel.Size = UDim2.new(1, -70, 1, 0)
toggleLabel.Position = UDim2.new(0, 14, 0, 0)
toggleLabel.BackgroundTransparency = 1
toggleLabel.Text = "🍀 Boost Luck"
toggleLabel.Font = Enum.Font.GothamSemibold
toggleLabel.TextSize = 14
toggleLabel.TextColor3 = Color3.fromRGB(234, 255, 242)
toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
toggleLabel.Parent = toggleRow

local switchBg = Instance.new("TextButton")
switchBg.Size = UDim2.new(0, 48, 0, 26)
switchBg.Position = UDim2.new(1, -60, 0.5, -13)
switchBg.BackgroundColor3 = Color3.fromRGB(43, 47, 58)
switchBg.Text = ""
switchBg.Parent = toggleRow
Instance.new("UICorner", switchBg).CornerRadius = UDim.new(1, 0)

local knob = Instance.new("Frame")
knob.Size = UDim2.new(0, 20, 0, 20)
knob.Position = UDim2.new(0, 3, 0.5, -10)
knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
knob.Parent = switchBg
Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

-- Status / Effect Zone
local statusZone = Instance.new("Frame")
statusZone.Size = UDim2.new(1, -28, 0, 100)
statusZone.Position = UDim2.new(0, 14, 0, 108)
statusZone.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
statusZone.BackgroundTransparency = 0.8
statusZone.Parent = mainFrame
Instance.new("UICorner", statusZone).CornerRadius = UDim.new(0, 14)

local glowCore = Instance.new("Frame")
glowCore.Size = UDim2.new(0, 40, 0, 40)
glowCore.Position = UDim2.new(0.5, -20, 0, 10)
glowCore.BackgroundColor3 = Color3.fromRGB(124, 252, 0)
glowCore.BackgroundTransparency = 0.85
glowCore.Parent = statusZone
Instance.new("UICorner", glowCore).CornerRadius = UDim.new(1, 0)

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 0, 20)
statusText.Position = UDim2.new(0, 0, 0, 56)
statusText.BackgroundTransparency = 1
statusText.Text = "Boost Luck: OFF"
statusText.Font = Enum.Font.GothamBold
statusText.TextSize = 13
statusText.TextColor3 = Color3.fromRGB(136, 136, 136)
statusText.Parent = statusZone

local fruitText = Instance.new("TextLabel")
fruitText.Size = UDim2.new(1, 0, 0, 16)
fruitText.Position = UDim2.new(0, 0, 0, 78)
fruitText.BackgroundTransparency = 1
fruitText.Text = ""
fruitText.Font = Enum.Font.Gotham
fruitText.TextSize = 11
fruitText.TextColor3 = Color3.fromRGB(201, 168, 255)
fruitText.Parent = statusZone

-- Footer note (bắt buộc theo yêu cầu)
local footerNote = Instance.new("TextLabel")
footerNote.Size = UDim2.new(1, -20, 0, 16)
footerNote.Position = UDim2.new(0, 10, 1, -20)
footerNote.BackgroundTransparency = 1
footerNote.Text = "Visual demo only — no real game interaction"
footerNote.Font = Enum.Font.Gotham
footerNote.TextSize = 9
footerNote.TextColor3 = Color3.fromRGB(92, 98, 112)
footerNote.Parent = mainFrame

----------------------------------------------------------------
-- MODULE 3: SOUND (dùng SoundId có sẵn của Roblox, âm ngắn nhẹ)
----------------------------------------------------------------
local function playTone(soundId, pitch)
	local s = Instance.new("Sound")
	s.SoundId = soundId
	s.Volume = 0.4
	s.PlaybackSpeed = pitch or 1
	s.Parent = SoundService
	s:Play()
	game:GetService("Debris"):AddItem(s, 1)
end

-- Âm UI mặc định của Roblox (click nhẹ) — an toàn, không cần asset ngoài
local CLICK_SOUND = "rbxasset://sounds/electronicpingshort.wav"

----------------------------------------------------------------
-- MODULE 4: DRAG (chuột PC + chạm mobile dùng chung InputBegan/Changed)
----------------------------------------------------------------
local function makeDraggable(frame, handle)
	local dragging, dragStart, startPos

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
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
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)
end

----------------------------------------------------------------
-- MODULE 5: VISUAL EFFECT (particles + random tên tự đặt)
----------------------------------------------------------------
local demoFruits = {
	"Ánh Sáng Huyền Bí", "Bóng Tối Vĩnh Cửu", "Rồng Cổ Đại",
	"Sấm Sét Ngàn Năm", "Băng Giá Vĩnh Hằng", "Lửa Thiêng",
	"Pha Lê Huyền Thoại", "Gió Vô Hình"
}

local effectRunning = false
local coreGlowTween

local function spawnParticle()
	local p = Instance.new("Frame")
	p.Size = UDim2.new(0, 4, 0, 4)
	p.BackgroundColor3 = Color3.fromRGB(157, 255, 214)
	p.Position = UDim2.new(0.5, math.random(-10, 10), 0, 40)
	p.Parent = statusZone
	Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)

	local dx = math.random(-40, 40)
	local tween = TweenService:Create(p, TweenInfo.new(1.1, Enum.EasingStyle.Quad), {
		Position = UDim2.new(0.5, dx, 0, -20),
		BackgroundTransparency = 1
	})
	tween:Play()
	tween.Completed:Connect(function() p:Destroy() end)
end

local function showRandomFruit()
	local name = demoFruits[math.random(1, #demoFruits)]
	fruitText.Text = "🍇 " .. name .. " (mô phỏng)"
end

local particleLoop, fruitLoop

local function startEffect()
	effectRunning = true
	statusText.Text = "Boost Luck: ON"
	statusText.TextColor3 = Color3.fromRGB(124, 252, 0)

	-- Glow pulse animation
	TweenService:Create(glowCore, TweenInfo.new(0.4), {BackgroundTransparency = 0.2}):Play()

	showRandomFruit()

	particleLoop = task.spawn(function()
		while effectRunning do
			spawnParticle()
			task.wait(0.18)
		end
	end)

	fruitLoop = task.spawn(function()
		while effectRunning do
			task.wait(2.2)
			if effectRunning then showRandomFruit() end
		end
	end)
end

local function stopEffect()
	effectRunning = false
	statusText.Text = "Boost Luck: OFF"
	statusText.TextColor3 = Color3.fromRGB(136, 136, 136)
	fruitText.Text = ""
	TweenService:Create(glowCore, TweenInfo.new(0.4), {BackgroundTransparency = 0.85}):Play()
end

----------------------------------------------------------------
-- MODULE 6: TOGGLE LOGIC
----------------------------------------------------------------
local isOn = false

local function toggleSwitch()
	isOn = not isOn

	if isOn then
		playTone(CLICK_SOUND, 1.3)
		TweenService:Create(switchBg, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(0, 200, 150)}):Play()
		TweenService:Create(knob, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Position = UDim2.new(0, 25, 0.5, -10)}):Play()
		startEffect()
	else
		playTone(CLICK_SOUND, 0.8)
		TweenService:Create(switchBg, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(43, 47, 58)}):Play()
		TweenService:Create(knob, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Position = UDim2.new(0, 3, 0.5, -10)}):Play()
		stopEffect()
	end
end

switchBg.MouseButton1Click:Connect(toggleSwitch)

----------------------------------------------------------------
-- MODULE 7: CLOSE BUTTON
----------------------------------------------------------------
closeBtn.MouseButton1Click:Connect(function()
	local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3), {
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 260, 0, 200)
	})
	tween:Play()
	tween.Completed:Connect(function()
		mainFrame.Visible = false
	end)
end)

----------------------------------------------------------------
-- INIT: chạy loading rồi hiện menu
----------------------------------------------------------------
task.spawn(function()
	local progress = 0
	while progress < 100 do
		progress = math.min(100, progress + math.random(4, 9))
		barFill.Size = UDim2.new(progress / 100, 0, 1, 0)
		percentLabel.Text = math.floor(progress) .. "%"
		task.wait(0.12)
	end

	task.wait(0.3)

	local fadeOut = TweenService:Create(loadingFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1})
	fadeOut:Play()
	loadTitle.TextTransparency = 0
	TweenService:Create(loadTitle, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
	TweenService:Create(percentLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
	TweenService:Create(barTrack, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
	TweenService:Create(barFill, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()

	fadeOut.Completed:Connect(function()
		loadingFrame.Visible = false

		mainFrame.Visible = true
		mainFrame.Position = UDim2.new(0.5, -150, 0.1, 0)
		mainFrame.BackgroundTransparency = 1

		local slideIn = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
			Position = UDim2.new(0.5, -150, 0.15, 0),
			BackgroundTransparency = 0.25
		})
		slideIn:Play()

		makeDraggable(mainFrame, header)
	end)
end)
