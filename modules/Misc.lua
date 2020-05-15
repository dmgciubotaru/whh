
function InList(list, element)
	for k,v in ipairs(list) do
		if v == element then
			return true
		end
	end
	return false
end

function ParseCSV(input, types)
	local values = {}
	
	-- Extract values
	for entry in input:gmatch("([^\n]+)") do
		if entry:len() then
			local items = {}
			for item in entry:gmatch("([^,]+)") do
				item = item:gsub("^%s*(.-)%s*$", "%1")
				table.insert(items, item)
			end
			table.insert(values, items)
		end
	end
	return values
end

function ToCSV(input)
	local csv = ""
	for lineno, items in ipairs(input) do
		local str = ""
		for itemno, item in ipairs(items) do
			str = str .. item .. ","
		end
		csv = csv .. str:sub(1, str:len() -1) .. "\n"
	end
	return csv:sub(1, csv:len()-1)
end

PartyUnitList = {
		"player", "pet", 
		"party1", "party2", "party3", "party4",
		"partypet1", "partypet2", "partypet3", "partypet4"
}

function GetUnitAuraList(unit)
	local idx = 1
	local aura = {}
	
	while 1 do
		name = UnitBuff(unit, idx)
		if not name then 
			break
		end
		table.insert(aura, name)
		idx = idx + 1
	end
	
	return aura
end
		

		