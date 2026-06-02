local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TabbedWindow"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Основной фрейм 700x700
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 700, 0, 700)
mainFrame.Position = UDim2.new(0.5, -350, 0.5, -350)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Заголовок
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -40, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Многостраничное окно"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 18
closeButton.Parent = titleBar
closeButton.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Левая боковая панель
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 150, 1, -30) -- высота минус заголовок
sidebar.Position = UDim2.new(0, 0, 0, 30)
sidebar.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

-- Кнопки навигации
local function createNavButton(text, positionY)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, positionY)
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
	btn.BorderSizePixel = 0
	btn.Text = text
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 14
	btn.Parent = sidebar
	return btn
end

local mainBtn = createNavButton("Main", 20)
local settingsBtn = createNavButton("Settings", 70)

-- Область контента
local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Size = UDim2.new(1, -150, 1, -30)
contentArea.Position = UDim2.new(0, 150, 0, 30)
contentArea.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
contentArea.BorderSizePixel = 0
contentArea.Parent = mainFrame

-- Страницы
local mainPage = Instance.new("Frame")
mainPage.Name = "MainPage"
mainPage.Size = UDim2.new(1, 0, 1, 0)
mainPage.BackgroundTransparency = 1
mainPage.Parent = contentArea

local settingsPage = Instance.new("Frame")
settingsPage.Name = "SettingsPage"
settingsPage.Size = UDim2.new(1, 0, 1, 0)
settingsPage.BackgroundTransparency = 1
settingsPage.Visible = false
settingsPage.Parent = contentArea

-- Наполнение Main
local labelMain = Instance.new("TextLabel")
labelMain.Size = UDim2.new(1, 0, 0, 20)
labelMain.Position = UDim2.new(0, 10, 0, 10)
labelMain.BackgroundTransparency = 1
labelMain.Text = "Главная вкладка"
labelMain.TextColor3 = Color3.new(1, 1, 1)
labelMain.Font = Enum.Font.SourceSans
labelMain.TextSize = 14
labelMain.Parent = mainPage

local inputField = Instance.new("TextBox")
inputField.Size = UDim2.new(1, -20, 0, 30)
inputField.Position = UDim2.new(0, 10, 0, 40)
inputField.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
inputField.BorderSizePixel = 0
inputField.Text = ""
inputField.TextColor3 = Color3.new(1, 1, 1)
inputField.PlaceholderText = "Введите текст..."
inputField.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
inputField.Font = Enum.Font.SourceSans
inputField.TextSize = 14
inputField.Parent = mainPage

local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(1, -20, 0, 30)
submitBtn.Position = UDim2.new(0, 10, 0, 80)
submitBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 200)
submitBtn.BorderSizePixel = 0
submitBtn.Text = "Отправить"
submitBtn.TextColor3 = Color3.new(1, 1, 1)
submitBtn.Font = Enum.Font.SourceSansBold
submitBtn.TextSize = 14
submitBtn.Parent = mainPage
submitBtn.MouseButton1Click:Connect(function()
	print("Введено:", inputField.Text)
	-- здесь можно вызывать RemoteEvent/HttpService
end)

-- Наполнение Settings
local labelSettings = Instance.new("TextLabel")
labelSettings.Size = UDim2.new(1, 0, 0, 20)
labelSettings.Position = UDim2.new(0, 10, 0, 10)
labelSettings.BackgroundTransparency = 1
labelSettings.Text = "Настройки"
labelSettings.TextColor3 = Color3.new(1, 1, 1)
labelSettings.Font = Enum.Font.SourceSans
labelSettings.TextSize = 14
labelSettings.Parent = settingsPage

-- Логика переключения вкладок
local function switchTab(tab)
	if tab == "Main" then
		mainPage.Visible = true
		settingsPage.Visible = false
		mainBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 200) -- активный
		settingsBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 65) -- неактивный
	elseif tab == "Settings" then
		mainPage.Visible = false
		settingsPage.Visible = true
		mainBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
		settingsBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 200)
	end
end

mainBtn.MouseButton1Click:Connect(function()
	switchTab("Main")
end)
settingsBtn.MouseButton1Click:Connect(function()
	switchTab("Settings")
end)

-- Изначальное состояние: Main активен
switchTab("Main")

-- ====== Реализация перетаскивания ======
local dragging = false
local dragStartPos = nil
local frameStartPos = mainFrame.Position

titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStartPos = input.Position
		frameStartPos = mainFrame.Position
	end
end)

titleBar.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStartPos
		mainFrame.Position = UDim2.new(
			frameStartPos.X.Scale,
			frameStartPos.X.Offset + delta.X,
			frameStartPos.Y.Scale,
			frameStartPos.Y.Offset + delta.Y
		)
	end
end)
