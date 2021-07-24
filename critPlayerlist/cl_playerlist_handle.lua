players = {
    [0] = {id = 0, name = "CritteR", crew = "ADMIN", rank = 34, rightText = "", showJP = false, txd = 'CHAR_BLANK_ENTRY'},
}

menuSettings = {
    title = "FiveM | Players Online: ",
    subtitle = "Page: "
}

scaleformId = 0
scaleformViewId = 0

RegisterNetEvent('critPlayerList:GetPlayers')
AddEventHandler('critPlayerList:GetPlayers', function(_playerList)
    local count = 0
    players = {}
    for i,k in pairs(_playerList) do
        players[count] = {id = k.id, name = k.name, crew = k.crew, rank = k.rank, rightText = k.rightText, showJP = k.showJP, txd = 'CHAR_BLANK_ENTRY'}
        if k.id == PlayerId() then
            players[count].txd = getHeadshot(PlayerPedId())
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
        scaleformId = generatePlayerList(menuSettings.title..#players+1, menuSettings.subtitle..scaleformViewId.." / "..(math.floor(#players / playersPerPage)+1), players, playersPerPage, scaleformViewId)
        if showBigMap then
            SetBigmapActive(true, false)
        end
        PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
    else
        scaleformViewId = 0
        if showBigMap then
            SetBigmapActive(false, false)
        end
        PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", true )
    end
end)
RegisterKeyMapping('showplayerlist', 'Toggle Scoreboard', 'keyboard', 'z')

Citizen.CreateThread(function()
    while true do
        if scaleformViewId ~= 0 then
            DrawScaleformMovie(scaleformId, 0.17, 0.4, 0.34, 0.7, 255, 255, 255, 255)
        else
            Citizen.Wait(100)
        end
        Citizen.Wait(1)
    end
end)