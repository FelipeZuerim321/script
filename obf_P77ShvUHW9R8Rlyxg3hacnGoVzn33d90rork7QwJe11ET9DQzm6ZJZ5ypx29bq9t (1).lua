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

MainTab:CreateToggle({
    Name = 'Auto Farm',
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            _G.IniciarAutoFarm()
        else
            _G.PararAutoFarm()
        end
    end,
})

MainTab:CreateSlider({
    Name = 'Valor dos Upgrades',
    Range = { 0, 1000 },
    Increment = 10,
    Suffix = 'pts',
    CurrentValue = 1,
    Callback = function(Value)
        _G.AplicarUpgrades(Value)
    end,
})

MainTab:CreateSlider({
    Name = 'Dano (Damage)',
    Range = { 0, 1000 },
    Increment = 10,
    Suffix = 'dmg',
    CurrentValue = 1,
    Callback = function(Value)
        _G.AplicarDano(Value)
    end,
})

loadstring(game:HttpGet("https://raw.githubusercontent.com/FelipeZuerim321/script/refs/heads/main/core.lua"))()

