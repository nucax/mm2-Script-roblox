local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "MM2 Role ESP",
   LoadingTitle = "Role ESP",
   LoadingSubtitle = "https://github.com/nucax",
   ConfigurationSaving = {
      Enabled = false,
   }
})

local Tab = Window:CreateTab("ESP", 4483362458)

Tab:CreateToggle({
    Name = "Role ESP",
    CurrentValue = false,
    Callback = function(value)
        getgenv().RoleESPEnabled = value
    end,
})

local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "MM2_RoleESP_Highlights"
ESPFolder.Parent = game.CoreGui

local function TrackPlayer(player)
    local highlight = Instance.new("Highlight")
    highlight.Name = player.Name .. "_RoleESP"
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = ESPFolder

    coroutine.wrap(function()
        while player and player.Parent do
            pcall(function()
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    highlight.Adornee = char
                    local knife = char:FindFirstChild("Knife") or (player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Knife"))
                    local gun = char:FindFirstChild("Gun") or (player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Gun"))

                    if knife then
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    elseif gun then
                        highlight.FillColor = Color3.fromRGB(0, 0, 255)
                    else
                        highlight.FillColor = Color3.fromRGB(0, 255, 0)
                    end

                    highlight.Enabled = getgenv().RoleESPEnabled
                else
                    highlight.Enabled = false
                end
            end)
            task.wait(1)
        end
        highlight:Destroy()
    end)()
end

for _, player in ipairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        TrackPlayer(player)
    end
end

game.Players.PlayerAdded:Connect(function(player)
    if player ~= game.Players.LocalPlayer then
        TrackPlayer(player)
    end
end)

game.Players.PlayerRemoving:Connect(function(player)
    local old = ESPFolder:FindFirstChild(player.Name .. "_RoleESP")
    if old then
        old:Destroy()
    end
end)

local FarmTab = Window:CreateTab("Farm", 4483362458)
local autofarm = false

FarmTab:CreateToggle({
    Name = "Auto Farm (TP to 99.9,140.4,60.7)",
    CurrentValue = false,
    Callback = function(value)
        autofarm = value
        if value then
            coroutine.wrap(function()
                while autofarm do
                    pcall(function()
                        local char = game.Players.LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(99.9, 140.4, 60.7)
                        end
                    end)
                    task.wait(0.1)
                end
            end)()
        end
    end,
})

local GitHubTab = Window:CreateTab("GitHub", 4483362458)

GitHubTab:CreateButton({
    Name = "Copy GitHub to Clipboard",
    Callback = function()
        setclipboard("www.github.com/nucax")
        Rayfield:Notify({
            Title = "GitHub",
            Content = "Copied GitHub link to clipboard!",
            Duration = 5
        })
    end,
})
