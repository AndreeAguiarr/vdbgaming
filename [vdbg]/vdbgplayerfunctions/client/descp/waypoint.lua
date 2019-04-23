local isLocating = false
local WAYPOINTLOC = { }
local DistToPoint = 0
local TRACKELEMENT = nil

function createWaypointLoc ( x, y, z )
	TRACKELEMENT = nil
	local px, py, pz = getElementPosition ( localPlayer )
	local dist = getDistanceBetweenPoints2D ( px, py, x, y )
	if ( dist <= 20 ) then
		return exports.VDBGMessages:sendClientMessage ( "Você está a "..tostring(math.floor(dist)).." metros do local.", 255, 255, 255 )
	end

	if ( isLocating ) then
		waypointUnlocate ( )
	end
	
	isLocating = true
	waypointBlip = exports.customblips:createCustomBlip ( x, y, 10, 10, "arquivos/waypoint.png", 9999999999 )
	WAYPOINTLOC = { x=x, y=y }
	addEventHandler ( "onClientRender", root, onWaypointRender )
end

local sx, sy = guiGetScreenSize ( )
local textY = sy/1.1
function waypointUnlocate ( ) 
	if ( not isLocating ) then
		return
	end
	WAYPOINTLOC = { }
	DistToPoint = 0
	isLocating = false
	removeEventHandler ( "onClientRender", root, onWaypointRender )
	exports.customblips:destroyCustomBlip ( waypointBlip )
	TRACKELEMENT = nil
end

function setWaypointAttachedToElement ( element ) 
	if ( not isElement ( element ) ) then return false end 
	TRACKELEMENT = element
	return true
end 

function onWaypointRender ( )
	if ( not isLocating or not WAYPOINTLOC ) then
		removeEventHandler ( "onClientRender", root, onWaypointRender )
		return
	end
	local px, py, _ = getElementPosition ( localPlayer )
	local x, y = WAYPOINTLOC.x, WAYPOINTLOC.y

	if ( TRACKELEMENT ) then
		if ( not isElement ( TRACKELEMENT ) ) then
			waypointUnlocate ( )
			exports.VDBGMessages:sendClientMessage ( "O jogador/local que você estáva rastreando não existe.", 255, 0, 0 )
			return
		else
			x, y, _ = getElementPosition ( TRACKELEMENT )
			
		end
	end 

	local dist = getDistanceBetweenPoints2D ( x, y, px, py )
	if ( dist <= 15 ) then
		waypointUnlocate ( )
		exports.VDBGMessages:sendClientMessage ( "Você chegou!", 0, 255, 0 )
	end
	
	if ( isPedInVehicle ( localPlayer ) ) then
		if ( textY > sy/1.2 ) then
			textY = textY - 2
			if ( textY < sy/1.2 ) then
				textY = sy/1.2
			end
		end
	else
		if ( textY < sy/1.1 ) then
			textY = textY + 2
			if ( textY > sy/1.1 ) then	
				textY = sy/1.1
			end
		end
	end
	
	local dist = math.floor ( dist )
	if ( DistToPoint ~= dist ) then
		if ( DistToPoint > dist ) then
			DistToPoint = DistToPoint - 3
			if ( DistToPoint < dist ) then
				DistToPoint = dist
			end
		else
			DistToPoint = DistToPoint + 3
			if ( DistToPoint > dist ) then	
				DistToPoint = dist
			end
		end
	end
	
	local t = "Você está a "..tostring(convertNumber(DistToPoint)).." metros do destino."
	dxDrawText ( t, 0, 0, sx/1.03+1, textY+1, tocolor ( 0, 0, 0, 255 ), 1, "default-bold", "right", "bottom" )
	dxDrawText ( t, 0, 0, sx/1.03, textY, tocolor ( 255, 255, 255, 255 ), 1, "default-bold", "right", "bottom" )
end

function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end