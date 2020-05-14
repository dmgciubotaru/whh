

local ADDON_NAME = "WHH"

SLASH_WHH1 = "/ah"
function SlashCmdList.WHH(msg)	
	LibStub("AceConfigDialog-3.0"):Open("WHHPanel")
	--print(Options.optionA)
	--Options.optionA = false
end


WHH = LibStub("AceAddon-3.0"):NewAddon("NotyfyMe")

function WHH:OnEnable()
	WHHOptions.Init()
	WHHNotifList.Init()
	WHHPetTracker.Init()
	WHHBagTracker.Init()
	WHHAuraTracker.Init()
end