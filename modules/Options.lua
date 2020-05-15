
WHHOptions = {}

do

	-- Addon options
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
				priority = 70,
				auraList = {},
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
	
	-- Addon ACE options
	local function GetOptionPanel()
		return {
			type = "group",
			name = "Helping Hand",
			desc = "Helping Hand Options",
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
					name = "Bag Tracker",
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
								WHHAuraTracker:CfgUpdate()
							end,
						},
						trackedAuras = {
							type = "input",
							name = "Tracked Aura",
							desc = "Add aura names to be traced.",
							width = "full",
							order = 1,
							multiline = true,
							get = function () 
								return ToCSV(WHHOptions.char.auraTracker.auraList)
							end,
							set = function (info, value) 
								WHHOptions.char.auraTracker.auraList = ParseCSV(value)
								WHHAuraTracker:CfgUpdate()
							end,
						},
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