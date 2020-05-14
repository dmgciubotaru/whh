
WHHPetTracker = {}

do
	local frame = nil
	local options = nil
	local msg = {text="Feed Pet", priority=75}
	
	local function Refresh()
		if options then 			
			happiness = GetPetHappiness()
			if happiness then
				if happiness == 3 then
					WHHNotifList.RemoveMessage(msg)
				else
					WHHNotifList.AddMessage(msg)
				end
			end
		end
	end
	
	local function Update()
		
		WHHNotifList.RemoveMessage(msg)
		
		if options then
			Refresh()
		end
	end
	
	local function Init()
		frame = CreateFrame("Frame")
		frame:RegisterEvent("UNIT_HAPPINESS")
		
		options = WHHOptions.char.petTracker
		frame:SetScript("OnEvent", Refresh)
	end
	
	WHHPetTracker.Init = Init
	WHHPetTracker.Update = Update
end

return WHHPetTracker