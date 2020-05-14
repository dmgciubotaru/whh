
WHHBagTracker = {}

do
	local frame = nil
	local options = nil
	local msgSpaceLeft = {}
	local msgCounters = {}
	
	
	local function GetCounters()
		local counters = {}
		for str, cnt in string.gmatch(options.counters, "([%w ]+),(%d+)") do
			counters[str] = tonumber(cnt)
		end
		return counters
	end

	local function Refresh()
		if not options.enabled then 
			return
		end
		local freeSpace = 0
		
		for bagId = 0,4 do
			local family = GetItemFamily(GetBagName(bagId))
			if family == nil or family == 0 then
				freeSpace = freeSpace + GetContainerNumFreeSlots(bagId)
			end
		end

		-- Check free spaces
		if freeSpace < options.spaceLeft then
			WHHNotifList.AddMessage(msgSpaceLeft)
		else
			WHHNotifList.RemoveMessage(msgSpaceLeft)
		end
		
		for k, v in pairs(msgCounters) do
			if GetItemCount(k) < v.count then 
				WHHNotifList.AddMessage(v.msg)
			else
				WHHNotifList.RemoveMessage(v.msg)
			end
		end
	end
	
	local function Update()
		-- Remove everything
		WHHNotifList.RemoveMessage(msgSpaceLeft)
		for k,v in pairs(msgCounters) do
			WHHNotifList.RemoveMessage(v.msg)
		end
		
		-- Add tracked items
		if options.enabled then
			msgSpaceLeft = {
				text="Less than "..options.spaceLeft.. " free slots",
				priority=70,
			}
			
			for k, v in pairs(GetCounters()) do
				msgCounters[k] = {
					msg = {
						text="Less than "..v.." "..k, 
						priority=70
					},
					count = v
				}
			end
			
			Refresh()
		end
		
	end
	
	local function Init()
		frame = CreateFrame("Frame")
		frame:RegisterEvent("BAG_UPDATE")
		frame:SetScript("OnEvent", Refresh)
		
		options = WHHOptions.char.bagTracker
		
		Update()
	end
	
	
	WHHBagTracker.Init = Init
	WHHBagTracker.Update = Update
end

return WHHBagTracker