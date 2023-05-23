local eventHandler;
local SERVER_RESTART_FORCE = "Перезагрузка через";

local FONT, FONTSIZE, FONTCOLOR = "Fonts\\Arialn.ttf", 22, {0, 1, 1};
local g_MsgSync;

-- /* hud message */
do
    local function showsynchudmsg(duration, time, justify, width, height)
        local hud = CreateFrame("ScrollingMessageFrame", nil, UIParent);
        hud:SetMaxLines(1);
        hud:SetFadeDuration(duration);
        hud:SetTimeVisible(time);
        hud:SetJustifyH(justify);
        hud:SetSize(width, height);
        hud:SetFont(FONT, FONTSIZE);
        hud:SetShadowColor(0, 0, 0, 1);
        hud:SetShadowOffset(1, -1);
        hud:SetTextColor(unpack(FONTCOLOR));
        hud:SetPoint("CENTER", UIParent, "CENTER", 0, 240);
        hud:SetFrameStrata("HIGH");
        hud:Hide(); -- скрыть фрейм при инициализации

        return hud;
    end

    g_MsgSync = showsynchudmsg(4, 5, "CENTER", 620, FONTSIZE);
end

-- /* fire event */
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
    if string.find(msg, SERVER_RESTART_FORCE) then -- использовать string.find вместо gmatch
        g_MsgSync:AddMessage(msg);
        g_MsgSync:Show(); -- показать фрейм при обнаружении сообщения
    end
end

-- боже это невероятно

print("|cffc41f3bRestarter Notice|r: |cffffff00by Woody#6606|r")