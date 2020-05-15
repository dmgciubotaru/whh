
WHHNotifList = {}

do
	local frame = nil
	local notifications = {}
	local hiddenMessages = {}
	local itemFrames = {}
	local options = {}
	
	local function Update()
		
		local visible = 0
		local hidden = 0
		local items = {}
		
		for k,v in pairs(notifications) do
			if not hiddenMessages[k.text] then 
				table.insert(items, k)
				visible = visible + 1
			else
				hidden = hidden + 1
			end
		end
		
		-- Sort statuses
		table.sort(items, function(a,b) return a.priority > b.priority end)
		
		-- Display notifications
		for i=1,min(table.getn(items), options.maxCount) do
			itemFrames[i].Title:SetText(items[i].text)
			itemFrames[i]:Show()
			itemFrames[i].ShowHide:SetScript("OnClick", function() 
				hiddenMessages[items[i].text] = true
				Update()
			end)
		end
		
		for i=table.getn(items)+1, options.maxCount do
			itemFrames[i]:Hide()
			itemFrames[i].ShowHide:SetScript("OnClick",nil)
		end
		
		frame:SetHeight(table.getn(items) * 50 + 25)
		frame.statusBar.title:SetText("Notifications "..visible.."/"..hidden)
		
	end
	
	local function Init()
		options = WHHOptions.global.notificationList
		
		frame = CreateFrame("Frame", nil, UIParent, "WHHNotifList")
		--frame:SetPoint("CENTER", 0, 0)
		frame:SetPoint("TOPLEFT", options.screenX, -options.screenY)
		frame:SetHeight(25)
		frame:Show()
		
		frame.statusBar:HookScript("OnDragStop", function(self)
			options.screenX = self:GetParent():GetLeft()
			options.screenY = GetScreenHeight() - self:GetParent():GetTop()
		end)
		
		frame.ShowHidden:SetScript("OnClick", function()
			hiddenMessages = {}
			Update()
		end)
		
		for i=1,options.maxCount do
			local newFrame = CreateFrame("Frame", nil, frame, "WHHNotifItem")
			newFrame:SetPoint("TOP", 0, -( 25 + (i-1) * 50))
			newFrame:Hide()
			table.insert(itemFrames,newFrame)
		end
		
	end
	
	-- Message Format
	-- text: string
	-- priority: 0 - 100
	
	local function AddMessage(message)
		if notifications[message] == nil then
			notifications[message] = true
		end
		Update()
	end
		
	local function RemoveMessage(message)
		notifications[message] = nil
		Update()
	end

	WHHNotifList.Init = Init
	WHHNotifList.AddMessage = AddMessage
	WHHNotifList.RemoveMessage = RemoveMessage
end

return WHHNotifList