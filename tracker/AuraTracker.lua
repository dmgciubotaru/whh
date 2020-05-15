
WHHAuraTracker = {}

do
	local frame = nil
	local tracked = {}
	local messages = {}
	local options = nil
	
	local function Update()
		
		-- Remove all messages
		for i,msg in ipairs(messages) do
			WHHNotifList.RemoveMessage(msg)
		end
		
		-- If disabled, return
		if not options.enabled then 
			return {}
		end
				
		-- Search for grp auras
		if tracked["party"] ~= nil then
		
			for idx = 1,table.getn(PartyUnitList) do
				
				if UnitExists(PartyUnitList[idx]) then
					local auraList = GetUnitAuraList(PartyUnitList[idx])

					for i, aura in ipairs(tracked["party"]) do
						if not InList(auraList, aura) then
							local msg = { 
								text = aura.." not found on ".. UnitName(PartyUnitList[idx]),
								priority = options.priority
							}			
							table.insert(messages,msg)
							WHHNotifList.AddMessage(msg)
						end
					end
				end
			end
		end
		
		-- Combat Auras
		if tracked["combat"] ~= nil then
			if UnitAffectingCombat("player") then
				local auraList = GetUnitAuras("player")
				for i, aura in ipairs(tracked["combat"]) do
					if not InList(auraList, aura) then 
						local msg = { 
							text = aura.." not found on ".. UnitName("player"),
							priority = options.priority
						}			
						table.insert(messages,msg)
						WHHNotifList.AddMessage(msg)
					end
				end
			end
		end
	end
	
	local function CfgUpdate()
		tracked = {}
		if options.enabled then
			for k, entry in ipairs(options.auraList) do
				local auraName = entry[1]
				local autaType = string.lower(entry[2])
				if tracked[autaType] == nil then
					tracked[autaType] = {}
				end
				table.insert(tracked[autaType], auraName)
			end
		end
		Update()
	end
	
	local function Init()
		frame = CreateFrame("Frame")
		frame:RegisterEvent("PLAYER_REGEN_DISABLED")
		frame:RegisterEvent("PLAYER_REGEN_ENABLED")
		frame:RegisterEvent("UNIT_AURA")
		frame:RegisterEvent("GROUP_ROSTER_UPDATE")
		
		frame:SetScript("OnEvent", Update)
		
		options = WHHOptions.char.auraTracker
		
		CfgUpdate()
		
	end

	
	WHHAuraTracker.Init = Init
	WHHAuraTracker.Update = Update
	WHHAuraTracker.CfgUpdate = CfgUpdate
end

return WHHAuraTracker