-- Required Services
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

-- Player, Character, Humanoid Parts
local Player = Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local HumRP = Char:WaitForChild("HumanoidRootPart")
local Hum = Char:WaitForChild("Humanoid")

-- Keystroke Statuses
local DKeyDown = false
local SKeyDown = false
local AKeyDown = false
local WKeyDown = false
local ShiftLocked = false

-- Input:   Buff: distance (studs) to dash
--          Duration: how fast the dash will be completed
-- Output:  No return value
--          HumanoidRootPart is manipulated by BodyPosition

local function Dash(Buff, Duration)

	local BP = Instance.new("BodyPosition")
	BP.MaxForce = Vector3.new(1000000,0,1000000) -- y-component is 0 because we don't want them to fly
	BP.P = 100000
	BP.D = 2000
	Hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)

	if not ShiftLocked then
		BP.Position = (HumRP.CFrame*CFrame.new(0,0,-Buff)).Position -- Dashes forward based on buff amount
	else
		if WKeyDown then
			BP.Position = (HumRP.CFrame*CFrame.new(0,0,-Buff)).Position -- Dashes forward based on buff amount
		elseif SKeyDown then
			BP.Position = (HumRP.CFrame*CFrame.new(0,0,Buff)).Position -- Dashes backward based on buff amount
		elseif AKeyDown then
			BP.Position = (HumRP.CFrame*CFrame.new(-Buff,0,0)).Position -- Dashes leftside based on buff amount
		elseif DKeyDown then
			BP.Position = (HumRP.CFrame*CFrame.new(Buff,0,0)).Position -- Dashes rightside based on buff amount
		else
			BP.Position = (HumRP.CFrame*CFrame.new(0,0,-Buff)).Position -- Dashes forward based on buff amount
		end
	end

	BP.Parent = HumRP
	delay(Duration, function()
		BP:Destroy()
		Hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
	end)

end

-- Frequently updates Keystroke Statuses
RunService.RenderStepped:Connect(function()

    -- Intentionally repeated block of code
	local Player = game.Players.LocalPlayer
	local Char = Player.Character or Player.CharacterAdded:Wait()
	local Hum = Char:FindFirstChild("Humanoid")

	if UIS:IsKeyDown(Enum.KeyCode.W)  then
		WKeyDown = true
	else
		WKeyDown = false
	end
	if UIS:IsKeyDown(Enum.KeyCode.A)  then
		AKeyDown = true
	else
		AKeyDown = false
	end
	if UIS:IsKeyDown(Enum.KeyCode.S) then
		SKeyDown = true
	else 
		SKeyDown = false
	end
	if UIS:IsKeyDown(Enum.KeyCode.D) then
		DKeyDown = true
	else 
		DKeyDown = false
	end
	if UIS.MouseBehavior == Enum.MouseBehavior.LockCenter then
		ShiftLocked = true
	else
		ShiftLocked = false
	end

end)
