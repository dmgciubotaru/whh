
WHHAuraTracker = {}

do
	local frame = nil
	local messages = {}
	local options = nil
	
	local function GetCombatAura()
		local counters = {}
		for str in string.gmatch(options.combatAura, "([^\n]+)") do
			counters[str] = true
		end
		return counters
	end
	
	local function GetGroupAura()
		local counters = {}
		for str in string.gmatch(options.groupAura, "([^\n]+)") do
			counters[str] = true
		end
		return counters
	end
	
	local function GetUnitAuras(unit)
		local idx = 1
		local aura = {}
		
		while 1 do
			name = UnitBuff(unit, idx)
			if not name then 
				break
			end
			aura[name] = true
			idx = idx + 1
		end
		
		return aura
	end
		

	local function Update(self, event)
	
		-- Remove everything
		for i, msg in ipairs(messages) do
			WHHNotifList.RemoveMessage(msg)
		end
		messages = {}
		
		-- If disabled, return
		if not options.enabled then 
			return
		end
		
		-- Combat Aura
		if UnitAffectingCombat("player") then
			local buffs = GetUnitAuras("player")
			for k,v in pairs(GetCombatAura()) do
				if buffs[k] == nil then
					table.insert(messages, {
						text = k.." not enabled",
						priority = 90,
					})
				end
			end
		end
		
		-- Group Aura
		local units = { "player", "party1", "party2", "party3", "party4"}
		for idx = 1,table.getn(units) do
		
			local name = UnitName(units[idx])			
		
			if not name then 
				break
			end
			
			local buffs = GetUnitAuras(units[idx])
			
			for k,v in pairs(GetGroupAura()) do
				if buffs[k] == nil then
					table.insert(messages, {
						text = k.." not enabled on ".. name,
						priority = 90,
					})
				end
			end
		end
		
		-- Show messages
		for i=1, table.getn(messages) do
			WHHNotifList.AddMessage(messages[i])
		end
	end
	
	
	local function Init()
		frame = CreateFrame("Frame")
		frame:RegisterEvent("PLAYER_REGEN_DISABLED")
		frame:RegisterEvent("PLAYER_REGEN_ENABLED")
		frame:RegisterEvent("UNIT_AURA")
		
		frame:SetScript("OnEvent", Update)
		
		options = WHHOptions.char.auraTracker
		
		Update()
	end

	
	WHHAuraTracker.Init = Init
	WHHAuraTracker.Update = Update
end

return WHHAuraTracker