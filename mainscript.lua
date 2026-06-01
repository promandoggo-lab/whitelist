-- [[ LOUIS HUB VIP - PROTECTED EDITION ]]
-- AUTH: Louis | LAYERS: 1-4 (Handshake, Whitelist, Key, Anti-Tamper)
-- VERSION: 13.5.2 (Security Sync Update with Custom Flick & Multi-Jump)

return function(AccessKey)
    -- [[ PROTEKSI 4: ANTI-TAMPER ]]
    local function IntegrityCheck()
        local test = tostring(game.HttpGet)
        if not test:find("function") or test:find("custom") or test:find("hook") then
            game.Players.LocalPlayer:Kick("LOUIS HUB: Security Violation (Hook Detected)")
            return false
        end
        return true
    end
    if not IntegrityCheck() then return end

    -- [[ PROTEKSI 3: KUNCI FUNGSI ]]
    if AccessKey ~= "LouisVIP_Secret_Key_9922" then 
        game.Players.LocalPlayer:Kick("LOUIS HUB: Bypass Detected (Key Error)")
        return 
    end

    -- [[ PROTEKSI 1: SESSION HANDSHAKE (Updated to genv) ]]
    local MyID = game.Players.LocalPlayer.UserId
    if not getgenv().LouisVerify or getgenv().LouisVerify() ~= "LouisVIP_Validated_" .. MyID then
        game.Players.LocalPlayer:Kick("LOUIS HUB: Illegal Execution (Handshake Failed)")
        return
    end

    -- [[ PROTEKSI 2: SELF-WHITELIST ]]
    local function Encr(t) local s = "" for _, v in pairs(t) do s = s .. string.char(v) end return s end
    local WhitelistURL = Encr({104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,110,97,122,117,109,105,114,117,105,53,45,111,115,115,47,119,104,105,116,101,108,105,115,116,47,114,101,102,115,47,104,101,97,100,115,47,109,97,105,110,47,119,104,105,116,101,108,105,115,116,46,108,117,97})
    
    local success, content = pcall(function() return game:HttpGet(WhitelistURL .. "?cache=" .. math.random(1,999)) end)
    local WhitelistData = success and loadstring(content)
    local Whitelist = WhitelistData and WhitelistData()

    if not Whitelist or not Whitelist[MyID] or os.time() > Whitelist[MyID] then
        game.Players.LocalPlayer:Kick("LOUIS HUB VIP: Unauthorized Access (Main Layer)")
        return
    end

    -- Bersihkan Session agar tidak bisa di-copy ke player lain
    getgenv().LouisVerify = nil

    -- ========================================================
    -- [[ ULTIMATE ANTI-DEBUG & SPY PROTECTOR + WEBHOOK ]]
    -- ========================================================
    local SecurityRunning = true
    local w1 = "https://discord.com/api/webhooks/"
    local w2 = "1499859204670750952/"
    local w3 = "333FbG7tb63jvKPPgD_zhHt7tn0cA1Y4T3-WLG16xQPY0uc-uozPcvnnSKS32dgzzt0P"
    local WebhookURL = w1 .. w2 .. w3

    local function SendSecurityAlert(toolName)
        local request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
        if request then
            pcall(function()
                request({
                    Url = WebhookURL,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = game:GetService("HttpService"):JSONEncode({
                        ["embeds"] = {{
                            ["title"] = "⚠️ SECURITY BREACH DETECTED!",
                            ["description"] = "A user tried to spy on Louis Hub VIP scripts.",
                            ["color"] = 0xFF0000,
                            ["fields"] = {
                                {["name"] = "👤 User", ["value"] = game.Players.LocalPlayer.Name, ["inline"] = true},
                                {["name"] = "🆔 ID", ["value"] = tostring(game.Players.LocalPlayer.UserId), ["inline"] = true},
                                {["name"] = "🔍 Detected Tool", ["value"] = toolName, ["inline"] = false},
                                {["name"] = "🛡️ Action", ["value"] = "Auto-Kick Executed", ["inline"] = true}
                            },
                            ["footer"] = {["text"] = "Louis Hub v13.5.2 | Anti-Tamper System"},
                            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
                        }}
                    })
                })
            end)
        end
    end

    local function UltimateSecurity()
        local LP = game:GetService("Players").LocalPlayer
        local CoreGui = game:GetService("CoreGui")
        
        local BlacklistNames = {
            "SimpleSpy", "Hydroxide", "TurtleSpy", "RemoteSpy", "Explorer", 
            "Dex", "DarkDex", "Adonis", "V.G Hub Spy", "OwlHub Spy", 
            "Postman", "ScriptDumper", "SaveInstance", "RbxSpy"
        }

        local function ScanDeeper()
            for _, name in pairs(BlacklistNames) do
                if CoreGui:FindFirstChild(name) then return true, name end
            end
            for _, obj in pairs(CoreGui:GetChildren()) do
                if obj:IsA("ScreenGui") and not obj:IsA("PluginGui") then
                    local data = tostring(obj):lower()
                    if data:find("spy") or data:find("remote") or data:find("debug") then
                        return true, obj.Name
                    end
                end
            end
            return false
        end

        task.spawn(function()
            while SecurityRunning do
                local detected, toolFound = false, ""
                pcall(function() 
                    local found, name = ScanDeeper()
                    if found then 
                        detected = true 
                        toolFound = name
                    end 
                end)
                
                if detected then
                    SecurityRunning = false
                    SendSecurityAlert(toolFound)
                    task.wait(0.1)
                    LP:Kick("\n[LOUIS HUB SECURITY]\nUnauthorized Debugging Tool Detected: " .. toolFound)
                    break
                end
                task.wait(3)
            end
        end)
    end
    UltimateSecurity()

    -- ========================================================
    -- [[ KODE UTAMA LOUIS HUB VIP ]]
    -- ========================================================
    
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local Workspace = game:GetService("Workspace")
    local Lighting = game:GetService("Lighting")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera

    -- ==========================================
    -- [[ 1. LOADING SCREEN ]]
    -- ==========================================

    local function startLoading()
        local playerGui = LocalPlayer:WaitForChild("PlayerGui")
        
        if playerGui:FindFirstChild("LouisVIP_Loading") then
            playerGui.LouisVIP_Loading:Destroy()
        end

        local loadingGui = Instance.new("ScreenGui", playerGui)
        loadingGui.Name = "LouisVIP_Loading"
        loadingGui.IgnoreGuiInset = true
        loadingGui.DisplayOrder = 999999

        local bg = Instance.new("Frame", loadingGui)
        bg.Size = UDim2.new(1, 0, 1, 0)
        bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        bg.BackgroundTransparency = 0.3
        bg.BorderSizePixel = 0

        local profileFrame = Instance.new("Frame", bg)
        profileFrame.Size = UDim2.new(0, 250, 0, 70)
        profileFrame.Position = UDim2.new(0, 20, 1, -90)
        profileFrame.BackgroundTransparency = 1

        local profileImage = Instance.new("ImageLabel", profileFrame)
        profileImage.Size = UDim2.new(0, 55, 0, 55)
        profileImage.Position = UDim2.new(0, 0, 0.5, -27)
        profileImage.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        profileImage.BorderSizePixel = 0
        profileImage.ImageTransparency = 1 
        profileImage.BackgroundTransparency = 1
        
        task.spawn(function()
            local content = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
            profileImage.Image = content
        end)
        
        Instance.new("UICorner", profileImage).CornerRadius = UDim.new(1, 0)
        local pStroke = Instance.new("UIStroke", profileImage)
        pStroke.Thickness = 2
        pStroke.Color = Color3.fromRGB(0, 180, 255)
        pStroke.Transparency = 1 

        local userInfo = Instance.new("TextLabel", profileFrame)
        userInfo.Size = UDim2.new(1, -65, 1, 0)
        userInfo.Position = UDim2.new(0, 65, 0, 0)
        userInfo.BackgroundTransparency = 1
        userInfo.Font = Enum.Font.GothamBold
        userInfo.TextColor3 = Color3.new(1, 1, 1)
        userInfo.TextSize = 12
        userInfo.TextXAlignment = Enum.TextXAlignment.Left
        userInfo.RichText = true
        userInfo.TextTransparency = 1 
        userInfo.Text = '<font color="rgb(255, 215, 0)">VIP MEMBER:</font>\n' .. LocalPlayer.Name:upper() .. '\n<font size="10" color="rgb(200, 200, 200)">ID: ' .. LocalPlayer.UserId .. '</font>'

        local title = Instance.new("TextLabel", bg)
        title.Size = UDim2.new(1, 0, 0.2, 0)
        title.Position = UDim2.new(0, 0, 0.3, 0)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBold
        title.TextSize = 65
        title.RichText = true
        title.Text = 'LOUIS HUB <font color="rgb(255, 215, 0)">VIP</font>'
        title.TextColor3 = Color3.fromRGB(0, 180, 255)
        title.TextTransparency = 1

        local welcome = Instance.new("TextLabel", bg)
        welcome.Size = UDim2.new(1, 0, 0.1, 0)
        welcome.Position = UDim2.new(0, 0, 0.45, 0)
        welcome.BackgroundTransparency = 1
        welcome.Text = "WELCOME MY VIP MEMBERS"
        welcome.TextColor3 = Color3.new(1, 1, 1)
        welcome.TextSize = 22
        welcome.Font = Enum.Font.GothamMedium
        welcome.TextTransparency = 1

        local subTitle = Instance.new("TextLabel", bg)
        subTitle.Size = UDim2.new(1, 0, 0.1, 0)
        subTitle.Position = UDim2.new(0, 0, 0.45, 0)
        subTitle.BackgroundTransparency = 1
        subTitle.Text = "TIME BOMB DUELS SCRIPT"
        subTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        subTitle.TextSize = 24
        subTitle.Font = Enum.Font.GothamBold
        subTitle.TextTransparency = 1

        local barBg = Instance.new("Frame", bg)
        barBg.Size = UDim2.new(0.3, 0, 0.008, 0)
        barBg.Position = UDim2.new(0.35, 0, 0.62, 0)
        barBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Instance.new("UICorner", barBg)
        
        local barFill = Instance.new("Frame", barBg)
        barFill.Size = UDim2.new(0, 0, 1, 0)
        barFill.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        Instance.new("UICorner", barFill)

        local skipBtn = Instance.new("TextButton", bg)
        skipBtn.Size = UDim2.new(0, 100, 0, 30)
        skipBtn.Position = UDim2.new(0.5, -50, 0.9, 0)
        skipBtn.BackgroundTransparency = 1
        skipBtn.Text = "SKIP"
        skipBtn.TextColor3 = Color3.new(1, 1, 1)
        skipBtn.Font = Enum.Font.GothamBold
        skipBtn.TextSize = 16
        skipBtn.ZIndex = 1000

        local introSound = Instance.new("Sound", bg)
        introSound.SoundId = "rbxassetid://131070686"
        introSound.Volume = 2

        local beepSound = Instance.new("Sound", bg)
        beepSound.SoundId = "rbxassetid://1567483853"
        beepSound.Volume = 0.6

        local function electricZapEffect()
            for i = 1, 3 do
                local zap = Instance.new("Frame", bg)
                zap.BackgroundColor3 = Color3.new(1, 1, 1)
                zap.BorderSizePixel = 0
                zap.Size = UDim2.new(0, math.random(50, 150), 0, 2)
                zap.Position = UDim2.new(0.5, math.random(-150, 150), 0.35, math.random(-40, 40))
                zap.Rotation = math.random(0, 360)
                task.spawn(function() task.wait(0.12); zap:Destroy() end)
            end
        end

        local skipTriggered = false
        local function forceExit()
            if skipTriggered then return end
            skipTriggered = true
            introSound:Stop()
            beepSound:Stop()
            local fadeInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(bg, fadeInfo, {BackgroundTransparency = 1}):Play()
            for _, obj in ipairs(bg:GetDescendants()) do
                pcall(function()
                    if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                        TweenService:Create(obj, fadeInfo, {TextTransparency = 1}):Play()
                    elseif obj:IsA("ImageLabel") then
                        TweenService:Create(obj, fadeInfo, {ImageTransparency = 1, BackgroundTransparency = 1}):Play()
                    elseif obj:IsA("Frame") then
                        TweenService:Create(obj, fadeInfo, {BackgroundTransparency = 1}):Play()
                    elseif obj:IsA("UIStroke") then
                        TweenService:Create(obj, fadeInfo, {Transparency = 1}):Play()
                    end
                end)
            end
            task.delay(0.45, function() loadingGui:Destroy() end)
        end

        skipBtn.MouseButton1Click:Connect(forceExit)
        introSound:Play()

        task.spawn(function()
            TweenService:Create(title, TweenInfo.new(1), {TextTransparency = 0}):Play()
            TweenService:Create(welcome, TweenInfo.new(1), {TextTransparency = 0}):Play()
            TweenService:Create(profileImage, TweenInfo.new(1), {ImageTransparency = 0, BackgroundTransparency = 0}):Play()
            TweenService:Create(pStroke, TweenInfo.new(1), {Transparency = 0}):Play()
            TweenService:Create(userInfo, TweenInfo.new(1), {TextTransparency = 0}):Play()
            task.wait(2.5)
            if skipTriggered then return end
            TweenService:Create(welcome, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
            task.wait(0.8)
            if skipTriggered then return end
            TweenService:Create(subTitle, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
            for i = 1, 6 do 
                if skipTriggered then break end
                local vis = not subTitle.Visible
                subTitle.Visible = vis
                title.Visible = vis
                if vis then electricZapEffect(); beepSound:Play() end
                task.wait(0.25)
            end
            if not skipTriggered then subTitle.Visible = true; title.Visible = true end
        end)

        barFill:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Linear", 7)
        local waitTime = 0
        while waitTime < 7.5 and not skipTriggered do
            waitTime = waitTime + 0.1
            task.wait(0.1)
        end
        if not skipTriggered then forceExit() end
    end

    startLoading()

    -- ==========================================
    -- [[ 2. CORE SETTINGS ]]
    -- ==========================================

    _G.MainColor = Color3.fromRGB(15, 15, 20)
    _G.AccentColor = Color3.fromRGB(0, 180, 255)
    _G.FollowEnabled = false
    _G.PredictEnabled = false 
    _G.HJEnabled = false 
    _G.FaceClassic = false 
    _G.FacePro = false 
    _G.FlickEnabled = false 
    _G.FlickActive = false
    _G.FlickStrength = 45
    _G.AutoJumpEnabled = false
    _G.WallHopDist = 2.5 
    _G.WHNormal = true 
    _G.WHInstant = false
    _G.PotatoEnabled = false

    _G.FOVEnabled = false
    _G.FOVValue = 70
    _G.FreezeEnabled = false
    
    -- INFINITE JUMP STATE
    _G.InfJumpEnabled = false
    _G.MaxJumpCount = 5
    _G.CurrentJumpCount = 0

    -- AUTO HOLD BOMB STATE
    _G.AutoHoldEnabled = false
    _G.AutoHoldActive = false

    -- GLOBAL NILAI UKURAN (1-200)
    _G.UIScaleValue = 100
    _G.ExtScaleValue = 100

    -- ANIMASI INDIKATOR TENGAH STATE
    _G.IndicatorEnabled = false
    _G.SelectedAnimType = 1

    local faceSpeed = 0.18
    local lockedTarget = nil 
    local lastHadBomb = false
    local retreatTimer = 0
    local targetMemory = 0 
    local bombTimer = 0 
    local isLocked = false
    local isMinimized = true 
    local hudMinimized = false
    local canWallJump = true
    local jumpDebounce = false

    -- Performance Throttling
    local lastRaycastCheck = 0
    local lastTargetSearch = 0
    local raycastInterval = 0.1
    local searchInterval = 0.25
    local isVisibleCached = false
    local isSticking = false

    local function ApplyPotato()
        pcall(function()
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 250
            Lighting.Brightness = 2
            local s = settings()
            s.Rendering.QualityLevel = 1
            s.Physics.AllowSleep = true
        end)
        task.defer(function()
            local function Clean(v)
                if not v:IsA("BasePart") and not v:IsA("MeshPart") then 
                    if v:IsA("Decal") or v:IsA("Texture") or v:IsA("Light") then v:Destroy()
                    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
                    return 
                end
                v.Material = Enum.Material.SmoothPlastic
                v.CastShadow = false
                v.Reflectance = 0
                if v:IsA("MeshPart") then v.TextureID = "" end
            end
            for _, v in ipairs(workspace:GetDescendants()) do pcall(Clean, v) end
        end)
    end

    -- ==========================================
    -- [[ 3. MAIN SCRIPT GUI ]]
    -- ==========================================

    local ScreenGui = Instance.new("ScreenGui", (gethui and gethui()) or game:GetService("CoreGui"))
    ScreenGui.Name = "LouisHub_VIP_Edition"
    ScreenGui.ResetOnSpawn = false

    -- [[ FLOATING TOGGLE (L BUTTON) ]]
    local MainVisible = false
    local ToggleBtnMain = Instance.new("TextButton", ScreenGui)
    ToggleBtnMain.Name = "FloatingToggle"
    ToggleBtnMain.Size = UDim2.new(0, 50, 0, 50)
    ToggleBtnMain.Position = UDim2.new(0, 20, 0.5, -25)
    ToggleBtnMain.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleBtnMain.Text = "L"
    ToggleBtnMain.TextColor3 = _G.AccentColor
    ToggleBtnMain.Font = Enum.Font.GothamBlack
    ToggleBtnMain.TextSize = 25
    ToggleBtnMain.AutoButtonColor = false
    Instance.new("UICorner", ToggleBtnMain).CornerRadius = UDim.new(1, 0)
    local ToggleStroke = Instance.new("UIStroke", ToggleBtnMain)
    ToggleStroke.Color = _G.AccentColor
    ToggleStroke.Thickness = 2
    ToggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    -- Floating Button Dragging
    local t_dragging, t_dragStart, t_startPos
    ToggleBtnMain.InputBegan:Connect(function(i) if (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) then t_dragging = true; t_dragStart = i.Position; t_startPos = ToggleBtnMain.Position end end)
    UserInputService.InputChanged:Connect(function(i) if t_dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local d = i.Position - t_dragStart; ToggleBtnMain.Position = UDim2.new(t_startPos.X.Scale, t_startPos.X.Offset + d.X, t_startPos.Y.Scale, t_startPos.Y.Offset + d.Y) end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then t_dragging = false end end)

    -- [[ HUD ELEMENTS ]]
    local HUDMain = Instance.new("Frame", ScreenGui)
    HUDMain.Size = UDim2.new(0, 125, 0, 45)
    HUDMain.Position = UDim2.new(1, -140, 0.15, 0)
    HUDMain.BackgroundTransparency = 1
    HUDMain.Visible = false

    local HUDFrame = Instance.new("Frame", HUDMain)
    HUDFrame.Size = UDim2.new(1, -20, 1, 0)
    HUDFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    HUDFrame.BackgroundTransparency = 0.6
    HUDFrame.ClipsDescendants = true
    Instance.new("UICorner", HUDFrame).CornerRadius = UDim.new(0, 6)

    local FPSLabel = Instance.new("TextLabel", HUDFrame)
    FPSLabel.Size = UDim2.new(0, 60, 0.4, 0); FPSLabel.Position = UDim2.new(0, 5, 0, 4)
    FPSLabel.BackgroundTransparency = 1; FPSLabel.TextColor3 = Color3.new(1, 1, 1)
    FPSLabel.Font = Enum.Font.GothamBold; FPSLabel.TextSize = 9; FPSLabel.TextXAlignment = Enum.TextXAlignment.Left

    local PingLabel = Instance.new("TextLabel", HUDFrame)
    PingLabel.Size = UDim2.new(0, 60, 0.4, 0); PingLabel.Position = UDim2.new(0, 5, 0.4, 0)
    PingLabel.BackgroundTransparency = 1; PingLabel.TextColor3 = _G.AccentColor
    PingLabel.Font = Enum.Font.GothamBold; PingLabel.TextSize = 9; PingLabel.TextXAlignment = Enum.TextXAlignment.Left

    local GraphFrame = Instance.new("Frame", HUDFrame)
    GraphFrame.Size = UDim2.new(0, 35, 0, 35); GraphFrame.Position = UDim2.new(1, -75, 0, 5); GraphFrame.BackgroundTransparency = 1

    local bars = {}
    for i = 1, 10 do
        local b = Instance.new("Frame", GraphFrame)
        b.Size = UDim2.new(0, 2, 0, 10); b.Position = UDim2.new(0, i*3, 1, -10)
        b.BackgroundColor3 = _G.AccentColor; b.BorderSizePixel = 0; bars[i] = b
    end

    local PotatoToggle = Instance.new("TextButton", HUDFrame)
    PotatoToggle.Size = UDim2.new(0, 30, 0, 25); PotatoToggle.Position = UDim2.new(1, -35, 0.5, -12.5)
    PotatoToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30); PotatoToggle.Text = "🍃"; PotatoToggle.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", PotatoToggle)
    local PotatoStroke = Instance.new("UIStroke", PotatoToggle)
    PotatoStroke.Color = Color3.fromRGB(100, 100, 100)
    PotatoStroke.Thickness = 1.5

    local HUDToggleBtn = Instance.new("TextButton", HUDMain)
    HUDToggleBtn.Size = UDim2.new(0, 15, 1, 0); HUDToggleBtn.Position = UDim2.new(1, -15, 0, 0)
    HUDToggleBtn.BackgroundColor3 = Color3.new(0,0,0); HUDToggleBtn.BackgroundTransparency = 0.8; HUDToggleBtn.Text = ">"
    HUDToggleBtn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", HUDToggleBtn)

    HUDToggleBtn.MouseButton1Click:Connect(function()
        hudMinimized = not hudMinimized
        HUDFrame:TweenSize(hudMinimized and UDim2.new(0, 0, 1, 0) or UDim2.new(1, -20, 1, 0), "Out", "Quad", 0.3, true)
        HUDToggleBtn.Text = hudMinimized and "<" or ">"
    end)

    -- [[ MAIN FRAME SETUP ]]
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 140, 0, 0)
    MainFrame.Position = UDim2.new(0.5, -70, 0.2, 0)
    MainFrame.BackgroundColor3 = _G.MainColor; MainFrame.Active = true; MainFrame.ClipsDescendants = true
    MainFrame.Visible = false
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
    local Stroke = Instance.new("UIStroke", MainFrame); Stroke.Color = _G.AccentColor; Stroke.Thickness = 1.5

    -- UIScale objek untuk mengukur seluruh UI secara dinamis
    local MainUIScale = Instance.new("UIScale", MainFrame)
    MainUIScale.Scale = 1.0

    local function createBtn(txt, pos, size, color)
        local b = Instance.new("TextButton", MainFrame)
        b.Size = size; b.Position = pos; b.BackgroundColor3 = color or Color3.fromRGB(30, 30, 35); b.TextColor3 = Color3.new(1,1,1)
        b.Text = txt; b.Font = Enum.Font.GothamBold; b.TextSize = 6.5; b.ClipsDescendants = true
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4); return b
    end

    local function createLabel(txt, pos, size)
        local l = Instance.new("TextLabel", MainFrame)
        l.Size = size or UDim2.new(0, 128, 0, 10); l.Position = pos
        l.BackgroundTransparency = 1; l.Text = txt; l.TextColor3 = Color3.fromRGB(200, 200, 200)
        l.TextSize = 7; l.Font = Enum.Font.GothamBold; return l
    end

    local function createLine(pos)
        local l = Instance.new("Frame", MainFrame)
        l.Size = UDim2.new(0, 128, 0, 1); l.Position = pos
        l.BackgroundColor3 = Color3.fromRGB(45, 45, 55); l.BorderSizePixel = 0; return l
    end

    local HubLabel = createLabel("LOUIS HUB VIP V13.5.2", UDim2.new(0, 6, 0, 4), UDim2.new(0, 128, 0, 12))
    HubLabel.TextColor3 = _G.AccentColor; HubLabel.TextSize = 6.5

    local ToggleBtn = createBtn("[Q] AUTO: OFF", UDim2.new(0, 6, 0, 18), UDim2.new(0, 98, 0, 20))
    local LockBtn = createBtn("🔓", UDim2.new(0, 108, 0, 18), UDim2.new(0, 26, 0, 20))

    -- [[ MENU INFO & SOSMED ]]
    local InfoBtn = createBtn("i", UDim2.new(0, 108, 0, 4), UDim2.new(0, 26, 0, 12), Color3.fromRGB(45, 45, 55))
    InfoBtn.TextSize = 8
    InfoBtn.TextColor3 = Color3.fromRGB(255, 215, 0) -- Gold

    local InfoFrame = Instance.new("Frame", MainFrame)
    InfoFrame.Size = UDim2.new(1, -12, 0, 0)
    InfoFrame.Position = UDim2.new(0, 6, 0, 45)
    InfoFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    InfoFrame.BorderSizePixel = 0
    InfoFrame.ClipsDescendants = true
    InfoFrame.Visible = false
    InfoFrame.ZIndex = 10
    Instance.new("UICorner", InfoFrame)
    local InfoStroke = Instance.new("UIStroke", InfoFrame)
    InfoStroke.Color = _G.AccentColor
    InfoStroke.Thickness = 1

    local function createInfoLabel(txt, pos, color)
        local l = Instance.new("TextLabel", InfoFrame)
        l.Size = UDim2.new(1, 0, 0, 12); l.Position = pos; l.BackgroundTransparency = 1; l.Text = txt
        l.TextColor3 = color or Color3.new(1,1,1); l.Font = Enum.Font.GothamBold; l.TextSize = 7; return l
    end

    createInfoLabel("--- SOCIAL MEDIA ---", UDim2.new(0, 0, 0, 5), _G.AccentColor)

    local function createSocialBtn(name, link, pos, color)
        local b = createBtn(name, pos, UDim2.new(1, -10, 0, 18), color)
        b.Parent = InfoFrame; b.TextSize = 6; b.ZIndex = 11
        b.MouseButton1Click:Connect(function()
            setclipboard(link)
            local oldText = b.Text; b.Text = "COPIED TO CLIPBOARD!"; task.wait(1.5); b.Text = oldText
        end)
    end

    createSocialBtn("DISCORD SERVER", "https://discord.gg/P2FEVBz2PG", UDim2.new(0, 5, 0, 25), Color3.fromRGB(88, 101, 242))
    createSocialBtn("TIKTOK: @louistimebombduels", "https://www.tiktok.com/@louistimebombduels", UDim2.new(0, 5, 0, 48), Color3.fromRGB(0, 0, 0))
    createSocialBtn("TIKTOK: @chillajakaliye_", "https://www.tiktok.com/@chillajakaliye_", UDim2.new(0, 5, 0, 71), Color3.fromRGB(0, 0, 0))

    local CloseInfo = createBtn("BACK TO MENU", UDim2.new(0, 5, 1, -22), UDim2.new(1, -10, 0, 18), Color3.fromRGB(40, 40, 45))
    CloseInfo.Parent = InfoFrame; CloseInfo.ZIndex = 11

    local infoOpen = false
    InfoBtn.MouseButton1Click:Connect(function()
        infoOpen = not infoOpen
        if infoOpen then
            InfoFrame.Visible = true
            InfoFrame:TweenSize(UDim2.new(1, -12, 1, -55), "Out", "Quad", 0.3, true)
        else
            InfoFrame:TweenSize(UDim2.new(1, -12, 0, 0), "In", "Quad", 0.3, true, function() InfoFrame.Visible = false end)
        end
    end)

    CloseInfo.MouseButton1Click:Connect(function()
        infoOpen = false
        InfoFrame:TweenSize(UDim2.new(1, -12, 0, 0), "In", "Quad", 0.3, true, function() InfoFrame.Visible = false end)
    end)

    -- MENGGUNAKAN SCROLLING FRAME UNTUK MENAMPUNG MENU (Canvas diperluas untuk Animasi)
    local ContentFrame = Instance.new("ScrollingFrame", MainFrame)
    ContentFrame.Size = UDim2.new(1, 0, 1, -61)
    ContentFrame.Position = UDim2.new(0, 0, 0, 45)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Visible = false
    ContentFrame.ScrollBarThickness = 0
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 535)
    
    local ModeBtn = createBtn("[E] MODE: CLASS", UDim2.new(0, 6, 0, 0), UDim2.new(0, 128, 0, 20)); ModeBtn.Parent = ContentFrame
    local FlickBtn = createBtn("[Z] FLICK: OFF", UDim2.new(0, 6, 0, 25), UDim2.new(0, 62, 0, 20)); FlickBtn.Parent = ContentFrame
    local HJBtn = createBtn("[X] HJ: OFF", UDim2.new(0, 72, 0, 25), UDim2.new(0, 62, 0, 20)); HJBtn.Parent = ContentFrame

    -- FLICK STRENGTH SLIDER (5-90) ditaruh di dekat tombol FLICK
    local FlickSliderLabel = createLabel("FLICK STRENGTH (5-90)", UDim2.new(0, 6, 0, 50))
    FlickSliderLabel.Parent = ContentFrame
    local FlickSliderFrame = Instance.new("Frame", ContentFrame)
    FlickSliderFrame.Size = UDim2.new(0, 128, 0, 12)
    FlickSliderFrame.Position = UDim2.new(0, 6, 0, 62)
    FlickSliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Instance.new("UICorner", FlickSliderFrame)
    
    local FlickSliderFill = Instance.new("Frame", FlickSliderFrame)
    FlickSliderFill.BackgroundColor3 = _G.AccentColor
    Instance.new("UICorner", FlickSliderFill)
    
    local FlickSliderText = Instance.new("TextLabel", FlickSliderFrame)
    FlickSliderText.Size = UDim2.new(1, 0, 1, 0)
    FlickSliderText.BackgroundTransparency = 1
    FlickSliderText.TextColor3 = Color3.new(1, 1, 1)
    FlickSliderText.TextSize = 7
    FlickSliderText.Font = Enum.Font.GothamBold

    local function syncFlickSlider(val)
        FlickSliderFill.Size = UDim2.new(math.clamp((val - 5) / 85, 0, 1), 0, 1, 0)
        FlickSliderText.Text = string.format("%.0f DEGREES", val)
    end
    syncFlickSlider(_G.FlickStrength)

    FlickSliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local moveConn; moveConn = UserInputService.InputChanged:Connect(function(move)
                if move.UserInputType == Enum.UserInputType.MouseMovement or move.UserInputType == Enum.UserInputType.Touch then
                    local pos = math.clamp((move.Position.X - FlickSliderFrame.AbsolutePosition.X) / FlickSliderFrame.AbsoluteSize.X, 0, 1)
                    _G.FlickStrength = math.floor(5 + (pos * 85))
                    syncFlickSlider(_G.FlickStrength)
                end
            end)
            UserInputService.InputEnded:Connect(function(ended)
                if ended.UserInputType == Enum.UserInputType.MouseButton1 or ended.UserInputType == Enum.UserInputType.Touch then
                    moveConn:Disconnect()
                end
            end)
        end
    end)

    -- Sisa Menu diletakkan di bawah Flick Slider secara runtut
    local AutoJumpBtn = createBtn("[C] AUTO JUMP: OFF", UDim2.new(0, 6, 0, 80), UDim2.new(0, 128, 0, 20)); AutoJumpBtn.Parent = ContentFrame

    -- TOMBOL MULTI JUMP & AUTO HOLD BOMB
    local InfJumpBtn = createBtn("[K] INF JUMP: OFF", UDim2.new(0, 6, 0, 105), UDim2.new(0, 62, 0, 20)); InfJumpBtn.Parent = ContentFrame
    local AutoHoldBtn = createBtn("[J] AUTO HOLD: OFF", UDim2.new(0, 72, 0, 105), UDim2.new(0, 62, 0, 20)); AutoHoldBtn.Parent = ContentFrame
    
    -- SLIDER JUMP LIMIT (2-10)
    createLabel("MAX JUMPS (2-10)", UDim2.new(0, 6, 0, 130)).Parent = ContentFrame
    local JumpSliderFrame = Instance.new("Frame", ContentFrame)
    JumpSliderFrame.Size = UDim2.new(0, 128, 0, 12)
    JumpSliderFrame.Position = UDim2.new(0, 6, 0, 142)
    JumpSliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Instance.new("UICorner", JumpSliderFrame)
    
    local JumpSliderFill = Instance.new("Frame", JumpSliderFrame)
    JumpSliderFill.BackgroundColor3 = _G.AccentColor
    Instance.new("UICorner", JumpSliderFill)
    
    local JumpSliderText = Instance.new("TextLabel", JumpSliderFrame)
    JumpSliderText.Size = UDim2.new(1, 0, 1, 0)
    JumpSliderText.BackgroundTransparency = 1
    JumpSliderText.TextColor3 = Color3.new(1, 1, 1)
    JumpSliderText.TextSize = 7
    JumpSliderText.Font = Enum.Font.GothamBold

    local function syncJumpSlider(val)
        JumpSliderFill.Size = UDim2.new(math.clamp((val - 2) / 8, 0, 1), 0, 1, 0)
        JumpSliderText.Text = string.format("%d JUMPS", val)
    end
    syncJumpSlider(_G.MaxJumpCount)

    JumpSliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local moveConn; moveConn = UserInputService.InputChanged:Connect(function(move)
                if move.UserInputType == Enum.UserInputType.MouseMovement or move.UserInputType == Enum.UserInputType.Touch then
                    local pos = math.clamp((move.Position.X - JumpSliderFrame.AbsolutePosition.X) / JumpSliderFrame.AbsoluteSize.X, 0, 1)
                    _G.MaxJumpCount = math.floor(2 + (pos * 8))
                    syncJumpSlider(_G.MaxJumpCount)
                end
            end)
            UserInputService.InputEnded:Connect(function(ended)
                if ended.UserInputType == Enum.UserInputType.MouseButton1 or ended.UserInputType == Enum.UserInputType.Touch then
                    moveConn:Disconnect()
                end
            end)
        end
    end)

    local InfJumpWarning = createLabel("WARNING: This feature has a risk of getting banned if you use this feature too often", UDim2.new(0, 6, 0, 157), UDim2.new(0, 128, 0, 20))
    InfJumpWarning.TextColor3 = Color3.fromRGB(255, 75, 75)
    InfJumpWarning.TextWrapped = true
    InfJumpWarning.TextSize = 5.5
    InfJumpWarning.Parent = ContentFrame

    createLine(UDim2.new(0, 6, 0, 182)).Parent = ContentFrame 
    createLabel("FACES MODE", UDim2.new(0, 6, 0, 188)).Parent = ContentFrame
    local ClassicBtn = createBtn("[G] CLASSIC: OFF", UDim2.new(0, 6, 0, 200), UDim2.new(0, 62, 0, 20)); ClassicBtn.Parent = ContentFrame
    local ProBtn = createBtn("[H] PRO: OFF", UDim2.new(0, 72, 0, 200), UDim2.new(0, 62, 0, 20)); ProBtn.Parent = ContentFrame

    createLine(UDim2.new(0, 6, 0, 226)).Parent = ContentFrame
    createLabel("WALLHOP MODE", UDim2.new(0, 6, 0, 232)).Parent = ContentFrame
    local WHNormalBtn = createBtn("NORMAL", UDim2.new(0, 6, 0, 244), UDim2.new(0, 62, 0, 20), _G.WHNormal and _G.AccentColor or nil); WHNormalBtn.Parent = ContentFrame
    local WHInstantBtn = createBtn("INSTANT", UDim2.new(0, 72, 0, 244), UDim2.new(0, 62, 0, 20)); WHInstantBtn.Parent = ContentFrame

    createLabel("WALLHOP DISTANCE", UDim2.new(0, 6, 0, 269)).Parent = ContentFrame
    local SliderFrame = Instance.new("Frame", ContentFrame); SliderFrame.Size = UDim2.new(0, 128, 0, 12); SliderFrame.Position = UDim2.new(0, 6, 0, 281); SliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30); Instance.new("UICorner", SliderFrame)
    local SliderFill = Instance.new("Frame", SliderFrame); SliderFill.BackgroundColor3 = _G.AccentColor; Instance.new("UICorner", SliderFill)
    local SliderText = Instance.new("TextLabel", SliderFrame); SliderText.Size = UDim2.new(1, 0, 1, 0); SliderText.BackgroundTransparency = 1; SliderText.TextColor3 = Color3.new(1, 1, 1); SliderText.TextSize = 7; SliderText.Font = Enum.Font.GothamBold

    -- CAMERA SETTINGS
    createLine(UDim2.new(0, 6, 0, 300)).Parent = ContentFrame
    createLabel("CAMERA SETTINGS", UDim2.new(0, 6, 0, 306)).Parent = ContentFrame
    
    local fov_label = createLabel("[I] FOV: OFF", UDim2.new(0, 6, 0, 318), UDim2.new(0, 128, 0, 20))
    local FOVBtn = createBtn("[I] FOV: OFF", UDim2.new(0, 6, 0, 318), UDim2.new(0, 128, 0, 20)); FOVBtn.Parent = ContentFrame

    local FOVSliderFrame = Instance.new("Frame", ContentFrame); FOVSliderFrame.Size = UDim2.new(0, 128, 0, 12); FOVSliderFrame.Position = UDim2.new(0, 6, 0, 343); FOVSliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30); Instance.new("UICorner", FOVSliderFrame)
    local FOVSliderFill = Instance.new("Frame", FOVSliderFrame); FOVSliderFill.BackgroundColor3 = _G.AccentColor; Instance.new("UICorner", FOVSliderFill)
    local FOVSliderText = Instance.new("TextLabel", FOVSliderFrame); FOVSliderText.Size = UDim2.new(1, 0, 1, 0); FOVSliderText.BackgroundTransparency = 1; FOVSliderText.TextColor3 = Color3.new(1, 1, 1); FOVSliderText.TextSize = 7; FOVSliderText.Font = Enum.Font.GothamBold

    -- FREEZE / LAG SYSTEM
    createLine(UDim2.new(0, 6, 0, 360)).Parent = ContentFrame
    createLabel("FREEZE / LAG SIMULATOR", UDim2.new(0, 6, 0, 366)).Parent = ContentFrame
    local FreezeBtn = createBtn("[O] FREEZE BUTTON: OFF", UDim2.new(0, 6, 0, 378), UDim2.new(0, 128, 0, 20)); FreezeBtn.Parent = ContentFrame

    -- SYSTEM SCALE SETTINGS
    createLine(UDim2.new(0, 6, 0, 403)).Parent = ContentFrame
    createLabel("SCALE SETTINGS", UDim2.new(0, 6, 0, 409)).Parent = ContentFrame

    -- SLIDER UKURAN UI (1-200%)
    local UIScaleSliderFrame = Instance.new("Frame", ContentFrame)
    UIScaleSliderFrame.Size = UDim2.new(0, 128, 0, 12)
    UIScaleSliderFrame.Position = UDim2.new(0, 6, 0, 421)
    UIScaleSliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Instance.new("UICorner", UIScaleSliderFrame)

    local UIScaleSliderFill = Instance.new("Frame", UIScaleSliderFrame)
    UIScaleSliderFill.BackgroundColor3 = _G.AccentColor
    Instance.new("UICorner", UIScaleSliderFill)

    local UIScaleSliderText = Instance.new("TextLabel", UIScaleSliderFrame)
    UIScaleSliderText.Size = UDim2.new(1, 0, 1, 0)
    UIScaleSliderText.BackgroundTransparency = 1
    UIScaleSliderText.TextColor3 = Color3.new(1, 1, 1)
    UIScaleSliderText.TextSize = 7
    UIScaleSliderText.Font = Enum.Font.GothamBold

    local function syncUIScaleSlider(val)
        UIScaleSliderFill.Size = UDim2.new(math.clamp((val - 1) / 199, 0, 1), 0, 1, 0)
        UIScaleSliderText.Text = string.format("UI SIZE: %.0f%%", val)
        MainUIScale.Scale = val / 100
    end
    syncUIScaleSlider(_G.UIScaleValue)

    local uiScaleDragging = false
    UIScaleSliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            uiScaleDragging = true
            local percentage = math.clamp((input.Position.X - UIScaleSliderFrame.AbsolutePosition.X) / UIScaleSliderFrame.AbsoluteSize.X, 0, 1)
            _G.UIScaleValue = math.floor(1 + (percentage * 199))
            syncUIScaleSlider(_G.UIScaleValue)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if uiScaleDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local percentage = math.clamp((input.Position.X - UIScaleSliderFrame.AbsolutePosition.X) / UIScaleSliderFrame.AbsoluteSize.X, 0, 1)
            _G.UIScaleValue = math.floor(1 + (percentage * 199))
            syncUIScaleSlider(_G.UIScaleValue)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            uiScaleDragging = false
        end
    end)

    -- SLIDER UKURAN TOMBOL EKSTERNAL (1-200%)
    local ExtScaleSliderFrame = Instance.new("Frame", ContentFrame)
    ExtScaleSliderFrame.Size = UDim2.new(0, 128, 0, 12)
    ExtScaleSliderFrame.Position = UDim2.new(0, 6, 0, 438)
    ExtScaleSliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Instance.new("UICorner", ExtScaleSliderFrame)

    local ExtScaleSliderFill = Instance.new("Frame", ExtScaleSliderFrame)
    ExtScaleSliderFill.BackgroundColor3 = _G.AccentColor
    Instance.new("UICorner", ExtScaleSliderFill)

    local ExtScaleSliderText = Instance.new("TextLabel", ExtScaleSliderFrame)
    ExtScaleSliderText.Size = UDim2.new(1, 0, 1, 0)
    ExtScaleSliderText.BackgroundTransparency = 1
    ExtScaleSliderText.TextColor3 = Color3.new(1, 1, 1)
    ExtScaleSliderText.TextSize = 7
    ExtScaleSliderText.Font = Enum.Font.GothamBold

    local ExternalUIScale
    local AutoHoldUIScale
    local FlickExternalUIScale

    local function syncExtScaleSlider(val)
        ExtScaleSliderFill.Size = UDim2.new(math.clamp((val - 1) / 199, 0, 1), 0, 1, 0)
        ExtScaleSliderText.Text = string.format("EXT SIZE: %.0f%%", val)
        if ExternalUIScale then ExternalUIScale.Scale = val / 100 end
        if AutoHoldUIScale then AutoHoldUIScale.Scale = val / 100 end
        if FlickExternalUIScale then FlickExternalUIScale.Scale = val / 100 end
    end

    local extScaleDragging = false
    ExtScaleSliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            extScaleDragging = true
            local percentage = math.clamp((input.Position.X - ExtScaleSliderFrame.AbsolutePosition.X) / ExtScaleSliderFrame.AbsoluteSize.X, 0, 1)
            _G.ExtScaleValue = math.floor(1 + (percentage * 199))
            syncExtScaleSlider(_G.ExtScaleValue)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if extScaleDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local percentage = math.clamp((input.Position.X - ExtScaleSliderFrame.AbsolutePosition.X) / ExtScaleSliderFrame.AbsoluteSize.X, 0, 1)
            _G.ExtScaleValue = math.floor(1 + (percentage * 199))
            syncExtScaleSlider(_G.ExtScaleValue)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            extScaleDragging = false
        end
    end)

    -- [[ SEKTOR BARU: CENTRAL INDICATOR ANIMATION SELECTOR ]]
    createLine(UDim2.new(0, 6, 0, 455)).Parent = ContentFrame
    createLabel("UI INDICATOR ANIMATION", UDim2.new(0, 6, 0, 461)).Parent = ContentFrame
    local IndicatorToggleBtn = createBtn("[U] INDICATOR: OFF", UDim2.new(0, 6, 0, 473), UDim2.new(0, 128, 0, 20)); IndicatorToggleBtn.Parent = ContentFrame
    local IndicatorStyleBtn = createBtn("TYPE: NEON SPINNER", UDim2.new(0, 6, 0, 498), UDim2.new(0, 128, 0, 20)); IndicatorStyleBtn.Parent = ContentFrame

    local AnimNames = {
        "NEON SPINNER", "PULSING BOX", "RAINBOW FLOW", "GLITCH SHAKE", "BREATHING DOT",
        "COLOR CYCLE", "DOUBLE RINGS", "HOVERING ORB", "METALLIC SWEEP", "SOUND WAVE"
    }

    -- Membuat objek Indikator Utama di tengah layar
    local CentralIndicator = Instance.new("Frame", ScreenGui)
    CentralIndicator.Name = "CentralIndicator"
    CentralIndicator.Size = UDim2.new(0, 40, 0, 40)
    CentralIndicator.Position = UDim2.new(0.5, 0, 0.5, 0)
    CentralIndicator.AnchorPoint = Vector2.new(0.5, 0.5)
    CentralIndicator.BackgroundTransparency = 1
    CentralIndicator.Visible = false

    local activeAnims = {}
    local function clearActiveAnimation()
        for _, v in ipairs(activeAnims) do
            if typeof(v) == "RBXScriptConnection" then
                v:Disconnect()
            elseif typeof(v) == "thread" then
                pcall(task.cancel, v)
            elseif typeof(v) == "Instance" and v:IsA("Tween") then
                v:Cancel()
            end
        end
        table.clear(activeAnims)
        CentralIndicator:ClearAllChildren()
        CentralIndicator.Rotation = 0
        CentralIndicator.BackgroundTransparency = 1
        CentralIndicator.Position = UDim2.new(0.5, 0, 0.5, 0)
    end

    local function applyIndicatorAnimation(index)
        clearActiveAnimation()
        if not _G.IndicatorEnabled then 
            CentralIndicator.Visible = false
            return 
        end
        CentralIndicator.Visible = true

        if index == 1 then -- NEON SPINNER
            CentralIndicator.Size = UDim2.new(0, 40, 0, 40)
            local RingStroke = Instance.new("UIStroke", CentralIndicator)
            RingStroke.Color = _G.AccentColor
            RingStroke.Thickness = 2
            Instance.new("UICorner", CentralIndicator).CornerRadius = UDim.new(1, 0)
            
            local notch = Instance.new("Frame", CentralIndicator)
            notch.Size = UDim2.new(0, 6, 0, 6)
            notch.Position = UDim2.new(0.5, -3, 0, -3)
            notch.BackgroundColor3 = _G.AccentColor
            Instance.new("UICorner", notch).CornerRadius = UDim.new(1, 0)
            
            local conn = RunService.RenderStepped:Connect(function(dt)
                CentralIndicator.Rotation = (CentralIndicator.Rotation + (120 * dt)) % 360
            end)
            table.insert(activeAnims, conn)

        elseif index == 2 then -- PULSING BOX
            CentralIndicator.Size = UDim2.new(0, 35, 0, 35)
            CentralIndicator.BackgroundColor3 = Color3.fromRGB(255, 0, 127)
            Instance.new("UICorner", CentralIndicator).CornerRadius = UDim.new(0, 8)
            CentralIndicator.BackgroundTransparency = 0
            
            local tween = TweenService:Create(CentralIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
                Size = UDim2.new(0, 20, 0, 20)
            })
            tween:Play()
            table.insert(activeAnims, tween)

        elseif index == 3 then -- RAINBOW FLOW
            CentralIndicator.Size = UDim2.new(0, 60, 0, 20)
            Instance.new("UICorner", CentralIndicator).CornerRadius = UDim.new(1, 0)
            CentralIndicator.BackgroundTransparency = 0
            
            local grad = Instance.new("UIGradient", CentralIndicator)
            grad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 255, 0)),
                ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
            })
            grad.Offset = Vector2.new(-1, 0)
            
            local tween = TweenService:Create(grad, TweenInfo.new(1.8, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false), {
                Offset = Vector2.new(1, 0)
            })
            tween:Play()
            table.insert(activeAnims, tween)

        elseif index == 4 then -- GLITCH SHAKE
            CentralIndicator.Size = UDim2.new(0, 35, 0, 35)
            local shadow = Instance.new("Frame", CentralIndicator)
            shadow.Size = UDim2.new(1, 0, 1, 0)
            shadow.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
            shadow.BackgroundTransparency = 0.4
            shadow.BorderSizePixel = 0
            
            local mainBox = Instance.new("Frame", CentralIndicator)
            mainBox.Size = UDim2.new(1, 0, 1, 0)
            mainBox.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            mainBox.BorderSizePixel = 0
            
            local th = task.spawn(function()
                while true do
                    local rx, ry = math.random(-3, 3), math.random(-3, 3)
                    mainBox.Position = UDim2.new(0, rx, 0, ry)
                    shadow.Position = UDim2.new(0, -rx, 0, -ry)
                    task.wait(0.06)
                end
            end)
            table.insert(activeAnims, th)

        elseif index == 5 then -- BREATHING DOT
            CentralIndicator.Size = UDim2.new(0, 30, 0, 30)
            CentralIndicator.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
            Instance.new("UICorner", CentralIndicator).CornerRadius = UDim.new(1, 0)
            CentralIndicator.BackgroundTransparency = 0
            
            local tween = TweenService:Create(CentralIndicator, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                BackgroundTransparency = 0.85
            })
            tween:Play()
            table.insert(activeAnims, tween)

        elseif index == 6 then -- COLOR CYCLE
            CentralIndicator.Size = UDim2.new(0, 30, 0, 30)
            CentralIndicator.Rotation = 45
            Instance.new("UICorner", CentralIndicator).CornerRadius = UDim.new(0, 4)
            CentralIndicator.BackgroundTransparency = 0
            
            local conn = RunService.RenderStepped:Connect(function(dt)
                local hue = (tick() * 0.2) % 1
                CentralIndicator.BackgroundColor3 = Color3.fromHSV(hue, 0.85, 1)
                CentralIndicator.Rotation = (CentralIndicator.Rotation + (50 * dt)) % 360
            end)
            table.insert(activeAnims, conn)

        elseif index == 7 then -- DOUBLE RINGS
            CentralIndicator.Size = UDim2.new(0, 45, 0, 45)
            
            local outRing = Instance.new("Frame", CentralIndicator)
            outRing.Size = UDim2.new(1, 0, 1, 0)
            outRing.BackgroundTransparency = 1
            Instance.new("UICorner", outRing).CornerRadius = UDim.new(1, 0)
            local sout = Instance.new("UIStroke", outRing)
            sout.Color = Color3.fromRGB(170, 0, 255)
            sout.Thickness = 1.5
            
            local nOut = Instance.new("Frame", outRing)
            nOut.Size = UDim2.new(0, 4, 0, 4)
            nOut.Position = UDim2.new(0.5, -2, 0, -2)
            nOut.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
            Instance.new("UICorner", nOut).CornerRadius = UDim.new(1, 0)
            
            local inRing = Instance.new("Frame", CentralIndicator)
            inRing.Size = UDim2.new(0, 26, 0, 26)
            inRing.Position = UDim2.new(0.5, -13, 0.5, -13)
            inRing.BackgroundTransparency = 1
            Instance.new("UICorner", inRing).CornerRadius = UDim.new(1, 0)
            local sin = Instance.new("UIStroke", inRing)
            sin.Color = Color3.fromRGB(255, 180, 0)
            sin.Thickness = 1.5
            
            local nIn = Instance.new("Frame", inRing)
            nIn.Size = UDim2.new(0, 4, 0, 4)
            nIn.Position = UDim2.new(0.5, -2, 1, -2)
            nIn.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
            Instance.new("UICorner", nIn).CornerRadius = UDim.new(1, 0)
            
            local conn = RunService.RenderStepped:Connect(function(dt)
                outRing.Rotation = (outRing.Rotation + (160 * dt)) % 360
                inRing.Rotation = (inRing.Rotation - (220 * dt)) % 360
            end)
            table.insert(activeAnims, conn)

        elseif index == 8 then -- HOVERING ORB
            CentralIndicator.Size = UDim2.new(0, 24, 0, 24)
            CentralIndicator.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
            Instance.new("UICorner", CentralIndicator).CornerRadius = UDim.new(1, 0)
            CentralIndicator.BackgroundTransparency = 0
            
            local shadow = Instance.new("Frame", ScreenGui)
            shadow.Size = UDim2.new(0, 20, 0, 4)
            shadow.BackgroundColor3 = Color3.fromRGB(0,0,0)
            shadow.BackgroundTransparency = 0.6
            shadow.BorderSizePixel = 0
            Instance.new("UICorner", shadow).CornerRadius = UDim.new(1, 0)
            table.insert(activeAnims, shadow)
            
            local conn = RunService.RenderStepped:Connect(function()
                local t = tick() * 4
                local yOffset = math.sin(t) * 10
                CentralIndicator.Position = UDim2.new(0.5, 0, 0.5, yOffset)
                
                local scale = 1 - (yOffset / 25)
                shadow.Size = UDim2.new(0, 18 * scale, 0, 4)
                shadow.Position = UDim2.new(0.5, -(9 * scale), 0.5, 18)
                shadow.BackgroundTransparency = 0.4 + (scale * 0.2)
            end)
            table.insert(activeAnims, conn)

        elseif index == 9 then -- METALLIC SWEEP
            CentralIndicator.Size = UDim2.new(0, 36, 0, 36)
            CentralIndicator.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            Instance.new("UICorner", CentralIndicator).CornerRadius = UDim.new(0, 6)
            CentralIndicator.BackgroundTransparency = 0
            
            local s = Instance.new("UIStroke", CentralIndicator)
            s.Color = Color3.fromRGB(218, 165, 32)
            s.Thickness = 1.8
            
            local shine = Instance.new("UIGradient", CentralIndicator)
            shine.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 45)),
                ColorSequenceKeypoint.new(0.45, Color3.fromRGB(40, 40, 45)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(0.55, Color3.fromRGB(40, 40, 45)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 45))
            })
            shine.Rotation = 45
            
            local th = task.spawn(function()
                while true do
                    shine.Offset = Vector2.new(-1, 0)
                    local sw = TweenService:Create(shine, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Offset = Vector2.new(1, 0)})
                    sw:Play()
                    task.wait(2.5)
                end
            end)
            table.insert(activeAnims, th)

        elseif index == 10 then -- SOUND WAVE
            CentralIndicator.Size = UDim2.new(0, 44, 0, 30)
            
            local bars = {}
            for i = 1, 3 do
                local bar = Instance.new("Frame", CentralIndicator)
                bar.Size = UDim2.new(0, 7, 0, 12)
                bar.BackgroundColor3 = Color3.fromRGB(0, 230, 230)
                bar.BorderSizePixel = 0
                Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 2)
                bars[i] = bar
            end
            bars[1].Position = UDim2.new(0.15, -3.5, 0.5, -6)
            bars[2].Position = UDim2.new(0.5, -3.5, 0.5, -6)
            bars[3].Position = UDim2.new(0.85, -3.5, 0.5, -6)
            
            local conn = RunService.RenderStepped:Connect(function()
                for i = 1, 3 do
                    local waveVal = math.sin((tick() * 10) + (i * 2))
                    local dynamicHeight = 10 + (waveVal * 8)
                    bars[i].Size = UDim2.new(0, 7, 0, dynamicHeight)
                    bars[i].Position = UDim2.new(bars[i].Position.X.Scale, -3.5, 0.5, -dynamicHeight/2)
                end
            end)
            table.insert(activeAnims, conn)
        end
    end

    local CloseBar = createBtn("▼ OPEN MENU ▼", UDim2.new(0, 0, 1, -16), UDim2.new(1, 0, 0, 16), Color3.new(0,0,0))
    CloseBar.BackgroundTransparency = 1; CloseBar.TextSize = 6

    CloseBar.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        MainFrame:TweenSize(isMinimized and UDim2.new(0, 140, 0, 58) or UDim2.new(0, 140, 0, 280), "Out", "Quad", 0.25, true)
        CloseBar.Text = isMinimized and "▼ OPEN MENU ▼" or "▲ CLOSE MENU ▲"
        task.wait(0.2); ContentFrame.Visible = not isMinimized
    end)

    ToggleBtnMain.MouseButton1Click:Connect(function()
        MainVisible = not MainVisible
        if MainVisible then
            MainFrame.Visible = true; HUDMain.Visible = true
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = isMinimized and UDim2.new(0, 140, 0, 58) or UDim2.new(0, 140, 0, 280)}):Play()
            TweenService:Create(ToggleBtnMain, TweenInfo.new(0.3), {BackgroundColor3 = _G.MainColor}):Play()
        else
            local t = TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 140, 0, 0)})
            t:Play(); t.Completed:Connect(function() if not MainVisible then MainFrame.Visible = false end end)
            HUDMain.Visible = false
            TweenService:Create(ToggleBtnMain, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
        end
    end)

    -- ==========================================
    -- [[ 4. CORE ENGINE LOGIC ]]
    -- ==========================================

    local function hasBomb(p) 
        if not p.Character then return false end
        return p.Character:FindFirstChild("Bomb") or (p:FindFirstChild("Backpack") and p.Backpack:FindFirstChild("Bomb")) 
    end

    -- DETEKSI SISA DETIK TIMER BOM
    local function getBombTime()
        local char = LocalPlayer.Character
        if not char then return nil end
        
        -- Cari BillboardGui/TextLabel di dalam karakter (Head, Tool, dll.)
        for _, obj in ipairs(char:GetDescendants()) do
            if obj:IsA("TextLabel") then
                local cleanTxt = obj.Text:match("[%d%.]+")
                if cleanTxt then
                    local num = tonumber(cleanTxt)
                    if num and num > 0 and num <= 30 then
                        return num
                    end
                end
            end
        end
        
        -- Cari di PlayerGui (jika ada HUD sisa waktu di layar)
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        if playerGui then
            for _, obj in ipairs(playerGui:GetDescendants()) do
                if obj:IsA("TextLabel") and obj.Visible then
                    local cleanTxt = obj.Text:match("^%d+%.?%d*$")
                    if cleanTxt then
                        local num = tonumber(cleanTxt)
                        if num and num > 0 and num <= 30 then
                            return num
                        end
                    end
                end
            end
        end
        return nil
    end

    local function isAlive(p) 
        return p and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 and p.Character:FindFirstChild("HumanoidRootPart") 
    end

    local function isTeammate(p)
        if not p or not p.Character then return false end
        if p.Team ~= nil and p.Team == LocalPlayer.Team then return true end
        for _, v in pairs(p.Character:GetDescendants()) do 
            if v:IsA("Highlight") and (v.FillColor.G > 0.5 or v.OutlineColor.G > 0.5) then return true end 
        end
        return false
    end

    local function canSeePlayerSticky(p)
        if not p.Character or not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return false end
        local char = p.Character; local origin = LocalPlayer.Character.HumanoidRootPart.Position
        local params = RaycastParams.new(); params.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
        params.FilterType = Enum.RaycastFilterType.Exclude
        local partsToCheck = {"Head", "HumanoidRootPart"}
        for _, partName in ipairs(partsToCheck) do
            local part = char:FindFirstChild(partName)
            if part then
                local direction = part.Position - origin
                local success, r = pcall(function() return Workspace:Raycast(origin, direction, params) end)
                if success and (not r or r.Instance:IsDescendantOf(char)) then return true end
            end
        end
        return false
    end

    RunService.Heartbeat:Connect(function(dt)
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
        local root = LocalPlayer.Character.HumanoidRootPart; local hum = LocalPlayer.Character.Humanoid
        local amIHolder = hasBomb(LocalPlayer)
        
        -- Reset Jump count if grounded
        if hum and hum.FloorMaterial ~= Enum.Material.Air then
            _G.CurrentJumpCount = 0
        end

        -- Sinkronisasi Kamera FOV Loop
        if _G.FOVEnabled then
            Camera.FieldOfView = _G.FOVValue
        end

        if hum.FloorMaterial == Enum.Material.Air and root.Velocity.Magnitude > 100 then root.Velocity = root.Velocity.Unit * 100 end
        if amIHolder then bombTimer += dt else bombTimer = 0 end

        isSticking = false

        if tick() - lastRaycastCheck >= raycastInterval then
            if lockedTarget then isVisibleCached = canSeePlayerSticky(lockedTarget) end
            lastRaycastCheck = tick()
        end

        if not lastHadBomb and amIHolder then
            retreatTimer = 0; local minDist = 15; local tagger = nil
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and isAlive(p) then
                    local d = (root.Position - p.Character.HumanoidRootPart.Position).Magnitude
                    if d < minDist then minDist = d; tagger = p end
                end
            end
            if tagger then lockedTarget = tagger; targetMemory = 2 end 
        end

        if lockedTarget and (not isAlive(lockedTarget) or isTeammate(lockedTarget) or (amIHolder and hasBomb(lockedTarget))) then lockedTarget = nil end
        if isVisibleCached then targetMemory = 1.2 elseif targetMemory > 0 then targetMemory -= dt end

        if tick() - lastTargetSearch >= searchInterval then
            local minDist = math.huge; local best = nil; local closestDist = math.huge; local closestPlayer = nil
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and isAlive(p) and not isTeammate(p) then
                    local d = (root.Position - p.Character.HumanoidRootPart.Position).Magnitude
                    if d < closestDist then closestDist = d; closestPlayer = p end
                    if (amIHolder and not hasBomb(p)) or (not amIHolder) then
                        if canSeePlayerSticky(p) then if d < minDist then minDist = d; best = p end end
                    end
                end
            end
            if closestPlayer and closestDist <= 7 then
                lockedTarget = closestPlayer; targetMemory = 1.2
            elseif not lockedTarget or (targetMemory <= 0 and not isVisibleCached) or (amIHolder and bombTimer > 7) then
                if best then lockedTarget = best; targetMemory = 1.2 end
            end
            lastTargetSearch = tick()
        end

        if lockedTarget and isAlive(lockedTarget) then
            local tRoot = lockedTarget.Character.HumanoidRootPart; local dist = (root.Position - tRoot.Position).Magnitude
            if amIHolder and dist <= 12 then hum.WalkSpeed = 25 else hum.WalkSpeed = 16 end
            if _G.FollowEnabled and retreatTimer <= 0 then 
                local targetPos = _G.PredictEnabled and (tRoot.Position + (tRoot.Velocity * 0.13)) or tRoot.Position
                hum:MoveTo(targetPos) 
            elseif _G.FollowEnabled then
                retreatTimer -= dt; hum:MoveTo(root.Position + (root.Position - tRoot.Position).Unit * 22)
            end
        else hum.WalkSpeed = 16 end

        if lastHadBomb and not amIHolder then 
            hum.WalkSpeed = 16; retreatTimer = _G.HJEnabled and 3.8 or 2.5
            if _G.HJEnabled then task.spawn(function() hum:ChangeState(3); task.wait(0.4); hum:ChangeState(3) end) end
        end

        -- LOGIKA FLICK (Menggunakan slider kekuatan Flick)
        if _G.FlickActive and amIHolder and isAlive(lockedTarget) and (root.Position - lockedTarget.Character.HumanoidRootPart.Position).Magnitude <= 4 then
            local str = _G.FlickStrength or 45
            Camera.CFrame *= CFrame.Angles(math.rad(math.random(-str/2, str/2)), math.rad(math.random(-str, str)), 0)
        end

        -- LOGIKA ROTASI DAN AUTO HOLD BOMB (Membelakangi Musuh Jika Memegang Bom, Menghadap Jika sisa 1 Detik)
        if UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter and isAlive(lockedTarget) then
            if _G.AutoHoldActive and amIHolder then
                hum.AutoRotate = false
                local remaining = getBombTime()
                local lookDir
                if remaining and remaining <= 1.05 then
                    lookDir = Vector3.new(lockedTarget.Character.HumanoidRootPart.Position.X, root.Position.Y, lockedTarget.Character.HumanoidRootPart.Position.Z)
                else
                    lookDir = root.Position + (root.Position - lockedTarget.Character.HumanoidRootPart.Position).Unit
                end
                root.CFrame = root.CFrame:Lerp(CFrame.new(root.Position, lookDir), 0.3)
            elseif _G.FaceClassic or _G.FacePro then
                hum.AutoRotate = false
                local lookDir = amIHolder and Vector3.new(lockedTarget.Character.HumanoidRootPart.Position.X, root.Position.Y, lockedTarget.Character.HumanoidRootPart.Position.Z) or (root.Position + (root.Position - lockedTarget.Character.HumanoidRootPart.Position).Unit)
                root.CFrame = root.CFrame:Lerp(CFrame.new(root.Position, lookDir), _G.FacePro and 0.3 or faceSpeed)
            else
                hum.AutoRotate = true
            end
        else
            if _G.AutoHoldActive and amIHolder and isAlive(lockedTarget) then
                hum.AutoRotate = false
                local remaining = getBombTime()
                local lookDir
                if remaining and remaining <= 1.05 then
                    lookDir = Vector3.new(lockedTarget.Character.HumanoidRootPart.Position.X, root.Position.Y, lockedTarget.Character.HumanoidRootPart.Position.Z)
                else
                    lookDir = root.Position + (root.Position - lockedTarget.Character.HumanoidRootPart.Position).Unit
                end
                root.CFrame = root.CFrame:Lerp(CFrame.new(root.Position, lookDir), 0.3)
            else
                hum.AutoRotate = true
            end
        end

        lastHadBomb = amIHolder
    end)

    local function handleAutoJump()
        if _G.AutoJumpEnabled and UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
            if LocalPlayer.Character and LocalPlayer.Character.Humanoid and LocalPlayer.Character.Humanoid.FloorMaterial ~= Enum.Material.Air then 
                LocalPlayer.Character.Humanoid.Jump = true 
            end
        end
    end
    UserInputService:GetPropertyChangedSignal("MouseBehavior"):Connect(handleAutoJump)

    -- LOGIKA JUMP REQUEST (Wallhop & Multi-Jump Limit)
    UserInputService.JumpRequest:Connect(function()
        isSticking = false 

        -- Custom Multi-Jump Logic dengan Debounce
        if _G.InfJumpEnabled and not jumpDebounce then
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                jumpDebounce = true
                if hum.FloorMaterial == Enum.Material.Air then
                    if _G.CurrentJumpCount < _G.MaxJumpCount - 1 then
                        _G.CurrentJumpCount = _G.CurrentJumpCount + 1
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                else
                    _G.CurrentJumpCount = 0
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
                task.spawn(function()
                    task.wait(0.2)
                    jumpDebounce = false
                end)
            end
        end

        if not LocalPlayer.Character or not canWallJump then return end
        local hrp = LocalPlayer.Character.HumanoidRootPart; local params = RaycastParams.new(); params.FilterDescendantsInstances = {LocalPlayer.Character}
        if _G.WHInstant and Workspace:Raycast(hrp.Position, hrp.CFrame.LookVector * _G.WallHopDist, params) then
            local angle = math.rad(37); Camera.CFrame *= CFrame.Angles(0, -angle, 0); task.wait(0.01); Camera.CFrame *= CFrame.Angles(0, angle * 2, 0); task.wait(0.01); Camera.CFrame *= CFrame.Angles(0, -angle, 0)
        elseif _G.WHNormal then
            for i = 0, 7 do
                local dir = (hrp.CFrame * CFrame.Angles(0, math.rad(i*45), 0)).LookVector
                local r = Workspace:Raycast(hrp.Position, dir * _G.WallHopDist, params)
                if r and r.Instance.CanCollide then
                    canWallJump = false; hrp.Velocity = Vector3.new(0, 0, 0); LocalPlayer.Character.Humanoid:ChangeState(3)
                    hrp.CFrame *= CFrame.Angles(0, -1, 0); task.wait(0.15); hrp.CFrame *= CFrame.Angles(0, 1, 0); task.wait(0.1); canWallJump = true; break
                end
            end
        end
    end)

    local function syncSlider(val)
        SliderFill.Size = UDim2.new(math.clamp((val - 1) / 9, 0, 1), 0, 1, 0); SliderText.Text = string.format("%.1f STUDS", val)
    end
    syncSlider(_G.WallHopDist)

    -- SINKRONISASI SLIDER FOV (1-200)
    local function syncFOVSlider(val)
        FOVSliderFill.Size = UDim2.new(math.clamp((val - 1) / 199, 0, 1), 0, 1, 0)
        FOVSliderText.Text = string.format("FOV: %.0f", val)
    end
    syncFOVSlider(_G.FOVValue)

    -- FOV SLIDER INTERACTION
    local fovDragging = false
    FOVSliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            fovDragging = true
            local percentage = math.clamp((input.Position.X - FOVSliderFrame.AbsolutePosition.X) / FOVSliderFrame.AbsoluteSize.X, 0, 1)
            _G.FOVValue = math.floor(1 + (percentage * 199))
            syncFOVSlider(_G.FOVValue)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if fovDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local percentage = math.clamp((input.Position.X - FOVSliderFrame.AbsolutePosition.X) / FOVSliderFrame.AbsoluteSize.X, 0, 1)
            _G.FOVValue = math.floor(1 + (percentage * 199))
            syncFOVSlider(_G.FOVValue)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            fovDragging = false
        end
    end)

    task.spawn(function()
        local lastTime = tick(); local frames = 0
        RunService.RenderStepped:Connect(function()
            frames += 1
            if tick() - lastTime >= 1 then
                FPSLabel.Text = "FPS: " .. frames; PingLabel.Text = "PING: " .. math.floor(LocalPlayer:GetNetworkPing() * 1000) .. "ms"
                for i = 1, 9 do bars[i].Size = bars[i+1].Size; bars[i].Position = UDim2.new(0, i*3, 1, -bars[i].Size.Y.Offset) end
                local newH = math.clamp(frames/3, 5, 30); bars[10].Size = UDim2.new(0, 2, 0, newH); bars[10].Position = UDim2.new(0, 30, 1, -newH)
                frames = 0; lastTime = tick()
            end
        end)
    end)

    -- ========================================================
    -- [[ 5. TOMBOL EKSTERNAL FREEZE (LAG), FLICK, & AUTO HOLD BOMB ]]
    -- ========================================================
    
    -- TOMBOL FREEZE
    local FreezeExternalBtn = Instance.new("TextButton", ScreenGui)
    FreezeExternalBtn.Name = "FreezeExternalButton"
    FreezeExternalBtn.Size = UDim2.new(0, 70, 0, 30)
    FreezeExternalBtn.Position = UDim2.new(0.5, -115, 0.8, 0)
    FreezeExternalBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    FreezeExternalBtn.Text = "FREEZE"
    FreezeExternalBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    FreezeExternalBtn.Font = Enum.Font.GothamBold
    FreezeExternalBtn.TextSize = 11
    FreezeExternalBtn.ZIndex = 100
    FreezeExternalBtn.Visible = false
    Instance.new("UICorner", FreezeExternalBtn).CornerRadius = UDim.new(0, 5)
    local FreezeStroke = Instance.new("UIStroke", FreezeExternalBtn)
    FreezeStroke.Color = _G.AccentColor
    FreezeStroke.Thickness = 1.5

    ExternalUIScale = Instance.new("UIScale", FreezeExternalBtn)
    ExternalUIScale.Scale = 1.0

    local StopFreezeExternalBtn = Instance.new("TextButton", FreezeExternalBtn)
    StopFreezeExternalBtn.Name = "StopFreezeExternalButton"
    StopFreezeExternalBtn.Size = UDim2.new(1, 0, 1, 0)
    StopFreezeExternalBtn.Position = UDim2.new(0, 0, 1, 5) 
    StopFreezeExternalBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    StopFreezeExternalBtn.Text = "STOP FREEZE"
    StopFreezeExternalBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    StopFreezeExternalBtn.Font = Enum.Font.GothamBold
    StopFreezeExternalBtn.TextSize = 9
    StopFreezeExternalBtn.ZIndex = 100
    Instance.new("UICorner", StopFreezeExternalBtn).CornerRadius = UDim.new(0, 5)
    local StopFreezeStroke = Instance.new("UIStroke", StopFreezeExternalBtn)
    StopFreezeStroke.Color = Color3.fromRGB(255, 50, 50) 
    StopFreezeStroke.Thickness = 1.5

    -- TOMBOL FLICK EKSTERNAL
    local FlickExternalBtn = Instance.new("TextButton", ScreenGui)
    FlickExternalBtn.Name = "FlickExternalButton"
    FlickExternalBtn.Size = UDim2.new(0, 70, 0, 30)
    FlickExternalBtn.Position = UDim2.new(0.5, -35, 0.8, 0)
    FlickExternalBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    FlickExternalBtn.Text = "FLICK"
    FlickExternalBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    FlickExternalBtn.Font = Enum.Font.GothamBold
    FlickExternalBtn.TextSize = 11
    FlickExternalBtn.ZIndex = 100
    FlickExternalBtn.Visible = false
    Instance.new("UICorner", FlickExternalBtn).CornerRadius = UDim.new(0, 5)
    local FlickExternalStroke = Instance.new("UIStroke", FlickExternalBtn)
    FlickExternalStroke.Color = _G.AccentColor
    FlickExternalStroke.Thickness = 1.5

    FlickExternalUIScale = Instance.new("UIScale", FlickExternalBtn)
    FlickExternalUIScale.Scale = 1.0

    -- TOMBOL AUTO HOLD BOMB
    local AutoHoldExternalBtn = Instance.new("TextButton", ScreenGui)
    AutoHoldExternalBtn.Name = "AutoHoldExternalButton"
    AutoHoldExternalBtn.Size = UDim2.new(0, 70, 0, 30)
    AutoHoldExternalBtn.Position = UDim2.new(0.5, 45, 0.8, 0)
    AutoHoldExternalBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    AutoHoldExternalBtn.Text = "HOLD BOMB"
    AutoHoldExternalBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    AutoHoldExternalBtn.Font = Enum.Font.GothamBold
    AutoHoldExternalBtn.TextSize = 10
    AutoHoldExternalBtn.ZIndex = 100
    AutoHoldExternalBtn.Visible = false
    Instance.new("UICorner", AutoHoldExternalBtn).CornerRadius = UDim.new(0, 5)
    local AutoHoldStroke = Instance.new("UIStroke", AutoHoldExternalBtn)
    AutoHoldStroke.Color = _G.AccentColor
    AutoHoldStroke.Thickness = 1.5

    AutoHoldUIScale = Instance.new("UIScale", AutoHoldExternalBtn)
    AutoHoldUIScale.Scale = 1.0

    syncExtScaleSlider(_G.ExtScaleValue)

    -- Tombol Freeze Draggable
    local fe_dragging, fe_dragStart, fe_startPos
    FreezeExternalBtn.InputBegan:Connect(function(i) 
        if (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) and not isLocked then 
            fe_dragging = true
            fe_dragStart = i.Position
            fe_startPos = FreezeExternalBtn.Position 
        end 
    end)
    UserInputService.InputChanged:Connect(function(i) 
        if fe_dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then 
            local d = i.Position - fe_dragStart
            FreezeExternalBtn.Position = UDim2.new(fe_startPos.X.Scale, fe_startPos.X.Offset + d.X, fe_startPos.Y.Scale, fe_startPos.Y.Offset + d.Y) 
        end 
    end)
    UserInputService.InputEnded:Connect(function(i) 
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then 
            fe_dragging = false 
        end 
    end)

    -- Tombol Flick Draggable
    local fl_dragging, fl_dragStart, fl_startPos
    FlickExternalBtn.InputBegan:Connect(function(i) 
        if (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) and not isLocked then 
            fl_dragging = true
            fl_dragStart = i.Position
            fl_startPos = FlickExternalBtn.Position 
        end 
    end)
    UserInputService.InputChanged:Connect(function(i) 
        if fl_dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then 
            local d = i.Position - fl_dragStart
            FlickExternalBtn.Position = UDim2.new(fl_startPos.X.Scale, fl_startPos.X.Offset + d.X, fl_startPos.Y.Scale, fl_startPos.Y.Offset + d.Y) 
        end 
    end)
    UserInputService.InputEnded:Connect(function(i) 
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then 
            fl_dragging = false 
        end 
    end)

    -- Tombol Auto Hold Draggable
    local ah_dragging, ah_dragStart, ah_startPos
    AutoHoldExternalBtn.InputBegan:Connect(function(i) 
        if (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) and not isLocked then 
            ah_dragging = true
            ah_dragStart = i.Position
            ah_startPos = AutoHoldExternalBtn.Position 
        end 
    end)
    UserInputService.InputChanged:Connect(function(i) 
        if ah_dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then 
            local d = i.Position - ah_dragStart
            AutoHoldExternalBtn.Position = UDim2.new(ah_startPos.X.Scale, ah_startPos.X.Offset + d.X, ah_startPos.Y.Scale, ah_startPos.Y.Offset + d.Y) 
        end 
    end)
    UserInputService.InputEnded:Connect(function(i) 
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then 
            ah_dragging = false 
        end 
    end)

    local isFreezing = false
    local activeAnchoredParts = {}

    local function stopFreeze()
        if not isFreezing then return end
        for _, part in ipairs(activeAnchoredParts) do
            pcall(function() part.Anchored = false end)
        end
        table.clear(activeAnchoredParts)
        FreezeExternalBtn.Text = "FREEZE"
        FreezeExternalBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        isFreezing = false
    end

    FreezeExternalBtn.MouseButton1Click:Connect(function()
        if isFreezing then return end
        isFreezing = true
        FreezeExternalBtn.Text = "LAGGING..."
        FreezeExternalBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)

        local char = LocalPlayer.Character
        table.clear(activeAnchoredParts)
        
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and not part.Anchored then
                    part.Anchored = true
                    table.insert(activeAnchoredParts, part)
                end
            end
        end

        local elapsed = 0
        while elapsed < 3.5 and isFreezing do
            task.wait(0.1)
            elapsed = elapsed + 0.1
        end

        if isFreezing then
            stopFreeze()
        end
    end)

    StopFreezeExternalBtn.MouseButton1Click:Connect(stopFreeze)

    -- Interaksi Tombol Eksternal Flick
    FlickExternalBtn.MouseButton1Click:Connect(function()
        _G.FlickActive = not _G.FlickActive
        if _G.FlickActive then
            FlickExternalBtn.Text = "FLICKING..."
            FlickExternalBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        else
            FlickExternalBtn.Text = "FLICK"
            FlickExternalBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end
    end)

    -- Interaksi Tombol Eksternal Auto Hold
    AutoHoldExternalBtn.MouseButton1Click:Connect(function()
        _G.AutoHoldActive = not _G.AutoHoldActive
        if _G.AutoHoldActive then
            AutoHoldExternalBtn.Text = "HOLDING..."
            AutoHoldExternalBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        else
            AutoHoldExternalBtn.Text = "HOLD BOMB"
            AutoHoldExternalBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end
    end)

    -- ==========================================
    -- [[ FUNCTION TRIGGERS FOR BUTTONS ]]
    -- ==========================================
    local function toggleFollow()
        _G.FollowEnabled = not _G.FollowEnabled
        ToggleBtn.Text = _G.FollowEnabled and "[Q] AUTO: ON" or "[Q] AUTO: OFF"
        ToggleBtn.BackgroundColor3 = _G.FollowEnabled and _G.AccentColor or Color3.fromRGB(30, 30, 35) 
    end

    local function toggleMode()
        _G.PredictEnabled = not _G.PredictEnabled
        ModeBtn.Text = _G.PredictEnabled and "[E] MODE: AGGRESSIVE" or "[E] MODE: CLASSIC" 
    end

    local function toggleFlick()
        _G.FlickEnabled = not _G.FlickEnabled
        FlickBtn.Text = _G.FlickEnabled and "[Z] FLICK: ON" or "[Z] FLICK: OFF"
        FlickBtn.BackgroundColor3 = _G.FlickEnabled and _G.AccentColor or Color3.fromRGB(30, 30, 35) 
        FlickExternalBtn.Visible = _G.FlickEnabled
        
        if not _G.FlickEnabled then
            _G.FlickActive = false
            FlickExternalBtn.Text = "FLICK"
            FlickExternalBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end
    end

    local function toggleHJ()
        _G.HJEnabled = not _G.HJEnabled
        HJBtn.Text = _G.HJEnabled and "[X] HJ: ON" or "[X] HJ: OFF"
        HJBtn.BackgroundColor3 = _G.HJEnabled and _G.AccentColor or Color3.fromRGB(30, 30, 35) 
    end

    local function toggleAutoJump()
        _G.AutoJumpEnabled = not _G.AutoJumpEnabled
        AutoJumpBtn.Text = _G.AutoJumpEnabled and "[C] AUTO JUMP: ON" or "[C] AUTO JUMP: OFF"
        AutoJumpBtn.BackgroundColor3 = _G.AutoJumpEnabled and _G.AccentColor or Color3.fromRGB(30, 30, 35) 
    end

    local function toggleClassicFace()
        _G.FaceClassic = not _G.FaceClassic
        if _G.FaceClassic then 
            _G.FacePro = false
            ProBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            ProBtn.Text = "[H] PRO: OFF" 
        end 
        ClassicBtn.Text = _G.FaceClassic and "[G] CLASSIC: ON" or "[G] CLASSIC: OFF"
        ClassicBtn.BackgroundColor3 = _G.FaceClassic and _G.AccentColor or Color3.fromRGB(30, 30, 35) 
    end

    local function toggleProFace()
        _G.FacePro = not _G.FacePro
        if _G.FacePro then 
            _G.FaceClassic = false
            ClassicBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            ClassicBtn.Text = "[G] CLASSIC: OFF" 
        end 
        ProBtn.Text = _G.FacePro and "[H] PRO: ON" or "[H] PRO: OFF"
        ProBtn.BackgroundColor3 = _G.FacePro and _G.AccentColor or Color3.fromRGB(30, 30, 35) 
    end

    local function toggleFOV()
        _G.FOVEnabled = not _G.FOVEnabled
        FOVBtn.Text = _G.FOVEnabled and "[I] FOV: ON" or "[I] FOV: OFF"
        FOVBtn.BackgroundColor3 = _G.FOVEnabled and _G.AccentColor or Color3.fromRGB(30, 30, 35)
        if not _G.FOVEnabled then
            Camera.FieldOfView = 70 
        end
    end

    local function toggleFreeze()
        _G.FreezeEnabled = not _G.FreezeEnabled
        FreezeBtn.Text = _G.FreezeEnabled and "[O] FREEZE BUTTON: ON" or "[O] FREEZE BUTTON: OFF"
        FreezeBtn.BackgroundColor3 = _G.FreezeEnabled and _G.AccentColor or Color3.fromRGB(30, 30, 35)
        FreezeExternalBtn.Visible = _G.FreezeEnabled
    end

    local function toggleInfJump()
        _G.InfJumpEnabled = not _G.InfJumpEnabled
        InfJumpBtn.Text = _G.InfJumpEnabled and "[K] INF JUMP: ON" or "[K] INF JUMP: OFF"
        InfJumpBtn.BackgroundColor3 = _G.InfJumpEnabled and _G.AccentColor or Color3.fromRGB(30, 30, 35) 
    end

    local function toggleAutoHold()
        _G.AutoHoldEnabled = not _G.AutoHoldEnabled
        AutoHoldBtn.Text = _G.AutoHoldEnabled and "[J] AUTO HOLD: ON" or "[J] AUTO HOLD: OFF"
        AutoHoldBtn.BackgroundColor3 = _G.AutoHoldEnabled and _G.AccentColor or Color3.fromRGB(30, 30, 35)
        AutoHoldExternalBtn.Visible = _G.AutoHoldEnabled
        
        if not _G.AutoHoldEnabled then
            _G.AutoHoldActive = false
            AutoHoldExternalBtn.Text = "HOLD BOMB"
            AutoHoldExternalBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end
    end

    -- PENGENDALI INDIKATOR TENGAH
    local function toggleIndicator()
        _G.IndicatorEnabled = not _G.IndicatorEnabled
        IndicatorToggleBtn.Text = _G.IndicatorEnabled and "[U] INDICATOR: ON" or "[U] INDICATOR: OFF"
        IndicatorToggleBtn.BackgroundColor3 = _G.IndicatorEnabled and _G.AccentColor or Color3.fromRGB(30, 30, 35)
        applyIndicatorAnimation(_G.SelectedAnimType)
    end

    local function cycleIndicatorStyle()
        _G.SelectedAnimType = (_G.SelectedAnimType % 10) + 1
        local activeName = AnimNames[_G.SelectedAnimType]
        IndicatorStyleBtn.Text = "TYPE: " .. activeName
        if _G.IndicatorEnabled then
            applyIndicatorAnimation(_G.SelectedAnimType)
        end
    end

    -- [[ BUTTON FUNCTIONALITIES ]]
    ToggleBtn.MouseButton1Click:Connect(toggleFollow)
    ModeBtn.MouseButton1Click:Connect(toggleMode)
    FlickBtn.MouseButton1Click:Connect(toggleFlick)
    HJBtn.MouseButton1Click:Connect(toggleHJ)
    AutoJumpBtn.MouseButton1Click:Connect(toggleAutoJump)
    ClassicBtn.MouseButton1Click:Connect(toggleClassicFace)
    ProBtn.MouseButton1Click:Connect(toggleProFace)
    InfJumpBtn.MouseButton1Click:Connect(toggleInfJump)
    AutoHoldBtn.MouseButton1Click:Connect(toggleAutoHold)
    IndicatorToggleBtn.MouseButton1Click:Connect(toggleIndicator)
    IndicatorStyleBtn.MouseButton1Click:Connect(cycleIndicatorStyle)
    
    WHNormalBtn.MouseButton1Click:Connect(function() 
        _G.WHNormal = not _G.WHNormal
        WHNormalBtn.BackgroundColor3 = _G.WHNormal and _G.AccentColor or Color3.fromRGB(30, 30, 35) 
    end)
    WHInstantBtn.MouseButton1Click:Connect(function() 
        _G.WHInstant = not _G.WHInstant
        WHInstantBtn.BackgroundColor3 = _G.WHInstant and _G.AccentColor or Color3.fromRGB(30, 30, 35) 
    end)
    
    LockBtn.MouseButton1Click:Connect(function() 
        isLocked = not isLocked
        LockBtn.Text = isLocked and "🔒" or "🔓" 
    end)
    
    PotatoToggle.MouseButton1Click:Connect(function() 
        _G.PotatoEnabled = not _G.PotatoEnabled
        PotatoToggle.BackgroundColor3 = _G.PotatoEnabled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(30, 30, 30)
        if _G.PotatoEnabled then ApplyPotato() end 
    end)

    FOVBtn.MouseButton1Click:Connect(toggleFOV)
    FreezeBtn.MouseButton1Click:Connect(toggleFreeze)

    SliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local moveConn; moveConn = UserInputService.InputChanged:Connect(function(move)
                if move.UserInputType == Enum.UserInputType.MouseMovement or move.UserInputType == Enum.UserInputType.Touch then
                    local pos = math.clamp((move.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1)
                    _G.WallHopDist = 1 + (pos * 9); syncSlider(_G.WallHopDist)
                end
            end)
            UserInputService.InputEnded:Connect(function(ended) if ended.UserInputType == Enum.UserInputType.MouseButton1 or ended.UserInputType == Enum.UserInputType.Touch then moveConn:Disconnect() end end)
        end
    end)

    -- [[ 6. KEYBIND SYSTEM ]]
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        local key = input.KeyCode
        if key == Enum.KeyCode.Q then toggleFollow()
        elseif key == Enum.KeyCode.E then toggleMode()
        elseif key == Enum.KeyCode.Z then toggleFlick()
        elseif key == Enum.KeyCode.X then toggleHJ()
        elseif key == Enum.KeyCode.C then toggleAutoJump()
        elseif key == Enum.KeyCode.G then toggleClassicFace()
        elseif key == Enum.KeyCode.H then toggleProFace()
        elseif key == Enum.KeyCode.P then PotatoToggle:Activate()
        elseif key == Enum.KeyCode.I then toggleFOV()
        elseif key == Enum.KeyCode.O then toggleFreeze()
        elseif key == Enum.KeyCode.K then toggleInfJump()
        elseif key == Enum.KeyCode.J then toggleAutoHold()
        elseif key == Enum.KeyCode.U then toggleIndicator()
        end
    end)

    -- Dragging Main UI
    local dragging, dragStart, startPos
    MainFrame.InputBegan:Connect(function(i) if (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) and not isLocked then dragging = true; dragStart = i.Position; startPos = MainFrame.Position end end)
    UserInputService.InputChanged:Connect(function(i) if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local d = i.Position - dragStart; MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y) end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end end)

    print("Louis Hub VIP V13.5.2: Initialized Successfully with Custom Flick & Multi-Jump limit.")
end
