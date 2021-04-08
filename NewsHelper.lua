script_name("NewsHelper") -- ��� �������
script_authors("Nikolay Wilde") -- ������
script_version("1.0") -- ��������� ������ �������

local dlstatus = require('moonloader').download_status
local vkeys = require 'vkeys'
local wm = require 'lib.windows.message'
local imgui = require 'imgui'
local SE = require 'lib.samp.events'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

local window = imgui.ImBool(false)

function main()
   if not isSampLoaded() then return end
   while not isSampAvailable() do wait(100) end
   
   update()

   sampRegisterChatCommand("test", function () window.v = not window.v end)
   wait(3500)
   sampAddChatMessage("{F00000}"..script.this.name.." | {FFFFFF}�����: {F00000}"..table.concat(script.this.authors), -1)
   sampAddChatMessage("{F00000}"..script.this.name.." | {FFFFFF}������ ������� ��������. ������� J ����� ������� ���� �������.", -1)
   sampAddChatMessage("{F00000}"..script.this.name.." | {FFFFFF}������ �������: {F00000}" .. script.this.version, -1)	
   sampRegisterChatCommand('startl', function() leksia() end)
   sampRegisterChatCommand('endl', function() offotig() end)
   sampRegisterChatCommand('newsupdate', function() goupdate() end)
	while true do
		wait(0)
		imgui.Process = window.v
	end
end

function apply_custom_style()
	imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 3)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)

    colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
    colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
    colors[clr.WindowBg]               = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.ChildWindowBg]          = ImVec4(0.12, 0.12, 0.12, 1.00);
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94);
    colors[clr.Border]                 = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.10);
    colors[clr.FrameBg]                = ImVec4(0.22, 0.22, 0.22, 1.00);
    colors[clr.FrameBgHovered]         = ImVec4(0.18, 0.18, 0.18, 1.00);
    colors[clr.FrameBgActive]          = ImVec4(0.09, 0.12, 0.14, 1.00);
    colors[clr.TitleBg]                = ImVec4(0.14, 0.14, 0.14, 0.81);
    colors[clr.TitleBgActive]          = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51);
    colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00);
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.39);
    colors[clr.ScrollbarGrab]          = ImVec4(0.36, 0.36, 0.36, 1.00);
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.18, 0.22, 0.25, 1.00);
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.CheckMark]              = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrab]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrabActive]       = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.Button]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ButtonHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ButtonActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.Header]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.HeaderHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.HeaderActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.ResizeGrip]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ResizeGripHovered]      = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ResizeGripActive]       = ImVec4(1.00, 0.19, 0.19, 1.00);
    colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
    colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
    colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00);
    colors[clr.PlotHistogram]          = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.18, 0.18, 1.00);
    colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.32, 0.32, 1.00);
    colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
end
apply_custom_style()

local imBool = imgui.ImBool(false)
----------------------------------------------------------------------------------------
local imBool2 = imgui.ImBool(false)
----------------------------------------------------------------------------------------
local imBool3 = imgui.ImBool(false)
local imBool4 = imgui.ImBool(false)
local imBool5 = imgui.ImBool(false)
local imBool6 = imgui.ImBool(false)
local imBool7 = imgui.ImBool(false)
local imBool8 = imgui.ImBool(false)
local imBool9 = imgui.ImBool(false)
local imBool10 = imgui.ImBool(false)
local imBool11 = imgui.ImBool(false)

function imgui.OnDrawFrame()

	local iScreenWidth, iScreenHeight = getScreenResolution()
   
   imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
   imgui.SetNextWindowSize(imgui.ImVec2(814, 256), imgui.Cond.FirstUseEver)
   
   imgui.Begin ("NewsHelper by Nikolay Wilde", window, imgui.WindowFlags.NoResize)
    imgui.BeginChild('##list1', imgui.ImVec2(195, 220), true)
	if imgui.ToggleButton("button##1", imBool) then
		if imBool.v then
			lua_thread.create(function()
				leksia()
--				sampAddChatMessage("������ ��������", -1) -- ���� ������ ����� ������. ��������
			end)
		else
			lua_thread.create(function()
				offotig()
--				sampAddChatMessage("������ �����������", -1) -- ���� ������ ����� ������. ��������
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("������ ������ ���"))
	imgui.EndChild()
----------------------------------------------------------------------------------------------------	
	imgui.SameLine()
	imgui.BeginChild('##list2', imgui.ImVec2(195, 220), true)
	if imgui.ToggleButton("Button##2", imBool2) then
		if imBool2.v then
			lua_thread.create(function()
--				leksia()
				sampAddChatMessage("������ ��������", -1) -- ���� ������ ����� ������. ��������
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("������ �����������", -1) -- ���� ������ ����� ������. ��������
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("�������� ������"))
	imgui.EndChild()
----------------------------------------------------------------------------------------------------	
	imgui.SameLine()
	imgui.BeginChild('##list3', imgui.ImVec2(398, 220), true)
    if imgui.ToggleButton("Button##3", imBool3) then
		if imBool3.v then
			lua_thread.create(function()
				rp1()
--				sampAddChatMessage("������ ��������", -1) -- ���� ������ ����� ������. ��������
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("��������� RP��� �����������", -1) -- ���� ������ ����� ������. ��������
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("RP��� �������� ��������"))
----------------------------------------------------------------------------------------------------
	if imgui.ToggleButton("Button##4", imBool4) then
		if imBool4.v then
			lua_thread.create(function()
				rp2()
--				sampAddChatMessage("������ ��������", -1) -- ���� ������ ����� ������. ��������
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("��������� RP��� �����������", -1) -- ���� ������ ����� ������. ��������
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("RP��� ������� ����������� �����"))
----------------------------------------------------------------------------------------------------	
	if imgui.ToggleButton("Button##5", imBool5) then
		if imBool5.v then
			lua_thread.create(function()
				rp3()
--				sampAddChatMessage("������ ��������", -1) -- ���� ������ ����� ������. ��������
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("��������� RP��� �����������", -1) -- ���� ������ ����� ������. ��������
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("RP��� ��������� ���������� �� ����������� ���������"))
----------------------------------------------------------------------------------------------------
	if imgui.ToggleButton("Button##6", imBool6) then
		if imBool6.v then
			lua_thread.create(function()
				rp4()
--				sampAddChatMessage("������ ��������", -1) -- ���� ������ ����� ������. ��������
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("��������� RP��� �����������", -1) -- ���� ������ ����� ������. ��������
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("RP��� ����� ���������� ����������"))
----------------------------------------------------------------------------------------------------
	if imgui.ToggleButton("Button##7", imBool7) then
		if imBool7.v then
			lua_thread.create(function()
				rp5()
--				sampAddChatMessage("������ ��������", -1) -- ���� ������ ����� ������. ��������
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("��������� RP��� �����������", -1) -- ���� ������ ����� ������. ��������
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("RP��� �������� ��������� ���������� ����������"))
----------------------------------------------------------------------------------------------------
	if imgui.ToggleButton("Button##8", imBool8) then
		if imBool8.v then
			lua_thread.create(function()
				rp6()
--				sampAddChatMessage("������ ��������", -1) -- ���� ������ ����� ������. ��������
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("��������� RP��� �����������", -1) -- ���� ������ ����� ������. ��������
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("RP���  ��������� ������� ����� ��������"))
----------------------------------------------------------------------------------------------------
	if imgui.ToggleButton("Button##9", imBool9) then
		if imBool9.v then
			lua_thread.create(function()
				rp7()
--				sampAddChatMessage("������ ��������", -1) -- ���� ������ ����� ������. ��������
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("��������� RP��� �����������", -1) -- ���� ������ ����� ������. ��������
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("RP��� ��������� ���� �� ������ � �����"))
----------------------------------------------------------------------------------------------------	
	if imgui.ToggleButton("Button##10", imBool10) then
		if imBool10.v then
			lua_thread.create(function()
				rp8()
--				sampAddChatMessage("������ ��������", -1) -- ���� ������ ����� ������. ��������
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("��������� RP��� �����������", -1) -- ���� ������ ����� ������. ��������
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("RP��� ���������� ���������� ������ ��������"))
----------------------------------------------------------------------------------------------------
	if imgui.ToggleButton("Button##11", imBool11) then
		if imBool11.v then
			lua_thread.create(function()
				rp9()
--				sampAddChatMessage("������ ��������", -1) -- ���� ������ ����� ������. ��������
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("��������� RP��� �����������", -1) -- ���� ������ ����� ������. ��������
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("RP��� ������ ��������� � ��������"))
	imgui.EndChild()
   imgui.End()
end

function makeScreenshot(disable) -- ���� �������� true, ��������� � ��� ����� ������
    if disable then displayHud(false) sampSetChatDisplayMode(0) end
    require('memory').setuint8(sampGetBase() + 0x119CBC, 1)
    if disable then displayHud(true) sampSetChatDisplayMode(2) end
end

function offotig()
	if thread ~= nil then
		if thread:status() ~= "dead" then
			thread:terminate()
		end
	end
end

function renderGradientText(font, text, posX, posY, startingColor, endingColor)
    local startingColorComponents = { startingColor:match('(..)(..)(..)') }
    local endingColorComponents = { endingColor:match('(..)(..)(..)') }
    for i = 1, 3 do
        startingColorComponents[i] = tonumber(startingColorComponents[i], 16)
        endingColorComponents[i] = tonumber(endingColorComponents[i], 16)
    end
    local length = text:len()
    local gradient = ''
    local function shift(comp, i)
        return startingColorComponents[comp] + (endingColorComponents[comp] - startingColorComponents[comp]) * ((i - 1) / (length - 1))
    end
    for i = 1, length do
        local R = shift(1, i)
        local G = shift(2, i)
        local B = shift(3, i)
        gradient = gradient .. string.format('{%0.2x%0.2x%0.2x}%s', R, G, B, text:sub(i, i))
    end
    renderFontDrawText(font, gradient, posX, posY, -1)
end

function leksia()
	thread = lua_thread.create(function()
		window.v = not window.v
		wait(2500)
		sampSendChat('������� ������ �� ���, ������� ��� ������.')
		wait(8000)
		sampSendChat('���������� ������ ���������� � ������� �����.')
		wait(8000)
		sampSendChat('���������� �������� ������� �� �����������, ������� ��� ������.')
		wait(8000)
		sampSendChat('��������: "�. Los Santos", "������ ��� ������".')
		wait(8000)
		sampSendChat('�����..')
		sampSendChat('/time 1')
		wait(250)
		makeScreenshot()
		wait(8000)
		sampSendChat('��� ����� ����������� ������� �� �������� � � ��������.')
		wait(8000)
		sampSendChat('��������: ����� ���� "Sultan". ������: 2.5 ��� ����')
		wait(8000)
		sampSendChat('����� "�����" �� �������.')
		wait(8000)
		sampSendChat('����� � �������� ������� �������� �������� � �����������.')
		sampSendChat('/time 1')
		wait(250)
		makeScreenshot()
		wait(8000)
		sampSendChat('�������� �������� "Mulholland 24-7",���."���" - ������� �� ���������� ����� � ���������� � �������.')
		wait(8000)
		sampSendChat('����������� ���������� ����� "���������" �� "���."')
		wait(8000)
		sampSendChat('�������� ���������� ������� ������� ��� �������.')
		wait(8000)
		sampSendChat('���������� � ������� ��������: �����, ������, ���� � ��. - �����������.')
		sampSendChat('/time 1')
		wait(250)
		makeScreenshot()
		wait(8000)
		sampSendChat('������ � �����, ������������� ����������� - ���������.')
		wait(8000)
		sampSendChat('����� "���" ����� �� ������, � ����� "���" ������ �����, �� ���� "���.".')
		wait(8000)
		sampSendChat('������: 2 ��� ���� � 200 ���. ����. ')
		wait(8000)
		sampSendChat('��������� ������������� ����� � �����-���� �����������')
		wait(8000)
		sampSendChat('���� � ���������� ��������, ��� ����������� ��� �������� ���������')
		wait(8000)
		sampSendChat('���������� ��� ���: "������ ��� � ������ ���������� �������"')
		wait(8000)
		sampSendChat('���� �������? ���� ��� �� ����������� � ������!')
		sampSendChat('/time 1')
		wait(250)
		makeScreenshot()
		wait(500)
		window.v = not window.v
	end)
end

function rp1()
	thread = lua_thread.create(function()
		window.v = not window.v
		wait(2500)
		sampSendChat('/do �� ����� ����� ����� � �������, ����� � ��������.')
		wait(8000)
		sampSendChat('/me ���� ����� � �������,������� � ���������.')
		wait(8000)
		sampSendChat('/me �������� ����� �� ���.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me ���� ����� � ������ ���� ��������� ���������.')
		wait(8000)
		sampSendChat('/me ��������� ��������� �������� ���� �����, ����� ���� ������ �.')
		wait(8000)
		sampSendChat('/me �������� �������� � ������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me �������� ���������� ������ � ����� ����� ����������� ������ �� �������.')
		wait(8000)
		sampSendChat('/do ����� ��������� ����� �������� ��� ��������� ��������.')
		wait(8000)
		sampSendChat('/do ����� � ������� �����.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me ������ ������� �������� � ����� � ������ �����.')
		wait(8000)
		sampSendChat('/me ������� ��� �� ����.')
		wait(8000)
		sampSendChat('/me ������� ������� ����� � �������� �����.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(2500)
		window.v = not window.v
	end)
end

function rp2()
	thread = lua_thread.create(function()
		window.v = not window.v
		wait(2500)
		sampSendChat('/do �� ����� ����� ����������� �����.')
		wait(8000)
		sampSendChat('/do � ����� ��������� ����� � �������������.')
		wait(8000)
		sampSendChat('/me ������� ����� �� ����')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me ���������� ����� ������� �������� ����.')
		wait(8000)
		sampSendChat('/me ������ �� ����� ��������� ��������.')
		wait(8000)
		sampSendChat('/me �������� ��� ������ � ������� �� � ����������� �������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me ����������� �������� �����.')
		wait(8000)
		sampSendChat('/todo ��� ����,������� ������*�������� ��������.')
		wait(8000)
		sampSendChat('/me ������ �� ����� � ������������� �������� � ���������-������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me ������� �������� � �������.')
		wait(8000)
		sampSendChat('/do ����� 30 ������ �������� ��������.')
		wait(8000)
		sampSendChat('/me �������� ������� � ����� ������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me ��������� ������� ��������.')
		wait(8000)
		sampSendChat('/do ������ 3 ������� �������������� ������ �������.')
		wait(8000)
		sampSendChat('/me �������� �������� �� �������')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me ������� �������� � ��������� ������� � �����')
		wait(8000)
		sampSendChat('/me ����� ������ ��������� �� �����.')
		wait(8000)
		sampSendChat('/do ����� ���������� � ��� �� ������� ���� ������ � ������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me ������ �� ����������� ������� ��������� � ��������� ������ ������ �������.')
		wait(8000)
		sampSendChat('/me ������� �������� � ����� c �������������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(2500)
		window.v = not window.v
	end)
end

function rp3()
	thread = lua_thread.create(function()
		window.v = not window.v
		wait(2500)
		sampSendChat('/do USB-���������� � �����.')
		wait(8000)
		sampSendChat('/me ������� ���������.')
		wait(8000)
		sampSendChat('/me ������� USB-���������� � ������ ����������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/do USB-���������� ����������.')
		wait(8000)
		sampSendChat('/me ����� �����, ������ ����� � �����������.')
		wait(8000)
		sampSendChat('/do � ����� ��������� "Guard".')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me �������� ��������� ���������.')
		wait(8000)
		sampSendChat('/do ��������� ���������������.')
		wait(8000)
		sampSendChat('/do ��������� ���������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me �������� USB-���������� �� ������ ����������.')
		wait(8000)
		sampSendChat('/me ������ ��������� � ������ �����, ����� ���� ������� USB-���������� � ������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(2500)
		window.v = not window.v
	end)
end

function rp4()
	thread = lua_thread.create(function()
		window.v = not window.v
		wait(2500)
		sampSendChat('/me ������ ����, ����� ���� ���� � ������� ����� ����� � ����� � ������ ����.')
		wait(8000)
		sampSendChat('/do ����� � ������ � ������ ����.')
		wait(8000)
		sampSendChat('/me ������� � �����, ����� ���� �������� ����� �����.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/do ����� ��������� �����.')
		wait(8000)
		sampSendChat('/me ��������� ��������� �������� ����� � ����� ����� ����������.')
		wait(8000)
		sampSendChat('/me ���� ������ � �����, ����� ���� ����� ���� ����� ����������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me ���� ����� ����������, ����������� �������� �������.')
		wait(8000)
		sampSendChat('/me �������� ���� ����������, ����� ���� ����� ������ � �����.')
		wait(8000)
		sampSendChat('/do ���������� ��� ����.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me ���� �����, ����� ���� ����� ���� � ����� �� ����� ����������.')
		wait(8000)
		sampSendChat('/me ������� ����� � ����, ����� ���� ���.')
		wait(8000)
		sampSendChat('/todo ��� ��������� ������� �������, ��� � �����!*������ ��� � ����.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(2500)
		window.v = not window.v
	end)
end

function rp5()
	thread = lua_thread.create(function()
		window.v = not window.v
		wait(2500)
		sampSendChat('/do ����� ���������� �������.')
		wait(8000)
		sampSendChat('/me ������ ����� ������ ����� ��� � ���� � ����� �� ����� �������� ������.')
		wait(8000)
		sampSendChat('/me ����� �� ����������, ����� ������� � ������ ������ ���.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/do ����� ������.')
		wait(8000)
		sampSendChat('/me ����� ����������� ��������� ����������.')
		wait(8000)
		sampSendChat('/do ��������� � �����.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me �������� ������ ��������� ������ �����.')
		wait(8000)
		sampSendChat('/do ����� ������.')
		wait(8000)
		sampSendChat('/todo ���, ����� ��������� � �����.*��������� � ������� ����.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me ���������� ����� ����������� ��� ������ ����������.')
		wait(8000)
		sampSendChat('/todo �� ��� ��� ������*���������� ����������� ������.')
		wait(8000)
		sampSendChat('/do ������ � �����.')
		wait(8000)
		sampSendChat('���, ������ ����� ���������� �������� � ������������, ��� ������ �������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(2500)
		window.v = not window.v
	end)
end

function rp6()
	thread = lua_thread.create(function()
		window.v = not window.v
		wait(2500)
		sampSendChat('/do �������� ����� �������� ���������.')
		wait(8000)
		sampSendChat('/todo ��� ������ ����� �������� �����.*���������, ��� ��������� ���� �� �����.')
		wait(8000)
		sampSendChat('/do ���� �� ����� � ����� ������� ������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me ������ ��������� ����� ���� ������ ����.')
		wait(8000)
		sampSendChat('/me ������� ���� � ���������, ����� �������� ������ ���.')
		wait(8000)
		sampSendChat('/do ��������� ������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me ������ ����� ��������� ������ ������.')
		wait(8000)
		sampSendChat('/todo ��, ��� ����� ������ �����.*������� � ��������� ����������.')
		wait(8000)
		sampSendChat('/me ������� � ��������� ��������� ������ ���')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/do �������� ������.')
		wait(8000)
		sampSendChat('/me ����� �������� �����.')
		wait(8000)
		sampSendChat('/me ������ ��������� ����� �������� �������� �����.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/do ���� ��������.')
		wait(8000)
		sampSendChat('/me ������ ��������')
		wait(8000)
		sampSendChat('/do �������� ��������� ������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/todo ���� �� �����, ����������!*�������� ���������� ������� � ������.')
		wait(8000)
		sampSendChat('/me ���� ���� �� ������� � ������, ����� ���� ���� � ���� ��������.')
		wait(8000)
		sampSendChat('/me ��������� ��������� ��� ������� ����� � ����� ��������, ����������� �� ��������� ��������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/do ������� � ���������.')
		wait(8000)
		sampSendChat('/me ���� ��������� �������, ����� ���� ���� � � ���� ��������.')
		wait(8000)
		sampSendChat('/me �������� ������� � ������, ����� ���� ������� � ����� � ������� �����.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(2500)
		window.v = not window.v
	end)
end

function rp7()
	thread = lua_thread.create(function()
		window.v = not window.v
		wait(2500)
		sampSendChat('/me ��������� ��������� ��� ��������� � ����� ��������, ����� ���� ������ ���.')
		wait(8000)
		sampSendChat('/do � ����� �� ������� ����� ����� �������� ������� ��������.')
		wait(8000)
		sampSendChat('/me ���� �������� ������� ��������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/do �������� � ������ ����.')
		wait(8000)
		sampSendChat('/me ������ ��������� ��� ������ �������� ������� ��������, ����� ���� ���� ����.')
		wait(8000)
		sampSendChat('/do �������� � ����� ����.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me ������� � ��������� ��������� ��������� ����� � �����.')
		wait(8000)
		sampSendChat('/do ����� ������.')
		wait(8000)
		sampSendChat('/me ������� � �������, ����� ���� ������� �������� � �������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/do �������� ��������� � �������.')
		wait(8000)
		sampSendChat('/me ������ �� �������� ���� �� ��������.')
		wait(8000)
		sampSendChat('/do �������� � ����� ����.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me ������� � ��������� ��������� ����� ��������� ���� �� �����.')
		wait(8000)
		sampSendChat('/do ���� ������.')
		wait(8000)
		sampSendChat('/me ������� � �������, ����� ���� ������� � � �������, �������� ��������� ����.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(2500)
		window.v = not window.v
	end)
end

function rp8()
	thread = lua_thread.create(function()
		window.v = not window.v
		wait(2500)
		sampSendChat('/me ������� ��������� ������ ����, g����� ���� ���� ����� � ����������� � ����.')
		wait(8000)
		sampSendChat('/do ����� � ����������� � �����.')
		wait(8000)
		sampSendChat('/me ������� ����� � ����������� �� ����, ����� ���� ������� ��� ���������...')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me ...��������� � ��������� �������.')
		wait(8000)
		sampSendChat('/me ����� ��������� �� �����, ����� ���� ����� ��������� ��.')
		wait(8000)
		sampSendChat('/me ������������ ��������� � ���������� �������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/do ��������� ��������� � ���������� �������.')
		wait(8000)
		sampSendChat('/me ���� ����� � �����������, ����� ���� ������� �� �� ������� ����� �����.')
		wait(8000)
		sampSendChat('/do � ����� ����� ����� � �����������.')
		wait(8000)
		sampSendChat('/me ������ ����, ����� ���� �������� � �����������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(2500)
		window.v = not window.v
	end)
end

function rp9()
	thread = lua_thread.create(function()
		window.v = not window.v
		wait(2500)
		sampSendChat('/do �� ����� ����� �������.')
		wait(8000)
		sampSendChat('/me ������� ��������� ������ ������ ��������, ����� ���� ������� ������ ��������.')
		wait(8000)
		sampSendChat('/do � �������� ��� ���������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me ������ �� ����� ��������, ����� ���� ������� ��� � �������.')
		wait(8000)
		sampSendChat('/me ��������� ��������� ������ �������� ��������.')
		wait(8000)
		sampSendChat('/do �������� �������� ���� �������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me ������� ������ �������� � �������, ����� ���� ����� ��������� �������.')
		wait(8000)
		sampSendChat('/do ������� ��������.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(2500)
		window.v = not window.v
	end)
end

function imgui.ToggleButton(str_id, bool)

	local rBool = false

	if LastActiveTime == nil then
		LastActiveTime = {}
	end
	if LastActive == nil then
		LastActive = {}
	end

	local function ImSaturate(f)
		return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f)
	end
	
	local p = imgui.GetCursorScreenPos()
	local draw_list = imgui.GetWindowDrawList()

	local height = imgui.GetTextLineHeightWithSpacing() + (imgui.GetStyle().FramePadding.y / 2)
	local width = height * 1.55
	local radius = height * 0.50
	local ANIM_SPEED = 0.15

	if imgui.InvisibleButton(str_id, imgui.ImVec2(width, height)) then
		bool.v = not bool.v
		rBool = true
		LastActiveTime[tostring(str_id)] = os.clock()
		LastActive[str_id] = true
	end

	local t = bool.v and 1.0 or 0.0

	if LastActive[str_id] then
		local time = os.clock() - LastActiveTime[tostring(str_id)]
		if time <= ANIM_SPEED then
			local t_anim = ImSaturate(time / ANIM_SPEED)
			t = bool.v and t_anim or 1.0 - t_anim
		else
			LastActive[str_id] = false
		end
	end

	local col_bg
	if imgui.IsItemHovered() then
		col_bg = imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.FrameBgHovered])
	else
		col_bg = imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.FrameBg])
	end

	draw_list:AddRectFilled(p, imgui.ImVec2(p.x + width, p.y + height), col_bg, height * 0.5)
	draw_list:AddCircleFilled(imgui.ImVec2(p.x + radius + t * (width - radius * 2.0), p.y + radius), radius - 1.5, imgui.GetColorU32(bool.v and imgui.GetStyle().Colors[imgui.Col.ButtonActive] or imgui.GetStyle().Colors[imgui.Col.Button]))

	return rBool
end

function update()
    local fpath = os.getenv('TEMP') .. '\\update.json'
    downloadUrlToFile('https://raw.githubusercontent.com/Decodir/auto-update/main/update.json', fpath, function(id, status, p1, p2)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            local f = io.open(fpath, 'r')
            if f then
                local info = decodeJson(f:read('*a'))
                updatelink = info.updateurl
                updlist1 = info.updlist
                ttt = updlist1
			    if info and info.latest then
                    if tonumber(thisScript().version) < tonumber(info.latest) then
                        sampAddChatMessage('���������� ���������� {ffffff}'..script.this.name..'{ffffff}. ��� ���������� ������� ������ � ������.',-1)
                        sampAddChatMessage('����������: ���� � ��� �� ��������� ������ ������� {ffffff}/newsupdate',-1)
                    else
                        sampAddChatMessage('���������� ������� �� ����������. �������� ����.',-1)
                        update = false
				    end
                end
            else
                print("�������� ���������� ������ ���������. �������� ������ ������.")
            end
        elseif status == 64 then
            print("�������� ���������� ������ ���������. �������� ������ ������.")
            update = false
        end
    end)
end


function goupdate()
	lua_thread.create(function()
    sampAddChatMessage('{ffffff}�������� ���������� ����������. ��������� ���� ������.', -1)
    wait(300)
    downloadUrlToFile(updatelink, thisScript().path, function(id3, status1, p13, p23)
        if status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
            thisScript():reload()
        elseif status1 == 64 then
            sampAddChatMessage("{ffffff}��������� ���������� ������ �������. ������������� ������.",-1)
        end
    end)
end)
end