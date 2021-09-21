local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")

local SOURCE_LOCALE = "en"
local translator = nil

local AnimateUI = {}

function translateText(guiObject, text, delayBetweenChars)
	local displayText = text

	if translator then
		displayText = translator:Translate(guiObject, text)
	end

	displayText = displayText:gsub("<br%s*/>", "\n")
	displayText:gsub("<[^<>]->", "")

	guiObject.Text = displayText

	local index = 0
	
	for first, last in utf8.graphemes(displayText) do
		index = index + 1
		guiObject.MaxVisibleGraphemes = index
		wait(delayBetweenChars)
	end
end

function AnimateUI.loadTranslator()
	pcall(function()
		translator = LocalizationService:GetTranslatorForPlayerAsync(Players.LocalPlayer)
	end)
	if not translator then
		pcall(function()
			translator = LocalizationService:GetTranslatorForLocaleAsync(SOURCE_LOCALE)
		end)
	end
end

function AnimateUI.typeWrite(guiObject, text, delayBetweenChars)
	guiObject.Visible = true
	guiObject.AutoLocalize = false
	
	if typeof(text) == "string" then
		translateText(guiObject, text, delayBetweenChars)
	elseif typeof(text) == "table" then
		for i,v in ipairs(text) do
			translateText(guiObject, v, delayBetweenChars)
		end
	end
end

return AnimateUI
