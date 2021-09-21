local write = require(script.Write)

local module = {}
module._index = module

function module.new(Label)
	local self = setmetatable(
		{
			["Label"] = Label;
		}, module
	)
		
	return self
end

function module:Add(Index, Priority, CustomLabel, Text, Speed)
	local tab = self
	local labelInst = (CustomLabel or tab["Label"])
	
	if self[Index] then
		warn("Overwriting previous indexed dialogue.")
	else
	 	self[Index] = {
			["Label"] = labelInst;
			["Priority"] = Priority;
			["Text"] = Text;
			["Speed"] = Speed;
		}
	end
end

function module:DoDialogue(index)
	local tab = self[index]
	local label = tab["Label"]
	local priority = tab["Priority"]
	local text = tab["Text"]
	local speed = tab["Speed"]
	
	write.typeWrite(label, text, speed)
end

return module
