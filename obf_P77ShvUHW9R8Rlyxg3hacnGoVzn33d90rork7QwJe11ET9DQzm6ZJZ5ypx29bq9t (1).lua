local a=loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local b=a:CreateWindow({Name='Felipe Hub',LoadingTitle='Felipe Auto Farm',LoadingSubtitle='FlashPoint',ConfigurationSaving={Enabled=true,FolderName='FelipeHub',FileName='AutoFarmConfig'},Discord={Enabled=false},KeySystem=false})
local c=b:CreateTab('Main',4483362458)
local d=false
local e
local f=1
local g=1
local h=false
local function i()
 local j=game:GetService('Players')
 local k=game:GetService('VirtualInputManager')
 local l=j.LocalPlayer
 l.CharacterAdded:Connect(function()h=false end)
 local m=workspace:WaitForChild('CrimeSpawns')
 local n=workspace:WaitForChild('NPCs')
 local function o()
  local p=l.Character or l.CharacterAdded:Wait()
  return p:WaitForChild('HumanoidRootPart')
 end
 local function q()
  if not h then
   k:SendKeyEvent(true,Enum.KeyCode.LeftControl,false,game)
   h=true
  end
 end
 local function r()
  for _,s in ipairs(m:GetChildren())do
   if s:IsA('BasePart')and s:FindFirstChild('SkyAttachment')then
    local t=o()
    t.CFrame=s.CFrame+Vector3.new(0,5,0)
    return
   end
  end
 end
 local function u()
  local v=o()
  for _,w in ipairs(n:GetChildren())do
   local x=w:FindFirstChild('HumanoidRootPart')
   if x and v then
    v.CFrame=x.CFrame*CFrame.new(0,0,-3)
    task.wait(0.2)
    k:SendMouseButtonEvent(0,0,0,true,game,0)
    k:SendMouseButtonEvent(0,0,0,false,game,0)
    task.wait(0.1)
   end
  end
 end
 e=task.spawn(function()
  while d do
   pcall(function()
    q()
    r()
    u()
   end)
   task.wait(0.5)
  end
 end)
end
c:CreateToggle({Name='Auto Farm',CurrentValue=false,Callback=function(y)
 d=y
 if d then
  h=false
  i()
 else
  if e then task.cancel(e)end
  h=false
 end
end})
c:CreateSlider({Name='Valor dos Upgrades',Range={0,1000},Increment=10,Suffix='pts',CurrentValue=f,Callback=function(z)
 f=z
 local A, B=pcall(function()
  local C=game:GetService('Players').LocalPlayer
  local D=C:WaitForChild('PlayerData'):WaitForChild('Upgrades')
  local E=C:WaitForChild('PlayerData')
  for _,F in pairs(D:GetChildren())do
   if F:IsA('IntValue')or F:IsA('NumberValue')then F.Value=f end
  end
  for _,F in pairs(E:GetChildren())do
   if F:IsA('IntValue')or F:IsA('NumberValue')then F.Value=f end
  end
 end)
 if A then a:Notify('Atualizado','Valores definidos para '..f)else a:Notify('Erro','Falha ao atualizar: '..tostring(B))end
end})
c:CreateSlider({Name='Dano (Damage)',Range={0,1000},Increment=10,Suffix='dmg',CurrentValue=g,Callback=function(G)
 g=G
 local H,I=pcall(function()
  local J=game:GetService('Players').LocalPlayer
  local K=J:WaitForChild('PlayerData'):WaitForChild('Upgrades')
  local L=J:WaitForChild('PlayerData'):WaitForChild('RebirthUpgrades')
  local M=K:FindFirstChild('Damage')
  local N=L:FindFirstChild('Damage')
  if M and (M:IsA('IntValue')or M:IsA('NumberValue'))then M.Value=g end
  if N and (N:IsA('IntValue')or N:IsA('NumberValue'))then N.Value=g end
 end)
 if H then a:Notify('Dano Atualizado','Damage definido como '..g)else a:Notify('Erro','Falha ao atualizar o dano: '..tostring(I))end
end})
