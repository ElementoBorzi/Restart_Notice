local eventHandler;
local SERVER_RESTART_FORCE = "Перезагрузка через";
local SERVER_RESTART_FORCE_EN = "Restart in";

local FONT, FONTSIZE = "Fonts\\Arialn.ttf", 22;
local FONTCOLOR = {0, 1, 1}; -- Голубой цвет (RGB: 0, 255, 255)
local FONTCOLOR_EN = {1, 1, 0}; -- Желтый цвет (RGB: 255, 255, 0)

local g_MsgSync;

do
    local function showsynchudmsg(duration, time, justify, width, height, language)
        local hud = CreateFrame("ScrollingMessageFrame", nil, UIParent);
        hud:SetMaxLines(1);
        hud:SetFadeDuration(duration);
        hud:SetTimeVisible(time);
        hud:SetJustifyH(justify);
        hud:SetSize(width, height);
        hud:SetFont(FONT, FONTSIZE);
        hud:SetShadowColor(0, 0, 0, 1);
        hud:SetShadowOffset(1, -1);
        hud:SetTextColor(unpack(language == "ru" and FONTCOLOR or FONTCOLOR_EN));
        hud:SetPoint("CENTER", UIParent, "CENTER", 0, 240);
        hud:SetFrameStrata("HIGH");
        hud:Hide();

        return hud;
    end

    g_MsgSync = showsynchudmsg(4, 5, "CENTER", 620, FONTSIZE, "ru");
end

do
    eventHandler = CreateFrame("Frame");
    eventHandler:RegisterEvent("CHAT_MSG_SYSTEM");
    eventHandler:SetScript("OnEvent", function(self, event, ...)
        local func = self[event];
        if type(func) == "function" then
            func(self, event, ...);
        end
    end);
end

function eventHandler:CHAT_MSG_SYSTEM(_, msg)
    if string.find(msg, SERVER_RESTART_FORCE) or string.find(msg, SERVER_RESTART_FORCE_EN) then
        g_MsgSync:AddMessage(msg);
        g_MsgSync:Show();
    end
end

print("|cffc41f3bRestarter Notice|r: |cffffff00by Woody#6606|r");
