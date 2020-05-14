
WHHOptions = {}

do
	local defaults = {
		char = {
			petTracker = true,
			bagTracker = {
				enabled = true,
				spaceLeft = 10,
				counters = "",
			},
			auraTracker  = {
				enabled = true,
				combatAura = "",
				groupAura = "",
			},
		},
		global = {
			notificationList = {
				maxCount = 10,
				screenX = 0,
				screenY = 0
			},
		},
	}
	
	local function GetOptionPanel()
		return {
			type = "group",
			name = "Notify Me",
			desc = "Notify Me Options",
			args = {
				general = {
					type = "group",
					name = "General",
					order = 0,
					args ={
						enablePetTracker = {
							type="toggle",
							name="Enable Pet Tracker",
							get = function () return WHHOptions.char.petTracker end,
							set = function (info, value) 
								WHHOptions.char.petTracker = value 
								WHHPetTracker:Update()
							end,
						},
					}
				},
				bagTracker = {
					type = "group",
					name = "Bag tracker",
					order = 1,
					args = {
						enable = {
							type="toggle",
							name="Enable",
							order = 0,
							get = function () return WHHOptions.char.bagTracker.enabled end,
							set = function (info, value) 
								WHHOptions.char.bagTracker.enabled = value 
								WHHBagTracker:Update()
							end,
						},
						spaceLeft = {
							type = "range",
							name = "Alert On Less than",
							order = 1,
							min = 2,
							max = 20,
							step = 1,
							get = function () return WHHOptions.char.bagTracker.spaceLeft end,
							set = function (info, value)
								WHHOptions.char.bagTracker.spaceLeft = value
								WHHBagTracker:Update()
							end,
						},
						counters = {
							type = "input",
							name = "Count Trackers",
							width = "full",
							order = 2,
							multiline = true,
							get = function () return WHHOptions.char.bagTracker.counters end,
							set = function (info, value) 
								WHHOptions.char.bagTracker.counters = value 
								WHHBagTracker:Update()
							end,
						}
					}
				},
				auraTracker = {
					type = "group",
					name = "Aura tracker",
					order = 2,
					args = {
						enable = {
							type="toggle",
							name="Enable",
							order = 0,
							get = function () return WHHOptions.char.auraTracker.enabled end,
							set = function (info, value) 
								WHHOptions.char.auraTracker.enabled = value 
								WHHAuraTracker:Update()
							end,
						},
						combatAura = {
							type = "input",
							name = "Combat Aura",
							width = "full",
							order = 1,
							multiline = true,
							get = function () return WHHOptions.char.auraTracker.combatAura end,
							set = function (info, value) 
								WHHOptions.char.auraTracker.combatAura = value 
								WHHAuraTracker:Update()
							end,
						},
						groupAura = {
							type = "input",
							name = "Group Aura",
							width = "full",
							order = 2,
							multiline = true,
							get = function () return WHHOptions.char.auraTracker.groupAura end,
							set = function (info, value) 
								WHHOptions.char.auraTracker.groupAura = value 
								WHHAuraTracker:Update()
							end,
						}
					}
				}
			}
		}
	end
	
	local function Init(self)
		local options = LibStub("AceDB-3.0"):New("WHHDB", defaults)
		WHHOptions.char = options.char
		WHHOptions.global = options.global 
		
		LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("WHHPanel", GetOptionPanel())
		LibStub("AceConfigDialog-3.0"):AddToBlizOptions("WHHPanel", "Helping Hand")
	
	end
	
	WHHOptions.Init = Init
end

return WHHOptions