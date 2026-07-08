-- =========================================================
                        -- PHASE 5 (3.3 - 4.0s): Everything fades, panel materializes
                        -- =========================================================
                        TS:Create(center, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
                        TS:Create(title, TweenInfo.new(0.4), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
                        TS:Create(subtitle, TweenInfo.new(0.35), {TextTransparency = 1}):Play()
                        TS:Create(lineTop, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 2)}):Play()
                        TS:Create(lineBot, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 2)}):Play()
                        TS:Create(darkBg, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
                        TS:Create(moonContainer, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {Position = UDim2.new(0.78, 0, 1.2, 0)}):Play()
                        TS:Create(moon, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
                        TS:Create(moonHalo, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
                        TS:Create(moonGlow, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
                        for _, c in ipairs(craters) do TS:Create(c, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play() end
                        for _, sd in ipairs(stars) do TS:Create(sd.frame, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play() end
                        TS:Create(main, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = origSize}):Play()
                        task.wait(0.7)
                        introActive = false
                        pcall(function() driftConn:Disconnect() end)
                        pcall(function() introGui:Destroy() end)
                end)
        end
end
local _savedCfg = nil
local function loadConfigKeys()
        if not(isfile and isfile("Tooze.json")) then return end
        local ok,cfg=pcall(function() return HS:JSONDecode(readfile("Tooze.json")) end)
        if not ok or not cfg then return end
        _savedCfg=cfg
        local function lk(e,d) if type(d)~="table" then return end;if d.kb and Enum.KeyCode[d.kb] then e.kb=Enum.KeyCode[d.kb] end;if d.gp and Enum.KeyCode[d.gp] then e.gp=Enum.KeyCode[d.gp] end end
        lk(KB.DropBrainrot,cfg.dropBrainrotKey);lk(KB.AutoLeft,cfg.autoLeftKey);lk(KB.AutoRight,cfg.autoRightKey)
        lk(KB.AutoBat,cfg.autoBatKey);lk(KB.LaggerToggle,cfg.laggerToggleKey)
        lk(KB.TPFloor,cfg.tpFloorKey);lk(KB.InstaReset,cfg.instaResetKey);lk(KB.GuiHide,cfg.guiHideKey);lk(KB.SpeedToggle,cfg.speedToggleKey)
        if cfg.normalSpeed then NS=cfg.normalSpeed end
        if cfg.carrySpeed then CS=cfg.carrySpeed end
        if cfg.grabRadius and type(cfg.grabRadius)=="number" then Steal.StealRadius=cfg.grabRadius else Steal.StealRadius=60 end
        if cfg.stealDuration and type(cfg.stealDuration)=="number" then Steal.StealDuration=cfg.stealDuration else Steal.StealDuration=1.4 end
        if cfg.laggerSpeed and type(cfg.laggerSpeed)=="number" then LAGGER_SPEED=cfg.laggerSpeed end
        if cfg.laggerCarrySpeed and type(cfg.laggerCarrySpeed)=="number" then LAGGER_CARRY_SPEED=cfg.laggerCarrySpeed end
        if cfg.autoTPHeight and type(cfg.autoTPHeight)=="number" then autoTPHeight=cfg.autoTPHeight end
        if cfg.autoSwing~=nil then autoSwingEnabled=cfg.autoSwing==true end
        if cfg.customFovValue and type(cfg.customFovValue)=="number" then V.customFovValue=cfg.customFovValue end
end
local function loadConfigState()
        local cfg=_savedCfg;if not cfg then return end
        if normalBox then normalBox.Text=tostring(NS) end
        if carryBox then carryBox.Text=tostring(CS) end
        if radInput then radInput.Text=tostring(Steal.StealRadius) end
        if durInput then durInput.Text=tostring(Steal.StealDuration) end
        if progressRadLbl then progressRadLbl.Text=string.format("Radius: %.2g",Steal.StealRadius) end
        if laggerBox then laggerBox.Text=tostring(LAGGER_SPEED) end
        if laggerCarryBox then laggerCarryBox.Text=tostring(LAGGER_CARRY_SPEED) end
        if autoTPHeightBox then autoTPHeightBox.Text=tostring(autoTPHeight) end
        if V.customFovBox then V.customFovBox.Text=tostring(V.customFovValue) end
        task.spawn(function()
                task.wait(0.15)
                if cfg.antiRagdoll then antiRagdollEnabled=true;if setAntiRagVisual then setAntiRagVisual(true) end;startAntiRagdoll() end
                if cfg.autoStealEnabled then Steal.AutoStealEnabled=true;if setInstaGrab then setInstaGrab(true) end;pcall(startAutoSteal) end
                if cfg.infiniteJump then infJumpEnabled=true;if setInfJumpVisual then setInfJumpVisual(true) end end
                if cfg.medusaCounter then medusaCounterEnabled=true;if setMedusaVisual then setMedusaVisual(true) end;setupMedusa(LP.Character) end
                if cfg.batCounter then batCounterEnabled=true;if setBatCounterVisual then setBatCounterVisual(true) end;startBatCounter() end
                if cfg.laggerMode then laggerToggled=true;speedMode=false;laggerPhase=cfg.laggerCarryMode and 2 or 1;refreshSpeedModeLabel()
                elseif cfg.carryMode then speedMode=false;toggleCarryMode() end
                if cfg.autoTPEnabled then autoTPEnabled=true;if setAutoTPVisual then setAutoTPVisual(true) end;startAutoTP() end
                if setAutoSwingVisual then setAutoSwingVisual(autoSwingEnabled) end
                if cfg.batSpeed and cfg.batSpeed > 0 and cfg.batSpeed <= 200 then AUTO_BAT_SPEED=cfg.batSpeed end
                if cfg.batVertSpeed and cfg.batVertSpeed > 0 and cfg.batVertSpeed <= 200 then AUTO_BAT_VERT_SPEED=cfg.batVertSpeed end
                if cfg.autoBat then autoBatEnabled=true;if autoBatSetVisual then autoBatSetVisual(true) end;queueAutoBatStart() end
                if cfg.unwalkEnabled then unwalkEnabled=true;if setUnwalkVisual then setUnwalkVisual(true) end;task.spawn(function() task.wait(0.5);startUnwalk() end) end
                if cfg.antiLag then enableAntiLag();if setAntiLagVisual then setAntiLagVisual(true) end end
                if cfg.stretchRez then enableStretchRez();if setStretchRezVisual then setStretchRezVisual(true) end end
                if cfg.customFov then enableCustomFov();if V.setCustomFovVisual then V.setCustomFovVisual(true) end end
                if cfg.skyTheme and SKY_PRESETS[cfg.skyTheme] then applyCustomSky(cfg.skyTheme);if V.setSkyVisual then V.setSkyVisual() end end
                if cfg.ultraMode then enableUltraMode();if V.setUltraModeVisual then V.setUltraModeVisual(true) end end
                if cfg.removeAccessories then enableRemoveAccessories();if V.setRemoveAccVisual then V.setRemoveAccVisual(true) end end
                if cfg.customFontEnabled then task.spawn(function() task.wait(1);enableCustomFont() end);if V.setCustomFontVisual then V.setCustomFontVisual(true) end end
                if cfg.potatoGraphics then enablePotatoGraphics();if V.setPotatoVisual then V.setPotatoVisual(true) end end
                if cfg.autoSave ~= nil then V.autoSaveEnabled=cfg.autoSave end  
                if cfg.lockGui ~= nil then _guiLocked=cfg.lockGui==true; if setLockGuiVisual then setLockGuiVisual(_guiLocked) end end
                if cfg.introEnabled ~= nil then _introEnabled=cfg.introEnabled==true; if setIntroVisual then setIntroVisual(_introEnabled) end end
                
                -- Force Cyan Duels Theme Injection & Color Sync
                if setAccent_global then 
                        setAccent_global(Color3.fromRGB(0, 255, 255)) -- Enforce high-vis Neon Cyan theme override
                end
                
                if cfg.sidebarArt and type(cfg.sidebarArt)=="string" then
                        if cfg.sidebarArt == "111817612356516" or cfg.sidebarArt == "115117078011241" or cfg.sidebarArt == "82028776918457" then cfg.sidebarArt = "99283614914059" end
                        pcall(function() if setSidebarArt_global then setSidebarArt_global(cfg.sidebarArt) end end)
                end
                if cfg.playerESP then
                        pcall(function() startPlayerESP(); if setPlayerESPVisual then setPlayerESPVisual(true) end end)
                end
        end)
end
loadConfigKeys()
buildGui()
loadConfigState()
print("Cyan Duels Loaded Successfully")
