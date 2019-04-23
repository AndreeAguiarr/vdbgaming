addEvent ( "VDBGJobs->Module->Job->Pilot->OnClientRequestF5Data", true )
addEventHandler ( "VDBGJobs->Module->Job->Pilot->OnClientRequestF5Data", root, function ( )
	local data = { }
	local flights = getJobColumnData ( getAccountName ( getPlayerAccount ( source ) ), getDatabaseColumnTypeFromJob ( "pilot" ) )
	data.flights = flights

	local nextrank = "None"
	local rankTable = { }
	for i, v in ipairs ( foreachinorder ( jobRanks['pilot'] ) ) do
		outputChatBox ( tostring ( i ).. tostring ( v[1] ))
	end 
end )

function foreachinorder(t, f, cmp)
    local keys = {}
    for k,_ in pairs(t) do
        keys[#keys+1] = k
    end
    table.sort(keys,cmp)
    local data = { }
    for _, k in ipairs ( keys ) do 
    	table.insert ( data, { k, t[k] } )
    end 
    return data
end