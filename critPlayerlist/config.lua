playersPerPage = 10
rowColor = 2
showBigMap = true
handlePlayersInternally = true --When this is false, you will have to use your own scripts for playerlist handle. players table MUST RESPECT the template bellow.

--[[

players = {
    [0] = {name = playerName, id = playerServerID, crew = crewTag, rightText = rightText, rank = _rank, showJP = false, txd = mugshotTXD or 'CHAR_BLANK_ENTRY'}
}

]]