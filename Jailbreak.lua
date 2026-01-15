local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local humanoid
local infiniteJump = false

local NORMAL_SPEED = 16
local RUN_SPEED = 150

local function setupCharacter(char)
    humanoid = char:WaitForChild("Humanoid")
    humanoid.WalkSpeed = NORMAL_SPEED
end

setupCharacter(player.Character or player.CharacterAdded:Wait())
player.CharacterAdded:Connect(setupCharacter)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end

    -- เปิด/ปิด กระโดดไม่จำกัด
    if input.KeyCode == Enum.KeyCode.B then
        infiniteJump = not infiniteJump
    end

    -- Infinite Jump
    if infiniteJump and input.KeyCode == Enum.KeyCode.Space then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

--Speed

  local walkspeedplayer = game:GetService("Players").LocalPlayer
    local walkspeedmouse = walkspeedplayer:GetMouse()
 
    local walkspeedenabled = false
 
    function x_walkspeed(key)
        if (key == "x") then
            if walkspeedenabled == false then
                _G.WS = 150;
                local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid;
                Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                Humanoid.WalkSpeed = _G.WS;
                end)
                Humanoid.WalkSpeed = _G.WS;
 
                walkspeedenabled = true
            elseif walkspeedenabled == true then
                _G.WS = 20;
                local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid;
                Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                Humanoid.WalkSpeed = _G.WS;
                end)
                Humanoid.WalkSpeed = _G.WS;
 
                walkspeedenabled = false
            end
        end
    end
 
    walkspeedmouse.KeyDown:connect(x_walkspeed)


--teleport

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- ตั้งค่าความไกลสูงสุดที่วาร์ปได้ (ถ้าต้องการจำกัดระยะ)
local MAX_DISTANCE = 1000 

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	-- ตรวจสอบว่าไม่ได้กำลังพิมพ์ในช่อง Chat และกดปุ่ม 
	if not gameProcessed and input.KeyCode == Enum.KeyCode.T then
		local character = player.Character
		if character and character:FindFirstChild("HumanoidRootPart") then

			-- ตรวจสอบว่าเมาส์ชี้ไปที่ตำแหน่งใดในโลก (Vector3)
			local targetPosition = mouse.Hit.Position

			-- ย้ายตำแหน่งตัวละคร (บวกความสูงขึ้น 3 หน่วยเพื่อไม่ให้จมดิน)
			character:SetPrimaryPartCFrame(CFrame.new(targetPosition + Vector3.new(0, 3, 0)))
		end
	end
end)