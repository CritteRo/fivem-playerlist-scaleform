
function getHeadshot(player)
    local handle = RegisterPedheadshot(player)
        while not IsPedheadshotReady(handle) or not IsPedheadshotValid(handle) do
            Citizen.Wait(0)
        end
    local txd = GetPedheadshotTxdString(handle)
    return txd
end

function generatePlayerList(_title, _rightTitle, _players, _playersPerPage, _page)
    local scaleform = RequestScaleformMovie("MP_MM_CARD_FREEMODE")
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    BeginScaleformMovieMethod(scaleform, "SET_TITLE")
    PushScaleformMovieMethodParameterString(_title)
    PushScaleformMovieMethodParameterString(_rightTitle)
    PushScaleformMovieMethodParameterInt(2)
    EndScaleformMovieMethod()

    for i=0, _playersPerPage, 1 do
        BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT_EMPTY")
        PushScaleformMovieMethodParameterInt(i)
        EndScaleformMovieMethod()
    end
    local condition = _page - 1
    for i=0, _playersPerPage, 1 do
        if _players[i+(_playersPerPage*condition)] ~= nil then
            BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
            PushScaleformMovieMethodParameterInt(i)
            PushScaleformMovieMethodParameterString(_players[i+(_playersPerPage*condition)].rank) --rank
            PushScaleformMovieMethodParameterString(_players[i+(_playersPerPage*condition)].name) --playername
            if _players[i+(_playersPerPage*condition)].color ~= nil then
                PushScaleformMovieMethodParameterInt(_players[i+(_playersPerPage*condition)].color) --row color
            else
                if PlayerId() == tonumber(_players[i+(_playersPerPage*condition)].id) then
                    PushScaleformMovieMethodParameterInt(rowColor2) --row color
                else
                    PushScaleformMovieMethodParameterInt(rowColor) --row color
                end
            end
            PushScaleformMovieMethodParameterInt(65) --right icon
            PushScaleformMovieMethodParameterString(_players[i+(_playersPerPage*condition)].id) --text in place of mugshot
            PushScaleformMovieMethodParameterString(_players[i+(_playersPerPage*condition)].rightText) --text next to rank
            if _players[i+(_playersPerPage*condition)].crew ~= "" then
                PushScaleformMovieMethodParameterString("..+".._players[i+(_playersPerPage*condition)].crew) --crew
            else
                PushScaleformMovieMethodParameterString("") --crew
            end
            PushScaleformMovieMethodParameterInt(_players[i+(_playersPerPage*condition)].showJP) --0 = text only, 1 = text with JP icon, 2 = only jp icon.
            PushScaleformMovieMethodParameterString(_players[i+(_playersPerPage*condition)].txd) --txd string
            PushScaleformMovieMethodParameterString(_players[i+(_playersPerPage*condition)].txd) --txd string
            PushScaleformMovieMethodParameterInt(0) --text in right corner of mugshot. 0 = disable
            EndScaleformMovieMethod()
        end
    end

    BeginScaleformMovieMethod(scaleform, "DISPLAY_VIEW")
    EndScaleformMovieMethod()

    return scaleform
end
