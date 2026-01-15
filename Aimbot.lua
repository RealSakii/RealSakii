--// Smart Smooth Aimbot (FOV = ON , No FOV = OFF)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- SETTINGS
local AIM_KEY = Enum.UserInputType.MouseButton2
local FOV_RADIUS = 500
local MAX_DISTANCE = 850
local SMOOTHNESS = 1.5
local AIM_PART = "HumanoidRootPart"

local FOV_ENABLED = false -- 🔵 เปิด = aimbot ทำงาน

-- FOV Circle
local FOV = Drawing.new("Circle")
FOV.Color = Color3.fromRGB(255, 255, 255)
FOV.Thickness = 0
FOV.NumSides = 0
FOV.Radius = FOV_RADIUS
FOV.Filled = false
FOV.Visible = FOV_ENABLED

-- Toggle FOV (ควบคุม aimbot ด้วย)
UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.UserInputType == Enum.UserInputType.MouseButton3 then
		FOV_ENABLED = not FOV_ENABLED
		FOV.Visible = FOV_ENABLED
	end
end)

-- หาเป้าในวง + ระยะ
local function GetTarget()
	local closestPart = nil
	local shortest = FOV_RADIUS

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character then
			local part = plr.Character:FindFirstChild(AIM_PART)
			local hum = plr.Character:FindFirstChild("Humanoid")

			if part and hum and hum.Health > 0 then
				local distance3D = (Camera.CFrame.Position - part.Position).Magnitude
				if distance3D > MAX_DISTANCE then continue end

				local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
				if onScreen then
					local dist2D = (Vector2.new(pos.X, pos.Y) -
						Vector2.new(Mouse.X, Mouse.Y)).Magnitude

					if dist2D < shortest then
						shortest = dist2D
						closestPart = part
					end
				end
			end
		end
	end

	return closestPart
end

-- Update
RunService.RenderStepped:Connect(function()
	-- อัปเดตวงเฉพาะตอนเปิด
	if FOV_ENABLED then
		FOV.Position = Vector2.new(Mouse.X, Mouse.Y)
	end

	-- ❗ ถ้า FOV ปิด = aimbot ไม่ทำงาน
	if not FOV_ENABLED then return end

	if UIS:IsMouseButtonPressed(AIM_KEY) then
		local target = GetTarget()
		if target then
			local camCF = Camera.CFrame
			local aimCF = CFrame.new(camCF.Position, target.Position)
			Camera.CFrame = camCF:Lerp(aimCF, SMOOTHNESS)
		end
	end
end)

if not getgenv().DisableNotification then
	stgui:SetCore("SendNotification", {
		Title = "☆lastsprite☆",
		Icon = "rbxassetid://133256475976305",
		Text = "smart aimbot(M3)",
		Duration = 10,
		Button1 = "Dismiss",
		Callback = function() end
	})
end
