-- Carregando Rayfield UI (não obfuscar)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Criando a janela
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

-- Criando a aba principal
local MainTab = Window:CreateTab('Main', 4483362458)

-- Função segura de notificação
_G.notify = function(title, message)
    if Rayfield and Rayfield.Notify then
        Rayfield.Notify(Rayfield, title, message)
    else
        warn("Notify falhou: Rayfield ou método está nil")
    end
end

-- Executando a lógica obfuscada (coloque o link do seu arquivo obfuscado abaixo)
loadstring(game:HttpGet("https://raw.githubusercontent.com/FelipeZuerim321/script/main/core.lua"))()
