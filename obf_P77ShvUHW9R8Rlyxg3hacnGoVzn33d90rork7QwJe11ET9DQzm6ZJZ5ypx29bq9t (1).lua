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
c:CreateSlider({
 Name='Valor dos Upgrades',
 Range={0,1000},
 Increment=10,
 Suffix='pts',
 CurrentValue=f,
 Callback=function(z)
  f=z
  local success, err=pcall(function()
   local player=game:GetService('Players').LocalPlayer
   if not player then error("Player não encontrado") end
   local playerData=player:FindFirstChild('PlayerData')
   if not playerData then error("PlayerData não encontrado") end
   local upgrades=playerData:FindFirstChild('Upgrades')
   if not upgrades then error("Upgrades não encontrado") end
   local rebirths=playerData:FindFirstChild('RebirthUpgrades') or playerData
   for _,v in pairs(upgrades:GetChildren())do
    if v:IsA('IntValue')or v:IsA('NumberValue')then v.Value=f end
   end
   for _,v in pairs(rebirths:GetChildren())do
    if v:IsA('IntValue')or v:IsA('NumberValue')then v.Value=f end
   end
  end)
  if success then
   a:Notify('Atualizado','Valores definidos para '..f)
  else
   a:Notify('Erro','Falha ao atualizar: '..tostring(err))
  end
 end,
})
c:CreateSlider({
 Name='Dano (Damage)',
 Range={0,1000},
 Increment=10,
 Suffix='dmg',
 CurrentValue=g,
 Callback=function(G)
  g=G
  local success, err=pcall(function()
   local player=game:GetService('Players').LocalPlayer
   if not player then error("Player não encontrado") end
   local playerData=player:FindFirstChild('PlayerData')
   if not playerData then error("PlayerData não encontrado") end
   local upgrades=playerData:FindFirstChild('Upgrades')
   local rebirths=playerData:FindFirstChild('RebirthUpgrades')
   if not upgrades then error("Upgrades não encontrado") end
   local damage1=upgrades:FindFirstChild('Damage')
   local damage2=rebirths and rebirths:FindFirstChild('Damage')
   if damage1 and (damage1:IsA('IntValue') or damage1:IsA('NumberValue')) then damage1.Value=g end
   if damage2 and (damage2:IsA('IntValue') or damage2:IsA('NumberValue')) then damage2.Value=g end
  end)
  if success then
   a:Notify('Dano Atualizado','Damage definido como '..g)
  else
   a:Notify('Erro','Falha ao atualizar o dano: '..tostring(err))
  end
 end,
})
