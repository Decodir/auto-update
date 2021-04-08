script_name("NewsHelper") -- имя скрипта
script_authors("Nikolay Wilde") -- авторы
script_version("1.0") -- указывает версию скрипта

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
   sampAddChatMessage("{F00000}"..script.this.name.." | {FFFFFF}Автор: {F00000}"..table.concat(script.this.authors), -1)
   sampAddChatMessage("{F00000}"..script.this.name.." | {FFFFFF}Скрипт успешно загружен. Нажмите J чтобы открыть меню скрипта.", -1)
   sampAddChatMessage("{F00000}"..script.this.name.." | {FFFFFF}Версия скрипта: {F00000}" .. script.this.version, -1)	
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
--				sampAddChatMessage("Лекция началась", -1) -- если хочешь вывод текста. Оставляй
			end)
		else
			lua_thread.create(function()
				offotig()
--				sampAddChatMessage("Лекция закончилась", -1) -- если хочешь вывод текста. Оставляй
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("Лекция правил ПРО"))
	imgui.EndChild()
----------------------------------------------------------------------------------------------------	
	imgui.SameLine()
	imgui.BeginChild('##list2', imgui.ImVec2(195, 220), true)
	if imgui.ToggleButton("Button##2", imBool2) then
		if imBool2.v then
			lua_thread.create(function()
--				leksia()
				sampAddChatMessage("Лекция началась", -1) -- если хочешь вывод текста. Оставляй
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("Лекция закончилась", -1) -- если хочешь вывод текста. Оставляй
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("Название кнопки"))
	imgui.EndChild()
----------------------------------------------------------------------------------------------------	
	imgui.SameLine()
	imgui.BeginChild('##list3', imgui.ImVec2(398, 220), true)
    if imgui.ToggleButton("Button##3", imBool3) then
		if imBool3.v then
			lua_thread.create(function()
				rp1()
--				sampAddChatMessage("Лекция началась", -1) -- если хочешь вывод текста. Оставляй
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("Отыгровка RPшки закончилась", -1) -- если хочешь вывод текста. Оставляй
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("RPшка Покраска вертолёта"))
----------------------------------------------------------------------------------------------------
	if imgui.ToggleButton("Button##4", imBool4) then
		if imBool4.v then
			lua_thread.create(function()
				rp2()
--				sampAddChatMessage("Лекция началась", -1) -- если хочешь вывод текста. Оставляй
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("Отыгровка RPшки закончилась", -1) -- если хочешь вывод текста. Оставляй
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("RPшка Починка фракционной рации"))
----------------------------------------------------------------------------------------------------	
	if imgui.ToggleButton("Button##5", imBool5) then
		if imBool5.v then
			lua_thread.create(function()
				rp3()
--				sampAddChatMessage("Лекция началась", -1) -- если хочешь вывод текста. Оставляй
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("Отыгровка RPшки закончилась", -1) -- если хочешь вывод текста. Оставляй
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("RPшка Установка антивируса на фракционный компьютер"))
----------------------------------------------------------------------------------------------------
	if imgui.ToggleButton("Button##6", imBool6) then
		if imBool6.v then
			lua_thread.create(function()
				rp4()
--				sampAddChatMessage("Лекция началась", -1) -- если хочешь вывод текста. Оставляй
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("Отыгровка RPшки закончилась", -1) -- если хочешь вывод текста. Оставляй
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("RPшка Мойка служебного автомобиля"))
----------------------------------------------------------------------------------------------------
	if imgui.ToggleButton("Button##7", imBool7) then
		if imBool7.v then
			lua_thread.create(function()
				rp5()
--				sampAddChatMessage("Лекция началась", -1) -- если хочешь вывод текста. Оставляй
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("Отыгровка RPшки закончилась", -1) -- если хочешь вывод текста. Оставляй
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("RPшка Проверка состояния служебного автомобиля"))
----------------------------------------------------------------------------------------------------
	if imgui.ToggleButton("Button##8", imBool8) then
		if imBool8.v then
			lua_thread.create(function()
				rp6()
--				sampAddChatMessage("Лекция началась", -1) -- если хочешь вывод текста. Оставляй
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("Отыгровка RPшки закончилась", -1) -- если хочешь вывод текста. Оставляй
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("RPшка  Разгрузка рабочей формы редакции"))
----------------------------------------------------------------------------------------------------
	if imgui.ToggleButton("Button##9", imBool9) then
		if imBool9.v then
			lua_thread.create(function()
				rp7()
--				sampAddChatMessage("Лекция началась", -1) -- если хочешь вывод текста. Оставляй
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("Отыгровка RPшки закончилась", -1) -- если хочешь вывод текста. Оставляй
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("RPшка Протираем пыль со столов и полок"))
----------------------------------------------------------------------------------------------------	
	if imgui.ToggleButton("Button##10", imBool10) then
		if imBool10.v then
			lua_thread.create(function()
				rp8()
--				sampAddChatMessage("Лекция началась", -1) -- если хочешь вывод текста. Оставляй
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("Отыгровка RPшки закончилась", -1) -- если хочешь вывод текста. Оставляй
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("RPшка Сортировка документов внутри редакции"))
----------------------------------------------------------------------------------------------------
	if imgui.ToggleButton("Button##11", imBool11) then
		if imBool11.v then
			lua_thread.create(function()
				rp9()
--				sampAddChatMessage("Лекция началась", -1) -- если хочешь вывод текста. Оставляй
			end)
		else
			lua_thread.create(function()
				offotig()
				sampAddChatMessage("Отыгровка RPшки закончилась", -1) -- если хочешь вывод текста. Оставляй
			end)
		end
	end
	imgui.SameLine()
	imgui.Text(u8("RPшка Замена картриджа в принтере"))
	imgui.EndChild()
   imgui.End()
end

function makeScreenshot(disable) -- если передать true, интерфейс и чат будут скрыты
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
		sampSendChat('Краткая лекция по ПРО, освежим вам память.')
		wait(8000)
		sampSendChat('Объявления должны начинаться с большой буквы.')
		wait(8000)
		sampSendChat('Сокращение названий городов не допускается, пишутся без дефиса.')
		wait(8000)
		sampSendChat('Например: "г. Los Santos", "города Сан Фиерро".')
		wait(8000)
		sampSendChat('Далее..')
		sampSendChat('/time 1')
		wait(250)
		makeScreenshot()
		wait(8000)
		sampSendChat('Все марки автомобилей пишутся на латинице и в кавычках.')
		wait(8000)
		sampSendChat('Например: Куплю авто "Sultan". Бюджет: 2.5 млн вирт')
		wait(8000)
		sampSendChat('Слово "класс" не пишется.')
		wait(8000)
		sampSendChat('Также в кавычках пишутся названия бизнесов и аксессуаров.')
		sampSendChat('/time 1')
		wait(250)
		makeScreenshot()
		wait(8000)
		sampSendChat('Названия бизнесов "Mulholland 24-7",акс."Меч" - пишутся на английском языке и помещаются в кавычки.')
		wait(8000)
		sampSendChat('Допускается сокращение слова "аксессуар" до "акс."')
		wait(8000)
		sampSendChat('Названия населенных пунктов пишутся без кавычек.')
		wait(8000)
		sampSendChat('Объявление и покупке костюмов: панда, пикачу, крик и др. - отклоняются.')
		sampSendChat('/time 1')
		wait(250)
		makeScreenshot()
		wait(8000)
		sampSendChat('Наборы в семьи, неофициальные организации - запрещены.')
		wait(8000)
		sampSendChat('После "млн" точку не ставим, а после "тыс" ставим точку, то есть "тыс.".')
		wait(8000)
		sampSendChat('Пример: 2 млн вирт и 200 тыс. вирт. ')
		wait(8000)
		sampSendChat('Запрещено рекламировать набор в какую-либо организацию')
		wait(8000)
		sampSendChat('Если в объявлении написано, что продающийся дом наполнен аптечками')
		wait(8000)
		sampSendChat('Указывайте это так: "Продам дом с полным комплектом аптечек"')
		wait(8000)
		sampSendChat('Есть вопросы? Если нет то приступайте к работе!')
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
		sampSendChat('/do На столе лежит банка с краской, ножик и кисточка.')
		wait(8000)
		sampSendChat('/me взял банку с краской,ножиком и кисточкой.')
		wait(8000)
		sampSendChat('/me поставил банку на пол.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me взял ножик в правую руку медленным движением.')
		wait(8000)
		sampSendChat('/me медленным движением подцепил край банки, после чего открыл её.')
		wait(8000)
		sampSendChat('/me обмакнул кисточку в краске.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me плавными движениями вправо и влево начал размазывать краску по корпусу.')
		wait(8000)
		sampSendChat('/do Через несколько минут вертолет был полностью покрашен.')
		wait(8000)
		sampSendChat('/do Банка с краской пуста.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me бросил грязную кисточку и ножик в пустую банку.')
		wait(8000)
		sampSendChat('/me положил нож на стол.')
		wait(8000)
		sampSendChat('/me выкинул грязную банку в мусорное ведро.')
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
		sampSendChat('/do На столе лежит неисправная рация.')
		wait(8000)
		sampSendChat('/do В руках находится сумка с инструментами.')
		wait(8000)
		sampSendChat('/me положил сумку на стол')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me перевернул рацию лицевой стороной вниз.')
		wait(8000)
		sampSendChat('/me достал из сумки крестовую отвертку.')
		wait(8000)
		sampSendChat('/me открутил все шурупы и положил их в специальную баночку.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me внимательно осмотрел плату.')
		wait(8000)
		sampSendChat('/todo Все ясно,контакт отошел*радостно улыбаясь.')
		wait(8000)
		sampSendChat('/me достал из сумки с инструментами паяльник и проволоку-припой.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me воткнул паяльник в розетку.')
		wait(8000)
		sampSendChat('/do через 30 секунд паяльник нагрелся.')
		wait(8000)
		sampSendChat('/me приложил контакт в место отрыва.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me расплавил кусочек проволки.')
		wait(8000)
		sampSendChat('/do Спустя 3 секунды расплавившаяся лужица застыла.')
		wait(8000)
		sampSendChat('/me выключил паяльник из розетки')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me положил паяльник и проволоку обратно в сумку')
		wait(8000)
		sampSendChat('/me нажал кнопку включения на рации.')
		wait(8000)
		sampSendChat('/do Рация включилась и все ее функции были готовы к работе.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me достал из специальной баночки шурупчики и прикрутил заднюю крышку обратно.')
		wait(8000)
		sampSendChat('/me положил отвертку в сумку c инструментами.')
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
		sampSendChat('/do USB-накопитель в руках.')
		wait(8000)
		sampSendChat('/me включил компьютер.')
		wait(8000)
		sampSendChat('/me вставил USB-накопитель в гнездо компьютера.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/do USB-накопитель загрузился.')
		wait(8000)
		sampSendChat('/me держа мышку, открыл папку с антивирусом.')
		wait(8000)
		sampSendChat('/do В папке антивирус "Guard".')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me запустил установку программы.')
		wait(8000)
		sampSendChat('/do Антивирус устанавливается.')
		wait(8000)
		sampSendChat('/do Установка завершена.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me выдернул USB-накопитель из гнезда компьютера.')
		wait(8000)
		sampSendChat('/me перевёл компьютер в спящий режим, после чего положил USB-накопитель в карман.')
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
		sampSendChat('/me открыл шкаф, после чего взял с верхней полки губку и ведро и закрыл шкаф.')
		wait(8000)
		sampSendChat('/do Ведро с губкой в правой руке.')
		wait(8000)
		sampSendChat('/me подошёл к крану, после чего наполнил ведро водой.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/do Ведро заполнено водой.')
		wait(8000)
		sampSendChat('/me медленным движением поставил ведро с водой возле автомобиля.')
		wait(8000)
		sampSendChat('/me взял тряпку с ведра, после чего начал мыть стёкла автомобиля.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me моет стёкла автомобиля, параллельно протирая зеркала.')
		wait(8000)
		sampSendChat('/me закончил мыть автомобиль, после чего кинул тряпку в ведро.')
		wait(8000)
		sampSendChat('/do Автомобиль был чист.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me взял ведро, после чего вылил воду с ведра на колёса автомобиля.')
		wait(8000)
		sampSendChat('/me положил губку в шкаф, после чего его.')
		wait(8000)
		sampSendChat('/todo Это оказалось намного труднее, чем я думал!*убирая пот с лица.')
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
		sampSendChat('/do Дверь автомобиля закрыта.')
		wait(8000)
		sampSendChat('/me правой рукой открыв дверь сел в авто и дёрнул за ручку открытие копота.')
		wait(8000)
		sampSendChat('/me вышел из автомобиля, затем подойдя к капоту открыл его.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/do Капот открыт.')
		wait(8000)
		sampSendChat('/me начал осматривать двигатель автомобиля.')
		wait(8000)
		sampSendChat('/do Двигатель в норме.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me закончив осмотр двигателя закрыл капот.')
		wait(8000)
		sampSendChat('/do Капот закрыт.')
		wait(8000)
		sampSendChat('/todo Так, видно двигатель в норме.*приступая к осмотру колёс.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me нагнувшись начал осматривать все колеса автомобиля.')
		wait(8000)
		sampSendChat('/todo Ну тут все хорошо*заканчивая осматривать колеса.')
		wait(8000)
		sampSendChat('/do Колеса в норме.')
		wait(8000)
		sampSendChat('Так, осмотр этого автомобиля пригоден к эксплуатации, его осмотр окончен.')
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
		sampSendChat('/do Напротив стоит грузовой контейнер.')
		wait(8000)
		sampSendChat('/todo Тут пришла новая поставка формы.*вспоминая, где находится ключ от груза.')
		wait(8000)
		sampSendChat('/do Ключ от груза в левом кармане штанов.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me резким движением левой руки достал ключ.')
		wait(8000)
		sampSendChat('/me вставил ключ в контейнер, затем повернув открыл его.')
		wait(8000)
		sampSendChat('/do Контейнер открыт.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me открыл двери контейнер обеими руками.')
		wait(8000)
		sampSendChat('/todo Да, это новая партия формы.*подходя к багажнику автомобиля.')
		wait(8000)
		sampSendChat('/me подойдя к багажнику грузовика открыл его')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/do Багажник открыт.')
		wait(8000)
		sampSendChat('/me начал погрузку груза.')
		wait(8000)
		sampSendChat('/me спустя несколько минут закончил погрузку груза.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/do Груз загружен.')
		wait(8000)
		sampSendChat('/me закрыл багажник')
		wait(8000)
		sampSendChat('/do Багажник грузовика закрыт.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/todo Груз на месте, разгружаем!*начавший разгружать коробки с грузом.')
		wait(8000)
		sampSendChat('/me взял одну из коробок с формой, после чего понёс в офис редакции.')
		wait(8000)
		sampSendChat('/me медленным движением рук положил форму в холле редакции, спустившись за следующей коробкой.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/do Коробка в грузовике.')
		wait(8000)
		sampSendChat('/me взял последнюю коробку, после чего понёс её в офис редакции.')
		wait(8000)
		sampSendChat('/me поставил коробку с формой, после чего сообщил в рацию о привозе формы.')
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
		sampSendChat('/me медленным движением рук потянулся к ручке шкафчика, после чего открыл его.')
		wait(8000)
		sampSendChat('/do В шкафу на верхней полке лежит упаковка влажных салфеток.')
		wait(8000)
		sampSendChat('/me взял упаковку влажных салфеток.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/do Упаковка в правой руке.')
		wait(8000)
		sampSendChat('/me резким движением рук открыл упаковку влажник салфеток, после чего взял одну.')
		wait(8000)
		sampSendChat('/do Салфетка в левой руке.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me плавным и медленным движением протирает полки в офисе.')
		wait(8000)
		sampSendChat('/do Полки чистые.')
		wait(8000)
		sampSendChat('/me подошёл к мусорке, после чего выкинул салфетку в мусорку.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/do Салфетка находится в мусорке.')
		wait(8000)
		sampSendChat('/me достал из упаковки одну из салфеток.')
		wait(8000)
		sampSendChat('/do Салфетка в левой руке.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me плавным и медленным движением начал протирать пыль со стола.')
		wait(8000)
		sampSendChat('/do Стол чистый.')
		wait(8000)
		sampSendChat('/me подошёл к мусорке, после чего выкинул её в мусорке, закончил протирать пыль.')
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
		sampSendChat('/me плавным движением открыл шкаф, gпосле чего взял папку с документами в руки.')
		wait(8000)
		sampSendChat('/do Папка с документами в руках.')
		wait(8000)
		sampSendChat('/me положил папку с документами на стол, после чего заметил что документы...')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me ...находятся в хаотичном порядке.')
		wait(8000)
		sampSendChat('/me вынул документы из папки, после чего начал разбирать их.')
		wait(8000)
		sampSendChat('/me раскладывает документы в алфавитном порядке.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/do Документы разобразы в алфавитном порядке.')
		wait(8000)
		sampSendChat('/me взял папку с документами, после чего положил их на верхнюю полку шкафа.')
		wait(8000)
		sampSendChat('/do В шкафу лежат папки с документами.')
		wait(8000)
		sampSendChat('/me закрыл шкаф, после чего вздохнул с облегчением.')
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
		sampSendChat('/do На столе стоит принтер.')
		wait(8000)
		sampSendChat('/me плавным движением открыл крышку принтера, после чего вытащил старый картридж.')
		wait(8000)
		sampSendChat('/do В принтере нет картриджа.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me достал из сумки картридж, после чего положил его в принтер.')
		wait(8000)
		sampSendChat('/me медленным движением закрыл крышечку принтера.')
		wait(8000)
		sampSendChat('/do Крышечка принтера была закрыта.')
		wait(1500)
		sampSendChat('/time 1')
		wait(1000)
		makeScreenshot()
		wait(8000)
		sampSendChat('/me выкинул старый картридж в мусорку, после чего начал проверять принтер.')
		wait(8000)
		sampSendChat('/do Принтер работает.')
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
                        sampAddChatMessage('Обнаружено обновление {ffffff}'..script.this.name..'{ffffff}. Для обновления нажмите кнопку в окошке.',-1)
                        sampAddChatMessage('Примечание: Если у вас не появилось окошко введите {ffffff}/newsupdate',-1)
                    else
                        sampAddChatMessage('Обновлений скрипта не обнаружено. Приятной игры.',-1)
                        update = false
				    end
                end
            else
                print("Проверка обновления прошка неуспешно. Запускаю старую версию.")
            end
        elseif status == 64 then
            print("Проверка обновления прошка неуспешно. Запускаю старую версию.")
            update = false
        end
    end)
end


function goupdate()
	lua_thread.create(function()
    sampAddChatMessage('{ffffff}Началось скачивание обновления. Подождите пару секнуд.', -1)
    wait(300)
    downloadUrlToFile(updatelink, thisScript().path, function(id3, status1, p13, p23)
        if status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
            thisScript():reload()
        elseif status1 == 64 then
            sampAddChatMessage("{ffffff}Установка обновления прошла успешно. Перезагрузите скрипт.",-1)
        end
    end)
end)
end