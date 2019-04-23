function isPlayerVIP ( )
	return tostring ( getElementData ( localPlayer, "VIP" ) ):lower ( ) ~= "semvip"
end

function getVipLevelFromName ( l )
	local levels = { ['semvip'] = 0, ['bronze'] = 1, ['prata'] = 2, ['ouro'] = 3, ['platina'] = 4 }
	return levels[l:lower()] or 0;
end