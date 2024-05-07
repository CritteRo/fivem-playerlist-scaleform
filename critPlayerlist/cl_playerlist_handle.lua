players = {
    [0] = {id = 0, name = "CritteR", crew = "ADMIN", rank = 34, rightText = "", showJP = false, txd = 'CHAR_BLANK_ENTRY'},
}

menuSettings = {
    title = "~y~FiveM~s~",
    subtitle = ""
}

scaleformId = 0
scaleformViewId = 0

RegisterNetEvent('critPlayerList:GetPlayers')
AddEventHandler('critPlayerList:GetPlayers', function(_playerList)
    local count = 0
    players = {}
    for i,k in pairs(_playerList) do
        players[count] = {id = k.id, name = k.name, crew = k.crew, rank = k.rank, rightText = k.rightText, showJP = k.showJP, txd = 'CHAR_BLANK_ENTRY'}
        if k.txd ~= nil then
            players[count].txd = k.txd
        end
        if k.color ~= nil then
            players[count].color = k.color
        end
        count = count + 1
    end
end)

--[[
RegisterNetEvent('critPlayerList:UpdateTxdForPlayer')
AddEventHandler('critPlayerList:UpdateTxdForPlayer', function(_playerid)
    for i,k in pairs(players) do
        if k.id == _playerid then
            print('found him')
            local ped = GetPlayerPed(_playerid)
            print(ped)
            k.txd = getHeadshot(ped)
            break
        end
    end
end)
]]
RegisterCommand('showplayerlist', function(source, args)
    --txd = getHeadshot(PlayerPedId())
    scaleformViewId = scaleformViewId + 1
    if players[0+(playersPerPage*(scaleformViewId-1))] ~= nil then
        scaleformId = generatePlayerList(menuSettings.title.." | Players: "..#players+1, "("..scaleformViewId.."/"..(math.floor(#players / playersPerPage)+1)..")", players, playersPerPage, scaleformViewId)
        if showBigMap then
            SetBigmapActive(true, false)
        end
        if scaleformViewId == 1 then
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
        else
            PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
        end
    else
        scaleformViewId = 0
        if showBigMap then
            SetBigmapActive(false, false)
        end
        PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", true )
    end
end)
RegisterKeyMapping('showplayerlist', 'Toggle Scoreboard', 'keyboard', 'z')

RegisterNetEvent('critPlayerList.ChangeTitle')
AddEventHandler('critPlayerList.ChangeTitle', function(newTitle)
    menuSettings.title = newTitle
end)

function getPlayerlistView()
    return scaleformViewId
end

Citizen.CreateThread(function()
    while true do
        if scaleformViewId ~= 0 then
            if hideHelpTextHud == true then
                HideHudComponentThisFrame(10)
            end
            DrawScaleformMovie(scaleformId, 0.14, 0.36, 0.3, 0.68, 255, 255, 255, 255)
        else
            Citizen.Wait(100)
        end
        Citizen.Wait(1)
    end
end)

function IsScoreboardOpen()
    local retval = false
    if scaleformViewId ~= 0 then
        retval = true
    end

    return retval
end