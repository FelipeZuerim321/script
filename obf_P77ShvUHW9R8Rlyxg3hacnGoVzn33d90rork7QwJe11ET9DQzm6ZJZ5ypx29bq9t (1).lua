

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = 'Felipe Hub',
    LoadingTitle = 'Felipe Auto Farm',
    LoadingSubtitle = 'FlashPoint',
    ConfigurationSaving = {
        Enabled = true,
        FolderName = 'FelipeHub',
        FileName = 'AutoFarmConfig',
    },
    Discord = {
        Enabled = false,
    },
    KeySystem = false,
})

local MainTab = Window:CreateTab('Main', 4483362458)

local autofarmAtivo = false
local autofarmThread
local upgradeValue = 1
local damageValue = 1
local ctrlPressionado = false

local function iniciarAutoFarm()
    local Players = game:GetService('Players')
    local VirtualInputManager = game:GetService('VirtualInputManager')
    local player = Players.LocalPlayer
    player.CharacterAdded:Connect(function()
        ctrlPressionado = false
    end)
    local CrimeSpawns = workspace:WaitForChild('CrimeSpawns')
    local NPCFolder = workspace:WaitForChild('NPCs')

    local function getHumanoidRootPart()
        local character = player.Character or player.CharacterAdded:Wait()
        return character:WaitForChild('HumanoidRootPart')
    end

    local function pressCtrl()
        if not ctrlPressionado then
            VirtualInputManager:SendKeyEvent(
                true,
                Enum.KeyCode.LeftControl,
                false,
                game
            )
            ctrlPressionado = true
        end
    end

    local function teleport()
        for _, part in ipairs(CrimeSpawns:GetChildren()) do
            if
                part:IsA('BasePart') and part:FindFirstChild('SkyAttachment')
            then
                local hrp = getHumanoidRootPart()
                hrp.CFrame = part.CFrame + Vector3.new(0, 5, 0)
                return
            end
        end
    end

    local function atacarNPCs()
        local hrp = getHumanoidRootPart()
        for _, npc in ipairs(NPCFolder:GetChildren()) do
            local npcHRP = npc:FindFirstChild('HumanoidRootPart')
            if npcHRP and hrp then
                hrp.CFrame = npcHRP.CFrame * CFrame.new(0, 0, -3)
                task.wait(0.2)
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                VirtualInputManager:SendMouseButtonEvent(
                    0,
                    0,
                    0,
                    false,
                    game,
                    0
                )
                task.wait(0.1)
            end
        end
    end

    autofarmThread = task.spawn(function()
        while autofarmAtivo do
            pcall(function()
                pressCtrl()
                teleport()
                atacarNPCs()
            end)
            task.wait(0.5)
        end
    end)
end

MainTab:CreateToggle({
    Name = 'Auto Farm',
    CurrentValue = false,
    Callback = function(Value)
        autofarmAtivo = Value
        if autofarmAtivo then
            ctrlPressionado = false -- Reset da flag para garantir nova ativação
            iniciarAutoFarm()
        else
            if autofarmThread then
                task.cancel(autofarmThread)
            end
            ctrlPressionado = false -- Libera para próxima ativação
        end
    end,
})

MainTab:CreateSlider({
    Name = 'Valor dos Upgrades',
    Range = { 0, 1000 },
    Increment = 10,
    Suffix = 'pts',
    CurrentValue = upgradeValue,
    Callback = function(Value)
        upgradeValue = Value
        local success, err = pcall(function()
            local player = game:GetService('Players').LocalPlayer
            local upgrades = player
                :WaitForChild('PlayerData')
                :WaitForChild('Upgrades')
            local rebirths = player:WaitForChild('PlayerData')

            for _, v in pairs(upgrades:GetChildren()) do
                if v:IsA('IntValue') or v:IsA('NumberValue') then
                    v.Value = upgradeValue
                end
            end

            for _, v in pairs(rebirths:GetChildren()) do
                if v:IsA('IntValue') or v:IsA('NumberValue') then
                    v.Value = upgradeValue
                end
            end
        end)

        if success then
            Rayfield:Notify(
                'Atualizado',
                'Valores definidos para ' .. upgradeValue
            )
        else
            Rayfield:Notify('Erro', 'Falha ao atualizar: ' .. tostring(err))
        end
    end,
})

MainTab:CreateSlider({
    Name = 'Dano (Damage)',
    Range = { 0, 1000 },
    Increment = 10,
    Suffix = 'dmg',
    CurrentValue = damageValue,
    Callback = function(Value)
        damageValue = Value
        local success, err = pcall(function()
            local player = game:GetService('Players').LocalPlayer
            local upgrades = player
                :WaitForChild('PlayerData')
                :WaitForChild('Upgrades')
            local rebirths = player
                :WaitForChild('PlayerData')
                :WaitForChild('RebirthUpgrades')
            local damage1 = upgrades:FindFirstChild('Damage')
            local damage2 = rebirths:FindFirstChild('Damage')

            if
                damage1
                and (damage1:IsA('IntValue') or damage1:IsA('NumberValue'))
            then
                damage1.Value = damageValue
            end
            if
                damage2
                and (damage2:IsA('IntValue') or damage2:IsA('NumberValue'))
            then
                damage2.Value = damageValue
            end
        end)

        if success then
            Rayfield:Notify(
                'Dano Atualizado',
                'Damage definido como ' .. damageValue
            )
        else
            Rayfield:Notify(
                'Erro',
                'Falha ao atualizar o dano: ' .. tostring(err)
            )
        end
    end,
})
