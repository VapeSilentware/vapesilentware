local mainapi = {
	Categories = {},
	GUIColor = {
		Hue = 0.405,
		Sat = 0.68,
		Value = 0.82
	},
	HeldKeybinds = {},
	Keybind = {'RightShift'},
	LegacyModuleNames = {
		VapePrivateDetector = 'SilentwarePrivateDetector'
	},
	Loaded = false,
	Libraries = {},
	Modules = {},
	Place = game.PlaceId,
	Profile = 'default',
	Profiles = {},
	RainbowSpeed = {Value = 1},
	RainbowUpdateSpeed = {Value = 60},
	RainbowTable = {},
	Scale = {Value = 1},
	ThreadFix = setthreadidentity and true or false,
	ToggleNotifications = {},
	Version = 'v1',
	Access = shared.SilentwareAccess,
	ThemePreset = 'Emerald Noir',
	SettingsPanes = {},
	ThemePreviewCards = {},
	Windows = {}
}
mainapi.ThreadFix = false

local cloneref = cloneref or function(obj)
	return obj
end
local tweenService = cloneref(game:GetService('TweenService'))
local inputService = cloneref(game:GetService('UserInputService'))
local textService = cloneref(game:GetService('TextService'))
local guiService = cloneref(game:GetService('GuiService'))
local runService = cloneref(game:GetService('RunService'))
local httpService = cloneref(game:GetService('HttpService'))
local lightingService = cloneref(game:GetService('Lighting'))

local fontsize = Instance.new('GetTextBoundsParams')
fontsize.Width = math.huge
local notifications
local assetfunction = getcustomasset
local getcustomasset
local clickgui
local scaledgui
local toolblur
local tooltip
local scale
local gui

local color = {}
local getAccentColor
local tween = {
	tweens = {},
	tweenstwo = {}
}
local uipallet = {
	Main = Color3.fromRGB(5, 8, 7),
	Surface = Color3.fromRGB(10, 15, 13),
	SurfaceAlt = Color3.fromRGB(16, 23, 20),
	SurfaceHigh = Color3.fromRGB(22, 31, 27),
	Border = Color3.fromRGB(49, 70, 61),
	Accent = Color3.fromRGB(62, 211, 139),
	AccentSoft = Color3.fromRGB(35, 152, 96),
	Success = Color3.fromRGB(62, 211, 139),
	Warning = Color3.fromRGB(234, 171, 75),
	Danger = Color3.fromRGB(235, 87, 103),
	Text = Color3.fromRGB(242, 250, 246),
	MutedText = Color3.fromRGB(151, 175, 164),
	DimText = Color3.fromRGB(99, 121, 111),
	AccentGlow = Color3.fromRGB(62, 211, 139),
	SelectedTab = Color3.fromRGB(21, 45, 34),
	ActiveToggle = Color3.fromRGB(62, 211, 139),
	NotificationAccent = Color3.fromRGB(62, 211, 139),
	GlassTransparency = 0.06,
	PanelTransparency = 0.05,
	ShadowTransparency = 0.18,
	Font = Font.fromEnum(Enum.Font.Gotham),
	FontSemiBold = Font.fromEnum(Enum.Font.Gotham, Enum.FontWeight.SemiBold),
	Tween = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	OpenTween = TweenInfo.new(0.34, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
}

mainapi.RainbowMode = mainapi.RainbowMode or {Value = 'Gradient'}
mainapi.RainbowTheme = false
mainapi.GUIColor.Rainbow = false

local interfaceBlur

local access = shared.SilentwareAccess or mainapi.Access or {
	Tier = 'free',
	Level = 0,
	DisplayNames = {free = 'Free'},
	CanUseModule = function()
		return true, 'free', 0
	end
}
mainapi.Access = access

local themePresetFiles = {
	['Emerald Noir'] = 'EmeraldNoir.lua',
	['Cotton Candy'] = 'CottonCandy.lua',
	['Sapphire Night'] = 'SapphireNight.lua',
	['Royal Amethyst'] = 'RoyalAmethyst.lua',
	['Rose Quartz'] = 'RoseQuartz.lua',
	['Arctic Chrome'] = 'ArcticChrome.lua',
	['Solar Flare'] = 'SolarFlare.lua',
	['Crimson Velvet'] = 'CrimsonVelvet.lua',
	['Cyberpunk Bloom'] = 'CyberpunkBloom.lua',
	['Ocean Glass'] = 'OceanGlass.lua',
	['Ghost Lavender'] = 'GhostLavender.lua',
	['Golden Hour'] = 'GoldenHour.lua',
	['Monochrome Ice'] = 'MonochromeIce.lua',
	['Sakura Noir'] = 'SakuraNoir.lua',
	['Void Blue'] = 'VoidBlue.lua',
	['Peach Cream'] = 'PeachCream.lua',
	['Grape Soda'] = 'GrapeSoda.lua',
	['Cherry Cola'] = 'CherryCola.lua',
	['Rainbow'] = 'Rainbow.lua',
}
local embeddedThemePresets = {
	['Emerald Noir'] = {
		Main = Color3.fromRGB(4, 7, 6),
		Surface = Color3.fromRGB(9, 14, 12),
		SurfaceAlt = Color3.fromRGB(15, 23, 19),
		SurfaceHigh = Color3.fromRGB(22, 33, 27),
		Border = Color3.fromRGB(49, 77, 64),
		Accent = Color3.fromRGB(56, 215, 139),
		AccentSoft = Color3.fromRGB(31, 150, 94),
		AccentGlow = Color3.fromRGB(77, 255, 171),
		SelectedTab = Color3.fromRGB(18, 52, 37),
		ActiveToggle = Color3.fromRGB(56, 215, 139),
		NotificationAccent = Color3.fromRGB(56, 215, 139),
		Text = Color3.fromRGB(244, 252, 248),
		MutedText = Color3.fromRGB(152, 183, 168),
		DimText = Color3.fromRGB(88, 113, 101),
		GlassTransparency = 0.05,
		PanelTransparency = 0.045,
		ShadowTransparency = 0.15,
		Hue = 0.405,
		Sat = 0.72,
		Value = 0.84,
		Description = 'deep black glass with rich emerald glow'
	},
	['Cotton Candy'] = {
		Main = Color3.fromRGB(9, 8, 18),
		Surface = Color3.fromRGB(18, 18, 34),
		SurfaceAlt = Color3.fromRGB(28, 31, 55),
		SurfaceHigh = Color3.fromRGB(42, 48, 78),
		Border = Color3.fromRGB(95, 94, 140),
		Accent = Color3.fromRGB(255, 122, 206),
		AccentSoft = Color3.fromRGB(95, 181, 255),
		AccentGlow = Color3.fromRGB(116, 211, 255),
		SelectedTab = Color3.fromRGB(53, 45, 83),
		ActiveToggle = Color3.fromRGB(255, 122, 206),
		NotificationAccent = Color3.fromRGB(116, 211, 255),
		Text = Color3.fromRGB(255, 246, 253),
		MutedText = Color3.fromRGB(197, 194, 230),
		DimText = Color3.fromRGB(132, 132, 171),
		GlassTransparency = 0.08,
		PanelTransparency = 0.055,
		ShadowTransparency = 0.16,
		Hue = 0.89,
		Sat = 0.52,
		Value = 1,
		Description = 'soft blue and pink glass with dreamy candy glow'
	},
	['Sapphire Night'] = {
		Main = Color3.fromRGB(4, 8, 18),
		Surface = Color3.fromRGB(8, 15, 30),
		SurfaceAlt = Color3.fromRGB(13, 25, 50),
		SurfaceHigh = Color3.fromRGB(22, 41, 78),
		Border = Color3.fromRGB(55, 86, 138),
		Accent = Color3.fromRGB(79, 154, 255),
		AccentSoft = Color3.fromRGB(45, 92, 185),
		AccentGlow = Color3.fromRGB(105, 190, 255),
		SelectedTab = Color3.fromRGB(20, 45, 89),
		ActiveToggle = Color3.fromRGB(79, 154, 255),
		NotificationAccent = Color3.fromRGB(105, 190, 255),
		Text = Color3.fromRGB(240, 247, 255),
		MutedText = Color3.fromRGB(152, 177, 214),
		DimText = Color3.fromRGB(91, 116, 153),
		GlassTransparency = 0.055,
		PanelTransparency = 0.045,
		ShadowTransparency = 0.14,
		Hue = 0.59,
		Sat = 0.68,
		Value = 1,
		Description = 'polished midnight blue with sapphire dashboard accents'
	},
	['Royal Amethyst'] = {
		Main = Color3.fromRGB(12, 6, 18),
		Surface = Color3.fromRGB(22, 12, 31),
		SurfaceAlt = Color3.fromRGB(34, 20, 50),
		SurfaceHigh = Color3.fromRGB(51, 32, 72),
		Border = Color3.fromRGB(99, 72, 139),
		Accent = Color3.fromRGB(181, 111, 255),
		AccentSoft = Color3.fromRGB(121, 72, 197),
		AccentGlow = Color3.fromRGB(205, 146, 255),
		SelectedTab = Color3.fromRGB(55, 34, 81),
		ActiveToggle = Color3.fromRGB(181, 111, 255),
		NotificationAccent = Color3.fromRGB(205, 146, 255),
		Text = Color3.fromRGB(250, 244, 255),
		MutedText = Color3.fromRGB(201, 176, 222),
		DimText = Color3.fromRGB(136, 105, 158),
		GlassTransparency = 0.06,
		PanelTransparency = 0.045,
		ShadowTransparency = 0.15,
		Hue = 0.76,
		Sat = 0.56,
		Value = 1,
		Description = 'luxury purple glass with soft amethyst lighting'
	},
	['Rose Quartz'] = {
		Main = Color3.fromRGB(18, 8, 12),
		Surface = Color3.fromRGB(30, 15, 21),
		SurfaceAlt = Color3.fromRGB(47, 24, 34),
		SurfaceHigh = Color3.fromRGB(70, 38, 51),
		Border = Color3.fromRGB(129, 77, 94),
		Accent = Color3.fromRGB(255, 132, 168),
		AccentSoft = Color3.fromRGB(192, 84, 122),
		AccentGlow = Color3.fromRGB(255, 173, 199),
		SelectedTab = Color3.fromRGB(70, 35, 49),
		ActiveToggle = Color3.fromRGB(255, 132, 168),
		NotificationAccent = Color3.fromRGB(255, 173, 199),
		Text = Color3.fromRGB(255, 246, 249),
		MutedText = Color3.fromRGB(218, 174, 188),
		DimText = Color3.fromRGB(150, 105, 120),
		GlassTransparency = 0.055,
		PanelTransparency = 0.04,
		ShadowTransparency = 0.14,
		Hue = 0.955,
		Sat = 0.52,
		Value = 1,
		Description = 'romantic rose glass with clean quartz highlights'
	},
	['Arctic Chrome'] = {
		Main = Color3.fromRGB(7, 11, 14),
		Surface = Color3.fromRGB(13, 19, 24),
		SurfaceAlt = Color3.fromRGB(22, 31, 38),
		SurfaceHigh = Color3.fromRGB(35, 47, 55),
		Border = Color3.fromRGB(91, 114, 125),
		Accent = Color3.fromRGB(169, 229, 255),
		AccentSoft = Color3.fromRGB(94, 157, 190),
		AccentGlow = Color3.fromRGB(210, 246, 255),
		SelectedTab = Color3.fromRGB(38, 55, 66),
		ActiveToggle = Color3.fromRGB(169, 229, 255),
		NotificationAccent = Color3.fromRGB(210, 246, 255),
		Text = Color3.fromRGB(246, 252, 255),
		MutedText = Color3.fromRGB(175, 199, 210),
		DimText = Color3.fromRGB(111, 137, 149),
		GlassTransparency = 0.045,
		PanelTransparency = 0.035,
		ShadowTransparency = 0.12,
		Hue = 0.54,
		Sat = 0.34,
		Value = 1,
		Description = 'frosted steel surfaces with icy chrome accents'
	},
	['Solar Flare'] = {
		Main = Color3.fromRGB(17, 9, 3),
		Surface = Color3.fromRGB(31, 18, 8),
		SurfaceAlt = Color3.fromRGB(50, 31, 12),
		SurfaceHigh = Color3.fromRGB(74, 48, 19),
		Border = Color3.fromRGB(139, 95, 42),
		Accent = Color3.fromRGB(255, 177, 74),
		AccentSoft = Color3.fromRGB(203, 106, 45),
		AccentGlow = Color3.fromRGB(255, 210, 110),
		SelectedTab = Color3.fromRGB(74, 45, 20),
		ActiveToggle = Color3.fromRGB(255, 177, 74),
		NotificationAccent = Color3.fromRGB(255, 210, 110),
		Text = Color3.fromRGB(255, 249, 238),
		MutedText = Color3.fromRGB(220, 187, 141),
		DimText = Color3.fromRGB(148, 113, 70),
		GlassTransparency = 0.052,
		PanelTransparency = 0.04,
		ShadowTransparency = 0.14,
		Hue = 0.095,
		Sat = 0.70,
		Value = 1,
		Description = 'dark amber console with warm golden flare highlights'
	},
	['Crimson Velvet'] = {
		Main = Color3.fromRGB(16, 5, 7),
		Surface = Color3.fromRGB(28, 10, 13),
		SurfaceAlt = Color3.fromRGB(45, 16, 21),
		SurfaceHigh = Color3.fromRGB(69, 28, 34),
		Border = Color3.fromRGB(126, 51, 61),
		Accent = Color3.fromRGB(243, 73, 91),
		AccentSoft = Color3.fromRGB(166, 40, 56),
		AccentGlow = Color3.fromRGB(255, 116, 129),
		SelectedTab = Color3.fromRGB(70, 24, 33),
		ActiveToggle = Color3.fromRGB(243, 73, 91),
		NotificationAccent = Color3.fromRGB(255, 116, 129),
		Text = Color3.fromRGB(255, 245, 246),
		MutedText = Color3.fromRGB(220, 165, 170),
		DimText = Color3.fromRGB(151, 92, 99),
		GlassTransparency = 0.05,
		PanelTransparency = 0.038,
		ShadowTransparency = 0.13,
		Hue = 0.985,
		Sat = 0.70,
		Value = 0.95,
		Description = 'cinematic red velvet with dark premium contrast'
	},
	['Cyberpunk Bloom'] = {
		Main = Color3.fromRGB(8, 5, 16),
		Surface = Color3.fromRGB(16, 10, 30),
		SurfaceAlt = Color3.fromRGB(27, 18, 48),
		SurfaceHigh = Color3.fromRGB(43, 28, 72),
		Border = Color3.fromRGB(91, 75, 136),
		Accent = Color3.fromRGB(255, 79, 214),
		AccentSoft = Color3.fromRGB(65, 211, 255),
		AccentGlow = Color3.fromRGB(88, 231, 255),
		SelectedTab = Color3.fromRGB(55, 30, 82),
		ActiveToggle = Color3.fromRGB(255, 79, 214),
		NotificationAccent = Color3.fromRGB(65, 211, 255),
		Text = Color3.fromRGB(255, 244, 253),
		MutedText = Color3.fromRGB(203, 181, 226),
		DimText = Color3.fromRGB(135, 113, 166),
		GlassTransparency = 0.07,
		PanelTransparency = 0.052,
		ShadowTransparency = 0.17,
		Hue = 0.855,
		Sat = 0.68,
		Value = 1,
		Description = 'magenta and cyan bloom for a futuristic neon-luxe look'
	},
	['Ocean Glass'] = {
		Main = Color3.fromRGB(3, 12, 17),
		Surface = Color3.fromRGB(8, 23, 31),
		SurfaceAlt = Color3.fromRGB(13, 37, 49),
		SurfaceHigh = Color3.fromRGB(21, 55, 70),
		Border = Color3.fromRGB(50, 102, 124),
		Accent = Color3.fromRGB(65, 206, 234),
		AccentSoft = Color3.fromRGB(31, 138, 180),
		AccentGlow = Color3.fromRGB(104, 235, 255),
		SelectedTab = Color3.fromRGB(18, 62, 79),
		ActiveToggle = Color3.fromRGB(65, 206, 234),
		NotificationAccent = Color3.fromRGB(104, 235, 255),
		Text = Color3.fromRGB(238, 253, 255),
		MutedText = Color3.fromRGB(143, 197, 211),
		DimText = Color3.fromRGB(79, 132, 149),
		GlassTransparency = 0.09,
		PanelTransparency = 0.06,
		ShadowTransparency = 0.16,
		Hue = 0.52,
		Sat = 0.65,
		Value = 0.92,
		Description = 'deep ocean glass with bright aquatic edge lighting'
	},
	['Ghost Lavender'] = {
		Main = Color3.fromRGB(10, 10, 17),
		Surface = Color3.fromRGB(18, 18, 29),
		SurfaceAlt = Color3.fromRGB(30, 29, 46),
		SurfaceHigh = Color3.fromRGB(46, 44, 66),
		Border = Color3.fromRGB(100, 96, 133),
		Accent = Color3.fromRGB(203, 178, 255),
		AccentSoft = Color3.fromRGB(137, 118, 199),
		AccentGlow = Color3.fromRGB(226, 211, 255),
		SelectedTab = Color3.fromRGB(55, 51, 78),
		ActiveToggle = Color3.fromRGB(203, 178, 255),
		NotificationAccent = Color3.fromRGB(226, 211, 255),
		Text = Color3.fromRGB(250, 248, 255),
		MutedText = Color3.fromRGB(199, 194, 222),
		DimText = Color3.fromRGB(132, 128, 159),
		GlassTransparency = 0.04,
		PanelTransparency = 0.035,
		ShadowTransparency = 0.12,
		Hue = 0.71,
		Sat = 0.32,
		Value = 1,
		Description = 'quiet lavender chrome with soft ghostly contrast'
	},
	['Golden Hour'] = {
		Main = Color3.fromRGB(18, 13, 5),
		Surface = Color3.fromRGB(31, 24, 12),
		SurfaceAlt = Color3.fromRGB(50, 39, 20),
		SurfaceHigh = Color3.fromRGB(75, 59, 29),
		Border = Color3.fromRGB(143, 116, 54),
		Accent = Color3.fromRGB(255, 207, 92),
		AccentSoft = Color3.fromRGB(199, 141, 45),
		AccentGlow = Color3.fromRGB(255, 226, 126),
		SelectedTab = Color3.fromRGB(75, 58, 24),
		ActiveToggle = Color3.fromRGB(255, 207, 92),
		NotificationAccent = Color3.fromRGB(255, 226, 126),
		Text = Color3.fromRGB(255, 251, 237),
		MutedText = Color3.fromRGB(218, 197, 149),
		DimText = Color3.fromRGB(147, 128, 79),
		GlassTransparency = 0.045,
		PanelTransparency = 0.035,
		ShadowTransparency = 0.12,
		Hue = 0.12,
		Sat = 0.62,
		Value = 1,
		Description = 'premium gold-on-black warmth without cheap yellow neon'
	},
	['Monochrome Ice'] = {
		Main = Color3.fromRGB(5, 6, 8),
		Surface = Color3.fromRGB(11, 12, 15),
		SurfaceAlt = Color3.fromRGB(20, 22, 27),
		SurfaceHigh = Color3.fromRGB(32, 35, 42),
		Border = Color3.fromRGB(82, 88, 99),
		Accent = Color3.fromRGB(235, 242, 255),
		AccentSoft = Color3.fromRGB(137, 148, 166),
		AccentGlow = Color3.fromRGB(255, 255, 255),
		SelectedTab = Color3.fromRGB(43, 47, 56),
		ActiveToggle = Color3.fromRGB(235, 242, 255),
		NotificationAccent = Color3.fromRGB(235, 242, 255),
		Text = Color3.fromRGB(248, 250, 255),
		MutedText = Color3.fromRGB(178, 184, 194),
		DimText = Color3.fromRGB(112, 119, 131),
		GlassTransparency = 0.025,
		PanelTransparency = 0.025,
		ShadowTransparency = 0.10,
		Hue = 0.61,
		Sat = 0.06,
		Value = 1,
		Description = 'minimal black and ice white for a clean pro tool feel'
	},
	['Sakura Noir'] = {
		Main = Color3.fromRGB(14, 7, 13),
		Surface = Color3.fromRGB(25, 13, 23),
		SurfaceAlt = Color3.fromRGB(40, 23, 37),
		SurfaceHigh = Color3.fromRGB(61, 37, 56),
		Border = Color3.fromRGB(120, 75, 111),
		Accent = Color3.fromRGB(255, 154, 220),
		AccentSoft = Color3.fromRGB(191, 92, 161),
		AccentGlow = Color3.fromRGB(255, 190, 235),
		SelectedTab = Color3.fromRGB(67, 37, 62),
		ActiveToggle = Color3.fromRGB(255, 154, 220),
		NotificationAccent = Color3.fromRGB(255, 190, 235),
		Text = Color3.fromRGB(255, 246, 253),
		MutedText = Color3.fromRGB(219, 179, 210),
		DimText = Color3.fromRGB(149, 103, 139),
		GlassTransparency = 0.055,
		PanelTransparency = 0.04,
		ShadowTransparency = 0.14,
		Hue = 0.89,
		Sat = 0.42,
		Value = 1,
		Description = 'black sakura panels with polished pink accent bloom'
	},
	['Void Blue'] = {
		Main = Color3.fromRGB(3, 5, 12),
		Surface = Color3.fromRGB(8, 11, 23),
		SurfaceAlt = Color3.fromRGB(14, 20, 39),
		SurfaceHigh = Color3.fromRGB(22, 32, 61),
		Border = Color3.fromRGB(50, 67, 112),
		Accent = Color3.fromRGB(94, 119, 255),
		AccentSoft = Color3.fromRGB(58, 72, 183),
		AccentGlow = Color3.fromRGB(129, 151, 255),
		SelectedTab = Color3.fromRGB(27, 36, 82),
		ActiveToggle = Color3.fromRGB(94, 119, 255),
		NotificationAccent = Color3.fromRGB(129, 151, 255),
		Text = Color3.fromRGB(241, 244, 255),
		MutedText = Color3.fromRGB(158, 168, 213),
		DimText = Color3.fromRGB(95, 104, 153),
		GlassTransparency = 0.055,
		PanelTransparency = 0.04,
		ShadowTransparency = 0.15,
		Hue = 0.65,
		Sat = 0.63,
		Value = 1,
		Description = 'deep void navy with electric periwinkle controls'
	},
	['Peach Cream'] = {
		Main = Color3.fromRGB(18, 10, 8),
		Surface = Color3.fromRGB(31, 18, 15),
		SurfaceAlt = Color3.fromRGB(49, 29, 24),
		SurfaceHigh = Color3.fromRGB(73, 45, 37),
		Border = Color3.fromRGB(139, 91, 75),
		Accent = Color3.fromRGB(255, 169, 134),
		AccentSoft = Color3.fromRGB(196, 103, 84),
		AccentGlow = Color3.fromRGB(255, 205, 176),
		SelectedTab = Color3.fromRGB(74, 44, 36),
		ActiveToggle = Color3.fromRGB(255, 169, 134),
		NotificationAccent = Color3.fromRGB(255, 205, 176),
		Text = Color3.fromRGB(255, 248, 243),
		MutedText = Color3.fromRGB(219, 185, 169),
		DimText = Color3.fromRGB(150, 111, 97),
		GlassTransparency = 0.05,
		PanelTransparency = 0.038,
		ShadowTransparency = 0.13,
		Hue = 0.04,
		Sat = 0.47,
		Value = 1,
		Description = 'warm peach cream accents on deep cocoa glass'
	},
	['Grape Soda'] = {
		Main = Color3.fromRGB(10, 6, 17),
		Surface = Color3.fromRGB(19, 12, 31),
		SurfaceAlt = Color3.fromRGB(32, 20, 50),
		SurfaceHigh = Color3.fromRGB(49, 33, 73),
		Border = Color3.fromRGB(101, 72, 145),
		Accent = Color3.fromRGB(151, 103, 255),
		AccentSoft = Color3.fromRGB(84, 190, 255),
		AccentGlow = Color3.fromRGB(180, 143, 255),
		SelectedTab = Color3.fromRGB(50, 34, 81),
		ActiveToggle = Color3.fromRGB(151, 103, 255),
		NotificationAccent = Color3.fromRGB(84, 190, 255),
		Text = Color3.fromRGB(249, 245, 255),
		MutedText = Color3.fromRGB(194, 176, 223),
		DimText = Color3.fromRGB(128, 106, 159),
		GlassTransparency = 0.06,
		PanelTransparency = 0.045,
		ShadowTransparency = 0.15,
		Hue = 0.72,
		Sat = 0.60,
		Value = 1,
		Description = 'playful purple and blue while still feeling polished'
	},
	['Cherry Cola'] = {
		Main = Color3.fromRGB(13, 5, 5),
		Surface = Color3.fromRGB(23, 10, 10),
		SurfaceAlt = Color3.fromRGB(38, 18, 17),
		SurfaceHigh = Color3.fromRGB(58, 31, 29),
		Border = Color3.fromRGB(105, 64, 56),
		Accent = Color3.fromRGB(218, 63, 70),
		AccentSoft = Color3.fromRGB(132, 77, 48),
		AccentGlow = Color3.fromRGB(255, 119, 116),
		SelectedTab = Color3.fromRGB(60, 29, 28),
		ActiveToggle = Color3.fromRGB(218, 63, 70),
		NotificationAccent = Color3.fromRGB(255, 119, 116),
		Text = Color3.fromRGB(255, 246, 244),
		MutedText = Color3.fromRGB(207, 163, 154),
		DimText = Color3.fromRGB(139, 99, 91),
		GlassTransparency = 0.045,
		PanelTransparency = 0.035,
		ShadowTransparency = 0.12,
		Hue = 0.99,
		Sat = 0.64,
		Value = 0.86,
		Description = 'dark cherry red with cola-toned premium depth'
	},
	['Rainbow'] = {
		Main = Color3.fromRGB(5, 6, 10),
		Surface = Color3.fromRGB(10, 12, 18),
		SurfaceAlt = Color3.fromRGB(18, 21, 31),
		SurfaceHigh = Color3.fromRGB(28, 31, 47),
		Border = Color3.fromRGB(80, 88, 119),
		Accent = Color3.fromRGB(255, 111, 189),
		AccentSoft = Color3.fromRGB(111, 176, 255),
		AccentGlow = Color3.fromRGB(156, 132, 255),
		SelectedTab = Color3.fromRGB(55, 38, 82),
		ActiveToggle = Color3.fromRGB(255, 111, 189),
		NotificationAccent = Color3.fromRGB(111, 176, 255),
		Text = Color3.fromRGB(248, 250, 255),
		MutedText = Color3.fromRGB(177, 185, 210),
		DimText = Color3.fromRGB(111, 119, 151),
		GlassTransparency = 0.065,
		PanelTransparency = 0.052,
		ShadowTransparency = 0.15,
		Hue = 0.91,
		Sat = 0.56,
		Value = 1,
		Description = 'static rainbow glass with pink, blue, gold, and violet accents'
	},
}

local themePresets = {}
local function loadThemePresetFromSource(presetName, allowRemote)
	local fileName = themePresetFiles[presetName]
	if not fileName then return nil end
	local function trySource(source)
		if type(source) ~= 'string' or source == '' then return nil end
		local loader = loadstring or load
		if not loader then return nil end
		local ok, result = pcall(function()
			local chunk = loader(source)
			return type(chunk) == 'function' and chunk() or nil
		end)
		return ok and type(result) == 'table' and result or nil
	end
	if isfile and readfile then
		for _, localPath in {'vape/themes/'..fileName, 'themes/'..fileName} do
			local ok, source = pcall(function()
				return isfile(localPath) and readfile(localPath) or nil
			end)
			local loaded = ok and trySource(source)
			if loaded then return loaded end
		end
	end
	if allowRemote ~= false and game and game.HttpGet then
		local ok, source = pcall(function()
			return game:HttpGet('https://raw.githubusercontent.com/VapeSilentware/vapesilentware/main/themes/'..fileName, true)
		end)
		local loaded = ok and trySource(source)
		if loaded then return loaded end
	end
	return nil
end

local function getThemePreset(presetName, allowRemote)
	if themePresets[presetName] then return themePresets[presetName] end
	local loaded = loadThemePresetFromSource(presetName, allowRemote)
	local fallback = embeddedThemePresets[presetName] or embeddedThemePresets['Emerald Noir']
	themePresets[presetName] = loaded or fallback
	return themePresets[presetName]
end


local themePresetNames = {'Emerald Noir', 'Cotton Candy', 'Sapphire Night', 'Royal Amethyst', 'Rose Quartz', 'Arctic Chrome', 'Solar Flare', 'Crimson Velvet', 'Cyberpunk Bloom', 'Ocean Glass', 'Ghost Lavender', 'Golden Hour', 'Monochrome Ice', 'Sakura Noir', 'Void Blue', 'Peach Cream', 'Grape Soda', 'Cherry Cola', 'Rainbow'}
local allowedThemePresets = {}
for _, themeName in themePresetNames do allowedThemePresets[themeName] = true end

local function applyThemeToPalette(presetName)
	if not allowedThemePresets[presetName] then presetName = 'Emerald Noir' end
	local preset = getThemePreset(presetName, true) or getThemePreset('Emerald Noir', false)
	for key, value in pairs(preset) do
		if uipallet[key] ~= nil and (typeof(value) == 'Color3' or type(value) == 'number') then
			uipallet[key] = value
		end
	end
	uipallet.Success = preset.Accent or uipallet.Success
	uipallet.AccentGlow = preset.AccentGlow or preset.Accent or uipallet.AccentGlow
	uipallet.SelectedTab = preset.SelectedTab or uipallet.SelectedTab
	uipallet.ActiveToggle = preset.ActiveToggle or preset.Accent or uipallet.ActiveToggle
	uipallet.NotificationAccent = preset.NotificationAccent or preset.Accent or uipallet.NotificationAccent
	mainapi.ThemePreset = presetName
	mainapi.RainbowTheme = preset.IsRainbow == true
	mainapi.GUIColor.Rainbow = false
	mainapi.GUIColor.Hue = preset.Hue or mainapi.GUIColor.Hue
	mainapi.GUIColor.Sat = preset.Sat or mainapi.GUIColor.Sat
	mainapi.GUIColor.Value = preset.Value or mainapi.GUIColor.Value
	return preset
end

pcall(function()
	if isfile and isfile('vape/SilentwareTheme.txt') then
		local savedTheme = tostring(readfile('vape/SilentwareTheme.txt') or ''):gsub('^%s+', ''):gsub('%s+$', '')
		if allowedThemePresets[savedTheme] and getThemePreset(savedTheme, false) then mainapi.ThemePreset = savedTheme end
	end
end)
applyThemeToPalette(mainapi.ThemePreset)

local function isThemePreviewObject(obj)
	local parent = obj
	while parent do
		if parent.Name and tostring(parent.Name):find('ThemeCard') then return true end
		parent = parent.Parent
	end
	return false
end



local function safeZIndex(obj)
	local ok, z = pcall(function()
		if obj and obj:IsA('GuiObject') then return obj.ZIndex end
		return nil
	end)
	return ok and z or nil
end

local function isSettingsPaneObject(obj)
	local parent = obj
	while parent do
		if parent.Name == 'Children' and parent.Parent and (safeZIndex(parent.Parent) or 0) >= 32 then return true end
		if (safeZIndex(parent) or 0) >= 32 and parent.Name ~= 'SettingsFocusScrim' then return true end
		parent = parent.Parent
	end
	return false
end

local function getSilentwareRole(obj)
	local ok, role = pcall(function()
		return obj and obj.GetAttribute and obj:GetAttribute('SilentwareRole')
	end)
	return ok and role or nil
end

local function styleManagedStroke(parent, strokeColor, transparency)
	local stroke = parent and parent:FindFirstChildOfClass('UIStroke')
	if stroke then
		stroke.Color = strokeColor or uipallet.Border
		if transparency ~= nil then stroke.Transparency = transparency end
	end
end

local function restyleControlObject(obj)
	if not obj or not obj.Parent or isThemePreviewObject(obj) then return end
	local accent = getAccentColor()
	local role = getSilentwareRole(obj)
	if obj:IsA('ScrollingFrame') then
		obj.ScrollBarImageColor3 = uipallet.Accent
		if obj.Name == 'Children' and obj.Parent and (safeZIndex(obj.Parent) or 0) >= 32 then
			obj.BackgroundColor3 = uipallet.Surface
		end
	elseif obj:IsA('TextLabel') then
		if role == 'TierLock' then
			obj.BackgroundColor3 = color.Light(uipallet.Main, 0.1)
			obj.TextColor3 = uipallet.Accent
			styleManagedStroke(obj, uipallet.Accent, 0.44)
		elseif obj.Name == 'AccessTierPill' then
			obj.BackgroundColor3 = color.Light(uipallet.Main, 0.08)
			obj.TextColor3 = uipallet.Accent
			styleManagedStroke(obj, uipallet.Accent, 0.42)
		elseif obj.Name == 'VapeLogo' then
			obj.TextColor3 = uipallet.Text
		elseif obj.Name == 'Version' or obj.Name == 'Subtitle' or obj.Name == 'Description' or obj.Name == 'Items' then
			obj.TextColor3 = uipallet.MutedText
		else
			obj.TextColor3 = obj.TextTransparency < 1 and uipallet.Text or obj.TextColor3
		end
		if obj.BackgroundTransparency < 1 and role ~= 'TierLock' and obj.Name ~= 'AccessTierPill' then
			obj.BackgroundColor3 = color.Light(uipallet.Surface, 0.018)
		end
	elseif obj:IsA('TextBox') then
		obj.TextColor3 = uipallet.Text
		obj.PlaceholderColor3 = uipallet.MutedText
	elseif obj:IsA('TextButton') then
		if role == 'SettingsNavButton' then
			obj.BackgroundColor3 = uipallet.SurfaceAlt
			obj.BackgroundTransparency = 0.08
			if obj.Text ~= '' and obj.TextTransparency < 1 then obj.TextColor3 = color.Dark(uipallet.Text, 0.12) end
			styleManagedStroke(obj, uipallet.Border, 0.58)
		elseif role == 'SettingsPane' or role == 'SettingsRoot' then
			obj.BackgroundColor3 = uipallet.Surface
			obj.BackgroundTransparency = math.clamp((uipallet.PanelTransparency or 0.03) + 0.01, 0.025, 0.12)
			styleManagedStroke(obj, uipallet.Border, 0.26)
		elseif obj.Name == 'Dropdown' or obj.Name == 'TextList' then
			obj.BackgroundColor3 = uipallet.Surface
		elseif obj.Name:find('Button') or obj.Name:find('Dropdown') or obj.Name:find('TextBox') or obj.Name:find('Toggle') or obj.Name:find('Slider') or obj.Name:find('TextList') then
			obj.BackgroundColor3 = color.Dark(uipallet.Surface, 0.01)
		elseif (safeZIndex(obj) or 0) >= 32 then
			obj.BackgroundColor3 = uipallet.Surface
		end
		if obj.Text ~= '' and obj.TextTransparency < 1 then
			obj.TextColor3 = uipallet.Text
		end
	elseif obj:IsA('Frame') then
		if role == 'SettingsDivider' or obj.Name == 'Divider' then
			obj.BackgroundColor3 = uipallet.Border
		elseif role == 'SettingsCard' then
			obj.BackgroundColor3 = uipallet.SurfaceAlt
			styleManagedStroke(obj, uipallet.Border, 0.58)
		elseif obj.Name == 'PremiumMainWindow' then
			obj.BackgroundColor3 = uipallet.Surface
		elseif obj.Name == 'Sidebar' then
			obj.BackgroundColor3 = color.Light(uipallet.Main, 0.015)
		elseif obj.Name == 'Content' then
			obj.BackgroundColor3 = color.Light(uipallet.Main, 0.012)
		elseif obj.Name == 'SettingsFocusScrim' then
			obj.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
		elseif obj.Name == 'BKG' or obj.Name == 'Card' or obj.Name == 'CardSurface' or obj.Name == 'Overlays' or obj.Name == 'OverlaysWindow' then
			obj.BackgroundColor3 = uipallet.SurfaceAlt
		elseif obj.Name == 'Knob' then
			obj.BackgroundColor3 = color.Light(uipallet.Main, 0.12)
		elseif obj.Name == 'Slider' then
			obj.BackgroundColor3 = color.Light(uipallet.Main, 0.08)
		elseif obj.Name == 'AccentLine' or obj.Name == 'AccentBar' or obj.Name == 'InnerAccentGlow' or obj.Name == 'Fill' or obj.Name == 'MiniAccent' or obj.Name == 'SelectionPip' then
			obj.BackgroundColor3 = accent
		elseif isSettingsPaneObject(obj) then
			obj.BackgroundColor3 = uipallet.Surface
		end
	elseif obj:IsA('ImageLabel') or obj:IsA('ImageButton') then
		if obj.Name == 'Dots' or role == 'ModuleDots' then
			obj.ImageColor3 = uipallet.Accent
		elseif role == 'SettingsArrow' then
			obj.ImageColor3 = uipallet.Accent
		elseif obj.Name == 'SettingsIcon' or obj.Name == 'OverlaysButtonIcon' or obj.Name == 'OverlayMenuIcon' or obj.Name == 'BindIcon' or obj.Name:find('Glow') or obj.Name:find('Accent') then
			obj.ImageColor3 = uipallet.AccentGlow or accent
		elseif obj.Name == 'Arrow' or obj.Name == 'Expand' or obj.Name == 'Back' then
			obj.ImageColor3 = uipallet.MutedText
		end
	elseif obj:IsA('UIStroke') then
		local parentRole = getSilentwareRole(obj.Parent)
		if parentRole == 'TierLock' or obj.Name == 'GlowStroke' or (obj.Parent and (obj.Parent.Name:find('Pill') or obj.Parent.Name:find('Accent') or obj.Parent.Name:find('Tier'))) then
			obj.Color = uipallet.Accent
		else
			obj.Color = uipallet.Border
		end
	end
end

local function repaintEveryControl()
	if notifications then
		for _, obj in notifications:GetDescendants() do
			restyleControlObject(obj)
		end
	end
	if gui then
		for _, obj in gui:GetDescendants() do
			restyleControlObject(obj)
		end
	end
	if mainapi.SettingsScrim then
		mainapi.SettingsScrim.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
	end
	if mainapi.GlassBackdrop then
		mainapi.GlassBackdrop.BackgroundColor3 = uipallet.Main
		mainapi.GlassBackdrop.BackgroundTransparency = math.clamp((uipallet.GlassTransparency or 0.08) + 0.55, 0.55, 0.82)
	end
end

local function makeRainbowSequence()
	return ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 82, 153)),
		ColorSequenceKeypoint.new(0.18, Color3.fromRGB(255, 183, 77)),
		ColorSequenceKeypoint.new(0.34, Color3.fromRGB(255, 239, 96)),
		ColorSequenceKeypoint.new(0.52, Color3.fromRGB(77, 238, 166)),
		ColorSequenceKeypoint.new(0.70, Color3.fromRGB(91, 173, 255)),
		ColorSequenceKeypoint.new(0.86, Color3.fromRGB(183, 111, 255)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 82, 153))
	})
end

local function setupRainbowDecor()
	mainapi.RainbowDecor = mainapi.RainbowDecor or {}
	local function ensureGradient(obj, name)
		if not obj then return end
		local gradient = obj:FindFirstChild(name)
		if not gradient then
			gradient = Instance.new('UIGradient')
			gradient.Name = name
			gradient.Parent = obj
		end
		gradient.Color = makeRainbowSequence()
		gradient.Rotation = gradient.Rotation or 0
		table.insert(mainapi.RainbowDecor, gradient)
		return gradient
	end
	table.clear(mainapi.RainbowDecor)
	ensureGradient(mainapi.PremiumShell, 'RainbowShellGradient')
	ensureGradient(mainapi.PremiumTitle, 'RainbowTitleGradient')
	ensureGradient(mainapi.AccessTierPill, 'RainbowTierGradient')
	ensureGradient(mainapi.PremiumGlow, 'RainbowGlowGradient')
end

local function clearRainbowDecor()
	if gui then
		for _, obj in gui:GetDescendants() do
			if obj:IsA('UIGradient') and tostring(obj.Name):find('Rainbow') then
				obj:Destroy()
			end
		end
	end
	mainapi.RainbowDecor = {}
end


local function repaintThemePreviewCards()
	if not mainapi.ThemePreviewCards then return end
	for _, cardInfo in mainapi.ThemePreviewCards do
		local preset = getThemePreset(cardInfo.PresetName, false)
		if preset then
			if cardInfo.Surface then cardInfo.Surface.BackgroundColor3 = preset.SurfaceAlt or uipallet.SurfaceAlt end
			if cardInfo.Swatch then cardInfo.Swatch.BackgroundColor3 = preset.Accent or uipallet.Accent end
			if cardInfo.Glow then
				cardInfo.Glow.ImageColor3 = preset.AccentGlow or preset.Accent or uipallet.Accent
			end
			if cardInfo.Title then cardInfo.Title.TextColor3 = preset.Text or uipallet.Text end
			if cardInfo.Description then cardInfo.Description.TextColor3 = preset.MutedText or uipallet.MutedText end
			if cardInfo.MiniA then cardInfo.MiniA.BackgroundColor3 = preset.SurfaceHigh or uipallet.SurfaceHigh end
			if cardInfo.MiniB then cardInfo.MiniB.BackgroundColor3 = preset.Accent or uipallet.Accent end
		end
	end
end

local function refreshPremiumTheme()
	local accent = getAccentColor()
	if mainapi.PremiumShell then mainapi.PremiumShell.BackgroundColor3 = uipallet.Surface end
	if mainapi.PremiumSidebar then mainapi.PremiumSidebar.BackgroundColor3 = color.Light(uipallet.Main, 0.015) end
	if mainapi.PremiumContent then mainapi.PremiumContent.BackgroundColor3 = color.Light(uipallet.Main, 0.012) end
	if mainapi.PremiumTitleGlow then
		mainapi.PremiumTitleGlow.TextColor3 = uipallet.AccentGlow or uipallet.Accent
		mainapi.PremiumTitleGlow.TextTransparency = 0.78
	end
	if mainapi.PremiumGlow then
		mainapi.PremiumGlow.ImageColor3 = uipallet.AccentGlow or accent
		mainapi.PremiumGlow.ImageTransparency = 0.74
	end
	if mainapi.PremiumShadow then mainapi.PremiumShadow.ImageTransparency = uipallet.ShadowTransparency or 0.15 end
	if notifications then
		for _, obj in notifications:GetDescendants() do
			if obj:IsA('TextLabel') or obj:IsA('TextButton') or obj:IsA('TextBox') then
				obj.TextColor3 = uipallet.Text
			end
		end
	end
	if gui then
		for _, obj in gui:GetDescendants() do
			if not isThemePreviewObject(obj) then
				if obj:IsA('UIStroke') then
					if obj.Color ~= accent then obj.Color = uipallet.Border end
				elseif obj:IsA('TextLabel') or obj:IsA('TextButton') or obj:IsA('TextBox') then
					if obj.Name == 'Version' or obj.Name == 'Subtitle' then
						obj.TextColor3 = uipallet.MutedText
					elseif obj.TextTransparency < 1 then
						obj.TextColor3 = uipallet.Text
					end
				elseif obj:IsA('ImageLabel') or obj:IsA('ImageButton') then
					if obj.Name:find('Glow') or obj.Name:find('Accent') then obj.ImageColor3 = accent end
				elseif obj:IsA('Frame') then
					if obj.Name == 'AccentLine' or obj.Name:find('Accent') or obj.Name == 'Fill' then
						obj.BackgroundColor3 = accent
					end
				end
			end
		end
	end
	for _, category in pairs(mainapi.Categories) do
		if category.Button and category.Button.ApplyState then
			pcall(function() category.Button.ApplyState(category.Button.Enabled) end)
		end
		if category.Object and category.Object:IsA('GuiObject') then
			pcall(function() category.Object.BackgroundColor3 = color.Light(uipallet.Main, 0.012) end)
		end
	end
	for _, moduleapi in pairs(mainapi.Modules) do
		if type(moduleapi.ApplyAccessState) == 'function' then
			pcall(function() moduleapi:ApplyAccessState() end)
		end
	end
	if gui then
		for _, obj in gui:GetDescendants() do
			if not isThemePreviewObject(obj) then
				if obj:IsA('ScrollingFrame') then
					obj.ScrollBarImageColor3 = uipallet.Accent
				elseif obj:IsA('UIStroke') and obj.Name ~= 'RainbowManagedStroke' then
					if obj.Parent and (obj.Parent.Name:find('Pill') or obj.Parent.Name:find('Accent') or obj.Parent.Name:find('Status')) then
						obj.Color = uipallet.Accent
					else
						obj.Color = uipallet.Border
					end
				elseif obj:IsA('Frame') then
					if obj.Name == 'InnerAccentGlow' or obj.Name == 'AccentBar' or obj.Name == 'AccentLine' or obj.Name == 'Fill' or obj.Name == 'MiniAccent' or obj.Name == 'SelectionPip' then
						obj.BackgroundColor3 = uipallet.Accent
					elseif obj.Name == 'PremiumMainWindow' then
						obj.BackgroundColor3 = uipallet.Surface
					elseif obj.Name == 'Sidebar' or obj.Name == 'Content' then
						obj.BackgroundColor3 = color.Light(uipallet.Main, obj.Name == 'Sidebar' and 0.015 or 0.012)
					end
				elseif obj:IsA('ImageLabel') or obj:IsA('ImageButton') then
					if obj.Name:find('Glow') or obj.Name:find('Accent') then
						obj.ImageColor3 = uipallet.AccentGlow or uipallet.Accent
					end
				end
			end
		end
	end
	if gui then
		for _, obj in gui:GetDescendants() do
			if not isThemePreviewObject(obj) then
				if obj:IsA('ImageLabel') or obj:IsA('ImageButton') then
					if obj.Name == 'SettingsIcon' or obj.Name == 'OverlaysButtonIcon' or obj.Name == 'OverlayMenuIcon' or obj.Name == 'BindIcon' then
						obj.ImageColor3 = uipallet.Accent
					end
				elseif obj:IsA('TextButton') then
					if obj.Name == 'SettingsButton' then
						obj.BackgroundColor3 = uipallet.SurfaceAlt
						local st = obj:FindFirstChildOfClass('UIStroke')
						if st then st.Color = uipallet.Accent; st.Transparency = 0.48 end
					elseif obj.Name == 'RebindGuiButton' then
						obj.BackgroundColor3 = uipallet.SurfaceAlt
						obj.TextColor3 = uipallet.Text
						local st = obj:FindFirstChildOfClass('UIStroke')
						if st then st.Color = uipallet.Border; st.Transparency = 0.52 end
					end
				elseif obj:IsA('Frame') then
					if obj.Name == 'Overlays' or obj.Name == 'OverlaysWindow' then
						obj.BackgroundColor3 = uipallet.Surface
						local st = obj:FindFirstChildOfClass('UIStroke')
						if st then st.Color = uipallet.Border end
					elseif obj.Name == 'ShadowCore' then
						obj.BackgroundTransparency = math.clamp(uipallet.ShadowTransparency + 0.72, 0.82, 0.95)
					end
				elseif obj:IsA('UIStroke') and obj.Name == 'GlowStroke' then
					obj.Color = uipallet.AccentGlow or uipallet.Accent
				end
			end
		end
	end
	for _, pane in pairs(mainapi.SettingsPanes or {}) do
		if type(pane.ApplyTheme) == 'function' then pcall(function() pane:ApplyTheme() end) end
	end
	repaintThemePreviewCards()
	repaintEveryControl()
	pcall(function() mainapi:UpdateGUI(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value, true) end)
end

local function refreshRainbowThemeFast()
	return
end

function mainapi:ApplyThemePreset(presetName)
	local preset = applyThemeToPalette(presetName)
	if mainapi.RainbowTheme then
		setupRainbowDecor()
	else
		clearRainbowDecor()
	end
	refreshPremiumTheme()
	pcall(function() mainapi:UpdateGUI(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value, true) end)
	for _, pane in pairs(mainapi.SettingsPanes or {}) do
		if type(pane.ApplyTheme) == 'function' then pcall(function() pane:ApplyTheme() end) end
	end
	pcall(function() mainapi:RefreshAccessLocks() end)
	repaintEveryControl()
	repaintThemePreviewCards()
	task.defer(function()
		for _, pane in pairs(mainapi.SettingsPanes or {}) do
			if type(pane.ApplyTheme) == 'function' then pcall(function() pane:ApplyTheme() end) end
		end
		pcall(function() mainapi:RefreshAccessLocks() end)
		repaintEveryControl()
		repaintThemePreviewCards()
	end)
	pcall(function()
		if writefile then writefile('vape/SilentwareTheme.txt', tostring(presetName)) end
	end)
	if self.CreateNotification then
		self:CreateNotification('Theme applied', '', 3)
	end
	return preset
end

local function accessCanUseModule(category, moduleName)
	local currentAccess = shared.SilentwareAccess or mainapi.Access or access
	if type(currentAccess) == 'table' and type(currentAccess.CanUseModule) == 'function' then
		local ok, allowed, tier, level = pcall(function()
			local a, b, c = currentAccess:CanUseModule(category, moduleName)
			return a, b, c
		end)
		if ok then return allowed, tier, level end
	end
	return true, 'free', 0
end

local getcustomassets = {
	['vape/assets/add.png'] = 'rbxassetid://14368300605',
	['vape/assets/alert.png'] = 'rbxassetid://14368301329',
	['vape/assets/allowedicon.png'] = 'rbxassetid://14368302000',
	['vape/assets/allowedtab.png'] = 'rbxassetid://14368302875',
	['vape/assets/arrowmodule.png'] = 'rbxassetid://14473354880',
	['vape/assets/back.png'] = 'rbxassetid://14368303894',
	['vape/assets/bind.png'] = 'rbxassetid://14368304734',
	['vape/assets/bindbkg.png'] = 'rbxassetid://14368305655',
	['vape/assets/blatanticon.png'] = 'rbxassetid://14368306745',
	['vape/assets/blockedicon.png'] = 'rbxassetid://14385669108',
	['vape/assets/blockedtab.png'] = 'rbxassetid://14385672881',
	['vape/assets/blur.png'] = 'rbxassetid://14898786664',
	['vape/assets/blurnotif.png'] = 'rbxassetid://16738720137',
	['vape/assets/close.png'] = 'rbxassetid://14368309446',
	['vape/assets/closemini.png'] = 'rbxassetid://14368310467',
	['vape/assets/colorpreview.png'] = 'rbxassetid://14368311578',
	['vape/assets/combaticon.png'] = 'rbxassetid://14368312652',
	['vape/assets/customsettings.png'] = 'rbxassetid://14403726449',
	['vape/assets/dots.png'] = 'rbxassetid://14368314459',
	['vape/assets/edit.png'] = 'rbxassetid://14368315443',
	['vape/assets/expandright.png'] = 'rbxassetid://14368316544',
	['vape/assets/expandup.png'] = 'rbxassetid://14368317595',
	['vape/assets/friendstab.png'] = 'rbxassetid://14397462778',
	['vape/assets/guisettings.png'] = 'rbxassetid://14368318994',
	['vape/assets/guislider.png'] = 'rbxassetid://14368320020',
	['vape/assets/guisliderrain.png'] = 'rbxassetid://14368321228',
	['vape/assets/guiv4.png'] = 'rbxassetid://14368322199',
	['vape/assets/guivape.png'] = 'rbxassetid://14657521312',
	['vape/assets/info.png'] = 'rbxassetid://14368324807',
	['vape/assets/inventoryicon.png'] = 'rbxassetid://14928011633',
	['vape/assets/legit.png'] = 'rbxassetid://14425650534',
	['vape/assets/legittab.png'] = 'rbxassetid://14426740825',
	['vape/assets/miniicon.png'] = 'rbxassetid://14368326029',
	['vape/assets/notification.png'] = 'rbxassetid://16738721069',
	['vape/assets/overlaysicon.png'] = 'rbxassetid://14368339581',
	['vape/assets/overlaystab.png'] = 'rbxassetid://14397380433',
	['vape/assets/pin.png'] = 'rbxassetid://14368342301',
	['vape/assets/profilesicon.png'] = 'rbxassetid://14397465323',
	['vape/assets/radaricon.png'] = 'rbxassetid://14368343291',
	['vape/assets/rainbow_1.png'] = 'rbxassetid://14368344374',
	['vape/assets/rainbow_2.png'] = 'rbxassetid://14368345149',
	['vape/assets/rainbow_3.png'] = 'rbxassetid://14368345840',
	['vape/assets/rainbow_4.png'] = 'rbxassetid://14368346696',
	['vape/assets/range.png'] = 'rbxassetid://14368347435',
	['vape/assets/rangearrow.png'] = 'rbxassetid://14368348640',
	['vape/assets/rendericon.png'] = 'rbxassetid://14368350193',
	['vape/assets/rendertab.png'] = 'rbxassetid://14397373458',
	['vape/assets/search.png'] = 'rbxassetid://14425646684',
	['vape/assets/expandicon.png'] = 'rbxassetid://14368353032',
	['vape/assets/targetinfoicon.png'] = 'rbxassetid://14368354234',
	['vape/assets/targetnpc1.png'] = 'rbxassetid://14497400332',
	['vape/assets/targetnpc2.png'] = 'rbxassetid://14497402744',
	['vape/assets/targetplayers1.png'] = 'rbxassetid://14497396015',
	['vape/assets/targetplayers2.png'] = 'rbxassetid://14497397862',
	['vape/assets/targetstab.png'] = 'rbxassetid://14497393895',
	['vape/assets/textguiicon.png'] = 'rbxassetid://14368355456',
	['vape/assets/textv4.png'] = 'rbxassetid://14368357095',
	['vape/assets/textvape.png'] = 'rbxassetid://14368358200',
	['vape/assets/utilityicon.png'] = 'rbxassetid://14368359107',
	['vape/assets/vape.png'] = 'rbxassetid://14373395239',
	['vape/assets/warning.png'] = 'rbxassetid://14368361552',
	['vape/assets/worldicon.png'] = 'rbxassetid://14368362492'
}

local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)
	return suc and res ~= nil and res ~= ''
end

local getfontsize = function(text, size, font)
	fontsize.Text = text
	fontsize.Size = size
	if typeof(font) == 'Font' then
		fontsize.Font = font
	end
	return textService:GetTextBoundsAsync(fontsize)
end

local function addBlur(parent, notif)
	local blur = Instance.new('ImageLabel')
	blur.Name = 'Blur'
	blur.Size = UDim2.new(1, 89, 1, 52)
	blur.Position = UDim2.fromOffset(-48, -31)
	blur.BackgroundTransparency = 1
	blur.Image = getcustomasset('vape/assets/'..(notif and 'blurnotif' or 'blur')..'.png')
	blur.ScaleType = Enum.ScaleType.Slice
	blur.SliceCenter = Rect.new(52, 31, 261, 502)
	blur.Parent = parent

	return blur
end

local function addCorner(parent, radius)
	local corner = Instance.new('UICorner')
	corner.CornerRadius = radius or UDim.new(0, 10)
	corner.Parent = parent

	return corner
end

local function addStroke(parent, strokeColor, thickness, transparency)
	local stroke = Instance.new('UIStroke')
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Color = strokeColor or uipallet.Border
	stroke.Thickness = thickness or 1
	stroke.Transparency = transparency == nil and 0.52 or transparency
	stroke.Parent = parent
	return stroke
end

local function styleShell(object, radius, strokeTransparency)
	addCorner(object, radius or UDim.new(0, 9))
	addStroke(object, uipallet.Border, 1, strokeTransparency == nil and 0.58 or strokeTransparency)
	object.BorderSizePixel = 0
	return object
end

local function styleListLayout(layout, padding)
	layout.Padding = UDim.new(0, padding or 4)
	return layout
end

function getAccentColor(hue, sat, val)
	return Color3.fromHSV(hue or mainapi.GUIColor.Hue, sat or mainapi.GUIColor.Sat, val or mainapi.GUIColor.Value)
end

local function addGlow(parent, name, transparency, sizePad)
	-- Code-only glow: no stretched image assets. The old image glow could render as
	-- giant translucent boxes in some executors, so this keeps the premium edge
	-- treatment without adding visible square artifacts.
	local glow = Instance.new('ImageLabel')
	glow.Name = name or 'Glow'
	glow.Size = UDim2.fromScale(1, 1)
	glow.Position = UDim2.fromOffset(0, 0)
	glow.BackgroundTransparency = 1
	glow.BorderSizePixel = 0
	glow.Image = ''
	glow.ImageColor3 = uipallet.AccentGlow or uipallet.Accent
	glow.ImageTransparency = 1
	glow.ZIndex = math.max((safeZIndex(parent) or 1) - 1, 0)
	glow.Parent = parent
	addCorner(glow, UDim.new(0, 16))
	local glowStroke = Instance.new('UIStroke')
	glowStroke.Name = 'GlowStroke'
	glowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	glowStroke.Color = uipallet.AccentGlow or uipallet.Accent
	glowStroke.Thickness = 1
	glowStroke.Transparency = transparency == nil and 0.74 or math.clamp(transparency, 0.38, 0.92)
	glowStroke.Parent = glow
	return glow
end

local function addShadow(parent, name, transparency, sizePad, offsetY)
	-- Code-only shadow: intentionally tight to the object so it cannot show as
	-- a huge square panel around the whole GUI.
	local shadow = Instance.new('ImageLabel')
	shadow.Name = name or 'DropShadow'
	shadow.Size = UDim2.new(1, 10, 1, 10)
	shadow.Position = UDim2.fromOffset(-5, -3 + (offsetY or 5))
	shadow.BackgroundTransparency = 1
	shadow.BorderSizePixel = 0
	shadow.Image = ''
	shadow.ImageColor3 = Color3.new(0, 0, 0)
	shadow.ImageTransparency = 1
	shadow.ZIndex = math.max((safeZIndex(parent) or 1) - 2, 0)
	shadow.Parent = parent
	local shadowCore = Instance.new('Frame')
	shadowCore.Name = 'ShadowCore'
	shadowCore.Size = UDim2.fromScale(1, 1)
	shadowCore.Position = UDim2.fromOffset(0, 0)
	shadowCore.BackgroundColor3 = Color3.new(0, 0, 0)
	shadowCore.BackgroundTransparency = math.clamp(transparency == nil and 0.86 or math.max(transparency, 0.82), 0.78, 0.96)
	shadowCore.BorderSizePixel = 0
	shadowCore.ZIndex = shadow.ZIndex
	shadowCore.Parent = shadow
	addCorner(shadowCore, UDim.new(0, 18))
	return shadow
end

local function configureScroll(frame, barThickness, barTransparency)
	if not frame or not frame:IsA('ScrollingFrame') then return end
	frame.Active = true
	frame.ClipsDescendants = true
	frame.ScrollingDirection = Enum.ScrollingDirection.Y
	frame.CanvasSize = UDim2.fromOffset(0, 0)
	pcall(function() frame.AutomaticCanvasSize = Enum.AutomaticSize.Y end)
	frame.ScrollBarThickness = barThickness or 4
	frame.ScrollBarImageTransparency = barTransparency == nil and 0.45 or barTransparency
	frame.ScrollBarImageColor3 = uipallet.Accent
end

local function makePremiumWindowFrame(parent, name, size, position)
	local frame = Instance.new('Frame')
	frame.Name = name
	frame.Size = size
	frame.Position = position
	frame.BackgroundColor3 = uipallet.Surface
	frame.BackgroundTransparency = uipallet.GlassTransparency or 0.06
	frame.BorderSizePixel = 0
	frame.ClipsDescendants = false
	frame.Parent = parent
	addCorner(frame, UDim.new(0, 20))
	addStroke(frame, uipallet.Border, 1, 0.34)
	return frame
end

local function addSurfaceGradient(parent, topColor, bottomColor, rotation)
	local gradient = Instance.new('UIGradient')
	gradient.Rotation = rotation or 90
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, topColor or color.Light(uipallet.Surface, 0.035)),
		ColorSequenceKeypoint.new(1, bottomColor or uipallet.Main)
	})
	gradient.Parent = parent
	return gradient
end

local function createAmbientOrb(parent, name, size, position, transparency, zindex)
	local orb = Instance.new('Frame')
	orb.Name = name
	orb.Size = UDim2.fromOffset(size, size)
	orb.Position = position
	orb.BackgroundColor3 = uipallet.AccentGlow or uipallet.Accent
	orb.BackgroundTransparency = transparency or 0.9
	orb.BorderSizePixel = 0
	orb.ZIndex = zindex or 0
	orb.Parent = parent
	addCorner(orb, UDim.new(1, 0))
	local glow = addGlow(orb, name..'Glow', 0.32, math.floor(size * 1.9))
	glow.ImageColor3 = uipallet.AccentGlow or uipallet.Accent
	return orb, glow
end

local function stylePremiumAction(object, strokeTransparency)
	if not object then return end
	object.BackgroundColor3 = uipallet.SurfaceAlt
	object.BackgroundTransparency = object.BackgroundTransparency or 0.08
	object.BorderSizePixel = 0
	addCorner(object, UDim.new(0, 10))
	addStroke(object, uipallet.Border, 1, strokeTransparency or 0.58)
	return object
end

local function animatePremiumOpen()
	local shell = mainapi.PremiumShell
	if not shell then return end
	local shellscale = mainapi.PremiumScale
	if shellscale then
		shellscale.Scale = 0.965
	end
	shell.Position = UDim2.fromScale(0.5, 0.515)
	shell.BackgroundTransparency = 0.18
	if mainapi.PremiumGlow then
		mainapi.PremiumGlow.ImageTransparency = 0.88
	end
	if shellscale then
		tween:Tween(shellscale, uipallet.OpenTween, {Scale = 1})
	end
	tween:Tween(shell, uipallet.OpenTween, {
		Position = UDim2.fromScale(0.5, 0.5),
		BackgroundTransparency = 0.06
	})
	if mainapi.PremiumGlow then
		tween:Tween(mainapi.PremiumGlow, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			ImageTransparency = 0.74
		})
	end
end

local function createStartupLoader()
	if mainapi.PremiumStartupShown or not scaledgui then return end
	mainapi.PremiumStartupShown = true

	local loader = Instance.new('Frame')
	loader.Name = 'SilentwareStartupLoader'
	loader.Size = UDim2.fromScale(1, 1)
	loader.BackgroundColor3 = Color3.new(0, 0, 0)
	loader.BackgroundTransparency = 0.42
	loader.BorderSizePixel = 0
	loader.ZIndex = 80
	-- Parent the loader to the ScreenGui instead of the scaled container.
	-- The scaled container is intentionally larger than the viewport for UI scaling,
	-- which could show ugly semi-transparent square edges during startup.
	loader.Parent = gui or scaledgui

	local card = Instance.new('Frame')
	card.Name = 'LoaderCard'
	card.AnchorPoint = Vector2.new(0.5, 0.5)
	card.Position = UDim2.fromScale(0.5, 0.5)
	card.Size = UDim2.fromOffset(310, 152)
	card.BackgroundColor3 = uipallet.Surface
	card.BackgroundTransparency = 0.04
	card.BorderSizePixel = 0
	card.ZIndex = 81
	card.Parent = loader
	addCorner(card, UDim.new(0, 18))
	addStroke(card, uipallet.Border, 1, 0.34)
	addShadow(card, 'LoaderShadow', 0.18, 120, 12)
	local cardGlow = addGlow(card, 'LoaderGlow', 0.42, 86)
	cardGlow.ImageColor3 = uipallet.Accent

	local cardScale = Instance.new('UIScale')
	cardScale.Scale = 0.92
	cardScale.Parent = card

	local title = Instance.new('TextLabel')
	title.Name = 'Title'
	title.Size = UDim2.new(1, -42, 0, 28)
	title.Position = UDim2.fromOffset(22, 22)
	title.BackgroundTransparency = 1
	title.Text = 'Silentware'
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.TextColor3 = uipallet.Text
	title.TextSize = 21
	title.FontFace = uipallet.FontSemiBold
	title.ZIndex = 82
	title.Parent = card

	local dot = Instance.new('Frame')
	dot.Name = 'GlowDot'
	dot.Size = UDim2.fromOffset(8, 8)
	dot.Position = UDim2.fromOffset(134, 32)
	dot.BackgroundColor3 = uipallet.Accent
	dot.BorderSizePixel = 0
	dot.ZIndex = 83
	dot.Parent = card
	addCorner(dot, UDim.new(1, 0))
	local dotGlow = addGlow(dot, 'DotGlow', 0.2, 44)
	dotGlow.ImageColor3 = uipallet.Accent

	local sub = Instance.new('TextLabel')
	sub.Name = 'Subtext'
	sub.Size = UDim2.new(1, -44, 0, 18)
	sub.Position = UDim2.fromOffset(22, 52)
	sub.BackgroundTransparency = 1
	sub.Text = 'loading premium interface...'
	sub.TextXAlignment = Enum.TextXAlignment.Left
	sub.TextColor3 = uipallet.MutedText
	sub.TextSize = 12
	sub.FontFace = uipallet.Font
	sub.ZIndex = 82
	sub.Parent = card

	local bar = Instance.new('Frame')
	bar.Name = 'ProgressTrack'
	bar.Size = UDim2.new(1, -44, 0, 7)
	bar.Position = UDim2.fromOffset(22, 101)
	bar.BackgroundColor3 = color.Light(uipallet.Main, 0.07)
	bar.BorderSizePixel = 0
	bar.ZIndex = 82
	bar.Parent = card
	addCorner(bar, UDim.new(1, 0))
	addStroke(bar, uipallet.Border, 1, 0.68)

	local fill = Instance.new('Frame')
	fill.Name = 'Fill'
	fill.Size = UDim2.fromScale(0, 1)
	fill.BackgroundColor3 = uipallet.Accent
	fill.BorderSizePixel = 0
	fill.ZIndex = 83
	fill.Parent = bar
	addCorner(fill, UDim.new(1, 0))
	local fillGlow = addGlow(fill, 'ProgressGlow', 0.34, 42)
	fillGlow.ImageColor3 = uipallet.Accent

	local sweep = Instance.new('Frame')
	sweep.Name = 'Sweep'
	sweep.Size = UDim2.fromOffset(42, 2)
	sweep.Position = UDim2.fromOffset(22, 122)
	sweep.BackgroundColor3 = uipallet.Accent
	sweep.BackgroundTransparency = 0.22
	sweep.BorderSizePixel = 0
	sweep.ZIndex = 83
	sweep.Parent = card
	addCorner(sweep, UDim.new(1, 0))
	local sweepGlow = addGlow(sweep, 'SweepGlow', 0.42, 40)
	sweepGlow.ImageColor3 = uipallet.Accent

	tween:Tween(cardScale, TweenInfo.new(0.36, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Scale = 1})
	tween:Tween(loader, TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.36})
	tween:Tween(fill, TweenInfo.new(0.92, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.fromScale(1, 1)})
	tween:Tween(sweep, TweenInfo.new(0.92, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.fromOffset(246, 122), BackgroundTransparency = 0.58})

	task.spawn(function()
		repeat
			tween:Tween(dotGlow, TweenInfo.new(0.42, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0.08})
			task.wait(0.42)
			tween:Tween(dotGlow, TweenInfo.new(0.42, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0.48})
			task.wait(0.42)
		until not loader.Parent or mainapi.Loaded == nil
	end)

	task.delay(1.02, function()
		if mainapi.Loaded == nil then return end
		if clickgui and not clickgui.Visible then
			clickgui.Visible = true
		else
			animatePremiumOpen()
		end
		tween:Tween(cardScale, TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Scale = 0.96})
		tween:Tween(loader, TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
		task.wait(0.25)
		if loader.Parent then loader:Destroy() end
	end)
end

local function compatOption(optionapi)
	if type(optionapi) ~= 'table' then
		return optionapi
	end
	if type(optionapi.Change) ~= 'function' then
		optionapi.Change = function(self, value)
			if type(self.SetValue) == 'function' and value ~= nil and type(value) ~= 'table' then
				self:SetValue(value, true)
			end
		end
	end
	if type(optionapi.ToggleButton) ~= 'function' and type(optionapi.Toggle) == 'function' then
		optionapi.ToggleButton = function()
			optionapi:Toggle()
		end
	end
	return optionapi
end

local function addCloseButton(parent, offset)
	local close = Instance.new('ImageButton')
	close.Name = 'Close'
	close.Size = UDim2.fromOffset(24, 24)
	close.Position = UDim2.new(1, -35, 0, offset or 9)
	close.BackgroundColor3 = uipallet.SurfaceAlt
	close.BackgroundTransparency = 0.35
	close.AutoButtonColor = false
	close.Image = getcustomasset('vape/assets/close.png')
	close.ImageColor3 = color.Light(uipallet.Text, 0.2)
	close.ImageTransparency = 0.5
	close.Parent = parent
	addCorner(close, UDim.new(1, 0))
	addStroke(close, uipallet.Border, 1, 0.5)

	close.MouseEnter:Connect(function()
		close.ImageTransparency = 0.3
		tween:Tween(close, uipallet.Tween, {
			BackgroundTransparency = 0.2
		})
	end)
	close.MouseLeave:Connect(function()
		close.ImageTransparency = 0.5
		tween:Tween(close, uipallet.Tween, {
			BackgroundTransparency = 0.35
		})
	end)

	return close
end

local function addMaid(object)
	object.Connections = {}
	function object:Clean(callback)
		if typeof(callback) == 'Instance' then
			table.insert(self.Connections, {
				Disconnect = function()
					callback:ClearAllChildren()
					callback:Destroy()
				end
			})
		elseif type(callback) == 'function' then
			table.insert(self.Connections, {
				Disconnect = callback
			})
		else
			table.insert(self.Connections, callback)
		end
	end
end

local function addTooltip(gui, text)
	if not text then return end

	local function tooltipMoved(x, y)
		local right = x + 16 + tooltip.Size.X.Offset > (scale.Scale * 1920)
		tooltip.Position = UDim2.fromOffset(
			(right and x - (tooltip.Size.X.Offset * scale.Scale) - 16 or x + 16) / scale.Scale,
			((y + 11) - (tooltip.Size.Y.Offset / 2)) / scale.Scale
		)
		tooltip.Visible = toolblur.Visible
	end

	gui.MouseEnter:Connect(function(x, y)
		local tooltipSize = getfontsize(text, tooltip.TextSize, uipallet.Font)
		tooltip.Size = UDim2.fromOffset(tooltipSize.X + 10, tooltipSize.Y + 10)
		tooltip.Text = text
		tooltipMoved(x, y)
	end)
	gui.MouseMoved:Connect(tooltipMoved)
	gui.MouseLeave:Connect(function()
		tooltip.Visible = false
	end)
end

local function checkKeybinds(compare, target, key)
	if type(target) == 'table' then
		if table.find(target, key) then
			for i, v in target do
				if not table.find(compare, v) then
					return false
				end
			end
			return true
		end
	end

	return false
end

local function createDownloader(text)
	if mainapi.Loaded ~= true then
		local downloader = mainapi.Downloader
		if not downloader then
			downloader = Instance.new('TextLabel')
			downloader.Size = UDim2.new(1, 0, 0, 40)
			downloader.BackgroundTransparency = 1
			downloader.TextStrokeTransparency = 0
			downloader.TextSize = 20
			downloader.TextColor3 = Color3.new(1, 1, 1)
			downloader.FontFace = uipallet.Font
			downloader.Parent = mainapi.gui
			mainapi.Downloader = downloader
		end
		downloader.Text = 'Downloading '..text
	end
end

local function createMobileButton(buttonapi, position)
	if not inputService.TouchEnabled then return end
	local heldbutton = false
	local button = Instance.new('TextButton')
	button.Size = UDim2.fromOffset(40, 40)
	button.Position = UDim2.fromOffset(position.X, position.Y)
	button.AnchorPoint = Vector2.new(0.5, 0.5)
	button.BackgroundColor3 = buttonapi.Enabled and Color3.new(0, 0.7, 0) or Color3.new()
	button.BackgroundTransparency = 0.5
	button.Text = buttonapi.Name
	button.TextColor3 = Color3.new(1, 1, 1)
	button.TextScaled = true
	button.Font = Enum.Font.Gotham
	button.Parent = mainapi.gui
	local buttonconstraint = Instance.new('UITextSizeConstraint')
	buttonconstraint.MaxTextSize = 16
	buttonconstraint.Parent = button
	addCorner(button, UDim.new(1, 0))

	button.MouseButton1Down:Connect(function()
		heldbutton = true
		local holdtime, holdpos = tick(), inputService:GetMouseLocation()
		repeat
			heldbutton = (inputService:GetMouseLocation() - holdpos).Magnitude < 6
			task.wait()
		until (tick() - holdtime) > 1 or not heldbutton
		if heldbutton then
			buttonapi.Bind = {}
			button:Destroy()
		end
	end)
	button.MouseButton1Up:Connect(function()
		heldbutton = false
	end)
	button.MouseButton1Click:Connect(function()
		buttonapi:Toggle()
		button.BackgroundColor3 = buttonapi.Enabled and Color3.new(0, 0.7, 0) or Color3.new()
	end)

	buttonapi.Bind = {Button = button}
end

local function downloadFile(path, func)
	if not isfile(path) then
		--createDownloader(path)
		local suc, res = pcall(function()
			return game:HttpGet('https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/'..readfile('vape/profiles/commit.txt')..'/'..select(1, path:gsub('vape/', '')), true)
		end)
		if not suc or res == '404: Not Found' then
			error(res)
		end
		if path:find('.lua') then
			res = '--This watermark is used to delete the file if its cached, remove it to make the file persist after vape updates.\n'..res
		end
		writefile(path, res)
	end
	return (func or readfile)(path)
end

--[[getcustomasset = not inputService.TouchEnabled and assetfunction and function(path)
	return downloadFile(path, assetfunction)
end or function(path)
	return getcustomassets[path] or ''
end--]]
getcustomasset = function(path)
	local mapped = getcustomassets[path]
	if mapped then return mapped end
	if assetfunction and isfile and isfile(path) then
		local suc, res = pcall(function()
			return assetfunction(path)
		end)
		if suc and type(res) == 'string' and res ~= '' then
			return res
		end
	end
	return ''
end

local function getTableSize(tab)
	local ind = 0
	for _ in tab do ind += 1 end
	return ind
end

local function loopClean(tab)
	for i, v in tab do
		if type(v) == 'table' then
			loopClean(v)
		end
		tab[i] = nil
	end
end

local function loadJson(path)
	local suc, res = pcall(function()
		return httpService:JSONDecode(readfile(path))
	end)
	return suc and type(res) == 'table' and res or nil, res
end

local function makeDraggable(gui, window)
	gui.InputBegan:Connect(function(inputObj)
		if window and not window.Visible then return end
		if
			(inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
			and (inputObj.Position.Y - gui.AbsolutePosition.Y < 40 or window)
		then
			local dragPosition = Vector2.new(
				gui.AbsolutePosition.X - inputObj.Position.X,
				gui.AbsolutePosition.Y - inputObj.Position.Y + guiService:GetGuiInset().Y
			) / scale.Scale

			local changed = inputService.InputChanged:Connect(function(input)
				if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
					local position = input.Position
					if inputService:IsKeyDown(Enum.KeyCode.LeftShift) then
						dragPosition = (dragPosition // 3) * 3
						position = (position // 3) * 3
					end
					gui.Position = UDim2.fromOffset((position.X / scale.Scale) + dragPosition.X, (position.Y / scale.Scale) + dragPosition.Y)
				end
			end)

			local ended
			ended = inputObj.Changed:Connect(function()
				if inputObj.UserInputState == Enum.UserInputState.End then
					if changed then
						changed:Disconnect()
					end
					if ended then
						ended:Disconnect()
					end
				end
			end)
		end
	end)
end

local function randomString()
	local array = {}
	for i = 1, math.random(10, 100) do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

local function removeTags(str)
	str = str:gsub('<br%s*/>', '\n')
	return str:gsub('<[^<>]->', '')
end

do
	local res = isfile("vape/profiles/color.txt") and loadJson("vape/profiles/color.txt")
	if res then
		uipallet.Main = res.Main and Color3.fromRGB(unpack(res.Main)) or uipallet.Main
		uipallet.Text = res.Text and Color3.fromRGB(unpack(res.Text)) or uipallet.Text
		uipallet.Font = res.Font and Font.new(
			res.Font:find('rbxasset') and res.Font
			or string.format('rbxasset://fonts/families/%s.json', res.Font)
		) or uipallet.Font
		uipallet.FontSemiBold = Font.new(uipallet.Font.Family, Enum.FontWeight.SemiBold)
	end
	fontsize.Font = uipallet.Font
end

do
	function color.Dark(col, num)
		local h, s, v = col:ToHSV()
		return Color3.fromHSV(h, s, math.clamp(select(3, uipallet.Main:ToHSV()) > 0.5 and v + num or v - num, 0, 1))
	end

	function color.Light(col, num)
		local h, s, v = col:ToHSV()
		return Color3.fromHSV(h, s, math.clamp(select(3, uipallet.Main:ToHSV()) > 0.5 and v - num or v + num, 0, 1))
	end

	function mainapi:Color(h)
		local s = 0.75 + (0.15 * math.min(h / 0.03, 1))
		if h > 0.57 then
			s = 0.9 - (0.4 * math.min((h - 0.57) / 0.09, 1))
		end
		if h > 0.66 then
			s = 0.5 + (0.4 * math.min((h - 0.66) / 0.16, 1))
		end
		if h > 0.87 then
			s = 0.9 - (0.15 * math.min((h - 0.87) / 0.13, 1))
		end
		return h, s, 1
	end

	function mainapi:TextColor(h, s, v)
		if v >= 0.7 and (s < 0.6 or h > 0.04 and h < 0.56) then
			return Color3.new(0.19, 0.19, 0.19)
		end
		return Color3.new(1, 1, 1)
	end
end

do
	function tween:Tween(obj, tweeninfo, goal, tab)
		if obj == nil then return end
		tab = tab or self.tweens
		if tab[obj] then
			tab[obj]:Cancel()
		end

		local shouldTween = obj ~= nil and obj.Parent ~= nil
		if shouldTween and typeof(obj) == 'Instance' and obj:IsA('GuiObject') then
			shouldTween = obj.Visible
		end

		if shouldTween then
			tab[obj] = tweenService:Create(obj, tweeninfo, goal)
			tab[obj].Completed:Once(function()
				if tab then
					tab[obj] = nil
					tab = nil
				end
			end)
			tab[obj]:Play()
		else
			for i, v in goal do
				obj[i] = v
			end
		end
	end

	function tween:Cancel(obj)
		if self.tweens[obj] then
			self.tweens[obj]:Cancel()
			self.tweens[obj] = nil
		end
	end
end

mainapi.Libraries = {
	color = color,
	getcustomasset = getcustomasset,
	getfontsize = getfontsize,
	tween = tween,
	uipallet = uipallet,
}

local attemptedRestarts = {}
local function hookCF(func, settings)
	local function refreshTable(data)
		local seenTables = {}
	
		local function cleanTable(tbl)
			if seenTables[tbl] then
				return "[Cyclic Table]"
			end
			seenTables[tbl] = true
	
			local result = {}
			for key, value in pairs(tbl) do
				local keyType = typeof(key)
				local valueType = typeof(value)
	
				if keyType ~= "function" and keyType ~= "userdata" and keyType ~= "thread" then
					if valueType == "table" then
						result[key] = cleanTable(value)
					elseif valueType == "function" or valueType == "userdata" or valueType == "thread" then
						result[key] = "[Non-Serializable]"
					else
						result[key] = value
					end
				end
			end
			return result
		end
	
		if typeof(data) == "table" then
			return cleanTable(data)
		else
			return data
		end
	end
	if func == nil or type(func) ~= "function" then return function() end end
	local S_Name, S_Creation = "Not Specified", {}
	if settings ~= nil and type(settings) == "table" then
		S_Name = settings.Name and tostring(settings.Name) or S_Name
		S_Creation = settings and type(settings) == "table" and refreshTable(table.clone(settings)) or S_Creation
	end
	local settings = {}
	local old = func
	func = function(...)
		local args = {...}
		task.spawn(function()
			local suc, err = pcall(function()
				old(unpack(args))
			end)
			if (not suc) then 
				if shared.VoidDev then
					task.spawn(function()
						repeat task.wait() until errorNotification ~= nil and type(errorNotification) == "function"
						errorNotification("Silentware | "..tostring(S_Name), debug.traceback(tostring(err)), 10)
					end)
				end
				task.spawn(function()
					repeat task.wait() until errorNotification ~= nil and type(errorNotification) == "function"
					if S_Name ~= "Not Specified" then
						if attemptedRestarts[S_Name] then 
							errorNotification('Silentware | '..tostring(S_Name), "Restart failed!", 3)
							errorNotification("Silentware | "..tostring(S_Name), "There was an error with this module. If you can please send the\n SW_Error_Log.json in your workspace to silentdev#0 or discord.gg/silentware", 10)
						else
							errorNotification('Silentware | '..tostring(S_Name), "There was an error with this module. Attempting restart...", 3)
							attemptedRestarts[S_Name] = true
							local suc2, err2 = pcall(function() func(false) end)
							if suc2 then InfoNotification("Silentware | "..tostring(S_Name), "Restart successfull!", 3)
end
						end
					else
						errorNotification("Silentware | "..tostring(S_Name), "There was an error with this module. If you can please send the\n SW_Error_Log.json in your workspace to silentdev#0 or discord.gg/silentware", 10)
					end
				end)
				local errorLog = {
					Name = S_Name,
					CheatEngineMode = shared ~= nil and type(shared) == "table" and shared.CheatEngineMode,
					Response = tostring(err),
					Debug = debug.traceback(tostring(err)),
					--Creation = S_Creation,
					PlaceId = game.PlaceId,
					JobId = game.JobId
				}
				local main = {}
				if isfile('SW_Error_Log.json') then
					local res = loadJson('SW_Error_Log.json')
					main = res or main
				end
				main["LogInfo"] = {
					Version = "REWRITE",
					Executor = identifyexecutor and ({identifyexecutor()})[1] or "Unknown executor",
					CheatEngineMode = shared.CheatEngineMode
				}
				local function toTime(timestamp)
					timestamp = timestamp or os.time()
					local dateTable = os.date("*t", timestamp)
					local timeString = string.format("%02d:%02d:%02d", dateTable.hour, dateTable.min, dateTable.sec)
					return timeString
				end
				local function toDate(timestamp)
					timestamp = timestamp or os.time()
					local dateTable = os.date("*t", timestamp)
					local dateString = string.format("%02d/%02d/%02d", dateTable.day, dateTable.month, dateTable.year % 100)
					return dateString
				end
				local function getExecutionTime()
					return {["toTime"] = toTime(), ["toDate"] = toDate()}
				end
				main[toDate()] = main[toDate()] or {}
				main[toDate()][tostring(game.PlaceId).." | "..tostring(game.JobId)] = main[toDate()][tostring(game.PlaceId).." | "..tostring(game.JobId)] or {}
				main[toDate()][tostring(game.PlaceId).." | "..tostring(game.JobId)][S_Name] = main[toDate()][tostring(game.PlaceId).." | "..tostring(game.JobId)][S_Name] or {}
				table.insert(main[toDate()][tostring(game.PlaceId).." | "..tostring(game.JobId)][S_Name], {
					Time = getExecutionTime(),
					Data = errorLog
				})
				writefile('SW_Error_Log.json', game:GetService("HttpService"):JSONEncode(main))
				warn('---------------[ERROR LOG START]--------------')
				warn(game:GetService("HttpService"):JSONEncode(errorLog))
				warn('---------------[ERROR LOG END]--------------')
			end
		end)
	end
	return func
end

local components
components = {
	Button = function(optionsettings, children, api)
		optionsettings.Function = hookCF(optionsettings.Function, optionsettings)
		local optionapi = {
			Type = 'Button',
			Index = api and getTableSize(api.Options or {}) or 0
		}
		local button = Instance.new('TextButton')
		button.Name = optionsettings.Name..'Button'
		button.Size = UDim2.new(1, 0, 0, 40)
		button.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		button.BorderSizePixel = 0
		button.AutoButtonColor = false
		button.Visible = optionsettings.Visible == nil or optionsettings.Visible
		button.Text = ''
		button.Parent = children
		addTooltip(button, optionsettings.Tooltip)
		local bkg = Instance.new('Frame')
		bkg.Size = UDim2.new(1, -20, 1, -6)
		bkg.Position = UDim2.fromOffset(10, 3)
		bkg.BackgroundColor3 = uipallet.SurfaceAlt
		bkg.Parent = button
		styleShell(bkg, UDim.new(0, 10), 0.52)
		local label = Instance.new('TextLabel')
		label.Size = UDim2.new(1, -4, 1, -4)
		label.Position = UDim2.fromOffset(2, 2)
		label.BackgroundColor3 = color.Light(uipallet.Surface, 0.018)
		label.Text = optionsettings.Name
		label.TextColor3 = color.Dark(uipallet.Text, 0.08)
		label.TextSize = 13
		label.FontFace = uipallet.Font
		label.Parent = bkg
		addCorner(label, UDim.new(0, 7))
		optionsettings.Function = optionsettings.Function or function() end
		
		button.MouseEnter:Connect(function()
			tween:Tween(bkg, uipallet.Tween, {
				BackgroundColor3 = color.Light(uipallet.SurfaceAlt, 0.04)
			})
		end)
		button.MouseLeave:Connect(function()
			tween:Tween(bkg, uipallet.Tween, {
				BackgroundColor3 = uipallet.SurfaceAlt
			})
		end)
		button.MouseButton1Click:Connect(optionsettings.Function)
		optionapi.Object = button
		function optionapi:SetVisible(state)
			button.Visible = state == true
		end
		if api and api.Options then
			api.Options[optionsettings.Name] = optionapi
		end
		return compatOption(optionapi)
	end,
	ColorSlider = function(optionsettings, children, api)
		optionsettings.Function = hookCF(optionsettings.Function, optionsettings)
		local optionapi = {
			Type = 'ColorSlider',
			Hue = optionsettings.DefaultHue or 0.44,
			Sat = optionsettings.DefaultSat or 1,
			Value = optionsettings.DefaultValue or 1,
			Opacity = optionsettings.DefaultOpacity or 1,
			Rainbow = false,
			Index = 0
		}
		
		local function createSlider(name, gradientColor)
			local slider = Instance.new('TextButton')
			slider.Name = optionsettings.Name..'Slider'..name
			slider.Size = UDim2.new(1, 0, 0, 54)
			slider.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
			slider.BorderSizePixel = 0
			slider.AutoButtonColor = false
			slider.Visible = false
			slider.Text = ''
			slider.Parent = children
			local title = Instance.new('TextLabel')
			title.Name = 'Title'
			title.Size = UDim2.fromOffset(60, 30)
			title.Position = UDim2.fromOffset(10, 2)
			title.BackgroundTransparency = 1
			title.Text = name
			title.TextXAlignment = Enum.TextXAlignment.Left
			title.TextColor3 = color.Dark(uipallet.Text, 0.08)
			title.TextSize = 11
			title.FontFace = uipallet.Font
			title.Parent = slider
			local bkg = Instance.new('Frame')
			bkg.Name = 'Slider'
			bkg.Size = UDim2.new(1, -20, 0, 5)
			bkg.Position = UDim2.fromOffset(10, 39)
			bkg.BackgroundColor3 = Color3.new(1, 1, 1)
			bkg.BorderSizePixel = 0
			bkg.Parent = slider

		local gradient = Instance.new('UIGradient')
			gradient.Color = gradientColor
			gradient.Parent = bkg
			local fill = bkg:Clone()
			fill.Name = 'Fill'
			fill.Size = UDim2.fromScale(math.clamp(name == 'Saturation' and optionapi.Sat or name == 'Vibrance' and optionapi.Value or optionapi.Opacity, 0.04, 0.96), 1)
			fill.Position = UDim2.new()
			fill.BackgroundTransparency = 1
			fill.Parent = bkg
			local knobholder = Instance.new('Frame')
			knobholder.Name = 'Knob'
			knobholder.Size = UDim2.fromOffset(24, 6)
			knobholder.Position = UDim2.fromScale(1, 0.5)
			knobholder.AnchorPoint = Vector2.new(0.5, 0.5)
			knobholder.BackgroundColor3 = slider.BackgroundColor3
			knobholder.BorderSizePixel = 0
			knobholder.Parent = fill
			local knob = Instance.new('Frame')
			knob.Name = 'Knob'
			knob.Size = UDim2.fromOffset(14, 14)
			knob.Position = UDim2.fromScale(0.5, 0.5)
			knob.AnchorPoint = Vector2.new(0.5, 0.5)
			knob.BackgroundColor3 = uipallet.Text
			knob.Parent = knobholder
			addCorner(knob, UDim.new(1, 0))
		
			slider.InputBegan:Connect(function(inputObj)
				if
					(inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
					and (inputObj.Position.Y - slider.AbsolutePosition.Y) > (20 * scale.Scale)
				then
					local changed = inputService.InputChanged:Connect(function(input)
						if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
							optionapi:SetValue(nil, name == 'Saturation' and math.clamp((input.Position.X - bkg.AbsolutePosition.X) / bkg.AbsoluteSize.X, 0, 1) or nil, name == 'Vibrance' and math.clamp((input.Position.X - bkg.AbsolutePosition.X) / bkg.AbsoluteSize.X, 0, 1) or nil, name == 'Opacity' and math.clamp((input.Position.X - bkg.AbsolutePosition.X) / bkg.AbsoluteSize.X, 0, 1) or nil)
						end
					end)
		
					local ended
					ended = inputObj.Changed:Connect(function()
						if inputObj.UserInputState == Enum.UserInputState.End then
							if changed then changed:Disconnect() end
							if ended then ended:Disconnect() end
						end
					end)
				end
			end)
			slider.MouseEnter:Connect(function()
				tween:Tween(knob, uipallet.Tween, {
					Size = UDim2.fromOffset(16, 16)
				})
			end)
			slider.MouseLeave:Connect(function()
				tween:Tween(knob, uipallet.Tween, {
					Size = UDim2.fromOffset(14, 14)
				})
			end)
		
			return slider
		end
		
		local slider = Instance.new('TextButton')
		slider.Name = optionsettings.Name..'Slider'
		slider.Size = UDim2.new(1, 0, 0, 52)
		slider.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		slider.BorderSizePixel = 0
		slider.AutoButtonColor = false
		slider.Visible = optionsettings.Visible == nil or optionsettings.Visible
		slider.Text = ''
		slider.Parent = children
		addTooltip(slider, optionsettings.Tooltip)
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.fromOffset(60, 30)
		title.Position = UDim2.fromOffset(10, 2)
		title.BackgroundTransparency = 1
		title.Text = optionsettings.Name
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = color.Dark(uipallet.Text, 0.08)
		title.TextSize = 11
		title.FontFace = uipallet.Font
		title.Parent = slider
		local valuebox = Instance.new('TextBox')
		valuebox.Name = 'Box'
		valuebox.Size = UDim2.fromOffset(60, 15)
		valuebox.Position = UDim2.new(1, -69, 0, 9)
		valuebox.BackgroundTransparency = 1
		valuebox.Visible = false
		valuebox.Text = ''
		valuebox.TextXAlignment = Enum.TextXAlignment.Right
		valuebox.TextColor3 = color.Dark(uipallet.Text, 0.08)
		valuebox.TextSize = 11
		valuebox.FontFace = uipallet.Font
		valuebox.ClearTextOnFocus = true
		valuebox.Parent = slider
		local bkg = Instance.new('Frame')
		bkg.Name = 'Slider'
		bkg.Size = UDim2.new(1, -20, 0, 5)
		bkg.Position = UDim2.fromOffset(10, 39)
		bkg.BackgroundColor3 = Color3.new(1, 1, 1)
		bkg.BorderSizePixel = 0
		bkg.Parent = slider
		local rainbowTable = {}
		for i = 0, 1, 0.1 do
			table.insert(rainbowTable, ColorSequenceKeypoint.new(i, Color3.fromHSV(i, 1, 1)))
		end

		local gradient = Instance.new('UIGradient')
		gradient.Color = ColorSequence.new(rainbowTable)
		gradient.Parent = bkg
		local fill = bkg:Clone()
		fill.Name = 'Fill'
		fill.Size = UDim2.fromScale(math.clamp(optionapi.Hue, 0.04, 0.96), 1)
		fill.Position = UDim2.new()
		fill.BackgroundTransparency = 1
		fill.Parent = bkg
		local preview = Instance.new('ImageButton')
		preview.Name = 'Preview'
		preview.Size = UDim2.fromOffset(12, 12)
		preview.Position = UDim2.new(1, -22, 0, 10)
		preview.BackgroundTransparency = 1
		preview.Image = getcustomasset('vape/assets/colorpreview.png')
		preview.ImageColor3 = Color3.fromHSV(optionapi.Hue, optionapi.Sat, optionapi.Value)
		preview.ImageTransparency = 1 - optionapi.Opacity
		preview.Parent = slider
		local expandbutton = Instance.new('TextButton')
		expandbutton.Name = 'Expand'
		expandbutton.Size = UDim2.fromOffset(17, 13)
		expandbutton.Position = UDim2.new(0, textService:GetTextSize(title.Text, title.TextSize, title.Font, Vector2.new(1000, 1000)).X + 11, 0, 7)
		expandbutton.BackgroundTransparency = 1
		expandbutton.Text = ''
		expandbutton.Parent = slider
		local expand = Instance.new('ImageLabel')
		expand.Name = 'Expand'
		expand.Size = UDim2.fromOffset(9, 5)
		expand.Position = UDim2.fromOffset(4, 4)
		expand.BackgroundTransparency = 1
		expand.Image = getcustomasset('vape/assets/expandicon.png')
		expand.ImageColor3 = color.Dark(uipallet.Text, 0.43)
		expand.Parent = expandbutton
		local rainbow = Instance.new('TextButton')
		rainbow.Name = 'Rainbow'
		rainbow.Size = UDim2.fromOffset(12, 12)
		rainbow.Position = UDim2.new(1, -42, 0, 10)
		rainbow.BackgroundTransparency = 1
		rainbow.Text = ''
		rainbow.Parent = slider
		local rainbow1 = Instance.new('ImageLabel')
		rainbow1.Size = UDim2.fromOffset(12, 12)
		rainbow1.BackgroundTransparency = 1
		rainbow1.Image = getcustomasset('vape/assets/rainbow_1.png')
		rainbow1.ImageColor3 = color.Light(uipallet.Main, 0.37)
		rainbow1.Parent = rainbow
		local rainbow2 = rainbow1:Clone()
		rainbow2.Image = getcustomasset('vape/assets/rainbow_2.png')
		rainbow2.Parent = rainbow
		local rainbow3 = rainbow1:Clone()
		rainbow3.Image = getcustomasset('vape/assets/rainbow_3.png')
		rainbow3.Parent = rainbow
		local rainbow4 = rainbow1:Clone()
		rainbow4.Image = getcustomasset('vape/assets/rainbow_4.png')
		rainbow4.Parent = rainbow
		local knobholder = Instance.new('Frame')
		knobholder.Name = 'Knob'
		knobholder.Size = UDim2.fromOffset(24, 4)
		knobholder.Position = UDim2.fromScale(1, 0.5)
		knobholder.AnchorPoint = Vector2.new(0.5, 0.5)
		knobholder.BackgroundColor3 = slider.BackgroundColor3
		knobholder.BorderSizePixel = 0
		knobholder.Parent = fill
		local knob = Instance.new('Frame')
		knob.Name = 'Knob'
		knob.Size = UDim2.fromOffset(14, 14)
		knob.Position = UDim2.fromScale(0.5, 0.5)
		knob.AnchorPoint = Vector2.new(0.5, 0.5)
		knob.BackgroundColor3 = uipallet.Text
		knob.Parent = knobholder
		addCorner(knob, UDim.new(1, 0))
		optionsettings.Function = optionsettings.Function or function() end
		local satSlider = createSlider('Saturation', ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, optionapi.Value)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(optionapi.Hue, 1, optionapi.Value))
		}))
		local vibSlider = createSlider('Vibrance', ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(optionapi.Hue, optionapi.Sat, 1))
		}))
		local opSlider = createSlider('Opacity', ColorSequence.new({
			ColorSequenceKeypoint.new(0, color.Dark(uipallet.Main, 0.02)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(optionapi.Hue, optionapi.Sat, optionapi.Value))
		}))
		
		function optionapi:Save(tab)
			tab[optionsettings.Name] = {
				Hue = self.Hue,
				Sat = self.Sat,
				Value = self.Value,
				Opacity = self.Opacity,
				Rainbow = self.Rainbow
			}
		end
		
		function optionapi:Load(tab)
			if tab.Rainbow ~= self.Rainbow then
				self:Toggle()
			end
			if self.Hue ~= tab.Hue or self.Sat ~= tab.Sat or self.Value ~= tab.Value or self.Opacity ~= tab.Opacity then
				self:SetValue(tab.Hue, tab.Sat, tab.Value, tab.Opacity)
			end
		end
		
		function optionapi:SetValue(h, s, v, o)
			self.Hue = h or self.Hue
			self.Sat = s or self.Sat
			self.Value = v or self.Value
			self.Opacity = o or self.Opacity
			preview.ImageColor3 = Color3.fromHSV(self.Hue, self.Sat, self.Value)
			preview.ImageTransparency = 1 - self.Opacity
			satSlider.Slider.UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, self.Value)),
				ColorSequenceKeypoint.new(1, Color3.fromHSV(self.Hue, 1, self.Value))
			})
			vibSlider.Slider.UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 0)),
				ColorSequenceKeypoint.new(1, Color3.fromHSV(self.Hue, self.Sat, 1))
			})
			opSlider.Slider.UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, color.Dark(uipallet.Main, 0.02)),
				ColorSequenceKeypoint.new(1, Color3.fromHSV(self.Hue, self.Sat, self.Value))
			})
		
			if self.Rainbow then
				fill.Size = UDim2.fromScale(math.clamp(self.Hue, 0.04, 0.96), 1)
			else
				tween:Tween(fill, uipallet.Tween, {
					Size = UDim2.fromScale(math.clamp(self.Hue, 0.04, 0.96), 1)
				})
			end
		
			if s then
				tween:Tween(satSlider.Slider.Fill, uipallet.Tween, {
					Size = UDim2.fromScale(math.clamp(self.Sat, 0.04, 0.96), 1)
				})
			end
			if v then
				tween:Tween(vibSlider.Slider.Fill, uipallet.Tween, {
					Size = UDim2.fromScale(math.clamp(self.Value, 0.04, 0.96), 1)
				})
			end
			if o then
				tween:Tween(opSlider.Slider.Fill, uipallet.Tween, {
					Size = UDim2.fromScale(math.clamp(self.Opacity, 0.04, 0.96), 1)
				})
			end
		
			optionsettings.Function(self.Hue, self.Sat, self.Value, self.Opacity)
		end
		
		function optionapi:Toggle()
			self.Rainbow = not self.Rainbow
			if self.Rainbow then
				table.insert(mainapi.RainbowTable, self)
				rainbow1.ImageColor3 = Color3.fromRGB(5, 127, 100)
				task.delay(0.1, function()
					if not self.Rainbow then return end
					rainbow2.ImageColor3 = Color3.fromRGB(228, 125, 43)
					task.delay(0.1, function()
						if not self.Rainbow then return end
						rainbow3.ImageColor3 = Color3.fromRGB(225, 46, 52)
					end)
				end)
			else
				local ind = table.find(mainapi.RainbowTable, self)
				if ind then
					table.remove(mainapi.RainbowTable, ind)
				end
				rainbow3.ImageColor3 = color.Light(uipallet.Main, 0.37)
				task.delay(0.1, function()
					if self.Rainbow then return end
					rainbow2.ImageColor3 = color.Light(uipallet.Main, 0.37)
					task.delay(0.1, function()
						if self.Rainbow then return end
						rainbow1.ImageColor3 = color.Light(uipallet.Main, 0.37)
					end)
				end)
			end
		end

		function optionapi.ToggleButton()
			self:Toggle()
		end
		
		local doubleClick = tick()
		preview.MouseButton1Click:Connect(function()
			preview.Visible = false
			valuebox.Visible = true
			valuebox:CaptureFocus()
			local text = Color3.fromHSV(optionapi.Hue, optionapi.Sat, optionapi.Value)
			valuebox.Text = math.round(text.R * 255)..', '..math.round(text.G * 255)..', '..math.round(text.B * 255)
		end)
		slider.InputBegan:Connect(function(inputObj)
			if
				(inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
				and (inputObj.Position.Y - slider.AbsolutePosition.Y) > (20 * scale.Scale)
			then
				if doubleClick > tick() then
					optionapi:Toggle()
				end
				doubleClick = tick() + 0.3
				local changed = inputService.InputChanged:Connect(function(input)
					if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
						optionapi:SetValue(math.clamp((input.Position.X - bkg.AbsolutePosition.X) / bkg.AbsoluteSize.X, 0, 1))
					end
				end)
		
				local ended
				ended = inputObj.Changed:Connect(function()
					if inputObj.UserInputState == Enum.UserInputState.End then
						if changed then
							changed:Disconnect()
						end
						if ended then
							ended:Disconnect()
						end
					end
				end)
			end
		end)
		slider.MouseEnter:Connect(function()
			tween:Tween(knob, uipallet.Tween, {
				Size = UDim2.fromOffset(16, 16)
			})
		end)
		slider.MouseLeave:Connect(function()
			tween:Tween(knob, uipallet.Tween, {
				Size = UDim2.fromOffset(14, 14)
			})
		end)
		slider:GetPropertyChangedSignal('Visible'):Connect(function()
			satSlider.Visible = expand.Rotation == 180 and slider.Visible
			vibSlider.Visible = satSlider.Visible
			opSlider.Visible = satSlider.Visible
		end)
		expandbutton.MouseEnter:Connect(function()
			expand.ImageColor3 = color.Dark(uipallet.Text, 0.16)
		end)
		expandbutton.MouseLeave:Connect(function()
			expand.ImageColor3 = color.Dark(uipallet.Text, 0.43)
		end)
		expandbutton.MouseButton1Click:Connect(function()
			satSlider.Visible = not satSlider.Visible
			vibSlider.Visible = satSlider.Visible
			opSlider.Visible = satSlider.Visible
			expand.Rotation = satSlider.Visible and 180 or 0
		end)
		rainbow.MouseButton1Click:Connect(function()
			optionapi:Toggle()
		end)
		valuebox.FocusLost:Connect(function(enter)
			preview.Visible = true
			valuebox.Visible = false
			if enter then
				local commas = valuebox.Text:split(',')
				local suc, res = pcall(function()
					return tonumber(commas[1]) and Color3.fromRGB(tonumber(commas[1]), tonumber(commas[2]), tonumber(commas[3])) or Color3.fromHex(valuebox.Text)
				end)
				if suc then
					if optionapi.Rainbow then
						optionapi:Toggle()
					end
					optionapi:SetValue(res:ToHSV())
				end
			end
		end)
		
		optionapi.Object = slider
		api.Options[optionsettings.Name] = optionapi
		
		return compatOption(optionapi)
	end,
	Dropdown = function(optionsettings, children, api)
		optionsettings.Function = hookCF(optionsettings.Function, optionsettings)
		local optionapi = {
			Type = 'Dropdown',
			Value = optionsettings.List[1] or 'None',
			Index = 0
		}
		
		local dropdown = Instance.new('TextButton')
		dropdown.Name = optionsettings.Name..'Dropdown'
		dropdown.Size = UDim2.new(1, 0, 0, 42)
		dropdown.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		dropdown.BorderSizePixel = 0
		dropdown.AutoButtonColor = false
		dropdown.Visible = optionsettings.Visible == nil or optionsettings.Visible
		dropdown.Text = ''
		dropdown.Parent = children
		addTooltip(dropdown, optionsettings.Tooltip or optionsettings.Name)
		local bkg = Instance.new('Frame')
		bkg.Name = 'BKG'
		bkg.Size = UDim2.new(1, -20, 1, -8)
		bkg.Position = UDim2.fromOffset(10, 4)
		bkg.BackgroundColor3 = uipallet.SurfaceAlt
		bkg.Parent = dropdown
		styleShell(bkg, UDim.new(0, 10), 0.52)
		local button = Instance.new('TextButton')
		button.Name = 'Dropdown'
		button.Size = UDim2.new(1, -2, 1, -2)
		button.Position = UDim2.fromOffset(1, 1)
		button.BackgroundColor3 = uipallet.Surface
		button.AutoButtonColor = false
		button.Text = ''
		button.Parent = bkg
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.new(1, 0, 0, 29)
		title.BackgroundTransparency = 1
		title.Text = '         '..optionsettings.Name..' - '..optionapi.Value
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = color.Dark(uipallet.Text, 0.08)
		title.TextSize = 13
		title.TextTruncate = Enum.TextTruncate.AtEnd
		title.FontFace = uipallet.Font
		title.Parent = button
		addCorner(button, UDim.new(0, 7))
		local arrow = Instance.new('ImageLabel')
		arrow.Name = 'Arrow'
		arrow:SetAttribute('SilentwareRole', 'SettingsArrow')
		arrow.Size = UDim2.fromOffset(4, 8)
		arrow.Position = UDim2.new(1, -17, 0, 11)
		arrow.BackgroundTransparency = 1
		arrow.Image = getcustomasset('vape/assets/expandright.png')
		arrow.ImageColor3 = uipallet.MutedText
		arrow.Rotation = 90
		arrow.Parent = button
		optionsettings.Function = optionsettings.Function or function() end
		local dropdownchildren
		
		function optionapi:Save(tab)
			tab[optionsettings.Name] = {Value = self.Value}
		end
		
		function optionapi:Load(tab)
			if self.Value ~= tab.Value then
				self:SetValue(tab.Value)
			end
		end
		
		function optionapi:Change(list)
			optionsettings.List = list or {}
			if not table.find(optionsettings.List, self.Value) then
				self:SetValue(self.Value)
			end
		end
		
		function optionapi:SetValue(val, mouse)
			self.Value = table.find(optionsettings.List, val) and val or optionsettings.List[1] or 'None'
			title.Text = '         '..optionsettings.Name..' - '..self.Value
			if dropdownchildren then
				arrow.Rotation = 90
				dropdownchildren:Destroy()
				dropdownchildren = nil
				dropdown.Size = UDim2.new(1, 0, 0, 40)
			end
			optionsettings.Function(self.Value, mouse)
		end
		
		button.MouseButton1Click:Connect(function()
			if not dropdownchildren then
				arrow.Rotation = 270
				dropdown.Size = UDim2.new(1, 0, 0, 42 + (#optionsettings.List - 1) * 28)
				dropdownchildren = Instance.new('Frame')
				dropdownchildren.Name = 'Children'
				dropdownchildren.Size = UDim2.new(1, 0, 0, (#optionsettings.List - 1) * 28)
				dropdownchildren.Position = UDim2.fromOffset(0, 29)
				dropdownchildren.BackgroundTransparency = 1
				dropdownchildren.Parent = button
				local ind = 0
				for _, v in optionsettings.List do
					if v == optionapi.Value then continue end
					local dropdownoption = Instance.new('TextButton')
					dropdownoption.Name = v..'Option'
					dropdownoption.Size = UDim2.new(1, 0, 0, 28)
					dropdownoption.Position = UDim2.fromOffset(0, ind * 28)
					dropdownoption.BackgroundColor3 = uipallet.Surface
					dropdownoption.BorderSizePixel = 0
					dropdownoption.AutoButtonColor = false
					dropdownoption.Text = '         '..v
					dropdownoption.TextXAlignment = Enum.TextXAlignment.Left
					dropdownoption.TextColor3 = color.Dark(uipallet.Text, 0.08)
					dropdownoption.TextSize = 13
					dropdownoption.TextTruncate = Enum.TextTruncate.AtEnd
					dropdownoption.FontFace = uipallet.Font
					dropdownoption.Parent = dropdownchildren
					dropdownoption.MouseEnter:Connect(function()
						tween:Tween(dropdownoption, uipallet.Tween, {
							BackgroundColor3 = color.Light(uipallet.Surface, 0.05)
						})
					end)
					dropdownoption.MouseLeave:Connect(function()
						tween:Tween(dropdownoption, uipallet.Tween, {
							BackgroundColor3 = uipallet.Surface
						})
					end)
					dropdownoption.MouseButton1Click:Connect(function()
						optionapi:SetValue(v, true)
					end)
					ind += 1
				end
			else
				optionapi:SetValue(optionapi.Value, true)
			end
		end)
		dropdown.MouseEnter:Connect(function()
			tween:Tween(bkg, uipallet.Tween, {
				BackgroundColor3 = color.Light(uipallet.SurfaceAlt, 0.05)
			})
		end)
		dropdown.MouseLeave:Connect(function()
			tween:Tween(bkg, uipallet.Tween, {
				BackgroundColor3 = uipallet.SurfaceAlt
			})
		end)
		
		optionapi.Object = dropdown
		api.Options[optionsettings.Name] = optionapi
		
		return compatOption(optionapi)
	end,
	Font = function(optionsettings, children, api)
		optionsettings.Function = hookCF(optionsettings.Function, optionsettings)
		local fonts = {
			optionsettings.Blacklist,
			'Custom'
		}
		for _, v in Enum.Font:GetEnumItems() do
			if not table.find(fonts, v.Name) then
				table.insert(fonts, v.Name)
			end
		end
		
		local optionapi = {Value = Font.fromEnum(Enum.Font[fonts[1]])}
		local fontdropdown
		local fontbox
		optionsettings.Function = optionsettings.Function or function() end
		
		fontdropdown = components.Dropdown({
			Name = optionsettings.Name,
			List = fonts,
			Function = function(val)
				fontbox.Object.Visible = val == 'Custom' and fontdropdown.Object.Visible
				if val ~= 'Custom' then
					optionapi.Value = Font.fromEnum(Enum.Font[val])
					optionsettings.Function(optionapi.Value)
				else
					pcall(function()
						optionapi.Value = Font.fromId(tonumber(fontbox.Value))
					end)
					optionsettings.Function(optionapi.Value)
				end
			end,
			Darker = optionsettings.Darker,
			Visible = optionsettings.Visible
		}, children, api)
		optionapi.Object = fontdropdown.Object
		fontbox = components.TextBox({
			Name = optionsettings.Name..' Asset',
			Placeholder = 'font (rbxasset)',
			Function = function()
				if fontdropdown.Value == 'Custom' then
					pcall(function()
						optionapi.Value = Font.fromId(tonumber(fontbox.Value))
					end)
					optionsettings.Function(optionapi.Value)
				end
			end,
			Visible = false,
			Darker = true
		}, children, api)
		
		fontdropdown.Object:GetPropertyChangedSignal('Visible'):Connect(function()
			fontbox.Object.Visible = fontdropdown.Object.Visible and fontdropdown.Value == 'Custom'
		end)
		
		return compatOption(optionapi)
	end,
	Slider = function(optionsettings, children, api)
		optionsettings.Function = hookCF(optionsettings.Function, optionsettings)
		local optionapi = {
			Type = 'Slider',
			Value = optionsettings.Default or optionsettings.Min,
			Max = optionsettings.Max,
			Index = getTableSize(api.Options)
		}
		
		local slider = Instance.new('TextButton')
		slider.Name = optionsettings.Name..'Slider'
		slider.Size = UDim2.new(1, 0, 0, 54)
		slider.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		slider.BorderSizePixel = 0
		slider.AutoButtonColor = false
		slider.Visible = optionsettings.Visible == nil or optionsettings.Visible
		slider.Text = ''
		slider.Parent = children
		addTooltip(slider, optionsettings.Tooltip)
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.fromOffset(60, 30)
		title.Position = UDim2.fromOffset(10, 2)
		title.BackgroundTransparency = 1
		title.Text = optionsettings.Name
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = color.Dark(uipallet.Text, 0.16)
		title.TextSize = 11
		title.FontFace = uipallet.Font
		title.Parent = slider
		local valuebutton = Instance.new('TextButton')
		valuebutton.Name = 'Value'
		valuebutton.Size = UDim2.fromOffset(60, 15)
		valuebutton.Position = UDim2.new(1, -69, 0, 9)
		valuebutton.BackgroundTransparency = 1
		valuebutton.Text = optionapi.Value..(optionsettings.Suffix and ' '..(type(optionsettings.Suffix) == 'function' and optionsettings.Suffix(optionapi.Value) or optionsettings.Suffix) or '')
		valuebutton.TextXAlignment = Enum.TextXAlignment.Right
		valuebutton.TextColor3 = color.Dark(uipallet.Text, 0.08)
		valuebutton.TextSize = 11
		valuebutton.FontFace = uipallet.Font
		valuebutton.Parent = slider
		local valuebox = Instance.new('TextBox')
		valuebox.Name = 'Box'
		valuebox.Size = valuebutton.Size
		valuebox.Position = valuebutton.Position
		valuebox.BackgroundTransparency = 1
		valuebox.Visible = false
		valuebox.Text = optionapi.Value
		valuebox.TextXAlignment = Enum.TextXAlignment.Right
		valuebox.TextColor3 = color.Dark(uipallet.Text, 0.08)
		valuebox.TextSize = 11
		valuebox.FontFace = uipallet.Font
		valuebox.ClearTextOnFocus = false
		valuebox.Parent = slider
		local bkg = Instance.new('Frame')
		bkg.Name = 'Slider'
		bkg.Size = UDim2.new(1, -20, 0, 5)
		bkg.Position = UDim2.fromOffset(10, 39)
		bkg.BackgroundColor3 = color.Light(uipallet.Main, 0.08)
		bkg.BorderSizePixel = 0
		bkg.Parent = slider
		local fill = bkg:Clone()
		fill.Name = 'Fill'
		fill.Size = UDim2.fromScale(math.clamp((optionapi.Value - optionsettings.Min) / optionsettings.Max, 0.04, 0.96), 1)
		fill.Position = UDim2.new()
		fill.BackgroundColor3 = getAccentColor()
		fill.Parent = bkg
		local knobholder = Instance.new('Frame')
		knobholder.Name = 'Knob'
		knobholder.Size = UDim2.fromOffset(24, 6)
		knobholder.Position = UDim2.fromScale(1, 0.5)
		knobholder.AnchorPoint = Vector2.new(0.5, 0.5)
		knobholder.BackgroundColor3 = slider.BackgroundColor3
		knobholder.BorderSizePixel = 0
		knobholder.Parent = fill
		local knob = Instance.new('Frame')
		knob.Name = 'Knob'
		knob.Size = UDim2.fromOffset(14, 14)
		knob.Position = UDim2.fromScale(0.5, 0.5)
		knob.AnchorPoint = Vector2.new(0.5, 0.5)
		knob.BackgroundColor3 = getAccentColor()
		knob.Parent = knobholder
		addCorner(knob, UDim.new(1, 0))
		optionsettings.Function = optionsettings.Function or function() end
		optionsettings.Decimal = optionsettings.Decimal or 1
		
		function optionapi:Save(tab)
			tab[optionsettings.Name] = {
				Value = self.Value,
				Max = self.Max
			}
		end
		
		function optionapi:Load(tab)
			local newval = tab.Value == tab.Max and tab.Max ~= self.Max and self.Max or tab.Value
			if self.Value ~= newval then
				self:SetValue(newval, nil, true)
			end
		end
		
		function optionapi:Color(hue, sat, val, rainbowcheck)
			fill.BackgroundColor3 = rainbowcheck and Color3.fromHSV(mainapi:Color((hue - (self.Index * 0.075)) % 1)) or Color3.fromHSV(hue, sat, val)
			knob.BackgroundColor3 = fill.BackgroundColor3
		end
		
		function optionapi:SetValue(value, pos, final)
			if tonumber(value) == math.huge or value ~= value then return end
			local check = self.Value ~= value
			self.Value = value
			tween:Tween(fill, uipallet.Tween, {
				Size = UDim2.fromScale(math.clamp(pos or math.clamp(value / optionsettings.Max, 0, 1), 0.04, 0.96), 1)
			})
			valuebutton.Text = self.Value..(optionsettings.Suffix and ' '..(type(optionsettings.Suffix) == 'function' and optionsettings.Suffix(self.Value) or optionsettings.Suffix) or '')
			if check or final then
				optionsettings.Function(value, final)
			end
		end
		
		slider.InputBegan:Connect(function(inputObj)
			if
				(inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
				and (inputObj.Position.Y - slider.AbsolutePosition.Y) > (20 * scale.Scale)
			then
				local newPosition = math.clamp((inputObj.Position.X - bkg.AbsolutePosition.X) / bkg.AbsoluteSize.X, 0, 1)
				optionapi:SetValue(math.floor((optionsettings.Min + (optionsettings.Max - optionsettings.Min) * newPosition) * optionsettings.Decimal) / optionsettings.Decimal, newPosition)
				local lastValue = optionapi.Value
				local lastPosition = newPosition
		
				local changed = inputService.InputChanged:Connect(function(input)
					if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
						local newPosition = math.clamp((input.Position.X - bkg.AbsolutePosition.X) / bkg.AbsoluteSize.X, 0, 1)
						optionapi:SetValue(math.floor((optionsettings.Min + (optionsettings.Max - optionsettings.Min) * newPosition) * optionsettings.Decimal) / optionsettings.Decimal, newPosition)
						lastValue = optionapi.Value
						lastPosition = newPosition
					end
				end)
		
				local ended
				ended = inputObj.Changed:Connect(function()
					if inputObj.UserInputState == Enum.UserInputState.End then
						if changed then
							changed:Disconnect()
						end
						if ended then
							ended:Disconnect()
						end
						optionapi:SetValue(lastValue, lastPosition, true)
					end
				end)
		
			end
		end)
		slider.MouseEnter:Connect(function()
			tween:Tween(knob, uipallet.Tween, {
				Size = UDim2.fromOffset(16, 16)
			})
		end)
		slider.MouseLeave:Connect(function()
			tween:Tween(knob, uipallet.Tween, {
				Size = UDim2.fromOffset(14, 14)
			})
		end)
		valuebutton.MouseButton1Click:Connect(function()
			valuebutton.Visible = false
			valuebox.Visible = true
			valuebox.Text = optionapi.Value
			valuebox:CaptureFocus()
		end)
		valuebox.FocusLost:Connect(function(enter)
			valuebutton.Visible = true
			valuebox.Visible = false
			if enter and tonumber(valuebox.Text) then
				optionapi:SetValue(tonumber(valuebox.Text), nil, true)
			end
		end)
		
		optionapi.Object = slider
		api.Options[optionsettings.Name] = optionapi
		
		return compatOption(optionapi)
	end,
	Targets = function(optionsettings, children, api)
		optionsettings.Function = hookCF(optionsettings.Function, optionsettings)
		local optionapi = {
			Type = 'Targets',
			Index = getTableSize(api.Options)
		}
		
		local textlist = Instance.new('TextButton')
		textlist.Name = 'Targets'
		textlist.Size = UDim2.new(1, 0, 0, 50)
		textlist.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		textlist.BorderSizePixel = 0
		textlist.AutoButtonColor = false
		textlist.Visible = optionsettings.Visible == nil or optionsettings.Visible
		textlist.Text = ''
		textlist.Parent = children
		addTooltip(textlist, optionsettings.Tooltip)
		local bkg = Instance.new('Frame')
		bkg.Name = 'BKG'
		bkg.Size = UDim2.new(1, -20, 1, -9)
		bkg.Position = UDim2.fromOffset(10, 4)
		bkg.BackgroundColor3 = uipallet.SurfaceAlt
		bkg.Parent = textlist
		styleShell(bkg, UDim.new(0, 8), 0.62)
		local button = Instance.new('TextButton')
		button.Name = 'TextList'
		button.Size = UDim2.new(1, -2, 1, -2)
		button.Position = UDim2.fromOffset(1, 1)
		button.BackgroundColor3 = uipallet.Surface
		button.AutoButtonColor = false
		button.Text = ''
		button.Parent = bkg
		local buttontitle = Instance.new('TextLabel')
		buttontitle.Name = 'Title'
		buttontitle.Size = UDim2.new(1, -5, 0, 15)
		buttontitle.Position = UDim2.fromOffset(5, 6)
		buttontitle.BackgroundTransparency = 1
		buttontitle.Text = 'Target:'
		buttontitle.TextXAlignment = Enum.TextXAlignment.Left
		buttontitle.TextColor3 = color.Dark(uipallet.Text, 0.08)
		buttontitle.TextSize = 15
		buttontitle.TextTruncate = Enum.TextTruncate.AtEnd
		buttontitle.FontFace = uipallet.Font
		buttontitle.Parent = button
		local items = buttontitle:Clone()
		items.Name = 'Items'
		items.Position = UDim2.fromOffset(5, 21)
		items.Text = 'Ignore none'
		items.TextColor3 = uipallet.MutedText
		items.TextSize = 11
		items.Parent = button
		addCorner(button, UDim.new(0, 7))
		local tool = Instance.new('Frame')
		tool.Size = UDim2.fromOffset(65, 12)
		tool.Position = UDim2.fromOffset(52, 8)
		tool.BackgroundTransparency = 1
		tool.Parent = button
		local toollist = Instance.new('UIListLayout')
		toollist.FillDirection = Enum.FillDirection.Horizontal
		toollist.Padding = UDim.new(0, 6)
		toollist.Parent = tool
		local window = Instance.new('TextButton')
		window.Name = 'TargetsTextWindow'
		window.Size = UDim2.fromOffset(220, 145)
		window.BackgroundColor3 = uipallet.Surface
		window.BorderSizePixel = 0
		window.AutoButtonColor = false
		window.Visible = false
		window.Text = ''
		window.Parent = clickgui
		optionapi.Window = window
		addBlur(window)
		styleShell(window, UDim.new(0, 10), 0.48)
		local icon = Instance.new('ImageLabel')
		icon.Name = 'Icon'
		icon.Size = UDim2.fromOffset(18, 12)
		icon.Position = UDim2.fromOffset(10, 15)
		icon.BackgroundTransparency = 1
		icon.Image = getcustomasset('vape/assets/targetstab.png')
		icon.Parent = window
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.new(1, -36, 0, 20)
		title.Position = UDim2.fromOffset(36, 12)
		title.BackgroundTransparency = 1
		title.Text = 'Target settings'
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = uipallet.Text
		title.TextSize = 13
		title.FontFace = uipallet.Font
		title.Parent = window
		local close = addCloseButton(window)
		optionsettings.Function = optionsettings.Function or function() end
		
		function optionapi:Save(tab)
			tab.Targets = {
				Players = self.Players.Enabled,
				NPCs = self.NPCs.Enabled,
				Invisible = self.Invisible.Enabled,
				Walls = self.Walls.Enabled
			}
		end
		
		function optionapi:Load(tab)
			if self.Players.Enabled ~= tab.Players then
				self.Players:Toggle()
			end
			if self.NPCs.Enabled ~= tab.NPCs then
				self.NPCs:Toggle()
			end
			if self.Invisible.Enabled ~= tab.Invisible then
				self.Invisible:Toggle()
			end
			if self.Walls.Enabled ~= tab.Walls then
				self.Walls:Toggle()
			end
		end
		
		function optionapi:Color(hue, sat, val, rainbowcheck)
			bkg.BackgroundColor3 = rainbowcheck and Color3.fromHSV(mainapi:Color((hue - (self.Index * 0.075)) % 1)) or Color3.fromHSV(hue, sat, val)
			if self.Players.Enabled then
				tween:Cancel(self.Players.Object.Frame)
				self.Players.Object.Frame.BackgroundColor3 = Color3.fromHSV(hue, sat, val)
			end
			if self.NPCs.Enabled then
				tween:Cancel(self.NPCs.Object.Frame)
				self.NPCs.Object.Frame.BackgroundColor3 = Color3.fromHSV(hue, sat, val)
			end
			if self.Invisible.Enabled then
				tween:Cancel(self.Invisible.Object.Knob)
				self.Invisible.Object.Knob.BackgroundColor3 = Color3.fromHSV(hue, sat, val)
			end
			if self.Walls.Enabled then
				tween:Cancel(self.Walls.Object.Knob)
				self.Walls.Object.Knob.BackgroundColor3 = Color3.fromHSV(hue, sat, val)
			end
		end
		
		optionapi.Players = components.TargetsButton({
			Position = UDim2.fromOffset(11, 45),
			Icon = getcustomasset('vape/assets/targetplayers1.png'),
			IconSize = UDim2.fromOffset(15, 16),
			IconParent = tool,
			ToolIcon = getcustomasset('vape/assets/targetplayers2.png'),
			ToolSize = UDim2.fromOffset(11, 12),
			Tooltip = 'Players',
			Function = optionsettings.Function
		}, window, tool)
		optionapi.NPCs = components.TargetsButton({
			Position = UDim2.fromOffset(112, 45),
			Icon = getcustomasset('vape/assets/targetnpc1.png'),
			IconSize = UDim2.fromOffset(12, 16),
			IconParent = tool,
			ToolIcon = getcustomasset('vape/assets/targetnpc2.png'),
			ToolSize = UDim2.fromOffset(9, 12),
			Tooltip = 'NPCs',
			Function = optionsettings.Function
		}, window, tool)
		optionapi.Invisible = components.Toggle({
			Name = 'Ignore invisible',
			Function = function()
				local text = 'none'
				if optionapi.Invisible.Enabled then
					text = 'invisible'
				end
				if optionapi.Walls.Enabled then
					text = text == 'none' and 'behind walls' or text..', behind walls'
				end
				items.Text = 'Ignore '..text
				optionsettings.Function()
			end
		}, window, {Options = {}})
		optionapi.Invisible.Object.Position = UDim2.fromOffset(0, 81)
		optionapi.Walls = components.Toggle({
			Name = 'Ignore behind walls',
			Function = function()
				local text = 'none'
				if optionapi.Invisible.Enabled then
					text = 'invisible'
				end
				if optionapi.Walls.Enabled then
					text = text == 'none' and 'behind walls' or text..', behind walls'
				end
				items.Text = 'Ignore '..text
				optionsettings.Function()
			end
		}, window, {Options = {}})
		optionapi.Walls.Object.Position = UDim2.fromOffset(0, 111)
		if optionsettings.Players then
			optionapi.Players:Toggle()
		end
		if optionsettings.NPCs then
			optionapi.NPCs:Toggle()
		end
		if optionsettings.Invisible then
			optionapi.Invisible:Toggle()
		end
		if optionsettings.Walls then
			optionapi.Walls:Toggle()
		end
		
		close.MouseButton1Click:Connect(function()
			window.Visible = false
		end)
		button.MouseButton1Click:Connect(function()
			window.Visible = not window.Visible
			tween:Cancel(bkg)
			bkg.BackgroundColor3 = window.Visible and Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value) or color.Light(uipallet.Main, 0.37)
		end)
		textlist.MouseEnter:Connect(function()
			if not optionapi.Window.Visible then
				tween:Tween(bkg, uipallet.Tween, {
					BackgroundColor3 = color.Light(uipallet.Main, 0.37)
				})
			end
		end)
		textlist.MouseLeave:Connect(function()
			if not optionapi.Window.Visible then
				tween:Tween(bkg, uipallet.Tween, {
					BackgroundColor3 = color.Light(uipallet.Main, 0.034)
				})
			end
		end)
		textlist:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
			if mainapi.ThreadFix then
				setthreadidentity(8)
			end
			local actualPosition = (textlist.AbsolutePosition + Vector2.new(0, 60)) / scale.Scale
			window.Position = UDim2.fromOffset(actualPosition.X + 220, actualPosition.Y)
		end)
		
		optionapi.Object = textlist
		api.Options.Targets = optionapi
		
		return compatOption(optionapi)
	end,
	TargetsButton = function(optionsettings, children, api)
		optionsettings.Function = hookCF(optionsettings.Function, optionsettings)
		local optionapi = {Enabled = false}
		
		local targetbutton = Instance.new('TextButton')
		targetbutton.Size = UDim2.fromOffset(98, 31)
		targetbutton.Position = optionsettings.Position
		targetbutton.BackgroundColor3 = color.Light(uipallet.Main, 0.05)
		targetbutton.AutoButtonColor = false
		targetbutton.Visible = optionsettings.Visible == nil or optionsettings.Visible
		targetbutton.Text = ''
		targetbutton.Parent = children
		addCorner(targetbutton)
		addTooltip(targetbutton, optionsettings.Tooltip)
		local bkg = Instance.new('Frame')
		bkg.Size = UDim2.new(1, -2, 1, -2)
		bkg.Position = UDim2.fromOffset(1, 1)
		bkg.BackgroundColor3 = uipallet.Main
		bkg.Parent = targetbutton
		addCorner(bkg)
		local icon = Instance.new('ImageLabel')
		icon.Size = optionsettings.IconSize
		icon.Position = UDim2.fromScale(0.5, 0.5)
		icon.AnchorPoint = Vector2.new(0.5, 0.5)
		icon.BackgroundTransparency = 1
		icon.Image = optionsettings.Icon
		icon.ImageColor3 = color.Light(uipallet.Main, 0.37)
		icon.Parent = bkg
		optionsettings.Function = optionsettings.Function or function() end
		local tooltipicon
		
		function optionapi:Toggle()
			self.Enabled = not self.Enabled
			tween:Tween(bkg, uipallet.Tween, {
				BackgroundColor3 = self.Enabled and Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value) or uipallet.Main
			})
			tween:Tween(icon, uipallet.Tween, {
				ImageColor3 = self.Enabled and Color3.new(1, 1, 1) or color.Light(uipallet.Main, 0.37)
			})
			if tooltipicon then
				tooltipicon:Destroy()
			end
			if self.Enabled then
				tooltipicon = Instance.new('ImageLabel')
				tooltipicon.Size = optionsettings.ToolSize
				tooltipicon.BackgroundTransparency = 1
				tooltipicon.Image = optionsettings.ToolIcon
				tooltipicon.ImageColor3 = uipallet.Text
				tooltipicon.Parent = optionsettings.IconParent
			end
			optionsettings.Function(self.Enabled)
		end
		
		targetbutton.MouseEnter:Connect(function()
			if not optionapi.Enabled then
				tween:Tween(bkg, uipallet.Tween, {
					BackgroundColor3 = Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value - 0.25)
				})
				tween:Tween(icon, uipallet.Tween, {
					ImageColor3 = Color3.new(1, 1, 1)
				})
			end
		end)
		targetbutton.MouseLeave:Connect(function()
			if not optionapi.Enabled then
				tween:Tween(bkg, uipallet.Tween, {
					BackgroundColor3 = uipallet.Main
				})
				tween:Tween(icon, uipallet.Tween, {
					ImageColor3 = color.Light(uipallet.Main, 0.37)
				})
			end
		end)
		targetbutton.MouseButton1Click:Connect(function()
			optionapi:Toggle()
		end)
		
		optionapi.Object = targetbutton
		
		return compatOption(optionapi)
	end,
	TextBox = function(optionsettings, children, api)
		optionsettings.Function = hookCF(optionsettings.Function, optionsettings)
		local optionapi = {
			Type = 'TextBox',
			Value = optionsettings.Default or '',
			Index = 0
		}
		
		local textbox = Instance.new('TextButton')
		textbox.Name = optionsettings.Name..'TextBox'
		textbox.Size = UDim2.new(1, 0, 0, 60)
		textbox.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		textbox.BorderSizePixel = 0
		textbox.AutoButtonColor = false
		textbox.Visible = optionsettings.Visible == nil or optionsettings.Visible
		textbox.Text = ''
		textbox.Parent = children
		addTooltip(textbox, optionsettings.Tooltip)
		local title = Instance.new('TextLabel')
		title.Size = UDim2.new(1, -10, 0, 20)
		title.Position = UDim2.fromOffset(10, 3)
		title.BackgroundTransparency = 1
		title.Text = optionsettings.Name
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = color.Dark(uipallet.Text, 0.05)
		title.TextSize = 12
		title.FontFace = uipallet.Font
		title.Parent = textbox
		local bkg = Instance.new('Frame')
		bkg.Name = 'BKG'
		bkg.Size = UDim2.new(1, -20, 0, 31)
		bkg.Position = UDim2.fromOffset(10, 23)
		bkg.BackgroundColor3 = uipallet.SurfaceAlt
		bkg.Parent = textbox
		styleShell(bkg, UDim.new(0, 7), 0.62)
		local box = Instance.new('TextBox')
		box.Size = UDim2.new(1, -8, 1, 0)
		box.Position = UDim2.fromOffset(8, 0)
		box.BackgroundTransparency = 1
		box.Text = optionsettings.Default or ''
		box.PlaceholderText = optionsettings.Placeholder or 'Click to set'
		box.TextXAlignment = Enum.TextXAlignment.Left
		box.TextColor3 = color.Dark(uipallet.Text, 0.08)
		box.PlaceholderColor3 = color.Dark(uipallet.Text, 0.4)
		box.TextSize = 12
		box.FontFace = uipallet.Font
		box.ClearTextOnFocus = false
		box.Parent = bkg
		optionsettings.Function = optionsettings.Function or function() end
		
		function optionapi:Save(tab)
			tab[optionsettings.Name] = {Value = self.Value}
		end
		
		function optionapi:Load(tab)
			if self.Value ~= tab.Value then
				self:SetValue(tab.Value)
			end
		end
		
		function optionapi:SetValue(val, enter)
			self.Value = val
			box.Text = val
			optionsettings.Function(enter)
		end
		
		textbox.MouseButton1Click:Connect(function()
			box:CaptureFocus()
		end)
		box.FocusLost:Connect(function(enter)
			optionapi:SetValue(box.Text, enter)
		end)
		box:GetPropertyChangedSignal('Text'):Connect(function()
			optionapi:SetValue(box.Text)
		end)
		
		optionapi.Object = textbox
		api.Options[optionsettings.Name] = optionapi
		
		return compatOption(optionapi)
	end,
	TextList = function(optionsettings, children, api)
		optionsettings.Function = hookCF(optionsettings.Function, optionsettings)
		local optionapi = {
			Type = 'TextList',
			List = optionsettings.Default or {},
			ListEnabled = optionsettings.Default or {},
			Objects = {},
			ObjectList = {},
			Window = {Visible = false},
			Index = getTableSize(api.Options)
		}
		optionsettings.Color = optionsettings.Color or Color3.fromRGB(5, 134, 105)
		
		local textlist = Instance.new('TextButton')
		textlist.Name = optionsettings.Name..'TextList'
		textlist.Size = UDim2.new(1, 0, 0, 50)
		textlist.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		textlist.BorderSizePixel = 0
		textlist.AutoButtonColor = false
		textlist.Visible = optionsettings.Visible == nil or optionsettings.Visible
		textlist.Text = ''
		textlist.Parent = children
		addTooltip(textlist, optionsettings.Tooltip)
		local bkg = Instance.new('Frame')
		bkg.Name = 'BKG'
		bkg.Size = UDim2.new(1, -20, 1, -9)
		bkg.Position = UDim2.fromOffset(10, 4)
		bkg.BackgroundColor3 = uipallet.SurfaceAlt
		bkg.Parent = textlist
		styleShell(bkg, UDim.new(0, 8), 0.62)
		local button = Instance.new('TextButton')
		button.Name = 'TextList'
		button.Size = UDim2.new(1, -2, 1, -2)
		button.Position = UDim2.fromOffset(1, 1)
		button.BackgroundColor3 = uipallet.Surface
		button.AutoButtonColor = false
		button.Text = ''
		button.Parent = bkg
		local buttonicon = Instance.new('ImageLabel')
		buttonicon.Name = 'Icon'
		buttonicon.Size = UDim2.fromOffset(14, 12)
		buttonicon.Position = UDim2.fromOffset(10, 14)
		buttonicon.BackgroundTransparency = 1
		buttonicon.Image = optionsettings.Icon or getcustomasset('vape/assets/allowedicon.png')
		buttonicon.Parent = button
		local buttontitle = Instance.new('TextLabel')
		buttontitle.Name = 'Title'
		buttontitle.Size = UDim2.new(1, -35, 0, 15)
		buttontitle.Position = UDim2.fromOffset(35, 6)
		buttontitle.BackgroundTransparency = 1
		buttontitle.Text = optionsettings.Name
		buttontitle.TextXAlignment = Enum.TextXAlignment.Left
		buttontitle.TextColor3 = color.Dark(uipallet.Text, 0.08)
		buttontitle.TextSize = 15
		buttontitle.TextTruncate = Enum.TextTruncate.AtEnd
		buttontitle.FontFace = uipallet.Font
		buttontitle.Parent = button
		local amount = buttontitle:Clone()
		amount.Name = 'Amount'
		amount.Size = UDim2.new(1, -13, 0, 15)
		amount.Position = UDim2.fromOffset(0, 6)
		amount.Text = '0'
		amount.TextXAlignment = Enum.TextXAlignment.Right
		amount.Parent = button
		local items = buttontitle:Clone()
		items.Name = 'Items'
		items.Position = UDim2.fromOffset(35, 21)
		items.Text = 'None'
		items.TextColor3 = color.Dark(uipallet.Text, 0.43)
		items.TextSize = 11
		items.Parent = button
		addCorner(button, UDim.new(0, 7))
		local window = Instance.new('TextButton')
		window.Name = optionsettings.Name..'TextWindow'
		window.Size = UDim2.fromOffset(220, 85)
		window.BackgroundColor3 = uipallet.Surface
		window.BorderSizePixel = 0
		window.AutoButtonColor = false
		window.Visible = false
		window.Text = ''
		window.Parent = api.Legit and mainapi.Legit.Window or clickgui
		optionapi.Window = window
		addBlur(window)
		styleShell(window, UDim.new(0, 10), 0.48)
		local icon = Instance.new('ImageLabel')
		icon.Name = 'Icon'
		icon.Size = optionsettings.TabSize or UDim2.fromOffset(19, 16)
		icon.Position = UDim2.fromOffset(10, 13)
		icon.BackgroundTransparency = 1
		icon.Image = optionsettings.Tab or getcustomasset('vape/assets/allowedtab.png')
		icon.Parent = window
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.new(1, -36, 0, 20)
		title.Position = UDim2.fromOffset(36, 12)
		title.BackgroundTransparency = 1
		title.Text = optionsettings.Name
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = uipallet.Text
		title.TextSize = 13
		title.FontFace = uipallet.Font
		title.Parent = window
		local close = addCloseButton(window)
		local addbkg = Instance.new('Frame')
		addbkg.Name = 'Add'
		addbkg.Size = UDim2.fromOffset(200, 31)
		addbkg.Position = UDim2.fromOffset(10, 45)
		addbkg.BackgroundColor3 = uipallet.SurfaceAlt
		addbkg.Parent = window
		styleShell(addbkg, UDim.new(0, 8), 0.62)
		local addbox = addbkg:Clone()
		addbox.Size = UDim2.new(1, -2, 1, -2)
		addbox.Position = UDim2.fromOffset(1, 1)
		addbox.BackgroundColor3 = uipallet.Surface
		addbox.Parent = addbkg
		local addvalue = Instance.new('TextBox')
		addvalue.Size = UDim2.new(1, -35, 1, 0)
		addvalue.Position = UDim2.fromOffset(10, 0)
		addvalue.BackgroundTransparency = 1
		addvalue.Text = ''
		addvalue.PlaceholderText = optionsettings.Placeholder or 'Add entry...'
		addvalue.TextXAlignment = Enum.TextXAlignment.Left
		addvalue.TextColor3 = uipallet.Text
		addvalue.PlaceholderColor3 = uipallet.MutedText
		addvalue.TextSize = 15
		addvalue.FontFace = uipallet.Font
		addvalue.ClearTextOnFocus = false
		addvalue.Parent = addbkg
		local addbutton = Instance.new('ImageButton')
		addbutton.Name = 'AddButton'
		addbutton.Size = UDim2.fromOffset(16, 16)
		addbutton.Position = UDim2.new(1, -26, 0, 8)
		addbutton.BackgroundTransparency = 1
		addbutton.Image = getcustomasset('vape/assets/add.png')
		addbutton.ImageColor3 = optionsettings.Color
		addbutton.ImageTransparency = 0.3
		addbutton.Parent = addbkg
		optionsettings.Function = optionsettings.Function or function() end
		
		function optionapi:Save(tab)
			tab[optionsettings.Name] = {
				List = self.List,
				ListEnabled = self.ListEnabled
			}
		end
		
		function optionapi:Load(tab)
			self.List = tab.List or {}
			self.ListEnabled = tab.ListEnabled or {}
			self:ChangeValue()
		end
		
		function optionapi:Color(hue, sat, val, rainbowcheck)
			if window.Visible then
				bkg.BackgroundColor3 = rainbowcheck and Color3.fromHSV(mainapi:Color((hue - (self.Index * 0.075)) % 1)) or Color3.fromHSV(hue, sat, val)
			end
		end
		
		function optionapi:ChangeValue(val)
			if val then
				local ind = table.find(self.List, val)
				if ind then
					table.remove(self.List, ind)
					ind = table.find(self.ListEnabled, val)
					if ind then
						table.remove(self.ListEnabled, ind)
					end
				else
					table.insert(self.List, val)
					table.insert(self.ListEnabled, val)
				end
			end
		
			optionsettings.Function(self.List)
			for _, v in self.Objects do
				v:Destroy()
			end
			table.clear(self.Objects)
			self.ObjectList = self.Objects
			window.Size = UDim2.fromOffset(220, 85 + (#self.List * 35))
			amount.Text = #self.List
		
			local enabledtext = 'None'
			for i, v in self.ListEnabled do
				if i == 1 then enabledtext = '' end
				enabledtext = enabledtext..(i == 1 and v or ', '..v)
			end
			items.Text = enabledtext
		
			for i, v in self.List do
				local enabled = table.find(self.ListEnabled, v)
				local object = Instance.new('TextButton')
				object.Name = v
				object.Size = UDim2.fromOffset(200, 32)
				object.Position = UDim2.fromOffset(10, 47 + (i * 35))
				object.BackgroundColor3 = uipallet.SurfaceAlt
				object.AutoButtonColor = false
				object.Text = ''
				object.Parent = window
				styleShell(object, UDim.new(0, 8), 0.66)
				local objectbkg = Instance.new('Frame')
				objectbkg.Name = 'BKG'
				objectbkg.Size = UDim2.new(1, -2, 1, -2)
				objectbkg.Position = UDim2.fromOffset(1, 1)
				objectbkg.BackgroundColor3 = color.Light(uipallet.SurfaceAlt, 0.04)
				objectbkg.Visible = false
				objectbkg.Parent = object
				addCorner(objectbkg, UDim.new(0, 7))
				local objectdot = Instance.new('Frame')
				objectdot.Name = 'Dot'
				objectdot.Size = UDim2.fromOffset(10, 11)
				objectdot.Position = UDim2.fromOffset(10, 12)
				objectdot.BackgroundColor3 = enabled and optionsettings.Color or color.Light(uipallet.Main, 0.37)
				objectdot.Parent = object
				addCorner(objectdot, UDim.new(1, 0))
				local objectdotin = objectdot:Clone()
				objectdotin.Size = UDim2.fromOffset(8, 9)
				objectdotin.Position = UDim2.fromOffset(1, 1)
				objectdotin.BackgroundColor3 = enabled and optionsettings.Color or uipallet.Surface
				objectdotin.Parent = objectdot
				local objecttitle = Instance.new('TextLabel')
				objecttitle.Name = 'Title'
				objecttitle.Size = UDim2.new(1, -30, 1, 0)
				objecttitle.Position = UDim2.fromOffset(30, 0)
				objecttitle.BackgroundTransparency = 1
				objecttitle.Text = v
				objecttitle.TextXAlignment = Enum.TextXAlignment.Left
				objecttitle.TextColor3 = color.Dark(uipallet.Text, 0.1)
				objecttitle.TextSize = 15
				objecttitle.FontFace = uipallet.Font
				objecttitle.Parent = object
				local close = Instance.new('ImageButton')
				close.Name = 'Close'
				close.Size = UDim2.fromOffset(16, 16)
				close.Position = UDim2.new(1, -26, 0, 8)
				close.BackgroundColor3 = uipallet.Surface
				close.BackgroundTransparency = 0.45
				close.AutoButtonColor = false
				close.Image = getcustomasset('vape/assets/closemini.png')
				close.ImageColor3 = color.Light(uipallet.Text, 0.2)
				close.ImageTransparency = 0.5
				close.Parent = object
				addCorner(close, UDim.new(1, 0))
		
				close.MouseEnter:Connect(function()
					close.ImageTransparency = 0.3
					tween:Tween(close, uipallet.Tween, {
						BackgroundTransparency = 0.25
					})
				end)
				close.MouseLeave:Connect(function()
					close.ImageTransparency = 0.5
					tween:Tween(close, uipallet.Tween, {
						BackgroundTransparency = 0.45
					})
				end)
				close.MouseButton1Click:Connect(function()
					self:ChangeValue(v)
				end)
				object.MouseEnter:Connect(function()
					objectbkg.Visible = true
				end)
				object.MouseLeave:Connect(function()
					objectbkg.Visible = false
				end)
				object.MouseButton1Click:Connect(function()
					local ind = table.find(self.ListEnabled, v)
					if ind then
						table.remove(self.ListEnabled, ind)
						objectdot.BackgroundColor3 = color.Light(uipallet.Main, 0.37)
						objectdotin.BackgroundColor3 = uipallet.Surface
					else
						table.insert(self.ListEnabled, v)
						objectdot.BackgroundColor3 = optionsettings.Color
						objectdotin.BackgroundColor3 = optionsettings.Color
					end
		
					local enabledtext = 'None'
					for i, v in self.ListEnabled do
						if i == 1 then enabledtext = '' end
						enabledtext = enabledtext..(i == 1 and v or ', '..v)
					end
		
					items.Text = enabledtext
					optionsettings.Function()
				end)
		
				table.insert(self.Objects, object)
				self.ObjectList = self.Objects
			end
		end
		
		addbutton.MouseEnter:Connect(function()
			addbutton.ImageTransparency = 0
		end)
		addbutton.MouseLeave:Connect(function()
			addbutton.ImageTransparency = 0.3
		end)
		addbutton.MouseButton1Click:Connect(function()
			if not table.find(optionapi.List, addvalue.Text) then
				optionapi:ChangeValue(addvalue.Text)
				addvalue.Text = ''
			end
		end)
		addvalue.FocusLost:Connect(function(enter)
			if enter and not table.find(optionapi.List, addvalue.Text) then
				optionapi:ChangeValue(addvalue.Text)
				addvalue.Text = ''
			end
		end)
		addvalue.MouseEnter:Connect(function()
			tween:Tween(addbkg, uipallet.Tween, {
				BackgroundColor3 = color.Light(uipallet.Main, 0.14)
			})
		end)
		addvalue.MouseLeave:Connect(function()
			tween:Tween(addbkg, uipallet.Tween, {
				BackgroundColor3 = color.Light(uipallet.Main, 0.02)
			})
		end)
		close.MouseButton1Click:Connect(function()
			window.Visible = false
		end)
		button.MouseButton1Click:Connect(function()
			window.Visible = not window.Visible
			tween:Cancel(bkg)
			bkg.BackgroundColor3 = window.Visible and Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value) or color.Light(uipallet.Main, 0.37)
		end)
		textlist.MouseEnter:Connect(function()
			if not optionapi.Window.Visible then
				tween:Tween(bkg, uipallet.Tween, {
					BackgroundColor3 = color.Light(uipallet.Main, 0.37)
				})
			end
		end)
		textlist.MouseLeave:Connect(function()
			if not optionapi.Window.Visible then
				tween:Tween(bkg, uipallet.Tween, {
					BackgroundColor3 = color.Light(uipallet.Main, 0.034)
				})
			end
		end)
		textlist:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
			if mainapi.ThreadFix then
				setthreadidentity(8)
			end
			local actualPosition = (textlist.AbsolutePosition - (api.Legit and mainapi.Legit.Window.AbsolutePosition or -guiService:GetGuiInset())) / scale.Scale
			window.Position = UDim2.fromOffset(actualPosition.X + 220, actualPosition.Y)
		end)
		
		if optionsettings.Default then
			optionapi:ChangeValue()
		end
		optionapi.Object = textlist
		api.Options[optionsettings.Name] = optionapi
		
		return compatOption(optionapi)
	end,
	Toggle = function(optionsettings, children, api)
		optionsettings.Function = hookCF(optionsettings.Function, optionsettings)
		local optionapi = {
			Type = 'Toggle',
			Enabled = false,
			Index = getTableSize(api.Options)
		}
		
		local toggle = Instance.new('TextButton')
		toggle.Name = optionsettings.Name..'Toggle'
		toggle.Size = UDim2.new(1, 0, 0, 34)
		toggle.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		toggle.BorderSizePixel = 0
		toggle.AutoButtonColor = false
		toggle.Visible = optionsettings.Visible == nil or optionsettings.Visible
		toggle.Text = '          '..optionsettings.Name
		toggle.TextXAlignment = Enum.TextXAlignment.Left
		toggle.TextColor3 = color.Dark(uipallet.Text, 0.1)
		toggle.TextSize = 14
		toggle.FontFace = uipallet.Font
		toggle.Parent = children
		addTooltip(toggle, optionsettings.Tooltip)
		local knobholder = Instance.new('Frame')
		knobholder.Name = 'Knob'
		knobholder.Size = UDim2.fromOffset(28, 14)
		knobholder.Position = UDim2.new(1, -36, 0, 10)
		knobholder.BackgroundColor3 = color.Light(uipallet.Main, 0.12)
		knobholder.Parent = toggle
		addCorner(knobholder, UDim.new(1, 0))
		addStroke(knobholder, uipallet.Border, 1, 0.66)
		local knob = knobholder:Clone()
		knob.Size = UDim2.fromOffset(10, 10)
		knob.Position = UDim2.fromOffset(2, 2)
		knob.BackgroundColor3 = uipallet.Surface
		knob.Parent = knobholder
		local hovered = false
		optionsettings.Function = optionsettings.Function or function() end
		
		function optionapi:Save(tab)
			tab[optionsettings.Name] = {Enabled = self.Enabled}
		end
		
		function optionapi:Load(tab)
			if self.Enabled ~= tab.Enabled then
				self:Toggle()
			end
		end
		
		function optionapi:Color(hue, sat, val, rainbowcheck)
			if self.Enabled then
				tween:Cancel(knobholder)
				knobholder.BackgroundColor3 = rainbowcheck and Color3.fromHSV(mainapi:Color((hue - (self.Index * 0.075)) % 1)) or Color3.fromHSV(hue, sat, val)
			end
		end
		
		function optionapi:Toggle()
			self.Enabled = not self.Enabled
			local rainbowcheck = mainapi.GUIColor.Rainbow and mainapi.RainbowMode.Value ~= 'Retro'
			tween:Tween(knobholder, uipallet.Tween, {
				BackgroundColor3 = self.Enabled and (rainbowcheck and Color3.fromHSV(mainapi:Color((mainapi.GUIColor.Hue - (self.Index * 0.075)) % 1)) or Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)) or (hovered and color.Light(uipallet.Main, 0.37) or color.Light(uipallet.Main, 0.14))
			})
			tween:Tween(knob, uipallet.Tween, {
				Position = UDim2.fromOffset(self.Enabled and 16 or 2, 2)
			})
			optionsettings.Function(self.Enabled)
		end

		optionapi.ToggleButton = function()
			optionapi:Toggle()
		end
		
		toggle.MouseEnter:Connect(function()
			hovered = true
			if not optionapi.Enabled then
				tween:Tween(knobholder, uipallet.Tween, {
					BackgroundColor3 = color.Light(uipallet.Main, 0.37)
				})
			end
		end)
		toggle.MouseLeave:Connect(function()
			hovered = false
			if not optionapi.Enabled then
				tween:Tween(knobholder, uipallet.Tween, {
					BackgroundColor3 = color.Light(uipallet.Main, 0.14)
				})
			end
		end)
		toggle.MouseButton1Click:Connect(function()
			optionapi:Toggle()
		end)
		
		if optionsettings.Default then
			optionapi:Toggle()
		end
		optionapi.Object = toggle
		api.Options[optionsettings.Name] = optionapi
		
		return compatOption(optionapi)
	end,
	TwoSlider = function(optionsettings, children, api)
		optionsettings.Function = hookCF(optionsettings.Function, optionsettings)
		local optionapi = {
			Type = 'TwoSlider',
			ValueMin = optionsettings.DefaultMin or optionsettings.Min,
			ValueMax = optionsettings.DefaultMax or 10,
			Max = optionsettings.Max,
			Index = getTableSize(api.Options)
		}
		
		local slider = Instance.new('TextButton')
		slider.Name = optionsettings.Name..'Slider'
		slider.Size = UDim2.new(1, 0, 0, 54)
		slider.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		slider.BorderSizePixel = 0
		slider.AutoButtonColor = false
		slider.Visible = optionsettings.Visible == nil or optionsettings.Visible
		slider.Text = ''
		slider.Parent = children
		addTooltip(slider, optionsettings.Tooltip)
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.fromOffset(60, 30)
		title.Position = UDim2.fromOffset(10, 2)
		title.BackgroundTransparency = 1
		title.Text = optionsettings.Name
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = color.Dark(uipallet.Text, 0.16)
		title.TextSize = 11
		title.FontFace = uipallet.Font
		title.Parent = slider
		local valuebutton = Instance.new('TextButton')
		valuebutton.Name = 'Value'
		valuebutton.Size = UDim2.fromOffset(60, 15)
		valuebutton.Position = UDim2.new(1, -69, 0, 9)
		valuebutton.BackgroundTransparency = 1
		valuebutton.Text = optionapi.ValueMax
		valuebutton.TextXAlignment = Enum.TextXAlignment.Right
		valuebutton.TextColor3 = color.Dark(uipallet.Text, 0.16)
		valuebutton.TextSize = 11
		valuebutton.FontFace = uipallet.Font
		valuebutton.Parent = slider
		local valuebutton2 = valuebutton:Clone()
		valuebutton2.Position = UDim2.new(1, -125, 0, 9)
		valuebutton2.Text = optionapi.ValueMin
		valuebutton2.Parent = slider
		local valuebox = Instance.new('TextBox')
		valuebox.Name = 'Box'
		valuebox.Size = valuebutton.Size
		valuebox.Position = valuebutton.Position
		valuebox.BackgroundTransparency = 1
		valuebox.Visible = false
		valuebox.Text = optionapi.ValueMin
		valuebox.TextXAlignment = Enum.TextXAlignment.Right
		valuebox.TextColor3 = color.Dark(uipallet.Text, 0.16)
		valuebox.TextSize = 11
		valuebox.FontFace = uipallet.Font
		valuebox.ClearTextOnFocus = false
		valuebox.Parent = slider
		local valuebox2 = valuebox:Clone()
		valuebox2.Position = valuebutton2.Position
		valuebox2.Parent = slider
		local bkg = Instance.new('Frame')
		bkg.Name = 'Slider'
		bkg.Size = UDim2.new(1, -20, 0, 2)
		bkg.Position = UDim2.fromOffset(10, 39)
		bkg.BackgroundColor3 = color.Light(uipallet.Main, 0.034)
		bkg.BorderSizePixel = 0
		bkg.Parent = slider
		local fill = bkg:Clone()
		fill.Name = 'Fill'
		fill.Position = UDim2.fromScale(math.clamp(optionapi.ValueMin / optionsettings.Max, 0.04, 0.96), 0)
		fill.Size = UDim2.fromScale(math.clamp(math.clamp(optionapi.ValueMax / optionsettings.Max, 0, 1), 0.04, 0.96) - fill.Position.X.Scale, 1)
		fill.BackgroundColor3 = getAccentColor()
		fill.Parent = bkg
		local knobholder = Instance.new('Frame')
		knobholder.Name = 'Knob'
		knobholder.Size = UDim2.fromOffset(16, 4)
		knobholder.Position = UDim2.fromScale(0, 0.5)
		knobholder.AnchorPoint = Vector2.new(0.5, 0.5)
		knobholder.BackgroundColor3 = slider.BackgroundColor3
		knobholder.BorderSizePixel = 0
		knobholder.Parent = fill
		local knob = Instance.new('ImageLabel')
		knob.Name = 'Knob'
		knob.Size = UDim2.fromOffset(9, 16)
		knob.Position = UDim2.fromScale(0.5, 0.5)
		knob.AnchorPoint = Vector2.new(0.5, 0.5)
		knob.BackgroundTransparency = 1
		knob.Image = getcustomasset('vape/assets/range.png')
		knob.ImageColor3 = Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
		knob.Parent = knobholder
		local knobholdermax = knobholder:Clone()
		knobholdermax.Name = 'KnobMax'
		knobholdermax.Position = UDim2.fromScale(1, 0.5)
		knobholdermax.Parent = fill
		knobholdermax.Knob.Rotation = 180
		local arrow = Instance.new('ImageLabel')
		arrow.Name = 'Arrow'
		arrow.Size = UDim2.fromOffset(12, 6)
		arrow.Position = UDim2.new(1, -56, 0, 10)
		arrow.BackgroundTransparency = 1
		arrow.Image = getcustomasset('vape/assets/rangearrow.png')
		arrow.ImageColor3 = color.Light(uipallet.Main, 0.14)
		arrow.Parent = slider
		optionsettings.Function = optionsettings.Function or function() end
		optionsettings.Decimal = optionsettings.Decimal or 1
		local random = Random.new()
		
		function optionapi:Save(tab)
			tab[optionsettings.Name] = {ValueMin = self.ValueMin, ValueMax = self.ValueMax}
		end
		
		function optionapi:Load(tab)
			if self.ValueMin ~= tab.ValueMin then
				self:SetValue(false, tab.ValueMin)
			end
			if self.ValueMax ~= tab.ValueMax then
				self:SetValue(true, tab.ValueMax)
			end
		end
		
		function optionapi:Color(hue, sat, val, rainbowcheck)
			fill.BackgroundColor3 = rainbowcheck and Color3.fromHSV(mainapi:Color((hue - (self.Index * 0.075)) % 1)) or Color3.fromHSV(hue, sat, val)
			knob.ImageColor3 = fill.BackgroundColor3
			knobholdermax.Knob.ImageColor3 = fill.BackgroundColor3
		end
		
		function optionapi:GetRandomValue()
			return random:NextNumber(optionapi.ValueMin, optionapi.ValueMax)
		end
		
		function optionapi:SetValue(max, value)
			if tonumber(value) == math.huge or value ~= value then return end
			self[max and 'ValueMax' or 'ValueMin'] = value
			valuebutton.Text = self.ValueMax
			valuebutton2.Text = self.ValueMin
			local size = math.clamp(math.clamp(self.ValueMin / optionsettings.Max, 0, 1), 0.04, 0.96)
			tween:Tween(fill, TweenInfo.new(0.1), {
				Position = UDim2.fromScale(size, 0),
				Size = UDim2.fromScale(math.clamp(math.clamp(math.clamp(self.ValueMax / optionsettings.Max, 0.04, 0.96), 0.04, 0.96) - size, 0, 1), 1)
			})
		end
		
		knobholder.MouseEnter:Connect(function()
			tween:Tween(knob, uipallet.Tween, {
				Size = UDim2.fromOffset(11, 18)
			})
		end)
		knobholder.MouseLeave:Connect(function()
			tween:Tween(knob, uipallet.Tween, {
				Size = UDim2.fromOffset(9, 16)
			})
		end)
		knobholdermax.MouseEnter:Connect(function()
			tween:Tween(knobholdermax.Knob, uipallet.Tween, {
				Size = UDim2.fromOffset(11, 18)
			})
		end)
		knobholdermax.MouseLeave:Connect(function()
			tween:Tween(knobholdermax.Knob, uipallet.Tween, {
				Size = UDim2.fromOffset(9, 16)
			})
		end)
		slider.InputBegan:Connect(function(inputObj)
			if
				(inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
				and (inputObj.Position.Y - slider.AbsolutePosition.Y) > (20 * scale.Scale)
			then
				local maxCheck = (inputObj.Position.X - knobholdermax.AbsolutePosition.X) > -10
				local newPosition = math.clamp((inputObj.Position.X - bkg.AbsolutePosition.X) / bkg.AbsoluteSize.X, 0, 1)
				optionapi:SetValue(maxCheck, math.floor((optionsettings.Min + (optionsettings.Max - optionsettings.Min) * newPosition) * optionsettings.Decimal) / optionsettings.Decimal, newPosition)
		
				local changed = inputService.InputChanged:Connect(function(input)
					if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
						local newPosition = math.clamp((input.Position.X - bkg.AbsolutePosition.X) / bkg.AbsoluteSize.X, 0, 1)
						optionapi:SetValue(maxCheck, math.floor((optionsettings.Min + (optionsettings.Max - optionsettings.Min) * newPosition) * optionsettings.Decimal) / optionsettings.Decimal, newPosition)
					end
				end)
		
				local ended
				ended = inputObj.Changed:Connect(function()
					if inputObj.UserInputState == Enum.UserInputState.End then
						if changed then
							changed:Disconnect()
						end
						if ended then
							ended:Disconnect()
						end
					end
				end)
			end
		end)
		valuebutton.MouseButton1Click:Connect(function()
			valuebutton.Visible = false
			valuebox.Visible = true
			valuebox.Text = optionapi.ValueMax
			valuebox:CaptureFocus()
		end)
		valuebutton2.MouseButton1Click:Connect(function()
			valuebutton2.Visible = false
			valuebox2.Visible = true
			valuebox2.Text = optionapi.ValueMin
			valuebox2:CaptureFocus()
		end)
		valuebox.FocusLost:Connect(function(enter)
			valuebutton.Visible = true
			valuebox.Visible = false
			if enter and tonumber(valuebox.Text) then
				optionapi:SetValue(true, tonumber(valuebox.Text))
			end
		end)
		valuebox2.FocusLost:Connect(function(enter)
			valuebutton2.Visible = true
			valuebox2.Visible = false
			if enter and tonumber(valuebox2.Text) then
				optionapi:SetValue(false, tonumber(valuebox2.Text))
			end
		end)
		
		optionapi.Object = slider
		api.Options[optionsettings.Name] = optionapi
		
		return compatOption(optionapi)
	end,
	Divider = function(children, text)
		local divider = Instance.new('Frame')
		divider.Name = 'Divider'
		divider:SetAttribute('SilentwareRole', 'SettingsDivider')
		divider.Size = UDim2.new(1, 0, 0, 1)
		divider.BackgroundColor3 = color.Light(uipallet.Main, 0.08)
		divider.BorderSizePixel = 0
		divider.Parent = children
		if text then
			local label = Instance.new('TextLabel')
			label.Name = 'DividerLabel'
			label.Size = UDim2.fromOffset(218, 30)
			label.BackgroundTransparency = 1
			label.Text = '          '..text:upper()
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.TextColor3 = color.Dark(uipallet.Text, 0.47)
			label.TextSize = 10
			label.FontFace = uipallet.Font
			label.Parent = children
			divider.Position = UDim2.fromOffset(0, 29)
			divider.Parent = label
		end
	end
}

mainapi.Components = setmetatable(components, {
	__newindex = function(self, ind, func)
		for _, v in mainapi.Modules do
			rawset(v, 'Create'..ind, function(_, settings)
				return func(settings, v.Children, v)
			end)
		end

		if mainapi.Legit then
			for _, v in mainapi.Legit.Modules do
				rawset(v, 'Create'..ind, function(_, settings)
					return func(settings, v.Children, v)
				end)
			end
		end

		rawset(self, ind, func)
	end
})

task.spawn(function()
	repeat
		-- Premium themes are preset-only now. Keep the legacy rainbow table dormant so old configs cannot lag the game.
		if mainapi.GUIColor then mainapi.GUIColor.Rainbow = false end
		task.wait(2)
	until mainapi.Loaded == nil
end)

task.spawn(function()
	while mainapi.Loaded ~= nil do
		if mainapi.RainbowTheme then
			refreshRainbowThemeFast()
		end
		task.wait(mainapi.RainbowTheme and 0.85 or 1.25)
	end
end)

function mainapi:BlurCheck()
	local enabled = clickgui and clickgui.Visible and self.Blur and self.Blur.Enabled
	if self.ThreadFix then
		setthreadidentity(8)
		runService:SetRobloxGuiFocused((clickgui.Visible or guiService:GetErrorType() ~= Enum.ConnectionError.OK) and self.Blur.Enabled)
	end
	pcall(function()
		if not interfaceBlur then
			interfaceBlur = Instance.new('BlurEffect')
			interfaceBlur.Name = 'SilentwareInterfaceBlur'
			interfaceBlur.Size = 0
			interfaceBlur.Parent = lightingService
		end
		interfaceBlur.Enabled = enabled == true
		tween:Tween(interfaceBlur, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = enabled and 13 or 0})
	end)
	if mainapi.GlassBackdrop then
		mainapi.GlassBackdrop.Visible = enabled == true
		tween:Tween(mainapi.GlassBackdrop, uipallet.Tween, {BackgroundTransparency = enabled and 0.68 or 1})
	end
	if mainapi.PremiumShell then
		tween:Tween(mainapi.PremiumShell, uipallet.Tween, {BackgroundTransparency = enabled and math.min((uipallet.GlassTransparency or 0.06) + 0.035, 0.16) or (uipallet.GlassTransparency or 0.06)})
	end
end

addMaid(mainapi)

function mainapi:RefreshAccessLocks()
	self.Access = shared.SilentwareAccess or self.Access or access
	for _, moduleapi in pairs(self.Modules) do
		if type(moduleapi.ApplyAccessState) == 'function' then
			moduleapi:ApplyAccessState()
		end
	end
end

function mainapi:CreateGUI()
	local categoryapi = {
		Type = 'MainWindow',
		Buttons = {},
		Options = {}
	}

	createStartupLoader()

	local glassBackdrop = Instance.new('Frame')
	glassBackdrop.Name = 'GlassBackdrop'
	glassBackdrop.Size = UDim2.fromScale(1, 1)
	glassBackdrop.BackgroundColor3 = uipallet.Main
	glassBackdrop.BackgroundTransparency = 1
	glassBackdrop.BorderSizePixel = 0
	glassBackdrop.Visible = false
	glassBackdrop.ZIndex = 0
	glassBackdrop.Parent = clickgui
	mainapi.GlassBackdrop = glassBackdrop

	local shell = makePremiumWindowFrame(clickgui, 'PremiumMainWindow', UDim2.fromOffset(842, 602), UDim2.fromScale(0.5, 0.5))
	shell.AnchorPoint = Vector2.new(0.5, 0.5)
	shell.ClipsDescendants = false
	mainapi.PremiumShell = shell
	mainapi.PremiumShadow = addShadow(shell, 'PremiumDropShadow', 0.58, 78, 10)
	mainapi.PremiumGlow = addGlow(shell, 'PremiumOuterGlow', 0.86, 54)
	mainapi.PremiumGlow.ImageColor3 = uipallet.AccentGlow or uipallet.Accent
	local shellscale = Instance.new('UIScale')
	shellscale.Name = 'OpenScale'
	shellscale.Scale = 0.965
	shellscale.Parent = shell
	mainapi.PremiumScale = shellscale

	local shellGradient = addSurfaceGradient(shell, color.Light(uipallet.Surface, 0.045), uipallet.Main, 90)
	-- Ambient orbs were removed because executor image scaling made them appear as ugly transparent squares.

	local innerGlow = Instance.new('Frame')
	innerGlow.Name = 'InnerAccentGlow'
	innerGlow.Size = UDim2.new(1, -28, 0, 58)
	innerGlow.Position = UDim2.fromOffset(14, 10)
	innerGlow.BackgroundColor3 = uipallet.Accent
	innerGlow.BackgroundTransparency = 0.88
	innerGlow.BorderSizePixel = 0
	innerGlow.ZIndex = 1
	innerGlow.Parent = shell
	addCorner(innerGlow, UDim.new(0, 16))
	local innerGrad = Instance.new('UIGradient')
	innerGrad.Rotation = 90
	innerGrad.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.35),
		NumberSequenceKeypoint.new(1, 1)
	})
	innerGrad.Parent = innerGlow

	local topbar = Instance.new('Frame')
	topbar.Name = 'Topbar'
	topbar.Size = UDim2.new(1, 0, 0, 58)
	topbar.BackgroundTransparency = 1
	topbar.ZIndex = 8
	topbar.Parent = shell

	local logo = Instance.new('TextLabel')
	logo.Name = 'VapeLogo'
	logo.Size = UDim2.fromOffset(198, 28)
	logo.Position = UDim2.fromOffset(24, 15)
	logo.BackgroundTransparency = 1
	logo.Text = 'Silentware'
	logo.TextXAlignment = Enum.TextXAlignment.Left
	logo.TextColor3 = uipallet.Text
	logo.TextSize = 20
	logo.FontFace = uipallet.FontSemiBold
	logo.Parent = topbar
	mainapi.PremiumTitle = logo
	local logoGlowText = logo:Clone()
	logoGlowText.Name = 'VapeLogoGlow'
	logoGlowText.TextColor3 = uipallet.AccentGlow or uipallet.Accent
	logoGlowText.TextTransparency = 0.78
	logoGlowText.Position = logo.Position + UDim2.fromOffset(1, 0)
	logoGlowText.ZIndex = math.max((safeZIndex(logo) or 1) - 1, 1)
	logoGlowText.Parent = topbar
	mainapi.PremiumTitleGlow = logoGlowText

	local subtitle = Instance.new('TextLabel')
	subtitle.Name = 'Subtitle'
	subtitle.Size = UDim2.fromOffset(240, 18)
	subtitle.Position = UDim2.fromOffset(24, 39)
	subtitle.BackgroundTransparency = 1
	subtitle.Text = 'v1.0'
	subtitle.TextXAlignment = Enum.TextXAlignment.Left
	subtitle.TextColor3 = uipallet.MutedText
	subtitle.TextSize = 11
	subtitle.FontFace = uipallet.Font
	subtitle.Parent = topbar

	local tierpill = Instance.new('TextLabel')
	tierpill.Name = 'AccessTierPill'
	tierpill.Size = UDim2.fromOffset(92, 22)
	tierpill.Position = UDim2.fromOffset(126, 18)
	tierpill.BackgroundColor3 = color.Light(uipallet.Main, 0.08)
	tierpill.BackgroundTransparency = 0.12
	tierpill.BorderSizePixel = 0
	tierpill.Text = tostring((access.DisplayNames and access.DisplayNames[access.Tier]) or access.Tier or 'Free')
	tierpill.TextColor3 = getAccentColor()
	tierpill.TextSize = 10
	tierpill.FontFace = uipallet.FontSemiBold
	tierpill.Parent = topbar
	addCorner(tierpill, UDim.new(1, 0))
	addStroke(tierpill, getAccentColor(), 1, 0.42)
	local tierGlow = addGlow(tierpill, 'TierGlow', 0.7, 52)
	tierGlow.ImageColor3 = getAccentColor()
	mainapi.AccessTierPill = tierpill

	local accentbar = Instance.new('Frame')
	accentbar.Name = 'AccentBar'
	accentbar.Size = UDim2.fromOffset(126, 2)
	accentbar.Position = UDim2.new(1, -152, 0, 30)
	accentbar.BackgroundColor3 = uipallet.Accent
	accentbar.BorderSizePixel = 0
	accentbar.Visible = false
	accentbar.Parent = topbar
	addCorner(accentbar, UDim.new(1, 0))
	local accentGlow = addGlow(accentbar, 'AccentGlow', 0.42, 46)
	accentGlow.ImageColor3 = uipallet.Accent
	local accentgrad = Instance.new('UIGradient')
	accentgrad.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.35, 0.15),
		NumberSequenceKeypoint.new(1, 0.38)
	})
	accentgrad.Parent = accentbar

	local headerline = Instance.new('Frame')
	headerline.Name = 'HeaderDivider'
	headerline.Size = UDim2.new(1, -34, 0, 1)
	headerline.Position = UDim2.fromOffset(17, 58)
	headerline.BackgroundColor3 = uipallet.Border
	headerline.BackgroundTransparency = 0.58
	headerline.BorderSizePixel = 0
	headerline.Parent = shell

	local sidebar = Instance.new('Frame')
	sidebar.Name = 'Sidebar'
	sidebar.Size = UDim2.fromOffset(246, 516)
	sidebar.Position = UDim2.fromOffset(18, 70)
	sidebar.BackgroundColor3 = color.Light(uipallet.Main, 0.015)
	sidebar.BackgroundTransparency = 0.07
	sidebar.BorderSizePixel = 0
	sidebar.ClipsDescendants = false
	sidebar.Parent = shell
	addCorner(sidebar, UDim.new(0, 14))
	addStroke(sidebar, uipallet.Border, 1, 0.56)
	-- shadow intentionally kept off sidebar to avoid translucent square artifacts

	local content = Instance.new('Frame')
	content.Name = 'Content'
	content.Size = UDim2.fromOffset(550, 516)
	content.Position = UDim2.fromOffset(276, 70)
	content.BackgroundColor3 = color.Light(uipallet.Main, 0.012)
	content.BackgroundTransparency = uipallet.PanelTransparency or 0.05
	content.BorderSizePixel = 0
	content.ClipsDescendants = false
	content.Parent = shell
	addCorner(content, UDim.new(0, 14))
	addStroke(content, uipallet.Border, 1, 0.52)
	-- shadow intentionally kept off content panel to avoid translucent square artifacts
	mainapi.PremiumContent = content
	mainapi.PremiumSidebar = sidebar

	local window = Instance.new('TextButton')
	window.Name = 'GUICategory'
	window.Size = UDim2.new(1, -18, 1, -18)
	window.Position = UDim2.fromOffset(9, 9)
	window.BackgroundTransparency = 1
	window.AutoButtonColor = false
	window.ClipsDescendants = true
	window.Text = ''
	window.Parent = sidebar

	local children = Instance.new('ScrollingFrame')
	children.Name = 'Children'
	children.Size = UDim2.new(1, 0, 1, -6)
	children.Position = UDim2.fromOffset(0, 6)
	children.BackgroundTransparency = 1
	children.BorderSizePixel = 0
	children.Parent = window
	configureScroll(children, 4, 0.38)
	local windowlist = Instance.new('UIListLayout')
	windowlist.SortOrder = Enum.SortOrder.LayoutOrder
	windowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
	windowlist.Parent = children
	styleListLayout(windowlist, 6)
	windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		if children:IsA('ScrollingFrame') then
			children.CanvasSize = UDim2.fromOffset(0, windowlist.AbsoluteContentSize.Y / scale.Scale + 12)
		end
	end)
	local settingsbutton = Instance.new('TextButton')
	settingsbutton.Name = 'SettingsButton'
	settingsbutton.Size = UDim2.fromOffset(38, 38)
	settingsbutton.Position = UDim2.new(1, -62, 0, 11)
	settingsbutton.BackgroundColor3 = uipallet.SurfaceAlt
	settingsbutton.BackgroundTransparency = 0.15
	settingsbutton.Text = ''
	settingsbutton.Parent = topbar
	addCorner(settingsbutton, UDim.new(0, 11))
	addStroke(settingsbutton, uipallet.Border, 1, 0.58)
	addTooltip(settingsbutton, 'Open settings')
	local settingsicon = Instance.new('ImageLabel')
	settingsicon.Name = 'SettingsIcon'
	settingsicon.Size = UDim2.fromOffset(15, 15)
	settingsicon.Position = UDim2.fromOffset(12, 11)
	settingsicon.BackgroundTransparency = 1
	settingsicon.Image = getcustomasset('vape/assets/guisettings.png')
	settingsicon.ImageColor3 = uipallet.Accent
	settingsicon.Parent = settingsbutton
	mainapi.SettingsIcon = settingsicon
	mainapi.SettingsButton = settingsbutton
	local settingspane = Instance.new('TextButton')
	settingspane.Size = UDim2.fromOffset(438, 390)
	settingspane.AnchorPoint = Vector2.new(0.5, 0.5)
	settingspane.Position = UDim2.fromScale(0.5, 0.5)
	settingspane.BackgroundColor3 = uipallet.Surface
	settingspane.BackgroundTransparency = uipallet.PanelTransparency or 0.02
	settingspane.AutoButtonColor = false
	settingspane:SetAttribute('SilentwareRole', 'SettingsRoot')
	settingspane.Visible = false
	settingspane.Text = ''
	settingspane.Parent = shell
	settingspane.ZIndex = 30
	addCorner(settingspane, UDim.new(0, 18))
	addShadow(settingspane, 'SettingsShadow', 0.62, 54, 8)
	local title = Instance.new('TextLabel')
	title.Name = 'Title'
	title.Size = UDim2.new(1, -36, 0, 20)
	title.Position = UDim2.fromOffset(36, 12)
	title.BackgroundTransparency = 1
	title.Text = 'Settings'
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.TextColor3 = uipallet.Text
	title.TextSize = 13
	title.FontFace = uipallet.Font
	title.Parent = settingspane
	local close = addCloseButton(settingspane)
	local back = Instance.new('ImageButton')
	back.Name = 'Back'
	back.Size = UDim2.fromOffset(16, 16)
	back.Position = UDim2.fromOffset(11, 13)
	back.BackgroundTransparency = 1
	back.Image = getcustomasset('vape/assets/back.png')
	back.ImageColor3 = color.Light(uipallet.Main, 0.37)
	back.Parent = settingspane
	local settingsversion = Instance.new('TextLabel')
	settingsversion.Name = 'Version'
	settingsversion.Size = UDim2.new(1, 0, 0, 16)
	settingsversion.Position = UDim2.new(0, 0, 1, -16)
	settingsversion.BackgroundTransparency = 1
	settingsversion.Text = 'Silentware v1 '
	settingsversion.TextColor3 = uipallet.MutedText
	settingsversion.TextXAlignment = Enum.TextXAlignment.Right
	settingsversion.TextSize = 10
	settingsversion.FontFace = uipallet.Font
	settingsversion.Parent = settingspane
	addCorner(settingspane, UDim.new(0, 14))
	addStroke(settingspane, uipallet.Border, 1, 0.3)
	local settingsScale = Instance.new('UIScale')
	settingsScale.Name = 'OpenScale'
	settingsScale.Scale = 1
	settingsScale.Parent = settingspane
	local settingschildren = Instance.new('ScrollingFrame')
	settingschildren.Name = 'Children'
	settingschildren:SetAttribute('SilentwareRole', 'SettingsChildren')
	settingschildren.Size = UDim2.new(1, -24, 1, -72)
	settingschildren.Position = UDim2.fromOffset(12, 46)
	settingschildren.BackgroundColor3 = uipallet.Surface
	settingschildren.BackgroundTransparency = 1
	settingschildren.BorderSizePixel = 0
	settingschildren.Parent = settingspane
	configureScroll(settingschildren, 4, 0.42)
	local settingswindowlist = Instance.new('UIListLayout')
	settingswindowlist.SortOrder = Enum.SortOrder.LayoutOrder
	settingswindowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
	settingswindowlist.Parent = settingschildren
	styleListLayout(settingswindowlist, 4)
	settingswindowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		if settingschildren:IsA('ScrollingFrame') then
			settingschildren.CanvasSize = UDim2.fromOffset(0, settingswindowlist.AbsoluteContentSize.Y / scale.Scale + 12)
		end
	end)
	categoryapi.Object = window

	function categoryapi:CreateBind()
		local optionapi = {Bind = {'RightShift'}}

		local button = Instance.new('TextButton')
		button.Name = 'RebindGuiButton'
		button:SetAttribute('SilentwareRole', 'SettingsNavButton')
		button.Size = UDim2.fromOffset(220, 40)
		button.BackgroundColor3 = uipallet.SurfaceAlt
		button.BorderSizePixel = 0
		button.AutoButtonColor = false
		button.Text = '          Rebind GUI'
		button.TextXAlignment = Enum.TextXAlignment.Left
		button.TextColor3 = color.Dark(uipallet.Text, 0.16)
		button.TextSize = 14
		button.FontFace = uipallet.Font
		button.Parent = settingschildren
		styleShell(button, UDim.new(0, 8), 0.66)
		addTooltip(button, 'Change the bind of the GUI')
		local bind = Instance.new('TextButton')
		bind.Name = 'Bind'
		bind.Size = UDim2.fromOffset(20, 21)
		bind.Position = UDim2.new(1, -10, 0, 9)
		bind.AnchorPoint = Vector2.new(1, 0)
		bind.BackgroundColor3 = color.Light(uipallet.SurfaceAlt, 0.05)
		bind.BackgroundTransparency = 0.2
		bind.BorderSizePixel = 0
		bind.AutoButtonColor = false
		bind.Text = ''
		bind.Parent = button
		addTooltip(bind, 'Click to bind')
		addCorner(bind, UDim.new(0, 4))
		addStroke(bind, uipallet.Border, 1, 0.68)
		local icon = Instance.new('ImageLabel')
		icon.Name = 'BindIcon'
		icon.Size = UDim2.fromOffset(12, 12)
		icon.Position = UDim2.new(0.5, -6, 0, 5)
		icon.BackgroundTransparency = 1
		icon.Image = getcustomasset('vape/assets/bind.png')
		icon.ImageColor3 = uipallet.Accent
		icon.Parent = bind
		local label = Instance.new('TextLabel')
		label.Name = 'Text'
		label.Size = UDim2.fromScale(1, 1)
		label.Position = UDim2.fromOffset(0, 1)
		label.BackgroundTransparency = 1
		label.Visible = false
		label.Text = ''
		label.TextColor3 = color.Dark(uipallet.Text, 0.43)
		label.TextSize = 12
		label.FontFace = uipallet.Font
		label.Parent = bind

		function optionapi:SetBind(tab)
			if tab == nil then return end
			mainapi.Keybind = #tab <= 0 and mainapi.Keybind or table.clone(tab)
			self.Bind = mainapi.Keybind
			if mainapi.VapeButton then
				mainapi.VapeButton:Destroy()
				mainapi.VapeButton = nil
			end

			bind.Visible = true
			label.Visible = true
			icon.Visible = false
			label.Text = table.concat(mainapi.Keybind, ' + '):upper()
			bind.Size = UDim2.fromOffset(math.max(getfontsize(label.Text, label.TextSize, label.Font).X + 10, 20), 21)
		end

		bind.MouseEnter:Connect(function()
			label.Visible = false
			icon.Visible = not label.Visible
			icon.Image = getcustomasset('vape/assets/edit.png')
			icon.ImageColor3 = uipallet.Accent
		end)
		bind.MouseLeave:Connect(function()
			label.Visible = true
			icon.Visible = not label.Visible
			icon.Image = getcustomasset('vape/assets/bind.png')
			icon.ImageColor3 = uipallet.Accent
		end)
		bind.MouseButton1Click:Connect(function()
			mainapi.Binding = optionapi
		end)

		categoryapi.Options.Bind = optionapi

		return optionapi
	end

	function categoryapi:CreateButton(categorysettings)
		local optionapi = {
			Enabled = false,
			Index = getTableSize(categoryapi.Buttons)
		}

		local button = Instance.new('TextButton')
		button.Name = categorysettings.Name
		button.Size = UDim2.new(1, -8, 0, 42)
		button.BackgroundColor3 = uipallet.SurfaceAlt
		button.BorderSizePixel = 0
		button.AutoButtonColor = false
		button.Text = (categorysettings.Icon and '                                 ' or '             ')..categorysettings.Name
		button.TextXAlignment = Enum.TextXAlignment.Left
		button.TextColor3 = color.Dark(uipallet.Text, 0.12)
		button.TextSize = 14
		button.FontFace = uipallet.Font
		button.Parent = children
		styleShell(button, UDim.new(0, 10), 0.64)
		local buttonStroke = button:FindFirstChildOfClass('UIStroke')
		local accentline = Instance.new('Frame')
		accentline.Name = 'AccentLine'
		accentline.Size = UDim2.fromOffset(3, 22)
		accentline.Position = UDim2.fromOffset(0, 10)
		accentline.BackgroundColor3 = getAccentColor()
		accentline.BackgroundTransparency = 1
		accentline.BorderSizePixel = 0
		accentline.Parent = button
		addCorner(accentline, UDim.new(1, 0))
		local activeGlow = addGlow(button, 'ActiveGlow', 1, 58)
		activeGlow.ImageColor3 = getAccentColor()
		local icon
		if categorysettings.Icon then
			icon = Instance.new('ImageLabel')
			icon.Name = 'Icon'
			icon.Size = categorysettings.Size
			icon.Position = UDim2.fromOffset(13, 13)
			icon.BackgroundTransparency = 1
			icon.Image = categorysettings.Icon
			icon.ImageColor3 = color.Dark(uipallet.Text, 0.16)
			icon.Parent = button
		end
		if categorysettings.Name == 'Profiles' then
			local label = Instance.new('TextLabel')
			label.Name = 'ProfileLabel'
			label.Size = UDim2.fromOffset(53, 24)
			label.Position = UDim2.new(1, -36, 0, 8)
			label.AnchorPoint = Vector2.new(1, 0)
			label.BackgroundColor3 = color.Light(uipallet.Main, 0.04)
			label.Text = 'default'
			label.TextColor3 = color.Dark(uipallet.Text, 0.29)
			label.TextSize = 12
			label.FontFace = uipallet.Font
			label.Parent = button
			addCorner(label)
			mainapi.ProfileLabel = label
		end
		local arrow = Instance.new('Frame')
		arrow.Name = 'SelectionPip'
		arrow.Size = UDim2.fromOffset(6, 6)
		arrow.Position = UDim2.new(1, -20, 0, 18)
		arrow.BackgroundTransparency = 1
		arrow.BackgroundColor3 = getAccentColor()
		arrow.BorderSizePixel = 0
		arrow.Parent = button
		addCorner(arrow, UDim.new(1, 0))
		optionapi.Name = categorysettings.Name
		optionapi.Icon = icon
		optionapi.Object = button

		local function applyState(enabled)
			tween:Tween(arrow, uipallet.Tween, {
				BackgroundTransparency = enabled and 0.1 or 1,
				Position = UDim2.new(1, enabled and -18 or -20, 0, 18)
			})
			button.TextColor3 = enabled and getAccentColor() or color.Dark(uipallet.Text, 0.12)
			button.BackgroundColor3 = enabled and uipallet.SelectedTab or uipallet.SurfaceAlt
			accentline.BackgroundTransparency = enabled and 0 or 1
			accentline.BackgroundColor3 = getAccentColor()
			activeGlow.ImageColor3 = getAccentColor()
			tween:Tween(activeGlow, uipallet.Tween, {ImageTransparency = enabled and 0.22 or 1})
			if buttonStroke then
				buttonStroke.Color = enabled and getAccentColor() or uipallet.Border
				buttonStroke.Transparency = enabled and 0.32 or 0.64
			end
			if icon then
				icon.ImageColor3 = enabled and getAccentColor() or color.Dark(uipallet.Text, 0.16)
			end
		end

		function optionapi:Toggle(force)
			local newState = force ~= nil and force or not self.Enabled
			if newState then
				for _, other in categoryapi.Buttons do
					if other ~= self and other.Enabled then
						other.Enabled = false
						if other.Window then other.Window.Visible = false end
						if other.ApplyState then other.ApplyState(false) end
					end
				end
			end
			self.Enabled = newState
			applyState(self.Enabled)
			if categorysettings.Window then
				categorysettings.Window.Visible = self.Enabled
			end
			if categorysettings.Api and self.Enabled then
				categorysettings.Api:Expand(true)
			end
		end
		optionapi.ApplyState = applyState
		optionapi.Window = categorysettings.Window

		optionapi.ToggleButton = function()
			optionapi:Toggle()
		end

		button.MouseEnter:Connect(function()
			if not optionapi.Enabled then
				button.TextColor3 = uipallet.Text
				if icon then icon.ImageColor3 = uipallet.Text end
				button.BackgroundColor3 = color.Light(uipallet.SurfaceAlt, 0.03)
			end
		end)
		button.MouseLeave:Connect(function()
			if not optionapi.Enabled then
				button.TextColor3 = color.Dark(uipallet.Text, 0.12)
				if icon then icon.ImageColor3 = color.Dark(uipallet.Text, 0.12) end
				button.BackgroundColor3 = uipallet.SurfaceAlt
			end
		end)
		button.MouseButton1Click:Connect(function()
			optionapi:Toggle()
		end)

		categoryapi.Buttons[categorysettings.Name] = optionapi

		return optionapi
	end

	function categoryapi:CreateDivider(text)
		return components.Divider(children, text)
	end

	function categoryapi:CreateOverlayBar()
		local optionapi = {Toggles = {}}

		local bar = Instance.new('Frame')
		bar.Name = 'Overlays'
		bar.Size = UDim2.fromOffset(220, 36)
		bar.BackgroundColor3 = uipallet.Surface
		bar.BorderSizePixel = 0
		bar.Parent = children
		components.Divider(bar)
		local button = Instance.new('ImageButton')
		button.Name = 'OverlaysButtonIcon'
		button.Size = UDim2.fromOffset(24, 24)
		button.Position = UDim2.new(1, -29, 0, 7)
		button.BackgroundTransparency = 1
		button.AutoButtonColor = false
		button.Image = getcustomasset('vape/assets/overlaysicon.png')
		button.ImageColor3 = uipallet.Accent
		button.Parent = bar
		mainapi.OverlaysIcon = button
		addCorner(button, UDim.new(1, 0))
		addTooltip(button, 'Open overlays menu')
		local shadow = Instance.new('TextButton')
		shadow.Name = 'Shadow'
		shadow.Size = UDim2.new(1, 0, 1, -5)
		shadow.BackgroundColor3 = Color3.new()
		shadow.BackgroundTransparency = 1
		shadow.AutoButtonColor = false
		shadow.ClipsDescendants = true
		shadow.Visible = false
		shadow.Text = ''
		shadow.Parent = window
		addCorner(shadow)
		local window = Instance.new('Frame')
		window.Name = 'OverlaysWindow'
		window.Size = UDim2.fromOffset(220, 42)
		window.Position = UDim2.fromScale(0, 1)
		window.BackgroundColor3 = uipallet.Surface
		window.Parent = shadow
		styleShell(window, UDim.new(0, 10), 0.48)
		local icon = Instance.new('ImageLabel')
		icon.Name = 'OverlayMenuIcon'
		icon.Size = UDim2.fromOffset(14, 12)
		icon.Position = UDim2.fromOffset(10, 13)
		icon.BackgroundTransparency = 1
		icon.Image = getcustomasset('vape/assets/overlaystab.png')
		icon.ImageColor3 = uipallet.Accent
		icon.Parent = window
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.new(1, -36, 0, 38)
		title.Position = UDim2.fromOffset(36, 0)
		title.BackgroundTransparency = 1
		title.Text = 'Overlays'
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = uipallet.Text
		title.TextSize = 15
		title.FontFace = uipallet.Font
		title.Parent = window
		local close = addCloseButton(window, 7)
		local divider = Instance.new('Frame')
		divider.Name = 'Divider'
		divider:SetAttribute('SilentwareRole', 'SettingsDivider')
		divider.Size = UDim2.new(1, 0, 0, 1)
		divider.Position = UDim2.fromOffset(0, 37)
		divider.BackgroundColor3 = uipallet.Border
		divider.BackgroundTransparency = 0.62
		divider.BorderSizePixel = 0
		divider.Parent = window
		local childrentoggle = Instance.new('Frame')
		childrentoggle.Position = UDim2.fromOffset(0, 38)
		childrentoggle.BackgroundTransparency = 1
		childrentoggle.Parent = window
		local windowlist = Instance.new('UIListLayout')
		windowlist.SortOrder = Enum.SortOrder.LayoutOrder
		windowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
		windowlist.Parent = childrentoggle
		styleListLayout(windowlist, 3)

		function optionapi:CreateToggle(togglesettings)
			local toggleapi = {
				Enabled = false,
				Index = getTableSize(optionapi.Toggles)
			}

			local toggle = Instance.new('TextButton')
			toggle.Name = togglesettings.Name..'Toggle'
			toggle.Size = UDim2.new(1, 0, 0, 40)
			toggle.BackgroundTransparency = 1
			toggle.AutoButtonColor = false
			toggle.Text = string.rep(' ', 33 * scale.Scale)..togglesettings.Name
			toggle.TextXAlignment = Enum.TextXAlignment.Left
			toggle.TextColor3 = color.Dark(uipallet.Text, 0.16)
			toggle.TextSize = 14
			toggle.FontFace = uipallet.Font
			toggle.Parent = childrentoggle
			local icon = Instance.new('ImageLabel')
			icon.Name = 'Icon'
			icon.Size = togglesettings.Size
			icon.Position = togglesettings.Position
			icon.BackgroundTransparency = 1
			icon.Image = togglesettings.Icon
			icon.ImageColor3 = uipallet.Text
			icon.Parent = toggle
			local knob = Instance.new('Frame')
			knob.Name = 'Knob'
			knob.Size = UDim2.fromOffset(28, 14)
			knob.Position = UDim2.new(1, -36, 0, 13)
			knob.BackgroundColor3 = color.Light(uipallet.Main, 0.12)
			knob.Parent = toggle
			addCorner(knob, UDim.new(1, 0))
			addStroke(knob, uipallet.Border, 1, 0.66)
			local knobmain = knob:Clone()
			knobmain.Size = UDim2.fromOffset(10, 10)
			knobmain.Position = UDim2.fromOffset(2, 2)
			knobmain.BackgroundColor3 = color.Light(uipallet.Surface, 0.06)
			knobmain.Parent = knob
			toggleapi.Object = toggle

			function toggleapi:Toggle()
				self.Enabled = not self.Enabled
				tween:Tween(knob, uipallet.Tween, {
					BackgroundColor3 = self.Enabled and getAccentColor() or (hovered and color.Light(uipallet.Main, 0.37) or color.Light(uipallet.Main, 0.14))
				})
				tween:Tween(knobmain, uipallet.Tween, {
					Position = UDim2.fromOffset(self.Enabled and 16 or 2, 2)
				})
				togglesettings.Function(self.Enabled)
			end

			local hovered = false
			scale:GetPropertyChangedSignal('Scale'):Connect(function()
				toggle.Text = string.rep(' ', 33 * scale.Scale)..togglesettings.Name
			end)
			toggle.MouseEnter:Connect(function()
				hovered = true
				if not toggleapi.Enabled then
					tween:Tween(knob, uipallet.Tween, {
						BackgroundColor3 = color.Light(uipallet.Main, 0.37)
					})
				end
			end)
			toggle.MouseLeave:Connect(function()
				hovered = false
				if not toggleapi.Enabled then
					tween:Tween(knob, uipallet.Tween, {
						BackgroundColor3 = color.Light(uipallet.Main, 0.14)
					})
				end
			end)
			toggle.MouseButton1Click:Connect(function()
				toggleapi:Toggle()
			end)

			table.insert(optionapi.Toggles, toggleapi)

			return toggleapi
		end

		button.MouseEnter:Connect(function()
			button.ImageColor3 = uipallet.Text
			tween:Tween(button, uipallet.Tween, {
				BackgroundTransparency = 0.9
			})
		end)
		button.MouseLeave:Connect(function()
			button.ImageColor3 = color.Light(uipallet.Main, 0.37)
			tween:Tween(button, uipallet.Tween, {
				BackgroundTransparency = 1
			})
		end)
		button.MouseButton1Click:Connect(function()
			shadow.Visible = true
			tween:Tween(shadow, uipallet.Tween, {
				BackgroundTransparency = 0.5
			})
			tween:Tween(window, uipallet.Tween, {
				Position = UDim2.new(0, 0, 1, -(window.Size.Y.Offset))
			})
		end)
		close.MouseButton1Click:Connect(function()
			tween:Tween(shadow, uipallet.Tween, {
				BackgroundTransparency = 1
			})
			tween:Tween(window, uipallet.Tween, {
				Position = UDim2.fromScale(0, 1)
			})
			task.wait(0.2)
			shadow.Visible = false
		end)
		shadow.MouseButton1Click:Connect(function()
			tween:Tween(shadow, uipallet.Tween, {
				BackgroundTransparency = 1
			})
			tween:Tween(window, uipallet.Tween, {
				Position = UDim2.fromScale(0, 1)
			})
			task.wait(0.2)
			shadow.Visible = false
		end)
		windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			if mainapi.ThreadFix then
				setthreadidentity(8)
			end
			window.Size = UDim2.fromOffset(220, math.min(37 + windowlist.AbsoluteContentSize.Y / scale.Scale, 605))
			childrentoggle.Size = UDim2.fromOffset(220, window.Size.Y.Offset - 5)
		end)

		mainapi.Overlays = optionapi

		return optionapi
	end

	function categoryapi:CreateSettingsDivider()
		components.Divider(settingschildren)
	end

	function categoryapi:CreateSettingsPane(categorysettings)
		local optionapi = {}

		local button = Instance.new('TextButton')
		button.Name = categorysettings.Name
		button:SetAttribute('SilentwareRole', 'SettingsNavButton')
		button.Size = UDim2.fromOffset(220, 42)
		button.BackgroundColor3 = uipallet.SurfaceAlt
		button.BorderSizePixel = 0
		button.AutoButtonColor = false
		button.Text = '          '..categorysettings.Name
		button.TextXAlignment = Enum.TextXAlignment.Left
		button.TextColor3 = color.Dark(uipallet.Text, 0.12)
		button.TextSize = 14
		button.FontFace = uipallet.Font
		button.Parent = settingschildren
		styleShell(button, UDim.new(0, 8), 0.66)
		local arrow = Instance.new('ImageLabel')
		arrow.Name = 'Arrow'
		arrow:SetAttribute('SilentwareRole', 'SettingsArrow')
		arrow.Size = UDim2.fromOffset(4, 8)
		arrow.Position = UDim2.new(1, -20, 0, 16)
		arrow.BackgroundTransparency = 1
		arrow.Image = getcustomasset('vape/assets/expandright.png')
		arrow.ImageColor3 = color.Light(uipallet.Main, 0.37)
		arrow.Parent = button
		local settingspane = Instance.new('TextButton')
		settingspane:SetAttribute('SilentwareRole', 'SettingsPane')
		settingspane.Size = UDim2.fromOffset(486, 438)
		settingspane.AnchorPoint = Vector2.new(0.5, 0.5)
		settingspane.Position = UDim2.fromScale(0.5, 0.5)
		settingspane.BackgroundColor3 = uipallet.Surface
		settingspane.BackgroundTransparency = uipallet.PanelTransparency or 0.02
		settingspane.AutoButtonColor = false
		settingspane.Visible = false
		settingspane.Text = ''
		settingspane.Parent = shell
		settingspane.ZIndex = 32
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.new(1, -36, 0, 20)
		title.Position = UDim2.fromOffset(36, 12)
		title.BackgroundTransparency = 1
		title.Text = categorysettings.Name
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = uipallet.Text
		title.TextSize = 13
		title.FontFace = uipallet.Font
		title.Parent = settingspane
		local close = addCloseButton(settingspane)
		local back = Instance.new('ImageButton')
		back.Name = 'Back'
		back.Size = UDim2.fromOffset(16, 16)
		back.Position = UDim2.fromOffset(11, 13)
		back.BackgroundTransparency = 1
		back.Image = getcustomasset('vape/assets/back.png')
		back.ImageColor3 = color.Light(uipallet.Main, 0.37)
		back.Parent = settingspane
		addCorner(settingspane, UDim.new(0, 14))
		addStroke(settingspane, uipallet.Border, 1, 0.26)
		-- image shadow removed here to prevent transparent square artifacts around settings panes
		local paneScale = Instance.new('UIScale')
		paneScale.Name = 'OpenScale'
		paneScale.Scale = 1
		paneScale.Parent = settingspane
		local settingschildren = Instance.new('ScrollingFrame')
		settingschildren.Name = 'Children'
		settingschildren:SetAttribute('SilentwareRole', 'SettingsChildren')
		settingschildren.Size = UDim2.new(1, -24, 1, -62)
		settingschildren.Position = UDim2.fromOffset(12, 48)
		settingschildren.BackgroundColor3 = uipallet.Surface
		settingschildren.BackgroundTransparency = 1
		settingschildren.BorderSizePixel = 0
		settingschildren.Parent = settingspane
		configureScroll(settingschildren, 4, 0.42)
		local divider = Instance.new('Frame')
		divider.Name = 'Divider'
		divider:SetAttribute('SilentwareRole', 'SettingsDivider')
		divider.Size = UDim2.new(1, 0, 0, 1)
		divider.BackgroundColor3 = uipallet.Border
		divider.BackgroundTransparency = 0.62
		divider.BorderSizePixel = 0
		divider.Parent = settingschildren
		local settingswindowlist = Instance.new('UIListLayout')
		settingswindowlist.SortOrder = Enum.SortOrder.LayoutOrder
		settingswindowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
		settingswindowlist.Parent = settingschildren
		styleListLayout(settingswindowlist, 4)
		settingswindowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			if settingschildren:IsA('ScrollingFrame') then
				settingschildren.CanvasSize = UDim2.fromOffset(0, settingswindowlist.AbsoluteContentSize.Y / scale.Scale + 12)
			end
		end)

		local function ensureSettingsScrim()
			if mainapi.SettingsScrim and mainapi.SettingsScrim.Parent then return mainapi.SettingsScrim end
			local scrim = Instance.new('TextButton')
			scrim.Name = 'SettingsFocusScrim'
			scrim.Size = UDim2.new(1, -24, 1, -74)
			scrim.Position = UDim2.fromOffset(12, 62)
			scrim.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
			scrim.BackgroundTransparency = 1
			scrim.AutoButtonColor = false
			scrim.Text = ''
			scrim.Visible = false
			scrim.ZIndex = 30
			scrim.Parent = shell
			addCorner(scrim, UDim.new(0, 16))
			mainapi.SettingsScrim = scrim
			return scrim
		end

		local function showSettingsPane()
			local scrim = ensureSettingsScrim()
			scrim.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
			scrim.Visible = true
			tween:Tween(scrim, uipallet.Tween, {BackgroundTransparency = 0.34})
			settingspane.Visible = true
			paneScale.Scale = 0.96
			settingspane.BackgroundColor3 = uipallet.Surface
			settingspane.BackgroundTransparency = math.clamp((uipallet.GlassTransparency or 0.08) + 0.04, 0.06, 0.18)
			for _, obj in settingspane:GetDescendants() do
				restyleControlObject(obj)
			end
			repaintEveryControl()
			tween:Tween(paneScale, uipallet.OpenTween, {Scale = 1})
			tween:Tween(settingspane, uipallet.OpenTween, {BackgroundTransparency = math.clamp((uipallet.PanelTransparency or 0.02) + 0.015, 0.025, 0.10)})
		end

		local function hideSettingsPane()
			settingspane.Visible = false
			local anyOpen = false
			for _, pane in shell:GetChildren() do
				if pane ~= settingspane and pane:IsA('GuiObject') and pane.Visible and pane.ZIndex >= 32 then
					anyOpen = true
					break
				end
			end
			if mainapi.SettingsScrim and not anyOpen then
				tween:Tween(mainapi.SettingsScrim, uipallet.Tween, {BackgroundTransparency = 1})
				task.delay(0.18, function()
					if mainapi.SettingsScrim and mainapi.SettingsScrim.BackgroundTransparency >= 0.98 then
						mainapi.SettingsScrim.Visible = false
					end
				end)
			end
		end

		optionapi.Object = settingspane
		optionapi.Children = settingschildren
		optionapi.ListLayout = settingswindowlist
		for i, v in components do
			optionapi['Create'..i] = function(_, settings)
				return v(settings, settingschildren, categoryapi)
			end
		end

		back.MouseEnter:Connect(function()
			back.ImageColor3 = uipallet.Text
		end)
		back.MouseLeave:Connect(function()
			back.ImageColor3 = color.Light(uipallet.Main, 0.37)
		end)
		back.MouseButton1Click:Connect(function()
			hideSettingsPane()
		end)
		button.MouseEnter:Connect(function()
			button.TextColor3 = uipallet.Text
			button.BackgroundColor3 = color.Light(uipallet.SurfaceAlt, 0.03)
		end)
		button.MouseLeave:Connect(function()
			button.TextColor3 = color.Dark(uipallet.Text, 0.12)
			button.BackgroundColor3 = uipallet.SurfaceAlt
		end)
		button.MouseButton1Click:Connect(function()
			showSettingsPane()
		end)
		close.MouseButton1Click:Connect(function()
			hideSettingsPane()
		end)
		function optionapi:ApplyTheme()
			button.BackgroundColor3 = uipallet.SurfaceAlt
			button.TextColor3 = color.Dark(uipallet.Text, 0.12)
			arrow.ImageColor3 = uipallet.Accent
			settingspane.BackgroundColor3 = uipallet.Surface
			settingspane.BackgroundTransparency = math.clamp((uipallet.PanelTransparency or 0.02) + 0.015, 0.025, 0.10)
			settingschildren.BackgroundColor3 = uipallet.Surface
			settingschildren.ScrollBarImageColor3 = uipallet.Accent
			divider.BackgroundColor3 = uipallet.Border
			local buttonStroke = button:FindFirstChildOfClass('UIStroke')
			if buttonStroke then buttonStroke.Color = uipallet.Border; buttonStroke.Transparency = 0.66 end
			local paneStroke = settingspane:FindFirstChildOfClass('UIStroke')
			if paneStroke then paneStroke.Color = uipallet.Border; paneStroke.Transparency = 0.26 end
			for _, obj in settingspane:GetDescendants() do
				restyleControlObject(obj)
			end
		end
		mainapi.SettingsPanes[categorysettings.Name] = optionapi

		windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			if mainapi.ThreadFix then
				setthreadidentity(8)
			end
			-- keep the centered sidebar fixed; only update label padding on scale/content changes
			for _, v in categoryapi.Buttons do
				if v.Icon then
					v.Object.Text = string.rep(' ', 33 * scale.Scale)..v.Name
				end
			end
		end)

		return optionapi
	end

	function categoryapi:CreateGUISlider(optionsettings)
		local optionapi = {
			Type = 'GUISlider',
			Notch = 4,
			Hue = 0.43,
			Sat = 0.72,
			Value = 0.78,
			Rainbow = false,
			CustomColor = false
		}
		local slidsilentlors = {
			Color3.fromRGB(250, 50, 56),
			Color3.fromRGB(242, 99, 33),
			Color3.fromRGB(252, 179, 22),
			Color3.fromRGB(56, 189, 129),
			Color3.fromRGB(47, 122, 229),
			Color3.fromRGB(126, 84, 217),
			Color3.fromRGB(232, 96, 152)
		}
		local slidsilentlorpos = {
			4,
			33,
			62,
			90,
			119,
			148,
			177
		}

		local function createSlider(name, gradientColor)
			local slider = Instance.new('TextButton')
			slider.Name = optionsettings.Name..'Slider'..name
			slider.Size = UDim2.fromOffset(220, 50)
			slider.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
			slider.BorderSizePixel = 0
			slider.AutoButtonColor = false
			slider.Visible = false
			slider.Text = ''
			slider.Parent = settingschildren
			local title = Instance.new('TextLabel')
			title.Name = 'Title'
			title.Size = UDim2.fromOffset(60, 30)
			title.Position = UDim2.fromOffset(10, 2)
			title.BackgroundTransparency = 1
			title.Text = name
			title.TextXAlignment = Enum.TextXAlignment.Left
			title.TextColor3 = color.Dark(uipallet.Text, 0.08)
			title.TextSize = 11
			title.FontFace = uipallet.Font
			title.Parent = slider
			local holder = Instance.new('Frame')
			holder.Name = 'Slider'
			holder.Size = UDim2.fromOffset(200, 4)
			holder.Position = UDim2.fromOffset(10, 37)
			holder.BackgroundColor3 = Color3.new(1, 1, 1)
			holder.BorderSizePixel = 0
			holder.Parent = slider
			local uigradient = Instance.new('UIGradient')
			uigradient.Color = gradientColor
			uigradient.Parent = holder
			local fill = holder:Clone()
			fill.Name = 'Fill'
			fill.Size = UDim2.fromScale(math.clamp(1, 0.04, 0.96), 1)
			fill.Position = UDim2.new()
			fill.BackgroundTransparency = 1
			fill.Parent = holder
			local knobframe = Instance.new('Frame')
			knobframe.Name = 'Knob'
			knobframe.Size = UDim2.fromOffset(24, 6)
			knobframe.Position = UDim2.fromScale(1, 0.5)
			knobframe.AnchorPoint = Vector2.new(0.5, 0.5)
			knobframe.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
			knobframe.BorderSizePixel = 0
			knobframe.Parent = fill
			local knob = Instance.new('Frame')
			knob.Name = 'Knob'
			knob.Size = UDim2.fromOffset(14, 14)
			knob.Position = UDim2.fromScale(0.5, 0.5)
			knob.AnchorPoint = Vector2.new(0.5, 0.5)
			knob.BackgroundColor3 = uipallet.Text
			knob.Parent = knobframe
			addCorner(knob, UDim.new(1, 0))
			if name == 'Custom color' then
				local reset = Instance.new('TextButton')
				reset.Size = UDim2.fromOffset(45, 20)
				reset.Position = UDim2.new(1, -52, 0, 5)
				reset.BackgroundTransparency = 1
				reset.Text = 'RESET'
				reset.TextColor3 = color.Dark(uipallet.Text, 0.16)
				reset.TextSize = 11
				reset.FontFace = uipallet.Font
				reset.Parent = slider
				reset.MouseButton1Click:Connect(function()
					optionapi:SetValue(nil, nil, nil, 4)
				end)
			end

			slider.InputBegan:Connect(function(inputObj)
				if
					(inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
					and (inputObj.Position.Y - slider.AbsolutePosition.Y) > (20 * scale.Scale)
				then
					local changed = inputService.InputChanged:Connect(function(input)
						if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
							local value = math.clamp((input.Position.X - holder.AbsolutePosition.X) / holder.AbsoluteSize.X, 0, 1)
							optionapi:SetValue(
								name == 'Custom color' and value or nil,
								name == 'Saturation' and value or nil,
								name == 'Vibrance' and value or nil,
								name == 'Opacity' and value or nil
							)
						end
					end)

					local ended
					ended = inputObj.Changed:Connect(function()
						if inputObj.UserInputState == Enum.UserInputState.End then
							if changed then
								changed:Disconnect()
							end
							if ended then
								ended:Disconnect()
							end
						end
					end)
				end
			end)
			slider.MouseEnter:Connect(function()
				tween:Tween(knob, uipallet.Tween, {
					Size = UDim2.fromOffset(16, 16)
				})
			end)
			slider.MouseLeave:Connect(function()
				tween:Tween(knob, uipallet.Tween, {
					Size = UDim2.fromOffset(14, 14)
				})
			end)

			return slider
		end

		local slider = Instance.new('TextButton')
		slider.Name = optionsettings.Name..'Slider'
		slider.Size = UDim2.fromOffset(220, 50)
		slider.BackgroundTransparency = 1
		slider.AutoButtonColor = false
		slider.Text = ''
		slider.Parent = settingschildren
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.fromOffset(60, 30)
		title.Position = UDim2.fromOffset(10, 2)
		title.BackgroundTransparency = 1
		title.Text = optionsettings.Name
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = color.Dark(uipallet.Text, 0.16)
		title.TextSize = 11
		title.FontFace = uipallet.Font
		title.Parent = slider
		local holder = Instance.new('Frame')
		holder.Name = 'Slider'
		holder.Size = UDim2.fromOffset(200, 2)
		holder.Position = UDim2.fromOffset(10, 37)
		holder.BackgroundTransparency = 1
		holder.BorderSizePixel = 0
		holder.Parent = slider
		local colornum = 0
		for i, color in slidsilentlors do
			local colorframe = Instance.new('Frame')
			colorframe.Size = UDim2.fromOffset(27 + (((i + 1) % 2) == 0 and 1 or 0), 2)
			colorframe.Position = UDim2.fromOffset(colornum, 0)
			colorframe.BackgroundColor3 = color
			colorframe.BorderSizePixel = 0
			colorframe.Parent = holder
			colornum += (colorframe.Size.X.Offset + 1)
		end
		local preview = Instance.new('ImageButton')
		preview.Name = 'Preview'
		preview.Size = UDim2.fromOffset(12, 12)
		preview.Position = UDim2.new(1, -22, 0, 10)
		preview.BackgroundTransparency = 1
		preview.Image = getcustomasset('vape/assets/colorpreview.png')
		preview.ImageColor3 = Color3.fromHSV(optionapi.Hue, 1, 1)
		preview.Parent = slider
		local valuebox = Instance.new('TextBox')
		valuebox.Name = 'Box'
		valuebox.Size = UDim2.fromOffset(60, 15)
		valuebox.Position = UDim2.new(1, -69, 0, 9)
		valuebox.BackgroundTransparency = 1
		valuebox.Visible = false
		valuebox.Text = ''
		valuebox.TextXAlignment = Enum.TextXAlignment.Right
		valuebox.TextColor3 = color.Dark(uipallet.Text, 0.16)
		valuebox.TextSize = 11
		valuebox.FontFace = uipallet.Font
		valuebox.ClearTextOnFocus = true
		valuebox.Parent = slider
		local expandbutton = Instance.new('TextButton')
		expandbutton.Name = 'Expand'
		expandbutton.Size = UDim2.fromOffset(17, 13)
		expandbutton.Position = UDim2.new(0, getfontsize(title.Text, title.TextSize, title.Font).X + 11, 0, 7)
		expandbutton.BackgroundTransparency = 1
		expandbutton.Text = ''
		expandbutton.Parent = slider
		local expandicon = Instance.new('ImageLabel')
		expandicon.Name = 'Expand'
		expandicon.Size = UDim2.fromOffset(9, 5)
		expandicon.Position = UDim2.fromOffset(4, 4)
		expandicon.BackgroundTransparency = 1
		expandicon.Image = getcustomasset('vape/assets/expandicon.png')
		expandicon.ImageColor3 = color.Dark(uipallet.Text, 0.43)
		expandicon.Parent = expandbutton
		local rainbow = Instance.new('TextButton')
		rainbow.Name = 'Rainbow'
		rainbow.Size = UDim2.fromOffset(12, 12)
		rainbow.Position = UDim2.new(1, -42, 0, 10)
		rainbow.BackgroundTransparency = 1
		rainbow.Text = ''
		rainbow.Parent = slider
		local rainbow1 = Instance.new('ImageLabel')
		rainbow1.Size = UDim2.fromOffset(12, 12)
		rainbow1.BackgroundTransparency = 1
		rainbow1.Image = getcustomasset('vape/assets/rainbow_1.png')
		rainbow1.ImageColor3 = color.Light(uipallet.Main, 0.37)
		rainbow1.Parent = rainbow
		local rainbow2 = rainbow1:Clone()
		rainbow2.Image = getcustomasset('vape/assets/rainbow_2.png')
		rainbow2.Parent = rainbow
		local rainbow3 = rainbow1:Clone()
		rainbow3.Image = getcustomasset('vape/assets/rainbow_3.png')
		rainbow3.Parent = rainbow
		local rainbow4 = rainbow1:Clone()
		rainbow4.Image = getcustomasset('vape/assets/rainbow_4.png')
		rainbow4.Parent = rainbow
		local knob = Instance.new('ImageLabel')
		knob.Name = 'Knob'
		knob.Size = UDim2.fromOffset(26, 12)
		knob.Position = UDim2.fromOffset(slidsilentlorpos[4] - 3, -5)
		knob.BackgroundTransparency = 1
		knob.Image = getcustomasset('vape/assets/guislider.png')
		knob.ImageColor3 = slidsilentlors[4]
		knob.Parent = holder
		optionsettings.Function = optionsettings.Function or function() end
		local rainbowTable = {}
		for i = 0, 1, 0.1 do
			table.insert(rainbowTable, ColorSequenceKeypoint.new(i, Color3.fromHSV(i, 1, 1)))
		end
		local colorSlider = createSlider('Custom color', ColorSequence.new(rainbowTable))
		local satSlider = createSlider('Saturation', ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, optionapi.Value)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(optionapi.Hue, 1, optionapi.Value))
		}))
		local vibSlider = createSlider('Vibrance', ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(optionapi.Hue, optionapi.Sat, 1))
		}))
		local normalknob = getcustomasset('vape/assets/guislider.png')
		local rainbowknob = getcustomasset('vape/assets/guisliderrain.png')
		local rainbowthread

		function optionapi:Save(tab)
			tab[optionsettings.Name] = {
				Hue = self.Hue,
				Sat = self.Sat,
				Value = self.Value,
				Notch = self.Notch,
				CustomColor = self.CustomColor,
				Rainbow = self.Rainbow
			}
		end

		function optionapi:Load(tab)
			if tab.Rainbow then
				self:Toggle()
			end
			if self.Rainbow or tab.CustomColor then
				self:SetValue(tab.Hue, tab.Sat, tab.Value)
			else
				self:SetValue(nil, nil, nil, tab.Notch)
			end
		end

		function optionapi:SetValue(h, s, v, n)
			if n then
				if self.Rainbow then
					self:Toggle()
				end
				self.CustomColor = false
				h, s, v = slidsilentlors[n]:ToHSV()
			else
				self.CustomColor = true
			end

			self.Hue = h or self.Hue
			self.Sat = s or self.Sat
			self.Value = v or self.Value
			self.Notch = n
			preview.ImageColor3 = Color3.fromHSV(self.Hue, self.Sat, self.Value)
			satSlider.Slider.UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, self.Value)),
				ColorSequenceKeypoint.new(1, Color3.fromHSV(self.Hue, 1, self.Value))
			})
			vibSlider.Slider.UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 0)),
				ColorSequenceKeypoint.new(1, Color3.fromHSV(self.Hue, self.Sat, 1))
			})

			if self.Rainbow or self.CustomColor then
				knob.Image = rainbowknob
				knob.ImageColor3 = Color3.new(1, 1, 1)
				tween:Tween(knob, uipallet.Tween, {
					Position = UDim2.fromOffset(slidsilentlorpos[4] - 3, -5)
				})
			else
				knob.Image = normalknob
				knob.ImageColor3 = Color3.fromHSV(self.Hue, self.Sat, self.Value)
				tween:Tween(knob, uipallet.Tween, {
					Position = UDim2.fromOffset(slidsilentlorpos[n or 4] - 3, -5)
				})
			end

			if self.Rainbow then
				if h then
					colorSlider.Slider.Fill.Size = UDim2.fromScale(math.clamp(self.Hue, 0.04, 0.96), 1)
				end
				if s then
					satSlider.Slider.Fill.Size = UDim2.fromScale(math.clamp(self.Sat, 0.04, 0.96), 1)
				end
				if v then
					vibSlider.Slider.Fill.Size = UDim2.fromScale(math.clamp(self.Value, 0.04, 0.96), 1)
				end
			else
				if h then
					tween:Tween(colorSlider.Slider.Fill, uipallet.Tween, {
						Size = UDim2.fromScale(math.clamp(self.Hue, 0.04, 0.96), 1)
					})
				end
				if s then
					tween:Tween(satSlider.Slider.Fill, uipallet.Tween, {
						Size = UDim2.fromScale(math.clamp(self.Sat, 0.04, 0.96), 1)
					})
				end
				if v then
					tween:Tween(vibSlider.Slider.Fill, uipallet.Tween, {
						Size = UDim2.fromScale(math.clamp(self.Value, 0.04, 0.96), 1)
					})
				end
			end
			optionsettings.Function(self.Hue, self.Sat, self.Value)
		end

		function optionapi:Toggle()
			self.Rainbow = not self.Rainbow
			if rainbowthread then
				task.cancel(rainbowthread)
			end

			if self.Rainbow then
				knob.Image = rainbowknob
				table.insert(mainapi.RainbowTable, self)

				rainbow1.ImageColor3 = Color3.fromRGB(5, 127, 100)
				rainbowthread = task.delay(0.1, function()
					rainbow2.ImageColor3 = Color3.fromRGB(228, 125, 43)
					rainbowthread = task.delay(0.1, function()
						rainbow3.ImageColor3 = Color3.fromRGB(225, 46, 52)
						rainbowthread = nil
					end)
				end)
			else
				self:SetValue(nil, nil, nil, 4)
				knob.Image = normalknob
				local ind = table.find(mainapi.RainbowTable, self)
				if ind then
					table.remove(mainapi.RainbowTable, ind)
				end

				rainbow3.ImageColor3 = color.Light(uipallet.Main, 0.37)
				rainbowthread = task.delay(0.1, function()
					rainbow2.ImageColor3 = color.Light(uipallet.Main, 0.37)
					rainbowthread = task.delay(0.1, function()
						rainbow1.ImageColor3 = color.Light(uipallet.Main, 0.37)
					end)
				end)
			end
		end

		optionapi.ToggleButton = function()
			optionapi:Toggle()
		end

		expandbutton.MouseEnter:Connect(function()
			expandicon.ImageColor3 = color.Dark(uipallet.Text, 0.16)
		end)
		expandbutton.MouseLeave:Connect(function()
			expandicon.ImageColor3 = color.Dark(uipallet.Text, 0.43)
		end)
		expandbutton.MouseButton1Click:Connect(function()
			colorSlider.Visible = not colorSlider.Visible
			satSlider.Visible = colorSlider.Visible
			vibSlider.Visible = satSlider.Visible
			expandicon.Rotation = satSlider.Visible and 180 or 0
		end)
		preview.MouseButton1Click:Connect(function()
			preview.Visible = false
			valuebox.Visible = true
			valuebox:CaptureFocus()
			local text = Color3.fromHSV(optionapi.Hue, optionapi.Sat, optionapi.Value)
			valuebox.Text = math.round(text.R * 255)..', '..math.round(text.G * 255)..', '..math.round(text.B * 255)
		end)
		slider.InputBegan:Connect(function(inputObj)
			if
				(inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
				and (inputObj.Position.Y - slider.AbsolutePosition.Y) > (20 * scale.Scale)
			then
				local changed = inputService.InputChanged:Connect(function(input)
					if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
						optionapi:SetValue(nil, nil, nil, math.clamp(math.round((input.Position.X - holder.AbsolutePosition.X) / scale.Scale / 27), 1, 7))
					end
				end)

				local ended
				ended = inputObj.Changed:Connect(function()
					if inputObj.UserInputState == Enum.UserInputState.End then
						if changed then
							changed:Disconnect()
						end
						if ended then
							ended:Disconnect()
						end
					end
				end)
				optionapi:SetValue(nil, nil, nil, math.clamp(math.round((inputObj.Position.X - holder.AbsolutePosition.X) / scale.Scale / 27), 1, 7))
			end
		end)
		rainbow.MouseButton1Click:Connect(function()
			optionapi:Toggle()
		end)
		valuebox.FocusLost:Connect(function(enter)
			preview.Visible = true
			valuebox.Visible = false
			if enter then
				local commas = valuebox.Text:split(',')
				local suc, res = pcall(function()
					return tonumber(commas[1]) and Color3.fromRGB(
						tonumber(commas[1]),
						tonumber(commas[2]),
						tonumber(commas[3])
					) or Color3.fromHex(valuebox.Text)
				end)

				if suc then
					if optionapi.Rainbow then
						optionapi:Toggle()
					end
					optionapi:SetValue(res:ToHSV())
				end
			end
		end)

		optionapi.Object = slider
		categoryapi.Options[optionsettings.Name] = optionapi

		return optionapi
	end

	back.MouseEnter:Connect(function()
		back.ImageColor3 = uipallet.Text
	end)
	back.MouseLeave:Connect(function()
		back.ImageColor3 = color.Light(uipallet.Main, 0.37)
	end)
	back.MouseButton1Click:Connect(function()
		settingspane.Visible = false
	end)
	close.MouseButton1Click:Connect(function()
		settingspane.Visible = false
	end)
	settingsbutton.MouseEnter:Connect(function()
		settingsicon.ImageColor3 = uipallet.AccentGlow or uipallet.Accent
	end)
	settingsbutton.MouseLeave:Connect(function()
		settingsicon.ImageColor3 = uipallet.Accent
	end)
	settingsbutton.MouseButton1Click:Connect(function()
		settingspane.Visible = true
		settingsScale.Scale = 0.96
		settingspane.BackgroundTransparency = 0.12
		tween:Tween(settingsScale, uipallet.OpenTween, {Scale = 1})
		tween:Tween(settingspane, uipallet.OpenTween, {BackgroundTransparency = 0.02})
	end)
	windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8)
		end
		if children:IsA('ScrollingFrame') then
			children.CanvasSize = UDim2.fromOffset(0, windowlist.AbsoluteContentSize.Y / scale.Scale + 12)
		end
		for _, v in categoryapi.Buttons do
			if v.Icon then
				v.Object.Text = string.rep(' ', 36 * scale.Scale)..v.Name
			end
		end
	end)

	self.Categories.Main = categoryapi
	createStartupLoader()

	return categoryapi
end

local isMobile = inputService.TouchEnabled and not inputService.KeyboardEnabled and not inputService.MouseEnabled

function mainapi:CreateCategory(categorysettings)
	local categoryapi = {
		Type = 'Category',
		Expanded = false
	}

	local window = Instance.new('TextButton')
	window.Name = categorysettings.Name..'Category'
	window.Size = UDim2.new(1, -20, 1, -20)
	window.Position = UDim2.fromOffset(10, 10)
	window.BackgroundColor3 = uipallet.SurfaceHigh or uipallet.Surface
	window.BackgroundTransparency = uipallet.PanelTransparency or 0.02
	window.AutoButtonColor = false
	window.Visible = false
	window.Text = ''
	window.Parent = mainapi.PremiumContent or clickgui
	window.ClipsDescendants = true

	addCorner(window, UDim.new(0, 12))
	addStroke(window, uipallet.Border, 1, 0.38)
	local icon = Instance.new('ImageLabel')
	icon.Name = 'Icon'
	icon.Size = categorysettings.Size
	icon.Position = UDim2.fromOffset(12, (icon.Size.X.Offset > 20 and 14 or 13))
	icon.BackgroundTransparency = 1
	icon.Image = categorysettings.Icon
	icon.ImageColor3 = uipallet.Text
	icon.Parent = window
	local title = Instance.new('TextLabel')
	title.Name = 'Title'
	title.Size = UDim2.new(1, -(categorysettings.Size.X.Offset > 18 and 40 or 33), 0, 41)
	title.Position = UDim2.fromOffset(math.abs(title.Size.X.Offset), 0)
	title.BackgroundTransparency = 1
	title.Text = categorysettings.Name
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.TextColor3 = uipallet.Text
	title.TextSize = 13
	title.FontFace = uipallet.Font
	title.Parent = window
	local arrowbutton = Instance.new('TextButton')
	arrowbutton.Name = 'Arrow'
	arrowbutton.Size = UDim2.fromOffset(40, 40)
	arrowbutton.Position = UDim2.new(1, -40, 0, 0)
	arrowbutton.BackgroundTransparency = 1
	arrowbutton.Text = ''
	arrowbutton.Parent = window
	local arrow = Instance.new('ImageLabel')
	arrow.Name = 'Arrow'
	arrow.Size = UDim2.fromOffset(9, 4)
	arrow.Position = UDim2.fromOffset(20, 18)
	arrow.BackgroundTransparency = 1
	arrow.Image = getcustomasset('vape/assets/expandup.png')
	arrow.ImageColor3 = uipallet.MutedText
	arrow.Rotation = 180
	arrow.Parent = arrowbutton
	arrow.Visible = false
	arrowbutton.Visible = false
	local children = Instance.new('ScrollingFrame')
	children.Name = 'Children'
	children.Size = UDim2.new(1, -12, 1, -49)
	children.Position = UDim2.fromOffset(6, 43)
	children.BackgroundTransparency = 1
	children.BorderSizePixel = 0
	children.Visible = false
	children.ScrollBarThickness = 4
	children.ScrollBarImageTransparency = 0.38
	children.CanvasSize = UDim2.new()
	children.Parent = window
	local divider = Instance.new('Frame')
	divider.Name = 'Divider'
	divider.Size = UDim2.new(1, 0, 0, 1)
	divider.Position = UDim2.fromOffset(0, 37)
	divider.BackgroundColor3 = uipallet.Border
	divider.BackgroundTransparency = 0.65
	divider.BorderSizePixel = 0
	divider.Visible = false
	divider.Parent = window
	local windowlist = Instance.new('UIListLayout')
	windowlist.SortOrder = Enum.SortOrder.LayoutOrder
	windowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
	windowlist.Parent = children
	styleListLayout(windowlist, 6)

	function categoryapi:CreateModule(modulesettings)
		modulesettings.Function = hookCF(modulesettings.Function, modulesettings)
		mainapi:Remove(modulesettings.Name)
		local moduleapi = {
			Enabled = false,
			Options = {},
			Bind = {},
			Index = getTableSize(mainapi.Modules),
			ExtraText = modulesettings.ExtraText,
			Name = modulesettings.Name,
			Category = categorysettings.Name,
			Locked = false,
			RequiredTier = 'free'
		}

		local modulebutton = Instance.new('TextButton')
		modulebutton.Name = modulesettings.Name
		modulebutton.Size = UDim2.new(1, -14, 0, 48)
		modulebutton.BackgroundColor3 = uipallet.SurfaceAlt
		modulebutton.BorderSizePixel = 0
		modulebutton.AutoButtonColor = false
		modulebutton.Text = '              '..modulesettings.Name
		modulebutton.TextXAlignment = Enum.TextXAlignment.Left
		modulebutton.TextColor3 = color.Dark(uipallet.Text, 0.22)
		modulebutton.TextSize = 14
		modulebutton.FontFace = uipallet.Font
		modulebutton.Parent = children
		styleShell(modulebutton, UDim.new(0, 12), 0.58)
		local moduleStroke = modulebutton:FindFirstChildOfClass('UIStroke')
		local moduleAccent = Instance.new('Frame')
		moduleAccent.Name = 'AccentLine'
		moduleAccent.Size = UDim2.fromOffset(3, 26)
		moduleAccent.Position = UDim2.fromOffset(0, 11)
		moduleAccent.BackgroundColor3 = getAccentColor()
		moduleAccent.BackgroundTransparency = 1
		moduleAccent.BorderSizePixel = 0
		moduleAccent.Parent = modulebutton
		addCorner(moduleAccent, UDim.new(1, 0))
		local moduleGlow = addGlow(modulebutton, 'ModuleGlow', 1, 76)
		moduleGlow.ImageColor3 = getAccentColor()

		local lockbadge = Instance.new('TextLabel')
		lockbadge.Name = 'TierLock'
		lockbadge:SetAttribute('SilentwareRole', 'TierLock')
		lockbadge.Size = UDim2.fromOffset(78, 22)
		lockbadge.Position = UDim2.new(1, -118, 0, 13)
		lockbadge.BackgroundColor3 = color.Light(uipallet.Main, 0.1)
		lockbadge.BackgroundTransparency = 0.08
		lockbadge.BorderSizePixel = 0
		lockbadge.Text = ''
		lockbadge.TextColor3 = uipallet.MutedText
		lockbadge.TextSize = 10
		lockbadge.FontFace = uipallet.FontSemiBold
		lockbadge.Visible = false
		lockbadge.Parent = modulebutton
		addCorner(lockbadge, UDim.new(1, 0))
		addStroke(lockbadge, uipallet.Border, 1, 0.48)

		local gradient = Instance.new('UIGradient')
		gradient.Rotation = 90
		gradient.Enabled = false
		gradient.Parent = modulebutton
		local modulechildren = Instance.new('Frame')
		local bind = Instance.new('TextButton')
		addTooltip(modulebutton, modulesettings.Tooltip)
		addTooltip(bind, 'Click to bind')
		bind.Name = 'Bind'
		bind.Size = UDim2.fromOffset(20, 21)
		bind.Position = UDim2.new(1, -38, 0, 13)
		bind.AnchorPoint = Vector2.new(1, 0)
		bind.BackgroundColor3 = color.Light(uipallet.SurfaceAlt, 0.05)
		bind.BackgroundTransparency = 0.2
		bind.BorderSizePixel = 0
		bind.AutoButtonColor = false
		bind.Visible = false
		bind.Text = ''
		addCorner(bind, UDim.new(0, 4))
		addStroke(bind, uipallet.Border, 1, 0.68)
		local bindicon = Instance.new('ImageLabel')
		bindicon.Name = 'Icon'
		bindicon.Size = UDim2.fromOffset(12, 12)
		bindicon.Position = UDim2.new(0.5, -6, 0, 5)
		bindicon.BackgroundTransparency = 1
		bindicon.Image = getcustomasset('vape/assets/bind.png')
		bindicon.ImageColor3 = color.Dark(uipallet.Text, 0.43)
		bindicon.Parent = bind
		local bindtext = Instance.new('TextLabel')
		bindtext.Size = UDim2.fromScale(1, 1)
		bindtext.Position = UDim2.fromOffset(0, 1)
		bindtext.BackgroundTransparency = 1
		bindtext.Visible = false
		bindtext.Text = ''
		bindtext.TextColor3 = color.Dark(uipallet.Text, 0.43)
		bindtext.TextSize = 12
		bindtext.FontFace = uipallet.Font
		bindtext.Parent = bind
		local bindcover = Instance.new('ImageLabel')
		bindcover.Name = 'Cover'
		bindcover.Size = UDim2.fromOffset(154, 40)
		bindcover.BackgroundTransparency = 1
		bindcover.Visible = false
		bindcover.Image = getcustomasset('vape/assets/bindbkg.png')
		bindcover.ScaleType = Enum.ScaleType.Slice
		bindcover.SliceCenter = Rect.new(0, 0, 141, 40)
		bindcover.Parent = modulebutton
		local bindcovertext = Instance.new('TextLabel')
		bindcovertext.Name = 'Text'
		bindcovertext.Size = UDim2.new(1, -10, 1, -3)
		bindcovertext.BackgroundTransparency = 1
		bindcovertext.Text = 'PRESS A KEY TO BIND'
		bindcovertext.TextColor3 = uipallet.Text
		bindcovertext.TextSize = 11
		bindcovertext.FontFace = uipallet.Font
		bindcovertext.Parent = bindcover
		bind.Parent = modulebutton
		local dotsbutton = Instance.new('TextButton')
		dotsbutton.Name = 'Dots'
		dotsbutton.Size = UDim2.fromOffset(26, 44)
		dotsbutton.Position = UDim2.new(1, -28, 0, 2)
		dotsbutton.BackgroundTransparency = 1
		dotsbutton.Text = ''
		dotsbutton.Parent = modulebutton
		local dots = Instance.new('ImageLabel')
		dots.Name = 'Dots'
		dots:SetAttribute('SilentwareRole', 'ModuleDots')
		dots.Size = UDim2.fromOffset(3, 16)
		dots.Position = UDim2.fromOffset(7, 14)
		dots.BackgroundTransparency = 1
		dots.Image = getcustomasset('vape/assets/dots.png')
		dots.ImageColor3 = uipallet.Accent
		dots.Parent = dotsbutton
		modulechildren.Name = modulesettings.Name..'Children'
		modulechildren.Size = UDim2.new(1, 0, 0, 0)
		modulechildren.BackgroundColor3 = color.Light(uipallet.Main, 0.01)
		modulechildren.BorderSizePixel = 0
		modulechildren.Visible = false
		modulechildren.Parent = children
		moduleapi.Children = modulechildren
		local windowlist = Instance.new('UIListLayout')
		windowlist.SortOrder = Enum.SortOrder.LayoutOrder
		windowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
		windowlist.Parent = modulechildren
		styleListLayout(windowlist, 3)
		local divider = Instance.new('Frame')
		divider.Name = 'Divider'
		divider:SetAttribute('SilentwareRole', 'SettingsDivider')
		divider.Size = UDim2.new(1, 0, 0, 1)
		divider.Position = UDim2.new(0, 0, 1, -1)
		divider.BackgroundColor3 = Color3.new(0.19, 0.19, 0.19)
		divider.BackgroundTransparency = 0.52
		divider.BorderSizePixel = 0
		divider.Visible = false
		divider.Parent = modulebutton
		modulesettings.Function = modulesettings.Function or function() end
		addMaid(moduleapi)

		function moduleapi:ApplyAccessState()
			local allowed, requiredTier = accessCanUseModule(self.Category, self.Name)
			self.Locked = not allowed
			self.RequiredTier = requiredTier or 'free'
			lockbadge.Text = string.upper(tostring(self.RequiredTier))
			lockbadge.BackgroundColor3 = color.Light(uipallet.Main, 0.1)
			lockbadge.TextColor3 = uipallet.Accent
			styleManagedStroke(lockbadge, uipallet.Accent, 0.44)
			lockbadge.Visible = self.Locked
			dots.ImageColor3 = self.Enabled and color.Dark(uipallet.Surface, 0.08) or uipallet.Accent
			if self.Locked then
				modulebutton.TextColor3 = color.Dark(uipallet.MutedText, 0.18)
				modulebutton.BackgroundColor3 = color.Dark(uipallet.SurfaceAlt, 0.03)
				modulebutton.AutoButtonColor = false
				moduleAccent.BackgroundTransparency = 0.35
				moduleAccent.BackgroundColor3 = uipallet.DimText
				if moduleStroke then
					moduleStroke.Color = uipallet.DimText
					moduleStroke.Transparency = 0.42
				end
				if self.Enabled then
					self.Locked = false
					self:Toggle(true)
					self.Locked = true
				end
			elseif self.Enabled then
				modulebutton.TextColor3 = mainapi.GUIColor.Rainbow and Color3.new(0.19, 0.19, 0.19) or mainapi:TextColor(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
				modulebutton.BackgroundColor3 = getAccentColor()
				moduleAccent.BackgroundTransparency = 0
				moduleAccent.BackgroundColor3 = getAccentColor()
				moduleGlow.ImageColor3 = getAccentColor()
				moduleGlow.ImageTransparency = 0.28
				if moduleStroke then
					moduleStroke.Color = getAccentColor()
					moduleStroke.Transparency = 0.25
				end
			else
				modulebutton.TextColor3 = color.Dark(uipallet.Text, 0.22)
				modulebutton.BackgroundColor3 = uipallet.SurfaceAlt
				moduleAccent.BackgroundTransparency = 1
				moduleGlow.ImageColor3 = getAccentColor()
				if moduleStroke then
					moduleStroke.Color = uipallet.Border
					moduleStroke.Transparency = 0.66
				end
			end
		end


		function moduleapi:SetBind(tab, mouse)
			if tab.Mobile then
				createMobileButton(moduleapi, Vector2.new(tab.X, tab.Y))
				return
			end

			self.Bind = table.clone(tab)
			if mouse then
				bindcovertext.Text = #tab <= 0 and 'BIND REMOVED' or 'BOUND TO'
				bindcover.Size = UDim2.fromOffset(getfontsize(bindcovertext.Text, bindcovertext.TextSize).X + 20, 40)
				task.delay(1, function()
					bindcover.Visible = false
				end)
			end

			if #tab <= 0 then
				bindtext.Visible = false
				bindicon.Visible = true
				bind.Size = UDim2.fromOffset(20, 21)
			else
				bind.Visible = true
				bindtext.Visible = true
				bindicon.Visible = false
				bindtext.Text = table.concat(tab, ' + '):upper()
				bind.Size = UDim2.fromOffset(math.max(getfontsize(bindtext.Text, bindtext.TextSize, bindtext.Font).X + 10, 20), 21)
			end
		end

		function moduleapi:Toggle(multiple)
			if self.Locked then
				local displayTier = (shared.SilentwareAccess and shared.SilentwareAccess.DisplayNames and shared.SilentwareAccess.DisplayNames[self.RequiredTier]) or tostring(self.RequiredTier)
				mainapi:CreateNotification('Locked module', self.Name..' requires '..tostring(displayTier)..' access.', 4, 'warning')
				return
			end
			if mainapi.ThreadFix then
				setthreadidentity(8)
			end
			self.Enabled = not self.Enabled
			divider.Visible = self.Enabled
			gradient.Enabled = self.Enabled
			modulebutton.TextColor3 = self.Enabled and mainapi:TextColor(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value) or ((hovered or modulechildren.Visible) and uipallet.Text or color.Dark(uipallet.Text, 0.22))
			modulebutton.BackgroundColor3 = self.Enabled and getAccentColor() or ((hovered or modulechildren.Visible) and color.Light(uipallet.SurfaceAlt, 0.055) or uipallet.SurfaceAlt)
			moduleAccent.BackgroundTransparency = self.Enabled and 0 or 1
			moduleAccent.BackgroundColor3 = getAccentColor()
			moduleGlow.ImageColor3 = getAccentColor()
			tween:Tween(moduleGlow, uipallet.Tween, {ImageTransparency = self.Enabled and 0.28 or 1})
			if moduleStroke then
				moduleStroke.Color = self.Enabled and getAccentColor() or uipallet.Border
				moduleStroke.Transparency = self.Enabled and 0.25 or 0.66
			end
			dots.ImageColor3 = self.Enabled and color.Dark(uipallet.Surface, 0.08) or uipallet.Accent
			bindicon.ImageColor3 = color.Dark(uipallet.Text, 0.43)
			bindtext.TextColor3 = color.Dark(uipallet.Text, 0.43)
			if not self.Enabled then
				for _, v in self.Connections do
					v:Disconnect()
				end
				table.clear(self.Connections)
			end
			if not multiple then
				mainapi:UpdateTextGUI()
			end
			task.spawn(modulesettings.Function, self.Enabled)
		end

		moduleapi.ToggleButton = function()
			moduleapi:Toggle()
		end

		for i, v in components do
			moduleapi['Create'..i] = function(_, optionsettings)
				return v(optionsettings, modulechildren, moduleapi)
			end
		end

		bind.MouseEnter:Connect(function()
			bindtext.Visible = false
			bindicon.Visible = not bindtext.Visible
			bindicon.Image = getcustomasset('vape/assets/edit.png')
			if not moduleapi.Enabled then bindicon.ImageColor3 = color.Dark(uipallet.Text, 0.16) end
		end)
		bind.MouseLeave:Connect(function()
			bindtext.Visible = #moduleapi.Bind > 0
			bindicon.Visible = not bindtext.Visible
			bindicon.Image = getcustomasset('vape/assets/bind.png')
			if not moduleapi.Enabled then
				bindicon.ImageColor3 = color.Dark(uipallet.Text, 0.43)
			end
		end)
		bind.MouseButton1Click:Connect(function()
			bindcovertext.Text = 'PRESS A KEY TO BIND'
			bindcover.Size = UDim2.fromOffset(getfontsize(bindcovertext.Text, bindcovertext.TextSize).X + 20, 40)
			bindcover.Visible = true
			mainapi.Binding = moduleapi
		end)
		dotsbutton.MouseEnter:Connect(function()
			if not moduleapi.Enabled then
				dots.ImageColor3 = uipallet.Text
			end
		end)
		dotsbutton.MouseLeave:Connect(function()
			if not moduleapi.Enabled then
				dots.ImageColor3 = uipallet.Accent
			end
		end)
		dotsbutton.MouseButton1Click:Connect(function()
			modulechildren.Visible = not modulechildren.Visible
		end)
		dotsbutton.MouseButton2Click:Connect(function()
			modulechildren.Visible = not modulechildren.Visible
		end)
		local hovered = false
		modulebutton.MouseEnter:Connect(function()
			hovered = true
			if not moduleapi.Enabled and not modulechildren.Visible then
				modulebutton.TextColor3 = uipallet.Text
				modulebutton.BackgroundColor3 = color.Light(uipallet.SurfaceAlt, 0.03)
			end
			bind.Visible = #moduleapi.Bind > 0 or hovered or modulechildren.Visible
		end)
		modulebutton.MouseLeave:Connect(function()
			hovered = false
			if not moduleapi.Enabled and not modulechildren.Visible then
				modulebutton.TextColor3 = color.Dark(uipallet.Text, 0.22)
				modulebutton.BackgroundColor3 = uipallet.SurfaceAlt
			end
			bind.Visible = #moduleapi.Bind > 0 or hovered or modulechildren.Visible
		end)
		modulebutton.MouseButton1Click:Connect(function()
			moduleapi:Toggle()
		end)
		modulebutton.MouseButton2Click:Connect(function()
			modulechildren.Visible = not modulechildren.Visible
		end)
		if inputService.TouchEnabled then
			local heldbutton = false
			modulebutton.MouseButton1Down:Connect(function()
				heldbutton = true
				local holdtime, holdpos = tick(), inputService:GetMouseLocation()
				repeat
					heldbutton = (inputService:GetMouseLocation() - holdpos).Magnitude < 3
					task.wait()
				until (tick() - holdtime) > 1 or not heldbutton or not clickgui.Visible
				if heldbutton and clickgui.Visible then
					if mainapi.ThreadFix then
						setthreadidentity(8)
					end
					clickgui.Visible = false
					tooltip.Visible = false
					mainapi:BlurCheck()
					for _, mobileButton in mainapi.Modules do
						if mobileButton.Bind.Button then
							mobileButton.Bind.Button.Visible = true
						end
					end

					local touchconnection
					touchconnection = inputService.InputBegan:Connect(function(inputType)
						if inputType.UserInputType == Enum.UserInputType.Touch then
							if mainapi.ThreadFix then setthreadidentity(8) end
							createMobileButton(moduleapi, inputType.Position + Vector3.new(0, guiService:GetGuiInset().Y, 0))
							clickgui.Visible = true
							mainapi:BlurCheck()
							for _, mobileButton in mainapi.Modules do
								if mobileButton.Bind.Button then
									mobileButton.Bind.Button.Visible = false
								end
							end
							touchconnection:Disconnect()
						end
					end)
				end
			end)
			modulebutton.MouseButton1Up:Connect(function()
				heldbutton = false
			end)
		end
		windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			if mainapi.ThreadFix then
				setthreadidentity(8)
			end
			modulechildren.Size = UDim2.new(1, 0, 0, windowlist.AbsoluteContentSize.Y / scale.Scale)
		end)

		moduleapi.Object = modulebutton
		mainapi.Modules[modulesettings.Name] = moduleapi
		moduleapi:ApplyAccessState()

		local sorting = {}
		for _, v in mainapi.Modules do
			sorting[v.Category] = sorting[v.Category] or {}
			table.insert(sorting[v.Category], v.Name)
		end

		for _, sort in sorting do
			table.sort(sort)
			for i, v in sort do
				mainapi.Modules[v].Index = i
				mainapi.Modules[v].Object.LayoutOrder = i
				mainapi.Modules[v].Children.LayoutOrder = i
			end
		end

		return moduleapi
	end

	function categoryapi:Expand(force)
		self.Expanded = true
		children.Visible = true
		arrow.Visible = false
		arrowbutton.Visible = false
		window.Size = UDim2.new(1, -20, 1, -20)
		divider.Visible = children.CanvasPosition.Y > 10 and children.Visible
	end

	arrowbutton.MouseButton1Click:Connect(function()
		categoryapi:Expand()
	end)
	arrowbutton.MouseButton2Click:Connect(function()
		categoryapi:Expand()
	end)
	arrowbutton.MouseEnter:Connect(function()
		arrow.ImageColor3 = Color3.fromRGB(220, 220, 220)
	end)
	arrowbutton.MouseLeave:Connect(function()
		arrow.ImageColor3 = Color3.fromRGB(140, 140, 140)
	end)
	children:GetPropertyChangedSignal('CanvasPosition'):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8)
		end
		divider.Visible = children.CanvasPosition.Y > 10 and children.Visible
	end)
	window.InputBegan:Connect(function(inputObj)
		-- Category content is always shown in the premium centered layout.
	end)
	windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8)
		end
		children.CanvasSize = UDim2.fromOffset(0, windowlist.AbsoluteContentSize.Y / scale.Scale)
		if categoryapi.Expanded then
			window.Size = UDim2.new(1, -20, 1, -20)
		end
	end)

	categoryapi.Button = self.Categories.Main:CreateButton({
		Name = categorysettings.Name,
		Icon = categorysettings.Icon,
		Size = categorysettings.Size,
		Window = window,
		Api = categoryapi
	})

	categoryapi.Object = window
	self.Categories[categorysettings.Name] = categoryapi

	return categoryapi
end

function mainapi:CreateOverlay(categorysettings)
	local window
	local categoryapi
	categoryapi = {
		Type = 'Overlay',
		Expanded = false,
		Button = self.Overlays:CreateToggle({
			Name = categorysettings.Name,
			Function = function(callback)
				window.Visible = callback and (clickgui.Visible or categoryapi.Pinned)
				if not callback then
					for _, v in categoryapi.Connections do
						v:Disconnect()
					end
					table.clear(categoryapi.Connections)
				end

				if categorysettings.Function then
					task.spawn(categorysettings.Function, callback)
				end
			end,
			Icon = categorysettings.Icon,
			Size = categorysettings.Size,
			Position = categorysettings.Position
		}),
		Pinned = false,
		Options = {}
	}

	window = Instance.new('TextButton')
	window.Name = categorysettings.Name..'Overlay'
	window.Size = UDim2.fromOffset(categorysettings.CategorySize or 220, 41)
	window.Position = UDim2.fromOffset(240, 46)
	window.BackgroundColor3 = uipallet.Surface
	window.AutoButtonColor = false
	window.Visible = false
	window.Text = ''
	window.Parent = scaledgui
	local blur = addBlur(window)
	styleShell(window, UDim.new(0, 10), 0.45)
	makeDraggable(window)
	local icon = Instance.new('ImageLabel')
	icon.Name = 'Icon'
	icon.Size = categorysettings.Size
	icon.Position = UDim2.fromOffset(12, (icon.Size.X.Offset > 14 and 14 or 13))
	icon.BackgroundTransparency = 1
	icon.Image = categorysettings.Icon
	icon.ImageColor3 = uipallet.Text
	icon.Parent = window
	local title = Instance.new('TextLabel')
	title.Name = 'Title'
	title.Size = UDim2.new(1, -32, 0, 41)
	title.Position = UDim2.fromOffset(math.abs(title.Size.X.Offset), 0)
	title.BackgroundTransparency = 1
	title.Text = categorysettings.Name
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.TextColor3 = uipallet.Text
	title.TextSize = 13
	title.FontFace = uipallet.Font
	title.Parent = window
	local pin = Instance.new('ImageButton')
	pin.Name = 'Pin'
	pin.Size = UDim2.fromOffset(16, 16)
	pin.Position = UDim2.new(1, -47, 0, 12)
	pin.BackgroundTransparency = 1
	pin.AutoButtonColor = false
	pin.Image = getcustomasset('vape/assets/pin.png')
	pin.ImageColor3 = color.Dark(uipallet.Text, 0.43)
	pin.Parent = window
	local dotsbutton = Instance.new('TextButton')
	dotsbutton.Name = 'Dots'
	dotsbutton.Size = UDim2.fromOffset(17, 40)
	dotsbutton.Position = UDim2.new(1, -17, 0, 0)
	dotsbutton.BackgroundTransparency = 1
	dotsbutton.Text = ''
	dotsbutton.Parent = window
	local dots = Instance.new('ImageLabel')
	dots.Name = 'Dots'
	dots.Size = UDim2.fromOffset(3, 16)
	dots.Position = UDim2.fromOffset(7, 14)
	dots.BackgroundTransparency = 1
	dots.Image = getcustomasset('vape/assets/dots.png')
	dots.ImageColor3 = uipallet.Accent
	dots.Parent = dotsbutton
	local customchildren = Instance.new('Frame')
	customchildren.Name = 'CustomChildren'
	customchildren.Size = UDim2.new(1, 0, 0, 200)
	customchildren.Position = UDim2.fromScale(0, 1)
	customchildren.BackgroundTransparency = 1
	customchildren.Parent = window
	local children = Instance.new('ScrollingFrame')
	children.Name = 'Children'
	children.Size = UDim2.new(1, 0, 1, -41)
	children.Position = UDim2.fromOffset(0, 37)
	children.BackgroundColor3 = color.Dark(uipallet.Surface, 0.01)
	children.BorderSizePixel = 0
	children.Visible = false
	children.ScrollBarThickness = 4
	children.ScrollBarImageTransparency = 0.75
	children.CanvasSize = UDim2.new()
	children.Parent = window
	local windowlist = Instance.new('UIListLayout')
	windowlist.SortOrder = Enum.SortOrder.LayoutOrder
	windowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
	windowlist.Parent = children
	styleListLayout(windowlist, 4)
	addMaid(categoryapi)

	function categoryapi:Expand(check)
		if check and not blur.Visible then return end
		self.Expanded = not self.Expanded
		children.Visible = self.Expanded
		dots.ImageColor3 = self.Expanded and uipallet.Text or color.Light(uipallet.Main, 0.37)
		if self.Expanded then
			window.Size = UDim2.fromOffset(window.Size.X.Offset, math.min(41 + windowlist.AbsoluteContentSize.Y / scale.Scale, 601))
		else
			window.Size = UDim2.fromOffset(window.Size.X.Offset, 41)
		end
	end

	function categoryapi:Pin()
		self.Pinned = not self.Pinned
		pin.ImageColor3 = self.Pinned and uipallet.Text or color.Dark(uipallet.Text, 0.43)
	end

	function categoryapi:Update()
		window.Visible = self.Button.Enabled and (clickgui.Visible or self.Pinned)
		if self.Expanded then
			self:Expand()
		end
		if clickgui.Visible then
			window.Size = UDim2.fromOffset(window.Size.X.Offset, 41)
			window.BackgroundTransparency = 0
			blur.Visible = true
			icon.Visible = true
			title.Visible = true
			pin.Visible = true
			dotsbutton.Visible = true
		else
			window.Size = UDim2.fromOffset(window.Size.X.Offset, 0)
			window.BackgroundTransparency = 1
			blur.Visible = false
			icon.Visible = false
			title.Visible = false
			pin.Visible = false
			dotsbutton.Visible = false
		end
	end

	for i, v in components do
		categoryapi['Create'..i] = function(self, optionsettings)
			return v(optionsettings, children, categoryapi)
		end
	end

	dotsbutton.MouseEnter:Connect(function()
		if not children.Visible then
			dots.ImageColor3 = uipallet.Text
		end
	end)
	dotsbutton.MouseLeave:Connect(function()
		if not children.Visible then
			dots.ImageColor3 = uipallet.Accent
		end
	end)
	dotsbutton.MouseButton1Click:Connect(function()
		categoryapi:Expand(true)
	end)
	dotsbutton.MouseButton2Click:Connect(function()
		categoryapi:Expand(true)
	end)
	pin.MouseButton1Click:Connect(function()
		categoryapi:Pin()
	end)
	window.MouseButton2Click:Connect(function()
		categoryapi:Expand(true)
	end)
	windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8)
		end
		children.CanvasSize = UDim2.fromOffset(0, windowlist.AbsoluteContentSize.Y / scale.Scale)
		if categoryapi.Expanded then
			window.Size = UDim2.fromOffset(window.Size.X.Offset, math.min(41 + windowlist.AbsoluteContentSize.Y / scale.Scale, 601))
		end
	end)
	self:Clean(clickgui:GetPropertyChangedSignal('Visible'):Connect(function()
		categoryapi:Update()
	end))

	categoryapi:Update()
	categoryapi.Object = window
	categoryapi.Children = customchildren
	self.Categories[categorysettings.Name] = categoryapi

	return categoryapi
end

function mainapi:CreateCategoryList(categorysettings)
	local categoryapi = {
		Type = 'CategoryList',
		Expanded = false,
		List = {},
		ListEnabled = {},
		Objects = {},
		Options = {}
	}
	categorysettings.Color = categorysettings.Color or Color3.fromRGB(5, 134, 105)

	local window = Instance.new('TextButton')
	window.Name = categorysettings.Name..'CategoryList'
	window.Size = UDim2.new(1, -20, 1, -20)
	window.Position = UDim2.fromOffset(10, 10)
	window.BackgroundColor3 = uipallet.SurfaceHigh or uipallet.Surface
	window.BackgroundTransparency = uipallet.PanelTransparency or 0.02
	window.AutoButtonColor = false
	window.Visible = false
	window.Text = ''
	window.ClipsDescendants = true
	window.Parent = mainapi.PremiumContent or clickgui
	styleShell(window, UDim.new(0, 12), 0.54)
	local icon = Instance.new('ImageLabel')
	icon.Name = 'Icon'
	icon.Size = categorysettings.Size
	icon.Position = categorysettings.Position or UDim2.fromOffset(12, (categorysettings.Size.X.Offset > 20 and 13 or 12))
	icon.BackgroundTransparency = 1
	icon.Image = categorysettings.Icon
	icon.ImageColor3 = uipallet.Text
	icon.Parent = window
	local title = Instance.new('TextLabel')
	title.Name = 'Title'
	title.Size = UDim2.new(1, -(categorysettings.Size.X.Offset > 20 and 44 or 36), 0, 20)
	title.Position = UDim2.fromOffset(math.abs(title.Size.X.Offset), 12)
	title.BackgroundTransparency = 1
	title.Text = categorysettings.Name
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.TextColor3 = uipallet.Text
	title.TextSize = 13
	title.FontFace = uipallet.Font
	title.Parent = window
	local arrowbutton = Instance.new('TextButton')
	arrowbutton.Name = 'Arrow'
	arrowbutton.Size = UDim2.fromOffset(40, 40)
	arrowbutton.Position = UDim2.new(1, -40, 0, 0)
	arrowbutton.BackgroundTransparency = 1
	arrowbutton.Text = ''
	arrowbutton.Parent = window
	local arrow = Instance.new('ImageLabel')
	arrow.Name = 'Arrow'
	arrow.Size = UDim2.fromOffset(9, 4)
	arrow.Position = UDim2.fromOffset(20, 19)
	arrow.BackgroundTransparency = 1
	arrow.Image = getcustomasset('vape/assets/expandup.png')
	arrow.ImageColor3 = uipallet.MutedText
	arrow.Rotation = 180
	arrow.Parent = arrowbutton
	local children = Instance.new('ScrollingFrame')
	children.Name = 'Children'
	children.Size = UDim2.new(1, 0, 1, -45)
	children.Position = UDim2.fromOffset(0, 45)
	children.BackgroundTransparency = 1
	children.BorderSizePixel = 0
	children.Visible = false
	children.ScrollBarThickness = 4
	children.ScrollBarImageTransparency = 0.75
	children.CanvasSize = UDim2.new()
	children.Parent = window
	local childrentwo = Instance.new('Frame')
	childrentwo.BackgroundTransparency = 1
	childrentwo.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
	childrentwo.Visible = false
	childrentwo.Parent = children
	local settings = Instance.new('ImageButton')
	settings.Name = 'Settings'
	settings.Size = UDim2.fromOffset(16, 16)
	settings.Position = UDim2.new(1, -52, 0, 13)
	settings.BackgroundTransparency = 1
	settings.AutoButtonColor = false
	settings.Image = getcustomasset('vape/assets/customsettings.png')
	settings.ImageColor3 = color.Dark(uipallet.Text, 0.43)
	settings.Parent = window
	local divider = Instance.new('Frame')
	divider.Name = 'Divider'
	divider.Size = UDim2.new(1, 0, 0, 1)
	divider.Position = UDim2.fromOffset(0, 41)
	divider.BorderSizePixel = 0
	divider.Visible = false
	divider.BackgroundColor3 = uipallet.Border
	divider.BackgroundTransparency = 0.62
	divider.Parent = window
	local windowlist = Instance.new('UIListLayout')
	windowlist.SortOrder = Enum.SortOrder.LayoutOrder
	windowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
	windowlist.Padding = UDim.new(0, 3)
	windowlist.Parent = children
	styleListLayout(windowlist, 4)
	local windowlisttwo = Instance.new('UIListLayout')
	windowlisttwo.SortOrder = Enum.SortOrder.LayoutOrder
	windowlisttwo.HorizontalAlignment = Enum.HorizontalAlignment.Center
	windowlisttwo.Parent = childrentwo
	styleListLayout(windowlisttwo, 4)
	local addbkg = Instance.new('Frame')
	addbkg.Name = 'Add'
	addbkg.Size = UDim2.fromOffset(200, 31)
	addbkg.Position = UDim2.fromOffset(10, 45)
	addbkg.BackgroundColor3 = uipallet.SurfaceAlt
	addbkg.Parent = children
	styleShell(addbkg, UDim.new(0, 8), 0.62)
	local addbox = addbkg:Clone()
	addbox.Size = UDim2.new(1, -2, 1, -2)
	addbox.Position = UDim2.fromOffset(1, 1)
	addbox.BackgroundColor3 = uipallet.Surface
	addbox.Parent = addbkg
	local addvalue = Instance.new('TextBox')
	addvalue.Size = UDim2.new(1, -35, 1, 0)
	addvalue.Position = UDim2.fromOffset(10, 0)
	addvalue.BackgroundTransparency = 1
	addvalue.Text = ''
	addvalue.PlaceholderText = categorysettings.Placeholder or 'Add entry...'
	addvalue.TextXAlignment = Enum.TextXAlignment.Left
	addvalue.TextColor3 = uipallet.Text
	addvalue.PlaceholderColor3 = uipallet.MutedText
	addvalue.TextSize = 15
	addvalue.FontFace = uipallet.Font
	addvalue.ClearTextOnFocus = false
	addvalue.Parent = addbkg
	local addbutton = Instance.new('ImageButton')
	addbutton.Name = 'AddButton'
	addbutton.Size = UDim2.fromOffset(16, 16)
	addbutton.Position = UDim2.new(1, -26, 0, 8)
	addbutton.BackgroundTransparency = 1
	addbutton.Image = getcustomasset('vape/assets/add.png')
	addbutton.ImageColor3 = categorysettings.Color
	addbutton.ImageTransparency = 0.3
	addbutton.Parent = addbkg
	local cursedpadding = Instance.new('Frame')
	cursedpadding.Size = UDim2.fromOffset()
	cursedpadding.BackgroundTransparency = 1
	cursedpadding.Parent = children
	categorysettings.Function = categorysettings.Function or function() end
	categorysettings.Function = function() return pcall(function() categorysettings.Function() end) end

	function categoryapi:ChangeValue(val)
		if val then
			if categorysettings.Profiles then
				local ind = self:GetValue(val)
				if ind then
					if val ~= 'default' then
						table.remove(mainapi.Profiles, ind)
						if isfile('vape/profiles/'..val..mainapi.Place..'.txt') and delfile then
							delfile('vape/profiles/'..val..mainapi.Place..'.txt')
						end
					end
				else
					table.insert(mainapi.Profiles, {Name = val, Bind = {}})
				end
			else
				local ind = table.find(self.List, val)
				if ind then
					table.remove(self.List, ind)
					ind = table.find(self.ListEnabled, val)
					if ind then
						table.remove(self.ListEnabled, ind)
					end
				else
					table.insert(self.List, val)
					table.insert(self.ListEnabled, val)
				end
			end
		end

		categorysettings.Function()
		for _, v in self.Objects do
			v:Destroy()
		end
		table.clear(self.Objects)
		self.Selected = nil

		for i, v in (categorysettings.Profiles and mainapi.Profiles or self.List) do
			if categorysettings.Profiles then
				local object = Instance.new('TextButton')
				object.Name = v.Name
				object.Size = UDim2.fromOffset(200, 33)
				object.BackgroundColor3 = uipallet.SurfaceAlt
				object.AutoButtonColor = false
				object.Text = ''
				object.Parent = children
				styleShell(object, UDim.new(0, 8), 0.66)
				local objectstroke = Instance.new('UIStroke')
				objectstroke.Color = color.Light(uipallet.Main, 0.1)
				objectstroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				objectstroke.Enabled = false
				objectstroke.Parent = object
				local objecttitle = Instance.new('TextLabel')
				objecttitle.Name = 'Title'
				objecttitle.Size = UDim2.new(1, -10, 1, 0)
				objecttitle.Position = UDim2.fromOffset(10, 0)
				objecttitle.BackgroundTransparency = 1
				objecttitle.Text = v.Name
				objecttitle.TextXAlignment = Enum.TextXAlignment.Left
				objecttitle.TextColor3 = color.Dark(uipallet.Text, 0.4)
				objecttitle.TextSize = 15
				objecttitle.FontFace = uipallet.Font
				objecttitle.Parent = object
				local dotsbutton = Instance.new('TextButton')
				dotsbutton.Name = 'Dots'
				dotsbutton.Size = UDim2.fromOffset(25, 33)
				dotsbutton.Position = UDim2.new(1, -28, 0, 2)
				dotsbutton.BackgroundTransparency = 1
				dotsbutton.Text = ''
				dotsbutton.Parent = object
				local dots = Instance.new('ImageLabel')
				dots.Name = 'Dots'
				dots.Size = UDim2.fromOffset(3, 16)
				dots.Position = UDim2.fromOffset(10, 9)
				dots.BackgroundTransparency = 1
				dots.Image = getcustomasset('vape/assets/dots.png')
				dots.ImageColor3 = uipallet.Accent
				dots.Parent = dotsbutton
				local bind = Instance.new('TextButton')
				addTooltip(bind, 'Click to bind')
				bind.Name = 'Bind'
				bind.Size = UDim2.fromOffset(20, 21)
				bind.Position = UDim2.new(1, -30, 0, 6)
				bind.AnchorPoint = Vector2.new(1, 0)
				bind.BackgroundColor3 = color.Light(uipallet.SurfaceAlt, 0.05)
				bind.BackgroundTransparency = 0.2
				bind.BorderSizePixel = 0
				bind.AutoButtonColor = false
				bind.Visible = false
				bind.Text = ''
				addCorner(bind, UDim.new(0, 4))
				addStroke(bind, uipallet.Border, 1, 0.68)
				local bindicon = Instance.new('ImageLabel')
				bindicon.Name = 'Icon'
				bindicon.Size = UDim2.fromOffset(12, 12)
				bindicon.Position = UDim2.new(0.5, -6, 0, 5)
				bindicon.BackgroundTransparency = 1
				bindicon.Image = getcustomasset('vape/assets/bind.png')
				bindicon.ImageColor3 = color.Dark(uipallet.Text, 0.43)
				bindicon.Parent = bind
				local bindtext = Instance.new('TextLabel')
				bindtext.Size = UDim2.fromScale(1, 1)
				bindtext.Position = UDim2.fromOffset(0, 1)
				bindtext.BackgroundTransparency = 1
				bindtext.Visible = false
				bindtext.Text = ''
				bindtext.TextColor3 = color.Dark(uipallet.Text, 0.43)
				bindtext.TextSize = 12
				bindtext.FontFace = uipallet.Font
				bindtext.Parent = bind
				bind.MouseEnter:Connect(function()
					bindtext.Visible = false
					bindicon.Visible = not bindtext.Visible
					bindicon.Image = getcustomasset('vape/assets/edit.png')
					if v.Name ~= mainapi.Profile then
						bindicon.ImageColor3 = color.Dark(uipallet.Text, 0.16)
					end
				end)
				bind.MouseLeave:Connect(function()
					bindtext.Visible = #v.Bind > 0
					bindicon.Visible = not bindtext.Visible
					bindicon.Image = getcustomasset('vape/assets/bind.png')
					if v.Name ~= mainapi.Profile then
						bindicon.ImageColor3 = color.Dark(uipallet.Text, 0.43)
					end
				end)
				local bindcover = Instance.new('ImageLabel')
				bindcover.Name = 'Cover'
				bindcover.Size = UDim2.fromOffset(154, 33)
				bindcover.BackgroundTransparency = 1
				bindcover.Visible = false
				bindcover.Image = getcustomasset('vape/assets/bindbkg.png')
				bindcover.ScaleType = Enum.ScaleType.Slice
				bindcover.SliceCenter = Rect.new(0, 0, 141, 40)
				bindcover.Parent = object
				local bindcovertext = Instance.new('TextLabel')
				bindcovertext.Name = 'Text'
				bindcovertext.Size = UDim2.new(1, -10, 1, -3)
				bindcovertext.BackgroundTransparency = 1
				bindcovertext.Text = 'PRESS A KEY TO BIND'
				bindcovertext.TextColor3 = uipallet.Text
				bindcovertext.TextSize = 11
				bindcovertext.FontFace = uipallet.Font
				bindcovertext.Parent = bindcover
				bind.Parent = object
				dotsbutton.MouseEnter:Connect(function()
					if v.Name ~= mainapi.Profile then
						dots.ImageColor3 = uipallet.Text
					end
				end)
				dotsbutton.MouseLeave:Connect(function()
					if v.Name ~= mainapi.Profile then
						dots.ImageColor3 = uipallet.Accent
					end
				end)
				dotsbutton.MouseButton1Click:Connect(function()
					if v.Name ~= mainapi.Profile then
						categoryapi:ChangeValue(v.Name)
					end
				end)
				object.MouseButton1Click:Connect(function()
					mainapi:Save(v.Name)
					mainapi:Load(true)
				end)
				object.MouseEnter:Connect(function()
					bind.Visible = true
					if v.Name ~= mainapi.Profile then
						objectstroke.Enabled = true
						objecttitle.TextColor3 = color.Dark(uipallet.Text, 0.16)
					end
				end)
				object.MouseLeave:Connect(function()
					bind.Visible = #v.Bind > 0
					if v.Name ~= mainapi.Profile then
						objectstroke.Enabled = false
						objecttitle.TextColor3 = color.Dark(uipallet.Text, 0.4)
					end
				end)

				local function bindFunction(self, tab, mouse)
					v.Bind = table.clone(tab)
					if mouse then
						bindcovertext.Text = #tab <= 0 and 'BIND REMOVED' or 'BOUND TO '..table.concat(tab, ' + '):upper()
						bindcover.Size = UDim2.fromOffset(getfontsize(bindcovertext.Text, bindcovertext.TextSize).X + 20, 40)
						task.delay(1, function()
							bindcover.Visible = false
						end)
					end

					if #tab <= 0 then
						bindtext.Visible = false
						bindicon.Visible = true
						bind.Size = UDim2.fromOffset(20, 21)
					else
						bind.Visible = true
						bindtext.Visible = true
						bindicon.Visible = false
						bindtext.Text = table.concat(tab, ' + '):upper()
						bind.Size = UDim2.fromOffset(math.max(getfontsize(bindtext.Text, bindtext.TextSize, bindtext.Font).X + 10, 20), 21)
					end
				end

				bindFunction({}, v.Bind)
				bind.MouseButton1Click:Connect(function()
					bindcovertext.Text = 'PRESS A KEY TO BIND'
					bindcover.Size = UDim2.fromOffset(getfontsize(bindcovertext.Text, bindcovertext.TextSize).X + 20, 40)
					bindcover.Visible = true
					mainapi.Binding = {SetBind = bindFunction, Bind = v.Bind}
				end)
				if v.Name == mainapi.Profile then
					self.Selected = object
				end
				table.insert(self.Objects, object)
			else
				local enabled = table.find(self.ListEnabled, v)
				local object = Instance.new('TextButton')
				object.Name = v
				object.Size = UDim2.fromOffset(200, 32)
				object.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
				object.AutoButtonColor = false
				object.Text = ''
				object.Parent = children
				addCorner(object)
				local objectbkg = Instance.new('Frame')
				objectbkg.Name = 'BKG'
				objectbkg.Size = UDim2.new(1, -2, 1, -2)
				objectbkg.Position = UDim2.fromOffset(1, 1)
				objectbkg.BackgroundColor3 = color.Light(uipallet.SurfaceAlt, 0.04)
				objectbkg.Visible = false
				objectbkg.Parent = object
				addCorner(objectbkg, UDim.new(0, 7))
				local objectdot = Instance.new('Frame')
				objectdot.Name = 'Dot'
				objectdot.Size = UDim2.fromOffset(10, 11)
				objectdot.Position = UDim2.fromOffset(10, 12)
				objectdot.BackgroundColor3 = enabled and categorysettings.Color or color.Light(uipallet.Main, 0.37)
				objectdot.Parent = object
				addCorner(objectdot, UDim.new(1, 0))
				local objectdotin = objectdot:Clone()
				objectdotin.Size = UDim2.fromOffset(8, 9)
				objectdotin.Position = UDim2.fromOffset(1, 1)
				objectdotin.BackgroundColor3 = enabled and categorysettings.Color or uipallet.Surface
				objectdotin.Parent = objectdot
				local objecttitle = Instance.new('TextLabel')
				objecttitle.Name = 'Title'
				objecttitle.Size = UDim2.new(1, -30, 1, 0)
				objecttitle.Position = UDim2.fromOffset(30, 0)
				objecttitle.BackgroundTransparency = 1
				objecttitle.Text = v
				objecttitle.TextXAlignment = Enum.TextXAlignment.Left
				objecttitle.TextColor3 = color.Dark(uipallet.Text, 0.1)
				objecttitle.TextSize = 15
				objecttitle.FontFace = uipallet.Font
				objecttitle.Parent = object
				if mainapi.ThreadFix then
					setthreadidentity(8)
				end
				local close = Instance.new('ImageButton')
				close.Name = 'Close'
				close.Size = UDim2.fromOffset(16, 16)
				close.Position = UDim2.new(1, -23, 0, 8)
				close.BackgroundColor3 = uipallet.Surface
				close.BackgroundTransparency = 0.45
				close.AutoButtonColor = false
				close.Image = getcustomasset('vape/assets/closemini.png')
				close.ImageColor3 = color.Light(uipallet.Text, 0.2)
				close.ImageTransparency = 0.5
				close.Parent = object
				addCorner(close, UDim.new(1, 0))
				close.MouseEnter:Connect(function()
					close.ImageTransparency = 0.3
					tween:Tween(close, uipallet.Tween, {
						BackgroundTransparency = 0.25
					})
				end)
				close.MouseLeave:Connect(function()
					close.ImageTransparency = 0.5
					tween:Tween(close, uipallet.Tween, {
						BackgroundTransparency = 0.45
					})
				end)
				close.MouseButton1Click:Connect(function()
					categoryapi:ChangeValue(v)
				end)
				object.MouseEnter:Connect(function()
					objectbkg.Visible = true
				end)
				object.MouseLeave:Connect(function()
					objectbkg.Visible = false
				end)
				object.MouseButton1Click:Connect(function()
					local ind = table.find(self.ListEnabled, v)
					if ind then
						table.remove(self.ListEnabled, ind)
						objectdot.BackgroundColor3 = color.Light(uipallet.Main, 0.37)
						objectdotin.BackgroundColor3 = uipallet.Surface
					else
						table.insert(self.ListEnabled, v)
						objectdot.BackgroundColor3 = categorysettings.Color
						objectdotin.BackgroundColor3 = categorysettings.Color
					end
					categorysettings.Function()
				end)
				table.insert(self.Objects, object)
			end
		end
		mainapi:UpdateGUI(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
	end

	function categoryapi:Expand(force)
		self.Expanded = force ~= nil and force or not self.Expanded
		children.Visible = self.Expanded
		arrow.Rotation = self.Expanded and 0 or 180
		window.Size = UDim2.new(1, -20, 1, -20)
		divider.Visible = children.CanvasPosition.Y > 10 and children.Visible
	end

	function categoryapi:GetValue(name)
		for i, v in mainapi.Profiles do
			if v.Name == name then
				return i
			end
		end
	end

	for i, v in components do
		categoryapi['Create'..i] = function(self, optionsettings)
			return v(optionsettings, childrentwo, categoryapi)
		end
	end

	addbutton.MouseEnter:Connect(function()
		addbutton.ImageTransparency = 0
	end)
	addbutton.MouseLeave:Connect(function()
		addbutton.ImageTransparency = 0.3
	end)
	addbutton.MouseButton1Click:Connect(function()
		if not table.find(categoryapi.List, addvalue.Text) then
			categoryapi:ChangeValue(addvalue.Text)
			addvalue.Text = ''
		end
	end)
	arrowbutton.MouseEnter:Connect(function()
		arrow.ImageColor3 = Color3.fromRGB(220, 220, 220)
	end)
	arrowbutton.MouseLeave:Connect(function()
		arrow.ImageColor3 = Color3.fromRGB(140, 140, 140)
	end)
	arrowbutton.MouseButton1Click:Connect(function()
		categoryapi:Expand()
	end)
	arrowbutton.MouseButton2Click:Connect(function()
		categoryapi:Expand()
	end)
	addvalue.FocusLost:Connect(function(enter)
		if enter and not table.find(categoryapi.List, addvalue.Text) then
			categoryapi:ChangeValue(addvalue.Text)
			addvalue.Text = ''
		end
	end)
	addvalue.MouseEnter:Connect(function()
		tween:Tween(addbkg, uipallet.Tween, {
			BackgroundColor3 = color.Light(uipallet.Main, 0.14)
		})
	end)
	addvalue.MouseLeave:Connect(function()
		tween:Tween(addbkg, uipallet.Tween, {
			BackgroundColor3 = color.Light(uipallet.Main, 0.02)
		})
	end)
	children:GetPropertyChangedSignal('CanvasPosition'):Connect(function()
		divider.Visible = children.CanvasPosition.Y > 10 and children.Visible
	end)
	settings.MouseEnter:Connect(function()
		settings.ImageColor3 = uipallet.Text
	end)
	settings.MouseLeave:Connect(function()
		settings.ImageColor3 = color.Light(uipallet.Main, 0.37)
	end)
	settings.MouseButton1Click:Connect(function()
		childrentwo.Visible = not childrentwo.Visible
	end)
	window.InputBegan:Connect(function(inputObj)
		if inputObj.Position.Y < window.AbsolutePosition.Y + 41 and inputObj.UserInputType == Enum.UserInputType.MouseButton2 then
			categoryapi:Expand()
		end
	end)
	windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8)
		end
		children.CanvasSize = UDim2.fromOffset(0, windowlist.AbsoluteContentSize.Y / scale.Scale)
		if categoryapi.Expanded then
			window.Size = UDim2.new(1, -20, 1, -20)
		end
	end)
	windowlisttwo:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8)
		end
		childrentwo.Size = UDim2.fromOffset(220, windowlisttwo.AbsoluteContentSize.Y)
	end)

	categoryapi.Button = self.Categories.Main:CreateButton({
		Name = categorysettings.Name,
		Icon = categorysettings.CategoryIcon,
		Size = categorysettings.CategorySize,
		Window = window,
		Api = categoryapi
	})

	categoryapi.Object = window
	self.Categories[categorysettings.Name] = categoryapi

	return categoryapi
end

mainapi.RemoveObject = function(name)
	name = tostring(name)
	local suc, err = pcall(function()
		mainapi:Remove(name:match("^(.-)OptionsButton") or name)
	end)
	return suc, err
end

function mainapi:CreateSearch()
	local searchbkg = Instance.new('Frame')
	searchbkg.Name = 'Search'
	searchbkg.Size = UDim2.fromOffset(220, 39)
	searchbkg.Position = UDim2.new(0.5, 0, 0, 13)
	searchbkg.AnchorPoint = Vector2.new(0.5, 0)
	searchbkg.BackgroundColor3 = uipallet.SurfaceAlt
	searchbkg.Parent = scaledgui
	searchbkg.Visible = clickgui.Visible
	clickgui:GetPropertyChangedSignal("Visible"):Connect(function()
		searchbkg.Visible = clickgui.Visible
	end)
	local searchicon = Instance.new('ImageLabel')
	searchicon.Name = 'Icon'
	searchicon.Size = UDim2.fromOffset(14, 14)
	searchicon.Position = UDim2.new(1, -23, 0, 11)
	searchicon.BackgroundTransparency = 1
	searchicon.Image = getcustomasset('vape/assets/search.png')
	searchicon.ImageColor3 = color.Light(uipallet.Main, 0.37)
	searchicon.Parent = searchbkg
	local legiticon = Instance.new('ImageButton')
	legiticon.Name = 'Legit'
	legiticon.Size = UDim2.fromOffset(29, 16)
	legiticon.Position = UDim2.fromOffset(8, 11)
	legiticon.BackgroundTransparency = 1
	legiticon.Image = getcustomasset('vape/assets/legit.png')
	legiticon.Parent = searchbkg
	local legitdivider = Instance.new('Frame')
	legitdivider.Name = 'LegitDivider'
	legitdivider.Size = UDim2.fromOffset(2, 12)
	legitdivider.Position = UDim2.fromOffset(43, 13)
	legitdivider.BackgroundColor3 = color.Light(uipallet.Main, 0.14)
	legitdivider.BorderSizePixel = 0
	legitdivider.Parent = searchbkg
	addBlur(searchbkg)
	styleShell(searchbkg, UDim.new(0, 10), 0.52)
	local search = Instance.new('TextBox')
	search.Size = UDim2.new(1, -50, 0, 37)
	search.Position = UDim2.fromOffset(50, 0)
	search.BackgroundTransparency = 1
	search.Text = ''
	search.PlaceholderText = ''
	search.TextXAlignment = Enum.TextXAlignment.Left
	search.TextColor3 = uipallet.Text
	search.TextSize = 13
	search.FontFace = uipallet.Font
	search.ClearTextOnFocus = false
	search.Parent = searchbkg
	local children = Instance.new('ScrollingFrame')
	children.Name = 'Children'
	children.Size = UDim2.new(1, 0, 1, -37)
	children.Position = UDim2.fromOffset(0, 34)
	children.BackgroundTransparency = 1
	children.BorderSizePixel = 0
	children.ScrollBarThickness = 4
	children.ScrollBarImageTransparency = 0.75
	children.CanvasSize = UDim2.new()
	children.Parent = searchbkg
	local divider = Instance.new('Frame')
	divider.Name = 'Divider'
	divider.Size = UDim2.new(1, 0, 0, 1)
	divider.Position = UDim2.fromOffset(0, 33)
	divider.BackgroundColor3 = Color3.new(1, 1, 1)
	divider.BackgroundTransparency = 0.928
	divider.BorderSizePixel = 0
	divider.Visible = false
	divider.Parent = searchbkg
	local windowlist = Instance.new('UIListLayout')
	windowlist.SortOrder = Enum.SortOrder.LayoutOrder
	windowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
	windowlist.Parent = children
	styleListLayout(windowlist, 3)

	children:GetPropertyChangedSignal('CanvasPosition'):Connect(function()
		divider.Visible = children.CanvasPosition.Y > 10 and children.Visible
	end)
	legiticon.MouseButton1Click:Connect(function()
		clickgui.Visible = false
		self.Legit.Window.Visible = true
		self.Legit.Window.Position = UDim2.new(0.5, -350, 0.5, -194)
	end)
	search:GetPropertyChangedSignal('Text'):Connect(function()
		for _, v in children:GetChildren() do
			if v:IsA('TextButton') then
				v:Destroy()
			end
		end
		if search.Text == '' then return end

		for i, v in self.Modules do
			if i:lower():find(search.Text:lower()) then
				local button = v.Object:Clone()
				button.Bind:Destroy()
				button.MouseButton1Click:Connect(function()
					v:Toggle()
				end)
				button.Parent = children
				task.spawn(function()
					repeat
						for _, v2 in {'Text', 'TextColor3', 'BackgroundColor3'} do
							button[v2] = v.Object[v2]
						end
						button.UIGradient.Color = v.Object.UIGradient.Color
						button.UIGradient.Enabled = v.Object.UIGradient.Enabled
						button.Dots.Dots.ImageColor3 = v.Object.Dots.Dots.ImageColor3
						task.wait()
					until not button.Parent
				end)
			end
		end
	end)
	windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8)
		end
		children.CanvasSize = UDim2.fromOffset(0, windowlist.AbsoluteContentSize.Y / scale.Scale)
		searchbkg.Size = UDim2.fromOffset(220, math.min(39 + windowlist.AbsoluteContentSize.Y / scale.Scale, 437))
	end)

	self.Legit.Icon = legiticon
end

function mainapi:CreateLegit()
	local legitapi = {Modules = {}}

	local window = Instance.new('Frame')
	window.Name = 'LegitGUI'
	window.Size = UDim2.fromOffset(700, 389)
	window.Position = UDim2.new(0.5, -350, 0.5, -194)
	window.BackgroundColor3 = uipallet.Surface
	window.Visible = false
	window.Parent = scaledgui
	addBlur(window)
	styleShell(window, UDim.new(0, 11), 0.45)
	makeDraggable(window)
	local modal = Instance.new('TextButton')
	modal.BackgroundTransparency = 1
	modal.Text = ''
	modal.Modal = true
	modal.Parent = window
	local icon = Instance.new('ImageLabel')
	icon.Name = 'Icon'
	icon.Size = UDim2.fromOffset(16, 16)
	icon.Position = UDim2.fromOffset(18, 13)
	icon.BackgroundTransparency = 1
	icon.Image = getcustomasset('vape/assets/legittab.png')
	icon.ImageColor3 = uipallet.Text
	icon.Parent = window
	local close = addCloseButton(window)
	local children = Instance.new('ScrollingFrame')
	children.Name = 'Children'
	children.Size = UDim2.fromOffset(684, 340)
	children.Position = UDim2.fromOffset(14, 41)
	children.BackgroundTransparency = 1
	children.BorderSizePixel = 0
	children.ScrollBarThickness = 4
	children.ScrollBarImageTransparency = 0.75
	children.CanvasSize = UDim2.new()
	children.Parent = window
	local windowlist = Instance.new('UIGridLayout')
	windowlist.SortOrder = Enum.SortOrder.LayoutOrder
	windowlist.FillDirectionMaxCells = 4
	windowlist.CellSize = UDim2.fromOffset(163, 114)
	windowlist.CellPadding = UDim2.fromOffset(6, 5)
	windowlist.Parent = children
	legitapi.Window = window
	table.insert(mainapi.Windows, window)

	function legitapi:CreateModule(modulesettings)
		mainapi:Remove(modulesettings.Name)
		local moduleapi = {
			Enabled = false,
			Options = {},
			Name = modulesettings.Name,
			Legit = true
		}

		local module = Instance.new('TextButton')
		module.Name = modulesettings.Name
		module.BackgroundColor3 = uipallet.SurfaceAlt
		module.Text = ''
		module.AutoButtonColor = false
		module.Parent = children
		addTooltip(module, modulesettings.Tooltip)
		styleShell(module, UDim.new(0, 8), 0.64)
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.new(1, -16, 0, 20)
		title.Position = UDim2.fromOffset(16, 81)
		title.BackgroundTransparency = 1
		title.Text = modulesettings.Name
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = color.Dark(uipallet.Text, 0.31)
		title.TextSize = 13
		title.FontFace = uipallet.Font
		title.Parent = module
		local knob = Instance.new('Frame')
		knob.Name = 'Knob'
		knob.Size = UDim2.fromOffset(28, 14)
		knob.Position = UDim2.new(1, -63, 0, 13)
		knob.BackgroundColor3 = color.Light(uipallet.Main, 0.12)
		knob.Parent = module
		addCorner(knob, UDim.new(1, 0))
		addStroke(knob, uipallet.Border, 1, 0.66)
		local knobmain = knob:Clone()
		knobmain.Size = UDim2.fromOffset(10, 10)
		knobmain.Position = UDim2.fromOffset(2, 2)
		knobmain.BackgroundColor3 = color.Light(uipallet.Surface, 0.06)
		knobmain.Parent = knob
		local dotsbutton = Instance.new('TextButton')
		dotsbutton.Name = 'Dots'
		dotsbutton.Size = UDim2.fromOffset(14, 24)
		dotsbutton.Position = UDim2.new(1, -27, 0, 8)
		dotsbutton.BackgroundTransparency = 1
		dotsbutton.Text = ''
		dotsbutton.Parent = module
		local dots = Instance.new('ImageLabel')
		dots.Name = 'Dots'
		dots.Size = UDim2.fromOffset(2, 12)
		dots.Position = UDim2.fromOffset(6, 6)
		dots.BackgroundTransparency = 1
		dots.Image = getcustomasset('vape/assets/dots.png')
		dots.ImageColor3 = uipallet.Accent
		dots.Parent = dotsbutton
		local shadow = Instance.new('TextButton')
		shadow.Name = 'Shadow'
		shadow.Size = UDim2.new(1, 0, 1, -5)
		shadow.BackgroundColor3 = Color3.new()
		shadow.BackgroundTransparency = 1
		shadow.AutoButtonColor = false
		shadow.ClipsDescendants = true
		shadow.Visible = false
		shadow.Text = ''
		shadow.Parent = window
		addCorner(shadow)
		local settingspane = Instance.new('TextButton')
		settingspane.Size = UDim2.new(0, 220, 1, 0)
		settingspane.Position = UDim2.fromScale(1, 0)
		settingspane.BackgroundColor3 = uipallet.Surface
		settingspane.AutoButtonColor = false
		settingspane.Text = ''
		settingspane.Parent = shadow
		local settingstitle = Instance.new('TextLabel')
		settingstitle.Name = 'Title'
		settingstitle.Size = UDim2.new(1, -36, 0, 20)
		settingstitle.Position = UDim2.fromOffset(36, 12)
		settingstitle.BackgroundTransparency = 1
		settingstitle.Text = modulesettings.Name
		settingstitle.TextXAlignment = Enum.TextXAlignment.Left
		settingstitle.TextColor3 = color.Dark(uipallet.Text, 0.16)
		settingstitle.TextSize = 13
		settingstitle.FontFace = uipallet.Font
		settingstitle.Parent = settingspane
		local back = Instance.new('ImageButton')
		back.Name = 'Back'
		back.Size = UDim2.fromOffset(16, 16)
		back.Position = UDim2.fromOffset(11, 13)
		back.BackgroundTransparency = 1
		back.Image = getcustomasset('vape/assets/back.png')
		back.ImageColor3 = color.Light(uipallet.Main, 0.37)
		back.Parent = settingspane
		addCorner(settingspane)
		addStroke(settingspane, uipallet.Border, 1, 0.42)
		local settingschildren = Instance.new('ScrollingFrame')
		settingschildren.Name = 'Children'
		settingschildren.Size = UDim2.new(1, 0, 1, -45)
		settingschildren.Position = UDim2.fromOffset(0, 41)
		settingschildren.BackgroundColor3 = uipallet.Surface
		settingschildren.BorderSizePixel = 0
		settingschildren.ScrollBarThickness = 4
		settingschildren.ScrollBarImageTransparency = 0.75
		settingschildren.CanvasSize = UDim2.new()
		settingschildren.Parent = settingspane
		local settingswindowlist = Instance.new('UIListLayout')
		settingswindowlist.SortOrder = Enum.SortOrder.LayoutOrder
		settingswindowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
		settingswindowlist.Parent = settingschildren
		styleListLayout(settingswindowlist, 4)
		if modulesettings.Size then
			local modulechildren = Instance.new('Frame')
			modulechildren.Size = modulesettings.Size
			modulechildren.BackgroundTransparency = 1
			modulechildren.Visible = false
			modulechildren.Parent = scaledgui
			makeDraggable(modulechildren, window)
			local objectstroke = Instance.new('UIStroke')
			objectstroke.Color = Color3.fromRGB(5, 134, 105)
			objectstroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			objectstroke.Thickness = 0
			objectstroke.Parent = modulechildren
			moduleapi.Children = modulechildren
		end
		modulesettings.Function = modulesettings.Function or function() end
		addMaid(moduleapi)

		function moduleapi:Toggle()
			moduleapi.Enabled = not moduleapi.Enabled
			if moduleapi.Children then
				moduleapi.Children.Visible = moduleapi.Enabled
			end
			title.TextColor3 = moduleapi.Enabled and color.Light(uipallet.Text, 0.2) or color.Dark(uipallet.Text, 0.31)
			module.BackgroundColor3 = moduleapi.Enabled and color.Light(uipallet.SurfaceAlt, 0.05) or uipallet.SurfaceAlt
			tween:Tween(knob, uipallet.Tween, {
				BackgroundColor3 = moduleapi.Enabled and Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value) or color.Light(uipallet.Main, 0.14)
			})
			tween:Tween(knobmain, uipallet.Tween, {
				Position = UDim2.fromOffset(moduleapi.Enabled and 16 or 2, 2)
			})
			if not moduleapi.Enabled then
				for _, v in moduleapi.Connections do
					v:Disconnect()
				end
				table.clear(moduleapi.Connections)
			end
			task.spawn(modulesettings.Function, moduleapi.Enabled)
		end

		back.MouseEnter:Connect(function()
			back.ImageColor3 = uipallet.Text
		end)
		back.MouseLeave:Connect(function()
			back.ImageColor3 = color.Light(uipallet.Main, 0.37)
		end)
		back.MouseButton1Click:Connect(function()
			tween:Tween(shadow, uipallet.Tween, {
				BackgroundTransparency = 1
			})
			tween:Tween(settingspane, uipallet.Tween, {
				Position = UDim2.fromScale(1, 0)
			})
			task.wait(0.2)
			shadow.Visible = false
		end)
		dotsbutton.MouseButton1Click:Connect(function()
			shadow.Visible = true
			tween:Tween(shadow, uipallet.Tween, {
				BackgroundTransparency = 0.5
			})
			tween:Tween(settingspane, uipallet.Tween, {
				Position = UDim2.new(1, -220, 0, 0)
			})
		end)
		dotsbutton.MouseEnter:Connect(function()
			dots.ImageColor3 = uipallet.Text
		end)
		dotsbutton.MouseLeave:Connect(function()
			dots.ImageColor3 = uipallet.Accent
		end)
		module.MouseEnter:Connect(function()
			if not moduleapi.Enabled then
				module.BackgroundColor3 = color.Light(uipallet.SurfaceAlt, 0.05)
			end
		end)
		module.MouseLeave:Connect(function()
			if not moduleapi.Enabled then
				module.BackgroundColor3 = uipallet.SurfaceAlt
			end
		end)
		module.MouseButton1Click:Connect(function()
			moduleapi:Toggle()
		end)
		module.MouseButton2Click:Connect(function()
			shadow.Visible = true
			tween:Tween(shadow, uipallet.Tween, {
				BackgroundTransparency = 0.5
			})
			tween:Tween(settingspane, uipallet.Tween, {
				Position = UDim2.new(1, -220, 0, 0)
			})
		end)
		shadow.MouseButton1Click:Connect(function()
			tween:Tween(shadow, uipallet.Tween, {
				BackgroundTransparency = 1
			})
			tween:Tween(settingspane, uipallet.Tween, {
				Position = UDim2.fromScale(1, 0)
			})
			task.wait(0.2)
			shadow.Visible = false
		end)
		settingswindowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			if mainapi.ThreadFix then
				setthreadidentity(8)
			end
			settingschildren.CanvasSize = UDim2.fromOffset(0, settingswindowlist.AbsoluteContentSize.Y / scale.Scale)
		end)

		for i, v in components do
			moduleapi['Create'..i] = function(_, optionsettings)
				return v(optionsettings, settingschildren, moduleapi)
			end
		end

		moduleapi.Object = module
		legitapi.Modules[modulesettings.Name] = moduleapi

		local sorting = {}
		for _, v in legitapi.Modules do
			table.insert(sorting, v.Name)
		end
		table.sort(sorting)

		for i, v in sorting do
			legitapi.Modules[v].Object.LayoutOrder = i
		end

		return moduleapi
	end

	local function visibleCheck()
		for _, v in legitapi.Modules do
			if v.Children then
				local visible = clickgui.Visible
				for _, v2 in self.Windows do
					visible = visible or v2.Visible
				end
				v.Children.Visible = (not visible or window.Visible) and v.Enabled
			end
		end
	end

	close.MouseButton1Click:Connect(function()
		window.Visible = false
		clickgui.Visible = true
	end)
	self:Clean(clickgui:GetPropertyChangedSignal('Visible'):Connect(visibleCheck))
	window:GetPropertyChangedSignal('Visible'):Connect(function()
		self:UpdateGUI(self.GUIColor.Hue, self.GUIColor.Sat, self.GUIColor.Value)
		visibleCheck()
	end)
	windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8)
		end
		children.CanvasSize = UDim2.fromOffset(0, windowlist.AbsoluteContentSize.Y / scale.Scale)
	end)

	self.Legit = legitapi

	return legitapi
end

function mainapi:CreateNotification(title, text, duration, type)
	if not self.Notifications.Enabled then return end
	task.delay(0, function()
		if self.ThreadFix then
			setthreadidentity(8)
		end
		text = text or ''
		local hasText = removeTags(text) ~= ''
		local i = #notifications:GetChildren() + 1
		local notification = Instance.new('ImageLabel')
		notification.Name = 'Notification'
		notification.Size = UDim2.fromOffset(math.max(getfontsize(removeTags(hasText and text or title), 14, uipallet.Font).X + 88, 238), hasText and 75 or 58)
		notification.Position = UDim2.new(1, 0, 1, -(29 + (78 * i)))
		notification.ZIndex = 5
		notification.BackgroundTransparency = 1
		notification.Image = getcustomasset('vape/assets/notification.png')
		notification.ScaleType = Enum.ScaleType.Slice
		notification.SliceCenter = Rect.new(7, 7, 9, 9)
		notification.Parent = notifications
		addStroke(notification, uipallet.Border, 1, 0.5)
		addBlur(notification, true)
		local iconshadow = Instance.new('ImageLabel')
		iconshadow.Name = 'Icon'
		iconshadow.Size = UDim2.fromOffset(60, 60)
		iconshadow.Position = UDim2.fromOffset(-5, -8)
		iconshadow.ZIndex = 5
		iconshadow.BackgroundTransparency = 1
		iconshadow.Image = getcustomasset('vape/assets/'..(type or 'info')..'.png')
		iconshadow.ImageColor3 = Color3.new()
		iconshadow.ImageTransparency = 0.5
		iconshadow.Parent = notification
		local icon = iconshadow:Clone()
		icon.Position = UDim2.fromOffset(-1, -1)
		icon.ImageColor3 = Color3.new(1, 1, 1)
		icon.ImageTransparency = 0
		icon.Parent = iconshadow
		local titlelabel = Instance.new('TextLabel')
		titlelabel.Name = 'Title'
		titlelabel.Size = UDim2.new(1, -56, 0, 20)
		titlelabel.Position = UDim2.fromOffset(46, hasText and 16 or 19)
		titlelabel.ZIndex = 5
		titlelabel.BackgroundTransparency = 1
		titlelabel.Text = "<stroke color='#FFFFFF' joins='round' thickness='0.3' transparency='0.5'>"..title..'</stroke>'
		titlelabel.TextXAlignment = Enum.TextXAlignment.Left
		titlelabel.TextYAlignment = Enum.TextYAlignment.Top
		titlelabel.TextColor3 = uipallet.Text
		titlelabel.TextSize = 13
		titlelabel.RichText = true
		titlelabel.FontFace = uipallet.FontSemiBold
		titlelabel.Parent = notification
		if hasText then
			local textshadow = titlelabel:Clone()
			textshadow.Name = 'Text'
			textshadow.Position = UDim2.fromOffset(47, 44)
			textshadow.Text = removeTags(text)
			textshadow.TextColor3 = Color3.new()
			textshadow.TextTransparency = 0.5
			textshadow.RichText = false
			textshadow.FontFace = uipallet.Font
			textshadow.Parent = notification
			local textlabel = textshadow:Clone()
			textlabel.Position = UDim2.fromOffset(-1, -1)
			textlabel.Text = text
			textlabel.TextColor3 = uipallet.MutedText
			textlabel.TextTransparency = 0
			textlabel.RichText = true
			textlabel.Parent = textshadow
		end
		local progress = Instance.new('Frame')
		progress.Name = 'Progress'
		progress.Size = UDim2.new(1, -13, 0, 2)
		progress.Position = UDim2.new(0, 3, 1, -4)
		progress.ZIndex = 5
		progress.BackgroundColor3 =
			type == 'alert' and Color3.fromRGB(250, 50, 56)
			or type == 'warning' and Color3.fromRGB(236, 129, 43)
			or uipallet.Accent
		progress.BorderSizePixel = 0
		progress.Parent = notification
		tween:Tween(notification, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
			AnchorPoint = Vector2.new(1, 0)
		}, tween.tweenstwo)
		tween:Tween(progress, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
			Size = UDim2.fromOffset(0, 2)
		})
		task.delay(duration, function()
			tween:Tween(notification, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
				AnchorPoint = Vector2.new(0, 0)
			}, tween.tweenstwo)
			task.wait(0.2)
			notification:ClearAllChildren()
			notification:Destroy()
		end)
	end)
end

function mainapi:Load(skipgui, profile)
	pcall(function()
		if (inputService.TouchEnabled or shared.FORCE_CREATE_MOBILE_VAPE_BUTTON) and not self.VapeButton then
			local button = Instance.new('TextButton')
			button.Size = UDim2.fromOffset(32, 32)
			button.Position = UDim2.new(1, -90, 0, 4)
			button.BackgroundColor3 = Color3.new()
			button.BackgroundTransparency = 0.5
			button.Text = ''
			button.Parent = gui
			local image = Instance.new('ImageLabel')
			image.Size = UDim2.fromOffset(26, 26)
			image.Position = UDim2.fromOffset(3, 3)
			image.BackgroundTransparency = 1
			image.Image = getcustomasset('vape/assets/vape.png')
			image.Parent = button
			local buttoncorner = Instance.new('UICorner')
			buttoncorner.Parent = button
			self.VapeButton = button
			button.MouseButton1Click:Connect(function()
				if self.ThreadFix then
					setthreadidentity(8)
				end
				for _, v in self.Windows do
					v.Visible = false
				end
				for _, mobileButton in self.Modules do
					if mobileButton.Bind.Button then
						mobileButton.Bind.Button.Visible = clickgui.Visible
					end
				end
				clickgui.Visible = not clickgui.Visible
				tooltip.Visible = false
				self:BlurCheck()
			end)
			if shared.CREATE_ICON_EDITOR then
				pcall(shared.CREATE_ICON_EDITOR, button)
			end
		end
	end)
	--[[local bedwarsID = {
		game = {6872274481, 8444591321, 8560631822},
		lobby = {6872265039}
	}
	local isGame = table.find(bedwarsID.game, game.PlaceId)
	local isLobby = table.find(bedwarsID.lobby, game.PlaceId)
	if isGame or isLobby then
		repeat task.wait() until game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character
	end--]]
	if not skipgui then
		self.GUIColor:SetValue(nil, nil, nil, 4)
	end
	local guidata = {}
	local savecheck = true

	if isfile('vape/profiles/'..game.GameId..'.gui.txt') then
		guidata, err = loadJson('vape/profiles/'..game.GameId..'.gui.txt')
		if not guidata then
			guidata = {Categories = {}}
			self:CreateNotification('Silentware', 'Failed to load GUI settings. '..tostring(err), 10, 'alert')
			pcall(function()
				delfile('vape/profiles/'..game.GameId..'.gui.txt')
			end)
			savecheck = false
		end

		if not skipgui then
			self.Keybind = (type(guidata.Keybind) == 'table' and #guidata.Keybind > 0) and guidata.Keybind or {'RightShift'}
			for i, v in guidata.Categories do
				local object = self.Categories[i]
				if not object then continue end
				if object.Options and v.Options then
					self:LoadOptions(object, v.Options)
					task.wait(shared.LoadSlowmode or 0.03)
				end
				if v.Enabled then
					task.spawn(function()
						object.Button:Toggle()
					end)
				end
				if v.Pinned then
					object:Pin()
				end
				if v.Expanded and object.Expand then
					object:Expand()
				end
				if v.List and (#object.List > 0 or #v.List > 0) then
					object.List = v.List or {}
					object.ListEnabled = v.ListEnabled or {}
					object:ChangeValue()
				end
				if v.Position then
					if object.Type == 'Category' and object.Object and object.Object.Parent == mainapi.PremiumContent then
						object.Object.Position = UDim2.fromOffset(10, 10)
					else
						object.Object.Position = UDim2.fromOffset(v.Position.X, v.Position.Y)
					end
				end
			end
		end
	end

	self.Profile = profile or guidata.Profile or 'default'
	self.Profiles = guidata.Profiles or {{
		Name = 'default', Bind = {}
	}}
	self.Categories.Profiles:ChangeValue()
	if self.ProfileLabel then
		self.ProfileLabel.Text = #self.Profile > 10 and self.Profile:sub(1, 10)..'...' or self.Profile
		self.ProfileLabel.Size = UDim2.fromOffset(getfontsize(self.ProfileLabel.Text, self.ProfileLabel.TextSize, self.ProfileLabel.Font).X + 16, 24)
	end

	if isfile('vape/profiles/'..self.Profile..self.Place..'.txt') then
		local savedata = loadJson('vape/profiles/'..self.Profile..self.Place..'.txt')
		if not savedata then
			savedata = {Categories = {}, Modules = {}, Legit = {}}
			self:CreateNotification('Silentware', 'Failed to load '..self.Profile..' profile.', 10, 'alert')
			savecheck = false
		end

		for i, v in savedata.Categories do
			local object = self.Categories[i]
			if not object then continue end
			if object.Options and v.Options then
				task.spawn(function()
					self:LoadOptions(object, v.Options)
				end)
			end
			if v.Pinned ~= object.Pinned then
				object:Pin()
			end
			if v.Expanded ~= nil and v.Expanded ~= object.Expanded then
				object:Expand()
			end
			if object.Button and (v.Enabled or false) ~= object.Button.Enabled then
				task.spawn(function()
					object.Button:Toggle()
				end)
			end
			if v.List and (#object.List > 0 or #v.List > 0) then
				object.List = v.List or {}
				object.ListEnabled = v.ListEnabled or {}
				object:ChangeValue()
			end
			if object.Type == 'Category' and object.Object and object.Object.Parent == mainapi.PremiumContent then
				object.Object.Position = UDim2.fromOffset(10, 10)
			else
				object.Object.Position = UDim2.fromOffset(v.Position.X, v.Position.Y)
			end
		end

		for i, v in savedata.Modules do
			local object = self.Modules[i] or (self.LegacyModuleNames[i] and self.Modules[self.LegacyModuleNames[i]])
			if not object then continue end
			if object.Options and v.Options then
				task.spawn(function()
					local suc, err = pcall(function()
						self:LoadOptions(object, v.Options)
					end)
					if (not suc) then
						task.spawn(function()
							repeat task.wait() until errorNotification ~= nil and type(errorNotification) == "function" 
							pcall(function()
								errorNotification("Silentware", "Failure loading "..tostring(v).." Error: "..tostring(err), 5)
							end)
						end)
					end
				end)
			end
			if v.Enabled ~= object.Enabled then
				if skipgui then
					if self.ToggleNotifications.Enabled then self:CreateNotification('Module Toggled', i.."<font color='#FFFFFF'> has been </font>"..(v.Enabled and "<font color='#5AFF5A'>Enabled</font>" or "<font color='#FF5A5A'>Disabled</font>").."<font color='#FFFFFF'>!</font>", 0.75) end
				end
				object:Toggle(true)
			end
			object:SetBind(v.Bind)
			object.Object.Bind.Visible = #v.Bind > 0
		end

		for i, v in savedata.Legit do
			local object = self.Legit.Modules[i]
			if not object then continue end
			if object.Options and v.Options then
				task.spawn(function()
					self:LoadOptions(object, v.Options)
				end)
			end
			if object.Enabled ~= v.Enabled then
				object:Toggle()
			end
			if v.Position and object.Children then
				object.Children.Position = UDim2.fromOffset(v.Position.X, v.Position.Y)
			end
		end

		self:UpdateTextGUI(true)
	else
		self:Save()
	end

	if self.Downloader then
		self.Downloader:Destroy()
		self.Downloader = nil
	end
	self.Loaded = savecheck
	self.Categories.Main.Options.Bind:SetBind(self.Keybind)
end

function mainapi:LoadOptions(object, savedoptions)
	for i, v in savedoptions do
		local option = object.Options[i]
		if not option then continue end
		option:Load(v)
	end
end

function mainapi:Remove(obj)
	local tab = (self.Modules[obj] and self.Modules or self.Legit.Modules[obj] and self.Legit.Modules or self.Categories)
	if tab and tab[obj] then
		local newobj = tab[obj]
		for _, v in {'Object', 'Children', 'Toggle', 'Button'} do
			local childobj = typeof(newobj[v]) == 'table' and newobj[v].Object or newobj[v]
			if typeof(childobj) == 'Instance' then
				childobj:Destroy()
				childobj:ClearAllChildren()
			end
		end
		loopClean(newobj)
		tab[obj] = nil
	end
end

local function notifyError(err)
	if errorNotification ~= nil and type(errorNotification) == "function" then
		pcall(function()
			errorNotification("Silentware", tostring(err), 5)
		end)
	end
end

local function saveSavingError(data)
	local errorLog = data
	local S_Name = "SAVING"
	local main = {}
	if isfile('SW_Error_Log.json') then
		local res = loadJson('SW_Error_Log.json')
		main = res or main
	end
	local function toTime(timestamp)
		timestamp = timestamp or os.time()
		local dateTable = os.date("*t", timestamp)
		local timeString = string.format("%02d:%02d:%02d", dateTable.hour, dateTable.min, dateTable.sec)
		return timeString
	end
	local function toDate(timestamp)
		timestamp = timestamp or os.time()
		local dateTable = os.date("*t", timestamp)
		local dateString = string.format("%02d/%02d/%02d", dateTable.day, dateTable.month, dateTable.year % 100)
		return dateString
	end
	local function getExecutionTime()
		return {["toTime"] = toTime(), ["toDate"] = toDate()}
	end
	local dateKey = toDate()
	local placeJobKey = tostring(game.PlaceId) .. " | " .. tostring(game.JobId)
	main[dateKey] = main[dateKey] or {}
	main[dateKey][placeJobKey] = main[dateKey][placeJobKey] or {}
	main[dateKey][placeJobKey][S_Name] = main[dateKey][placeJobKey][S_Name] or {}
	table.insert(main[dateKey][placeJobKey][S_Name], {
		Time = getExecutionTime(),
		Data = errorLog
	})
	local success, jsonResult = pcall(function()
		return httpService:JSONEncode(main)
	end)
	if success then
		writefile('SW_Error_Log.json', jsonResult)
	else
		warn("Failed to encode JSON: " .. jsonResult)
	end
end

function mainapi:Save(newprofile)
	if not self.Loaded then
		return
	end
	local guidata = {
		Categories = {},
		Profile = newprofile or self.Profile,
		Profiles = self.Profiles,
		Keybind = self.Keybind,
	}
	local savedata = {
		Modules = {},
		Categories = {},
		Legit = {},
	}

	for i, v in self.Categories do
		(v.Type ~= "Category" and i ~= "Main" and savedata or guidata).Categories[i] = {
			Enabled = i ~= "Main" and v.Button.Enabled or nil,
			Expanded = v.Type ~= "Overlay" and v.Expanded or nil,
			Pinned = v.Pinned,
			Position = { X = v.Object.Position.X.Offset, Y = v.Object.Position.Y.Offset },
			Options = mainapi:SaveOptions(v, v.Options),
			List = v.List,
			ListEnabled = v.ListEnabled,
		}
	end

	for i, v in self.Modules do
		savedata.Modules[i] = {
			Enabled = v.Enabled,
			Bind = v.Bind.Button
					and { Mobile = true, X = v.Bind.Button.Position.X.Offset, Y = v.Bind.Button.Position.Y.Offset }
				or v.Bind,
			Options = mainapi:SaveOptions(v, true),
		}
	end

	for i, v in self.Legit.Modules do
		savedata.Legit[i] = {
			Enabled = v.Enabled,
			Position = v.Children and { X = v.Children.Position.X.Offset, Y = v.Children.Position.Y.Offset } or nil,
			Options = mainapi:SaveOptions(v, v.Options),
		}
	end

	writefile("vape/profiles/" .. game.GameId .. ".gui.txt", httpService:JSONEncode(guidata))
	writefile("vape/profiles/" .. self.Profile .. self.Place .. ".txt", httpService:JSONEncode(savedata))
end

function mainapi:SaveOptions(object, savedoptions)
	if not savedoptions then
		return
	end
	savedoptions = {}
	for _, v in object.Options do
		if not v.Save then
			continue
		end
		v:Save(savedoptions)
	end
	return savedoptions
end

mainapi.SelfDestructEvent = Instance.new("BindableEvent")
function mainapi:Uninject()
	mainapi.SelfDestructEvent:Fire()
	mainapi:Save()
	mainapi.Loaded = nil
	for _, v in self.Modules do
		if v.Enabled then
			v:Toggle()
		end
	end
	for _, v in self.Legit.Modules do
		if v.Enabled then
			v:Toggle()
		end
	end
	for _, v in self.Categories do
		if v.Type == 'Overlay' and v.Button.Enabled then
			v.Button:Toggle()
		end
	end
	for _, v in mainapi.Connections do
		pcall(function()
			v:Disconnect()
		end)
	end
	if mainapi.ThreadFix then
		setthreadidentity(8)
		clickgui.Visible = false
		mainapi:BlurCheck()
	end
	pcall(function() if interfaceBlur then interfaceBlur.Enabled = false interfaceBlur.Size = 0 end end)
	mainapi.gui:ClearAllChildren()
	mainapi.gui:Destroy()
	table.clear(mainapi.Libraries)
	loopClean(mainapi)
	shared.vape = nil
	shared.vapereload = nil
	shared.VapeIndependent = nil
end

gui = Instance.new('ScreenGui')
gui.Name = randomString()
gui.DisplayOrder = 9999999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.IgnoreGuiInset = true
pcall(function() gui.OnTopOfCoreBlur = true end)
if mainapi.ThreadFix then
	gui.Parent = cloneref(game:GetService('CoreGui'))--(gethui and gethui()) or cloneref(game:GetService('CoreGui'))
else
	gui.Parent = cloneref(game:GetService('Players')).LocalPlayer.PlayerGui
	gui.ResetOnSpawn = false
end
mainapi.gui = gui
scaledgui = Instance.new('Frame')
scaledgui.Name = 'ScaledGui'
scaledgui.Size = UDim2.fromScale(1, 1)
scaledgui.BackgroundTransparency = 1
scaledgui.Parent = gui

--clickgui = isMobile and Instance.new('ScrollingFrame') or Instance.new("Frame")
clickgui = Instance.new("Frame")
clickgui.Name = 'ClickGui'
clickgui.Size = UDim2.fromScale(1, 1)
--[[if isMobile then
	clickgui.CanvasSize = isMobile and UDim2.new(2, 0, 2, 0) or UDim2.new(1, 0, 1, 0)
	clickgui.AutomaticCanvasSize = Enum.AutomaticSize.Y
	clickgui.ScrollBarThickness = 0
	clickgui.ScrollBarImageTransparency = 1
	clickgui.Interactable = clickgui.Visible
	clickgui:GetPropertyChangedSignal("Visible"):Connect(function()
		clickgui.Interactable = clickgui.Visible
	end)
	clickgui.BorderSizePixel = 0
end--]]
clickgui.BackgroundTransparency = 1
clickgui.Visible = false
clickgui.Parent = scaledgui

--[[if isMobile then
	local scrollingFrame = clickgui
	local debounceTime = 0.2
	local lastPosition = scrollingFrame.CanvasPosition
	local lastChange = tick()
	local scrolling = false
	
	local running_tweens = {}
	
	task.spawn(function()
		local TweenService = game:GetService("TweenService")
		local createTween = function(instance, properties, duration, easingStyle, easingDirection, repeatCount, reverses, delayTime)
			local tweenInfo = TweenInfo.new(
				duration or 0.3,
				easingStyle or Enum.EasingStyle.Sine,
				easingDirection or Enum.EasingDirection.InOut,
				repeatCount or 0,
				reverses or false,
				delayTime or 0
			)
		
			local tween = TweenService:Create(instance, tweenInfo, properties)
			return tween
		end
		local con
		con = game:GetService("RunService").Heartbeat:Connect(function()
			local currentPosition = scrollingFrame.CanvasPosition
			if currentPosition ~= lastPosition then
				lastPosition = currentPosition
				lastChange = tick()
		
				if not scrolling then
					scrolling = true
					if running_tweens[scrollingFrame] then
						pcall(function()
							running_tweens[scrollingFrame]:Cancel()
						end)
					end
					local tween = createTween(scrollingFrame, {
						ScrollBarImageTransparency = 0,
						ScrollBarThickness = 10
					})
					running_tweens[scrollingFrame] = tween
					tween:Play()
				end
			elseif scrolling and tick() - lastChange >= debounceTime then
				scrolling = false
				if running_tweens[scrollingFrame] then
					pcall(function()
						running_tweens[scrollingFrame]:Cancel()
					end)
				end
				local tween = createTween(scrollingFrame, {
					ScrollBarImageTransparency = 1,
					ScrollBarThickness = 0
				})
				running_tweens[scrollingFrame] = tween
				tween:Play()
			end
		end)
		mainapi.SelfDestructEvent.Event:Connect(function()
			pcall(function() con:Disconnect() end)
		end)
	end)
end--]]

local modal = Instance.new('TextButton')
modal.BackgroundTransparency = 1
modal.Modal = true
modal.Text = ''
modal.Parent = clickgui
local cursor = Instance.new('ImageLabel')
cursor.Size = UDim2.fromOffset(64, 64)
cursor.BackgroundTransparency = 1
cursor.Visible = false
cursor.Image = 'rbxasset://textures/Cursors/KeyboardMouse/ArrowFarCursor.png'
cursor.Parent = gui
notifications = Instance.new('Folder')
notifications.Name = 'Notifications'
notifications.Parent = scaledgui
tooltip = Instance.new('TextLabel')
tooltip.Name = 'Tooltip'
tooltip.Position = UDim2.fromScale(-1, -1)
tooltip.ZIndex = 5
tooltip.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
tooltip.Visible = false
tooltip.Text = ''
tooltip.TextColor3 = color.Dark(uipallet.Text, 0.16)
tooltip.TextSize = 12
tooltip.FontFace = uipallet.Font
tooltip.Parent = scaledgui
toolblur = addBlur(tooltip)
addCorner(tooltip)
local toolstrokebkg = Instance.new('Frame')
toolstrokebkg.Size = UDim2.new(1, -2, 1, -2)
toolstrokebkg.Position = UDim2.fromOffset(1, 1)
toolstrokebkg.ZIndex = 6
toolstrokebkg.BackgroundTransparency = 1
toolstrokebkg.Parent = tooltip
local toolstroke = Instance.new('UIStroke')
toolstroke.Color = color.Light(uipallet.Main, 0.02)
toolstroke.Parent = toolstrokebkg
addCorner(toolstrokebkg, UDim.new(0, 4))

--local GuiService = game:GetService("GuiService")
--local screenResolution = GuiService:GetScreenResolution()

scale = Instance.new('UIScale')
scale.Scale = math.max(gui.AbsoluteSize.X / 1920, isMobile and 0.5 or 0.68)
scale.Parent = scaledgui
mainapi.guiscale = scale
scaledgui.Size = UDim2.fromScale(1 / scale.Scale, 1 / scale.Scale)

mainapi:Clean(gui:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
	if mainapi.Scale.Enabled then
		scale.Scale = math.max(gui.AbsoluteSize.X / 1920, 0.68)
	end
end))

mainapi:Clean(scale:GetPropertyChangedSignal('Scale'):Connect(function()
	scaledgui.Size = UDim2.fromScale(1 / scale.Scale, 1 / scale.Scale)
	for _, v in scaledgui:GetDescendants() do
		if v:IsA('GuiObject') and v.Visible then
			v.Visible = false
			v.Visible = true
		end
	end
end))

mainapi:Clean(clickgui:GetPropertyChangedSignal('Visible'):Connect(function()
	mainapi:UpdateGUI(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value, true)
	if clickgui.Visible then
		animatePremiumOpen()
	end
	if clickgui.Visible and inputService.MouseEnabled then
		repeat
			local visibleCheck = clickgui.Visible
			for _, v in mainapi.Windows do
				visibleCheck = visibleCheck or v.Visible
			end
			if not visibleCheck then break end

			cursor.Visible = not inputService.MouseIconEnabled
			if cursor.Visible then
				local mouseLocation = inputService:GetMouseLocation()
				cursor.Position = UDim2.fromOffset(mouseLocation.X - 31, mouseLocation.Y - 32)
			end

			task.wait()
		until mainapi.Loaded == nil
		cursor.Visible = false
	end
end))

mainapi:CreateGUI()
mainapi.Categories.Main:CreateDivider()
mainapi:CreateCategory({
	Name = 'Combat',
	Icon = getcustomasset('vape/assets/combaticon.png'),
	Size = UDim2.fromOffset(13, 14)
})
mainapi:CreateCategory({
	Name = 'Blatant',
	Icon = getcustomasset('vape/assets/blatanticon.png'),
	Size = UDim2.fromOffset(14, 14)
})
mainapi:CreateCategory({
	Name = 'Render',
	Icon = getcustomasset('vape/assets/rendericon.png'),
	Size = UDim2.fromOffset(15, 14)
})
mainapi:CreateCategory({
	Name = 'Utility',
	Icon = getcustomasset('vape/assets/utilityicon.png'),
	Size = UDim2.fromOffset(15, 14)
})
mainapi:CreateCategory({
	Name = 'World',
	Icon = getcustomasset('vape/assets/worldicon.png'),
	Size = UDim2.fromOffset(14, 14)
})
mainapi:CreateCategory({
	Name = 'Misc',
	Icon = getcustomasset('vape/assets/worldicon.png'),
	Size = UDim2.fromOffset(14, 14)
})
mainapi:CreateCategory({
	Name = 'Inventory',
	Icon = getcustomasset('vape/assets/inventoryicon.png'),
	Size = UDim2.fromOffset(15, 14)
})
mainapi:CreateCategory({
	Name = 'Minigames',
	Icon = getcustomasset('vape/assets/miniicon.png'),
	Size = UDim2.fromOffset(19, 12)
})
mainapi.Categories.Main:CreateDivider('misc')

--[[
	Friends
]]
local friends
local friendscolor = {
	Hue = 1,
	Sat = 1,
	Value = 1
}
local friendssettings = {
	Name = 'Friends',
	Icon = getcustomasset('vape/assets/friendstab.png'),
	Size = UDim2.fromOffset(17, 16),
	Placeholder = 'Roblox username',
	Color = Color3.fromRGB(5, 134, 105),
	Function = function()
		friends.Update:Fire()
		friends.ColorUpdate:Fire(friendscolor.Hue, friendscolor.Sat, friendscolor.Value)
	end
}
friends = mainapi:CreateCategoryList(friendssettings)
friends.Update = Instance.new('BindableEvent')
friends.ColorUpdate = Instance.new('BindableEvent')
friends:CreateToggle({
	Name = 'Recolor visuals',
	Darker = true,
	Default = true,
	Function = function()
		friends.Update:Fire()
		friends.ColorUpdate:Fire(friendscolor.Hue, friendscolor.Sat, friendscolor.Value)
	end
})
friendscolor = friends:CreateColorSlider({
	Name = 'Friends color',
	Darker = true,
	Function = function(hue, sat, val)
		for _, v in friends.Object.Children:GetChildren() do
			local dot = v:FindFirstChild('Dot')
			if dot and dot.BackgroundColor3 ~= color.Light(uipallet.Main, 0.37) then
				dot.BackgroundColor3 = Color3.fromHSV(hue, sat, val)
				dot.Dot.BackgroundColor3 = dot.BackgroundColor3
			end
		end
		friendssettings.Color = Color3.fromHSV(hue, sat, val)
		friends.ColorUpdate:Fire(hue, sat, val)
	end
})
friends:CreateToggle({
	Name = 'Use friends',
	Darker = true,
	Default = true,
	Function = function()
		friends.Update:Fire()
		friends.ColorUpdate:Fire(friendscolor.Hue, friendscolor.Sat, friendscolor.Value)
	end
})
mainapi:Clean(friends.Update)
mainapi:Clean(friends.ColorUpdate)

--[[
	Profiles
]]
mainapi:CreateCategoryList({
	Name = 'Profiles',
	Icon = getcustomasset('vape/assets/profilesicon.png'),
	Size = UDim2.fromOffset(17, 10),
	Position = UDim2.fromOffset(12, 16),
	Placeholder = 'Type name',
	Profiles = true
})

--[[
	Targets
]]
local targets
targets = mainapi:CreateCategoryList({
	Name = 'Targets',
	Icon = getcustomasset('vape/assets/friendstab.png'),
	Size = UDim2.fromOffset(17, 16),
	Placeholder = 'Roblox username',
	Function = function()
		targets.Update:Fire()
	end
})
targets.Update = Instance.new('BindableEvent')
mainapi:Clean(targets.Update)

mainapi:CreateLegit()
mainapi:CreateSearch()
mainapi.Categories.Main:CreateOverlayBar()
mainapi.Categories.Main:CreateSettingsDivider()

--[[
	General Settings
]]

local general = mainapi.Categories.Main:CreateSettingsPane({Name = 'General'})
mainapi.MultiKeybind = general:CreateToggle({
	Name = 'Enable Multi-Keybinding',
	Tooltip = 'Allows multiple keys to be bound to a module (eg. G + H)'
})
general:CreateButton({
	Name = 'Reset current profile',
	Function = function()
	mainapi.Save = function() end
		if isfile('vape/profiles/'..mainapi.Profile..mainapi.Place..'.txt') and delfile then
			delfile('vape/profiles/'..mainapi.Profile..mainapi.Place..'.txt')
		end
		shared.vapereload = true
		pload('NewMainScript.lua', true)
	end,
	Tooltip = 'This will set your profile to the default Silentware settings'
})
general:CreateButton({
	Name = 'Self destruct',
	Function = function()
		mainapi:Uninject()
	end,
	Tooltip = 'Removes Silentware from the current game'
})
general:CreateButton({
	Name = 'Reinject',
	Function = function()
		shared.vapereload = true
		pload('NewMainScript.lua', true)
	end,
	Tooltip = 'Reloads Silentware for debugging purposes'
})

--[[
	Module Settings
]]

local modules = mainapi.Categories.Main:CreateSettingsPane({Name = 'Modules'})
modules:CreateToggle({
	Name = 'Teams by server',
	Tooltip = 'Ignore players on your team designated by the server',
	Default = true,
	Function = function()
		if mainapi.Libraries.entity and mainapi.Libraries.entity.Running then
			mainapi.Libraries.entity.refresh()
		end
	end
})
modules:CreateToggle({
	Name = 'Use team color',
	Tooltip = 'Uses the TeamColor property on players for render modules',
	Default = true,
	Function = function()
		if mainapi.Libraries.entity and mainapi.Libraries.entity.Running then
			mainapi.Libraries.entity.refresh()
		end
	end
})

--[[
	Theme Settings
]]


local function createThemePreviewCard(parent, themeName, preset, layoutOrder)
	if not parent or not parent.Children then return end
	local card = Instance.new('TextButton')
	card.Name = themeName..'ThemeCard'
	card.Size = UDim2.new(1, 0, 0, 72)
	card.BackgroundTransparency = 1
	card.AutoButtonColor = false
	card.Text = ''
	card.LayoutOrder = layoutOrder or 0
	card.Parent = parent.Children
	addTooltip(card, tostring(preset and preset.Description or 'Premium Silentware theme'))
	local shell = Instance.new('Frame')
	shell.Name = 'CardSurface'
	shell.Size = UDim2.new(1, -20, 1, -8)
	shell.Position = UDim2.fromOffset(10, 4)
	shell.BackgroundColor3 = preset.SurfaceAlt or uipallet.SurfaceAlt
	shell.BackgroundTransparency = 0.04
	shell.BorderSizePixel = 0
	shell.Parent = card
	addCorner(shell, UDim.new(0, 12))
	addStroke(shell, preset.Border or uipallet.Border, 1, 0.34)
	local swatch = Instance.new('Frame')
	swatch.Name = 'AccentSwatch'
	swatch.Size = UDim2.fromOffset(7, 46)
	swatch.Position = UDim2.fromOffset(11, 9)
	swatch.BackgroundColor3 = preset.Accent or uipallet.Accent
	swatch.BorderSizePixel = 0
	swatch.Parent = shell
	addCorner(swatch, UDim.new(1, 0))
	local swatchGlow = addGlow(swatch, 'SwatchGlow', 0.46, 48)
	swatchGlow.ImageColor3 = preset.AccentGlow or preset.Accent or uipallet.Accent
	local title = Instance.new('TextLabel')
	title.Name = 'Title'
	title.Size = UDim2.new(1, -100, 0, 20)
	title.Position = UDim2.fromOffset(28, 11)
	title.BackgroundTransparency = 1
	title.Text = themeName
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.TextColor3 = preset.Text or uipallet.Text
	title.TextSize = 14
	title.FontFace = uipallet.FontSemiBold
	title.Parent = shell
	local desc = Instance.new('TextLabel')
	desc.Name = 'Description'
	desc.Size = UDim2.new(1, -110, 0, 28)
	desc.Position = UDim2.fromOffset(28, 31)
	desc.BackgroundTransparency = 1
	desc.Text = tostring(preset.Description or '')
	desc.TextXAlignment = Enum.TextXAlignment.Left
	desc.TextYAlignment = Enum.TextYAlignment.Top
	desc.TextWrapped = true
	desc.TextColor3 = preset.MutedText or uipallet.MutedText
	desc.TextSize = 10
	desc.FontFace = uipallet.Font
	desc.Parent = shell
	local miniA = Instance.new('Frame')
	miniA.Name = 'MiniSurface'
	miniA.Size = UDim2.fromOffset(42, 18)
	miniA.Position = UDim2.new(1, -57, 0, 13)
	miniA.BackgroundColor3 = preset.SurfaceHigh or uipallet.SurfaceHigh
	miniA.BorderSizePixel = 0
	miniA.Parent = shell
	addCorner(miniA, UDim.new(0, 6))
	local miniB = Instance.new('Frame')
	miniB.Name = 'MiniAccent'
	miniB.Size = UDim2.fromOffset(42, 6)
	miniB.Position = UDim2.new(1, -57, 0, 39)
	miniB.BackgroundColor3 = preset.Accent or uipallet.Accent
	miniB.BorderSizePixel = 0
	miniB.Parent = shell
	addCorner(miniB, UDim.new(1, 0))
	table.insert(mainapi.ThemePreviewCards, {Card = card, Surface = shell, Swatch = swatch, Glow = swatchGlow, Title = title, Description = desc, MiniA = miniA, MiniB = miniB, PresetName = themeName})
	card.MouseEnter:Connect(function()
		tween:Tween(shell, uipallet.Tween, {BackgroundTransparency = 0})
		tween:Tween(swatchGlow, uipallet.Tween, {ImageTransparency = 0.2})
	end)
	card.MouseLeave:Connect(function()
		tween:Tween(shell, uipallet.Tween, {BackgroundTransparency = 0.04})
		tween:Tween(swatchGlow, uipallet.Tween, {ImageTransparency = 0.46})
	end)
	card.MouseButton1Click:Connect(function()
		mainapi:ApplyThemePreset(themeName)
	end)
	return card
end
local themepane = mainapi.Categories.Main:CreateSettingsPane({Name = 'Theme Settings'})
themepane:CreateDropdown({
	Name = 'Theme preset',
	List = themePresetNames,
	Function = function(val)
		mainapi:ApplyThemePreset(val)
	end,
	Tooltip = 'Choose a premade premium Silentware theme.'
})
for index, themeName in themePresetNames do
	createThemePreviewCard(themepane, themeName, getThemePreset(themeName, false), 20 + index)
end

--[[
	Access / Admin Settings
]]

local accesspane = mainapi.Categories.Main:CreateSettingsPane({Name = 'Access'})
local tierText
local function getAccessDisplay(currentAccess)
	currentAccess = currentAccess or shared.SilentwareAccess or access
	return tostring((currentAccess.DisplayNames and currentAccess.DisplayNames[currentAccess.Tier]) or currentAccess.Tier or 'Free')
end
local function updateAccessVisuals(currentAccess)
	currentAccess = currentAccess or shared.SilentwareAccess or access
	if mainapi.AccessTierPill then
		mainapi.AccessTierPill.Text = getAccessDisplay(currentAccess)
	end
	if tierText and tierText.Object then
		local label = tierText.Object:FindFirstChildWhichIsA('Frame') and tierText.Object:FindFirstChildWhichIsA('Frame'):FindFirstChildWhichIsA('TextLabel')
		if label then label.Text = 'Current tier: '..getAccessDisplay(currentAccess) end
	end
	mainapi:RefreshAccessLocks()
	repaintEveryControl()
end
tierText = accesspane:CreateButton({
	Name = 'Current tier: '..getAccessDisplay(access),
	Function = function()
		mainapi:CreateNotification('Access tier', 'Current tier: '..tostring((shared.SilentwareAccess and shared.SilentwareAccess.Tier) or 'free'), 4)
	end,
	Tooltip = 'Shows your active Silentware access tier.'
})
local storedKey = nil
pcall(function()
	local currentAccess = shared.SilentwareAccess or access
	if type(currentAccess) == 'table' and type(currentAccess.GetStoredKey) == 'function' then
		storedKey = currentAccess:GetStoredKey()
	end
end)
local keybox = accesspane:CreateTextBox({
	Name = 'Access key',
	Default = storedKey or '',
	Placeholder = 'Paste whitelist or admin key',
	Tooltip = 'Whitelist keys are stored locally and checked automatically on startup. Admin keys only unlock admin tools.'
})
local adminControls = {}
local function setAdminToolsVisible(state)
	for _, control in adminControls do
		if control and control.Object then
			control.Object.Visible = state == true
		elseif typeof(control) == 'Instance' and control:IsA('GuiObject') then
			control.Visible = state == true
		end
	end
	if state then repaintEveryControl() end
end
local targetkey = accesspane:CreateTextBox({
	Name = 'Target key/user',
	Placeholder = 'Key or Roblox user id',
	Tooltip = 'Key or user id to grant/revoke from the backend.'
})
table.insert(adminControls, targetkey)
local targettier = accesspane:CreateDropdown({
	Name = 'Target tier',
	List = {'free', 'standard', 'premium', 'beta'},
	Tooltip = 'Tier to grant through the admin backend.'
})
table.insert(adminControls, targettier)
local adminnote = accesspane:CreateTextBox({
	Name = 'Admin note',
	Placeholder = 'Optional note / reason',
	Tooltip = 'Sent to the admin endpoint with grant/revoke requests.'
})
table.insert(adminControls, adminnote)
local grantButton = accesspane:CreateButton({
	Name = 'Grant whitelist',
	Function = function()
		local currentAccess = shared.SilentwareAccess or access
		local ok, msg = false, 'Access library unavailable.'
		if type(currentAccess) == 'table' and type(currentAccess.GrantKey) == 'function' then
			ok, msg = currentAccess:GrantKey(targetkey.Value, targettier.Value, adminnote.Value)
		end
		mainapi:CreateNotification(ok and 'Whitelist granted' or 'Grant failed', tostring(msg), 7, ok and 'info' or 'alert')
	end,
	Tooltip = 'Sends a grant request to your admin backend.'
})
table.insert(adminControls, grantButton)
local revokeButton = accesspane:CreateButton({
	Name = 'Revoke whitelist',
	Function = function()
		local currentAccess = shared.SilentwareAccess or access
		local ok, msg = false, 'Access library unavailable.'
		if type(currentAccess) == 'table' and type(currentAccess.RevokeKey) == 'function' then
			ok, msg = currentAccess:RevokeKey(targetkey.Value, adminnote.Value)
		end
		mainapi:CreateNotification(ok and 'Whitelist revoked' or 'Revoke failed', tostring(msg), 7, ok and 'info' or 'alert')
	end,
	Tooltip = 'Sends a revoke request to your admin backend.'
})
table.insert(adminControls, revokeButton)
local setUserButton = accesspane:CreateButton({
	Name = 'Set user tier',
	Function = function()
		local currentAccess = shared.SilentwareAccess or access
		local ok, msg = false, 'Access library unavailable.'
		if type(currentAccess) == 'table' and type(currentAccess.SetUserTier) == 'function' then
			ok, msg = currentAccess:SetUserTier(targetkey.Value, targettier.Value, adminnote.Value)
		end
		mainapi:CreateNotification(ok and 'User tier updated' or 'User tier failed', tostring(msg), 7, ok and 'info' or 'alert')
	end,
	Tooltip = 'Sends a Roblox user-id tier update to your admin backend.'
})
table.insert(adminControls, setUserButton)
local webhookButton = accesspane:CreateButton({
	Name = 'Send test webhook',
	Function = function()
		local currentAccess = shared.SilentwareAccess or access
		local ok, msg = false, 'No webhook configured.'
		if type(currentAccess) == 'table' and type(currentAccess.SendExecutionWebhook) == 'function' then
			ok, msg = currentAccess:SendExecutionWebhook('manual_test')
		end
		mainapi:CreateNotification(ok and 'Webhook sent' or 'Webhook failed', tostring(msg), 6, ok and 'info' or 'warning')
	end,
	Tooltip = 'Sends a Discord webhook test if configured. Keep the URL server-side when possible.'
})
table.insert(adminControls, webhookButton)
setAdminToolsVisible((shared.SilentwareAccess or access).AdminAuthed == true)
accesspane:CreateButton({
	Name = 'Check access key',
	Function = function()
		local safe, safeErr = pcall(function()
			local currentAccess = shared.SilentwareAccess or access
			local entered = tostring(keybox.Value or ''):gsub('^%s+', ''):gsub('%s+$', '')
			if entered == '' then
				mainapi:CreateNotification('Access failed', 'Enter a whitelist or admin key.', 5, 'warning')
				return
			end

			if type(currentAccess) == 'table' and type(currentAccess.AdminLogin) == 'function' then
				local adminOk = false
				local okAdmin = pcall(function()
					local result = currentAccess:AdminLogin(entered)
					adminOk = result == true
				end)
				if okAdmin and adminOk then
					setAdminToolsVisible(true)
					mainapi:CreateNotification('Admin unlocked', 'Admin tools enabled.', 5, 'info')
					repaintEveryControl()
					return
				end
			end

			if type(currentAccess) == 'table' and type(currentAccess.CheckKey) == 'function' then
				local ok, result = pcall(function()
					return currentAccess:CheckKey(entered)
				end)
				if ok then
					mainapi.Access = currentAccess
					setAdminToolsVisible(false)
					updateAccessVisuals(currentAccess)
					mainapi:CreateNotification('Access updated', 'Tier: '..getAccessDisplay(currentAccess), 5)
					repaintEveryControl()
				else
					mainapi:CreateNotification('Access failed', tostring(result), 6, 'alert')
				end
			else
				mainapi:CreateNotification('Access unavailable', 'The access library did not load.', 6, 'alert')
			end
		end)
		if not safe then
			mainapi:CreateNotification('Access failed', tostring(safeErr), 6, 'alert')
		end
	end,
	Tooltip = 'Checks a whitelist key or unlocks admin tools when an admin key is entered.'
})
task.defer(function()
	local currentAccess = shared.SilentwareAccess or access
	if type(currentAccess) == 'table' and type(currentAccess.RefreshAccess) == 'function' and type(currentAccess.GetStoredKey) == 'function' then
		local stored = currentAccess:GetStoredKey()
		if stored and stored ~= '' then
			pcall(function() currentAccess:RefreshAccess(stored) end)
			if keybox and keybox.SetValue then pcall(function() keybox:SetValue(stored) end) end
			updateAccessVisuals(currentAccess)
		end
	end
end)

--[[
	GUI Settings
]]

local guipane = mainapi.Categories.Main:CreateSettingsPane({Name = 'GUI'})
mainapi.Blur = guipane:CreateToggle({
	Name = 'Blur background',
	Function = function()
		mainapi:BlurCheck()
	end,
	Default = true,
	Tooltip = 'Blur the background of the GUI'
})
guipane:CreateToggle({
	Name = 'GUI bind indicator',
	Default = true,
	Tooltip = "Displays a message indicating your GUI upon injecting.\nI.E. 'Press RSHIFT to open GUI'"
})
guipane:CreateToggle({
	Name = 'Show tooltips',
	Function = function(enabled)
		tooltip.Visible = false
		toolblur.Visible = enabled
	end,
	Default = true,
	Tooltip = 'Toggles visibility of these'
})
guipane:CreateToggle({
	Name = 'Show legit mode',
	Function = function(enabled)
		scaledgui.Search.Legit.Visible = enabled
		scaledgui.Search.LegitDivider.Visible = enabled
		scaledgui.Search.TextBox.Size = UDim2.new(1, enabled and -50 or -10, 0, 37)
		scaledgui.Search.TextBox.Position = UDim2.fromOffset(enabled and 50 or 10, 0)
	end,
	Default = true,
	Tooltip = 'Shows the button to change to Legit Mode'
})
local scaleslider = {Object = {}, Value = 1}
mainapi.Scale = guipane:CreateToggle({
	Name = 'Auto rescale',
	Default = true,
	Function = function(callback)
		scaleslider.Object.Visible = not callback
		if callback then
			scale.Scale = math.max(gui.AbsoluteSize.X / 1920, 0.68)
		else
			scale.Scale = scaleslider.Value
		end
	end,
	Tooltip = 'Automatically rescales the gui using the screens resolution'
})
scaleslider = guipane:CreateSlider({
	Name = 'Scale',
	Min = 0.1,
	Max = 2,
	Decimal = 10,
	Function = function(val, final)
		if final and not mainapi.Scale.Enabled then
			scale.Scale = val
		end
	end,
	Default = 1,
	Darker = true,
	Visible = false
})
-- Manual GUI color controls removed: Silentware now uses curated theme presets only.
mainapi.RainbowMode = mainapi.RainbowMode or {Value = 'Gradient'}
mainapi.RainbowSpeed = mainapi.RainbowSpeed or {Value = 1}
mainapi.RainbowUpdateSpeed = mainapi.RainbowUpdateSpeed or {Value = 60}

--[[
	Notification Settings
]]

local notifpane = mainapi.Categories.Main:CreateSettingsPane({Name = 'Notifications'})
mainapi.Notifications = notifpane:CreateToggle({
	Name = 'Notifications',
	Function = function(enabled)
		if mainapi.ToggleNotifications.Object then
			mainapi.ToggleNotifications.Object.Visible = enabled
		end
	end,
	Tooltip = 'Shows notifications',
	Default = true
})
mainapi.ToggleNotifications = notifpane:CreateToggle({
	Name = 'Toggle alert',
	Tooltip = 'Notifies you if a module is enabled/disabled.',
	Default = true,
	Darker = true
})

-- Manual GUI theme slider removed. Use Theme Settings presets instead.
mainapi.Categories.Main:CreateBind()

--[[
	Text GUI
]]

local textgui = mainapi:CreateOverlay({
	Name = 'Text GUI',
	Icon = getcustomasset('vape/assets/textguiicon.png'),
	Size = UDim2.fromOffset(16, 12),
	Position = UDim2.fromOffset(12, 14),
	Function = function()
		mainapi:UpdateTextGUI()
	end
})
local textguisort = textgui:CreateDropdown({
	Name = 'Sort',
	List = {'Alphabetical', 'Length'},
	Function = function()
		mainapi:UpdateTextGUI()
	end
})
local textguifont = textgui:CreateFont({
	Name = 'Font',
	Blacklist = 'Arial',
	Function = function()
		mainapi:UpdateTextGUI()
	end
})
local textguicolor
local textguicolordrop = textgui:CreateDropdown({
	Name = 'Color Mode',
	List = {'Match GUI color', 'Custom color'},
	Function = function(val)
		textguicolor.Object.Visible = val == 'Custom color'
		mainapi:UpdateTextGUI()
	end
})
textguicolor = textgui:CreateColorSlider({
	Name = 'Text GUI color',
	Function = function()
		mainapi:UpdateGUI(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
	end,
	Darker = true,
	Visible = false
})
local VapeTextScale = Instance.new('UIScale')
VapeTextScale.Parent = textgui.Children
local textguiscale = textgui:CreateSlider({
	Name = 'Scale',
	Min = 0,
	Max = 2,
	Decimal = 10,
	Default = 1,
	Function = function(val)
		VapeTextScale.Scale = val
		mainapi:UpdateTextGUI()
	end
})
local textguishadow = textgui:CreateToggle({
	Name = 'Shadow',
	Tooltip = 'Renders shadowed text.',
	Function = function()
		mainapi:UpdateTextGUI()
	end
})
local textguigradientv4
local textguigradient = textgui:CreateToggle({
	Name = 'Gradient',
	Tooltip = 'Renders a gradient',
	Function = function(callback)
		textguigradientv4.Object.Visible = callback
		mainapi:UpdateTextGUI()
	end
})
textguigradientv4 = textgui:CreateToggle({
	Name = 'V4 Gradient',
	Function = function()
		mainapi:UpdateTextGUI()
	end,
	Darker = true,
	Visible = false
})
local textguianimations = textgui:CreateToggle({
	Name = 'Animations',
	Tooltip = 'Use animations on text gui',
	Function = function()
		mainapi:UpdateTextGUI()
	end
})
local textguiwatermark = textgui:CreateToggle({
	Name = 'Watermark',
	Tooltip = 'Renders a Silentware watermark',
	Function = function()
		mainapi:UpdateTextGUI()
	end
})
local textguibackgroundtransparency = {
	Value = 0.5,
	Object = {Visible = {}}
}
local textguibackgroundtint = {Enabled = false}
local textguibackground = textgui:CreateToggle({
	Name = 'Render background',
	Function = function(callback)
		textguibackgroundtransparency.Object.Visible = callback
		textguibackgroundtint.Object.Visible = callback
		mainapi:UpdateTextGUI()
	end
})
textguibackgroundtransparency = textgui:CreateSlider({
	Name = 'Transparency',
	Min = 0,
	Max = 1,
	Default = 0.5,
	Decimal = 10,
	Function = function()
		mainapi:UpdateTextGUI()
	end,
	Darker = true,
	Visible = false
})
textguibackgroundtint = textgui:CreateToggle({
	Name = 'Tint',
	Function = function()
		mainapi:UpdateTextGUI()
	end,
	Darker = true,
	Visible = false
})
local textguimoduleslist
local textguimodules = textgui:CreateToggle({
	Name = 'Hide modules',
	Tooltip = 'Allows you to blacklist certain modules from being shown.',
	Function = function(enabled)
		textguimoduleslist.Object.Visible = enabled
		mainapi:UpdateTextGUI()
	end
})
textguimoduleslist = textgui:CreateTextList({
	Name = 'Blacklist',
	Tooltip = 'Name of module to hide.',
	Icon = getcustomasset('vape/assets/blockedicon.png'),
	Tab = getcustomasset('vape/assets/blockedtab.png'),
	TabSize = UDim2.fromOffset(21, 16),
	Color = Color3.fromRGB(250, 50, 56),
	Function = function()
		mainapi:UpdateTextGUI()
	end,
	Visible = false,
	Darker = true
})
local textguirender = textgui:CreateToggle({
	Name = 'Hide render',
	Function = function()
		mainapi:UpdateTextGUI()
	end
})
local textguibox
local textguifontcustom
local textguicolorcustomtoggle
local textguicolorcustom
local textguitext = textgui:CreateToggle({
	Name = 'Add custom text',
	Function = function(enabled)
		textguibox.Object.Visible = enabled
		textguifontcustom.Object.Visible = enabled
		textguicolorcustomtoggle.Object.Visible = enabled
		textguicolorcustom.Object.Visible = textguicolorcustomtoggle.Enabled and enabled
		mainapi:UpdateTextGUI()
	end
})
textguibox = textgui:CreateTextBox({
	Name = 'Custom text',
	Function = function()
		mainapi:UpdateTextGUI()
	end,
	Darker = true,
	Visible = false
})
textguifontcustom = textgui:CreateFont({
	Name = 'Custom Font',
	Blacklist = 'Arial',
	Function = function()
		mainapi:UpdateTextGUI()
	end,
	Darker = true,
	Visible = false
})
textguicolorcustomtoggle = textgui:CreateToggle({
	Name = 'Set custom text color',
	Function = function(enabled)
		textguicolorcustom.Object.Visible = enabled
		mainapi:UpdateGUI(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
	end,
	Darker = true,
	Visible = false
})
textguicolorcustom = textgui:CreateColorSlider({
	Name = 'Color of custom text',
	Function = function()
		mainapi:UpdateGUI(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
	end,
	Darker = true,
	Visible = false
})

--[[
	Text GUI Objects
]]

local VapeLabels = {}
local VapeLogo = Instance.new('TextLabel')
VapeLogo.Name = 'Logo'
VapeLogo.Size = UDim2.fromOffset(112, 24)
VapeLogo.Position = UDim2.new(1, -142, 0, 3)
VapeLogo.BackgroundTransparency = 1
VapeLogo.BorderSizePixel = 0
VapeLogo.Visible = false
VapeLogo.BackgroundColor3 = Color3.new()
VapeLogo.Text = 'Silentware'
VapeLogo.TextXAlignment = Enum.TextXAlignment.Left
VapeLogo.TextColor3 = uipallet.Text
VapeLogo.TextSize = 22
VapeLogo.FontFace = uipallet.FontSemiBold
VapeLogo.Parent = textgui.Children

local lastside = textgui.Children.AbsolutePosition.X > (gui.AbsoluteSize.X / 2)
mainapi:Clean(textgui.Children:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
	if mainapi.ThreadFix then
		setthreadidentity(8)
	end
	local newside = textgui.Children.AbsolutePosition.X > (gui.AbsoluteSize.X / 2)
	if lastside ~= newside then
		lastside = newside
		mainapi:UpdateTextGUI()
	end
end))

local VapeLogoV4 = Instance.new('TextLabel')
VapeLogoV4.Name = 'Logo2'
VapeLogoV4.Size = UDim2.fromOffset(27, 16)
VapeLogoV4.Position = UDim2.new(1, 3, 0, 4)
VapeLogoV4.BackgroundColor3 = Color3.new()
VapeLogoV4.BackgroundTransparency = 1
VapeLogoV4.BorderSizePixel = 0
VapeLogoV4.Text = 'SW'
VapeLogoV4.TextXAlignment = Enum.TextXAlignment.Left
VapeLogoV4.TextColor3 = uipallet.Accent
VapeLogoV4.TextSize = 13
VapeLogoV4.FontFace = uipallet.FontSemiBold
VapeLogoV4.Parent = VapeLogo
local VapeLogoShadow = VapeLogo:Clone()
VapeLogoShadow.Position = UDim2.fromOffset(1, 1)
VapeLogoShadow.ZIndex = 0
VapeLogoShadow.Visible = true
VapeLogoShadow.TextColor3 = Color3.new()
VapeLogoShadow.TextTransparency = 0.65
VapeLogoShadow.Parent = VapeLogo
VapeLogoShadow.Logo2.ZIndex = 0
VapeLogoShadow.Logo2.TextColor3 = Color3.new()
VapeLogoShadow.Logo2.TextTransparency = 0.65
local VapeLogoGradient = Instance.new('UIGradient')
VapeLogoGradient.Rotation = 90
VapeLogoGradient.Parent = VapeLogo
local VapeLogoGradient2 = Instance.new('UIGradient')
VapeLogoGradient2.Rotation = 90
VapeLogoGradient2.Parent = VapeLogoV4
local VapeLabelCustom = Instance.new('TextLabel')
VapeLabelCustom.Position = UDim2.fromOffset(5, 2)
VapeLabelCustom.BackgroundTransparency = 1
VapeLabelCustom.BorderSizePixel = 0
VapeLabelCustom.Visible = false
VapeLabelCustom.Text = ''
VapeLabelCustom.TextSize = 25
VapeLabelCustom.FontFace = textguifontcustom.Value
VapeLabelCustom.RichText = true
local VapeLabelCustomShadow = VapeLabelCustom:Clone()
VapeLabelCustom:GetPropertyChangedSignal('Position'):Connect(function()
	VapeLabelCustomShadow.Position = UDim2.new(
		VapeLabelCustom.Position.X.Scale,
		VapeLabelCustom.Position.X.Offset + 1,
		0,
		VapeLabelCustom.Position.Y.Offset + 1
	)
end)
VapeLabelCustom:GetPropertyChangedSignal('FontFace'):Connect(function()
	VapeLabelCustomShadow.FontFace = VapeLabelCustom.FontFace
end)
VapeLabelCustom:GetPropertyChangedSignal('Text'):Connect(function()
	VapeLabelCustomShadow.Text = removeTags(VapeLabelCustom.Text)
end)
VapeLabelCustom:GetPropertyChangedSignal('Size'):Connect(function()
	VapeLabelCustomShadow.Size = VapeLabelCustom.Size
end)
VapeLabelCustomShadow.TextColor3 = Color3.new()
VapeLabelCustomShadow.TextTransparency = 0.65
VapeLabelCustomShadow.Parent = textgui.Children
VapeLabelCustom.Parent = textgui.Children
local VapeLabelHolder = Instance.new('Frame')
VapeLabelHolder.Name = 'Holder'
VapeLabelHolder.Size = UDim2.fromScale(1, 1)
VapeLabelHolder.Position = UDim2.fromOffset(5, 37)
VapeLabelHolder.BackgroundTransparency = 1
VapeLabelHolder.Parent = textgui.Children
local VapeLabelSorter = Instance.new('UIListLayout')
VapeLabelSorter.HorizontalAlignment = Enum.HorizontalAlignment.Right
VapeLabelSorter.VerticalAlignment = Enum.VerticalAlignment.Top
VapeLabelSorter.SortOrder = Enum.SortOrder.LayoutOrder
VapeLabelSorter.Parent = VapeLabelHolder

--[[
	Target Info
]]

local targetinfo
local targetinfoobj
local targetinfobcolor
local targetinfofollow
targetinfoobj = mainapi:CreateOverlay({
	Name = 'Target Info',
	Icon = getcustomasset('vape/assets/targetinfoicon.png'),
	Size = UDim2.fromOffset(14, 14),
	Position = UDim2.fromOffset(12, 14),
	CategorySize = 240,
	Function = function(callback)
		if callback then
			task.spawn(function()
				repeat
					local suc, err = pcall(function()
						local target = targetinfo:UpdateInfo()
						if target ~= nil and targetinfofollow and targetinfofollow.Enabled then
							local vec, screen = workspace.CurrentCamera:WorldToScreenPoint(target.Position)
							if screen then
								targetinfobkg.Parent.Parent.Position = UDim2.fromOffset(vec.X, vec.Y)
							end
						end
					end)
					if not suc and shared.VoidDev then warn("[TargetInfo Error]: "..tostring(err)) end
					task.wait()
				until not targetinfoobj.Button or not targetinfoobj.Button.Enabled
			end)
		end
	end
})

local targetinfobkg = Instance.new('Frame')
targetinfobkg.Size = UDim2.fromOffset(240, 89)
targetinfobkg.BackgroundColor3 = color.Dark(uipallet.Main, 0.1)
targetinfobkg.BackgroundTransparency = 0.5
targetinfobkg.Parent = targetinfoobj.Children
local targetinfoblurobj = addBlur(targetinfobkg)
targetinfoblurobj.Visible = false
addCorner(targetinfobkg)
local targetinfoshot = Instance.new('ImageLabel')
targetinfoshot.Size = UDim2.fromOffset(26, 27)
targetinfoshot.Position = UDim2.fromOffset(19, 17)
targetinfoshot.BackgroundColor3 = uipallet.Main
targetinfoshot.Image = 'rbxthumb://type=AvatarHeadShot&id=1&w=420&h=420'
targetinfoshot.Parent = targetinfobkg
local targetinfoshotflash = Instance.new('Frame')
targetinfoshotflash.Size = UDim2.fromScale(1, 1)
targetinfoshotflash.BackgroundTransparency = 1
targetinfoshotflash.BackgroundColor3 = Color3.new(1, 0, 0)
targetinfoshotflash.Parent = targetinfoshot
addCorner(targetinfoshotflash)
local targetinfoshotblur = addBlur(targetinfoshot)
targetinfoshotblur.Visible = false
addCorner(targetinfoshot)
local targetinfoname = Instance.new('TextLabel')
targetinfoname.Size = UDim2.fromOffset(145, 20)
targetinfoname.Position = UDim2.fromOffset(54, 20)
targetinfoname.BackgroundTransparency = 1
targetinfoname.Text = 'Target name'
targetinfoname.TextXAlignment = Enum.TextXAlignment.Left
targetinfoname.TextYAlignment = Enum.TextYAlignment.Top
targetinfoname.TextScaled = true
targetinfoname.TextColor3 = color.Light(uipallet.Text, 0.4)
targetinfoname.TextStrokeTransparency = 1
targetinfoname.FontFace = uipallet.Font
local targetinfoshadow = targetinfoname:Clone()
targetinfoshadow.Position = UDim2.fromOffset(55, 21)
targetinfoshadow.TextColor3 = Color3.new()
targetinfoshadow.TextTransparency = 0.65
targetinfoshadow.Visible = false
targetinfoshadow.Parent = targetinfobkg
targetinfoname:GetPropertyChangedSignal('Size'):Connect(function()
	targetinfoshadow.Size = targetinfoname.Size
end)
targetinfoname:GetPropertyChangedSignal('Text'):Connect(function()
	targetinfoshadow.Text = targetinfoname.Text
end)
targetinfoname:GetPropertyChangedSignal('FontFace'):Connect(function()
	targetinfoshadow.FontFace = targetinfoname.FontFace
end)
targetinfoname.Parent = targetinfobkg
local targetinfohealthbkg = Instance.new('Frame')
targetinfohealthbkg.Name = 'HealthBKG'
targetinfohealthbkg.Size = UDim2.fromOffset(200, 9)
targetinfohealthbkg.Position = UDim2.fromOffset(20, 56)
targetinfohealthbkg.BackgroundColor3 = uipallet.Main
targetinfohealthbkg.BorderSizePixel = 0
targetinfohealthbkg.Parent = targetinfobkg
addCorner(targetinfohealthbkg, UDim.new(1, 0))
local targetinfohealth = targetinfohealthbkg:Clone()
targetinfohealth.Size = UDim2.fromScale(0.8, 1)
targetinfohealth.Position = UDim2.new()
targetinfohealth.BackgroundColor3 = Color3.fromHSV(1 / 2.5, 0.89, 0.75)
targetinfohealth.Parent = targetinfohealthbkg
targetinfohealth:GetPropertyChangedSignal('Size'):Connect(function()
	targetinfohealth.Visible = targetinfohealth.Size.X.Scale > 0.01
end)
local targetinfohealthextra = targetinfohealth:Clone()
targetinfohealthextra.Size = UDim2.new()
targetinfohealthextra.Position = UDim2.fromScale(1, 0)
targetinfohealthextra.AnchorPoint = Vector2.new(1, 0)
targetinfohealthextra.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
targetinfohealthextra.Visible = false
targetinfohealthextra.Parent = targetinfohealthbkg
targetinfohealthextra:GetPropertyChangedSignal('Size'):Connect(function()
	targetinfohealthextra.Visible = targetinfohealthextra.Size.X.Scale > 0.01
end)
local targetinfohealthblur = addBlur(targetinfohealthbkg)
targetinfohealthblur.SliceCenter = Rect.new(52, 31, 261, 510)
targetinfohealthblur.ImageColor3 = Color3.new()
targetinfohealthblur.Visible = false
local targetinfob = Instance.new('UIStroke')
targetinfob.Enabled = false
targetinfob.Color = Color3.fromHSV(0.44, 1, 1)
targetinfob.Parent = targetinfobkg

targetinfoobj:CreateFont({
	Name = 'Font',
	Blacklist = 'Arial',
	Function = function(val)
		targetinfoname.FontFace = val
	end
})
local targetinfobackgroundtransparency = {
	Value = 0.5,
	Object = {Visible = {}}
}
local targetinfodisplay = targetinfoobj:CreateToggle({
	Name = 'Use Displayname',
	Default = true
})
targetinfofollow = targetinfoobj:CreateToggle({
	Name = 'Follow Player',
	Function = function() end
})
targetinfoobj:CreateToggle({
	Name = 'Render Background',
	Function = function(callback)
		targetinfobkg.BackgroundTransparency = callback and targetinfobackgroundtransparency.Value or 1
		targetinfoshadow.Visible = not callback
		targetinfoblurobj.Visible = callback
		targetinfohealthblur.Visible = not callback
		targetinfoshotblur.Visible = not callback
		targetinfobackgroundtransparency.Object.Visible = callback
	end,
	Default = true
})
targetinfobackgroundtransparency = targetinfoobj:CreateSlider({
	Name = 'Transparency',
	Min = 0,
	Max = 1,
	Default = 0.5,
	Decimal = 10,
	Function = function(val)
		targetinfobkg.BackgroundTransparency = val
	end,
	Darker = true
})
local targetinfocolor
local targetinfocolortoggle = targetinfoobj:CreateToggle({
	Name = 'Custom Color',
	Function = function(callback)
		targetinfocolor.Object.Visible = callback
		if callback then
			targetinfobkg.BackgroundColor3 = Color3.fromHSV(targetinfocolor.Hue, targetinfocolor.Sat, targetinfocolor.Value)
			targetinfoshot.BackgroundColor3 = Color3.fromHSV(targetinfocolor.Hue, targetinfocolor.Sat, math.max(targetinfocolor.Value - 0.1, 0.075))
			targetinfohealthbkg.BackgroundColor3 = targetinfoshot.BackgroundColor3
		else
			targetinfobkg.BackgroundColor3 = color.Dark(uipallet.Main, 0.1)
			targetinfoshot.BackgroundColor3 = uipallet.Main
			targetinfohealthbkg.BackgroundColor3 = uipallet.Main
		end
	end
})
targetinfocolor = targetinfoobj:CreateColorSlider({
	Name = 'Color',
	Function = function(hue, sat, val)
		if targetinfocolortoggle.Enabled then
			targetinfobkg.BackgroundColor3 = Color3.fromHSV(hue, sat, val)
			targetinfoshot.BackgroundColor3 = Color3.fromHSV(hue, sat, math.max(val - 0.1, 0))
			targetinfohealthbkg.BackgroundColor3 = targetinfoshot.BackgroundColor3
		end
	end,
	Darker = true,
	Visible = false
})
targetinfoobj:CreateToggle({
	Name = 'Border',
	Function = function(callback)
		targetinfob.Enabled = callback
		targetinfobcolor.Object.Visible = callback
	end
})
targetinfobcolor = targetinfoobj:CreateColorSlider({
	Name = 'Border Color',
	Function = function(hue, sat, val, opacity)
		targetinfob.Color = Color3.fromHSV(hue, sat, val)
		targetinfob.Transparency = 1 - opacity
	end,
	Darker = true,
	Visible = false
})

local lasthealth = 0
local lastmaxhealth = 0
targetinfo = {
	Targets = {},
	Object = targetinfobkg,
	UpdateInfo = function(self)
		local entitylib = mainapi.Libraries
		if not entitylib then return end

		for i, v in self.Targets do
			if v < tick() then
				self.Targets[i] = nil
			end
		end

		local v, highest = nil, tick()
		for i, check in self.Targets do
			if check > highest then
				v = i
				highest = check
			end
		end

		targetinfobkg.Visible = v ~= nil or mainapi.gui.ScaledGui.ClickGui.Visible
		if v then
			targetinfoname.Text = v.Player and (targetinfodisplay.Enabled and v.Player.DisplayName or v.Player.Name) or v.Character and v.Character.Name or targetinfoname.Text
			targetinfoshot.Image = 'rbxthumb://type=AvatarHeadShot&id='..(v.Player and v.Player.UserId or 1)..'&w=420&h=420'

			if not v.Character then
				v.Health = v.Health or 0
				v.MaxHealth = v.MaxHealth or 100
			end

			if v.Health ~= lasthealth or v.MaxHealth ~= lastmaxhealth then
				local percent = math.max(v.Health / v.MaxHealth, 0)
				tween:Tween(targetinfohealth, TweenInfo.new(0.3), {
					Size = UDim2.fromScale(math.min(percent, 1), 1), BackgroundColor3 = Color3.fromHSV(math.clamp(percent / 2.5, 0, 1), 0.89, 0.75)
				})
				tween:Tween(targetinfohealthextra, TweenInfo.new(0.3), {
					Size = UDim2.fromScale(math.clamp(percent - 1, 0, 0.8), 1)
				})
				if lasthealth > v.Health and self.LastTarget == v then
					tween:Cancel(targetinfoshotflash)
					targetinfoshotflash.BackgroundTransparency = 0.3
					tween:Tween(targetinfoshotflash, TweenInfo.new(0.5), {
						BackgroundTransparency = 1
					})
				end
				lasthealth = v.Health
				lastmaxhealth = v.MaxHealth
			end

			if not v.Character then table.clear(v) end
			self.LastTarget = v
		end
		return v
	end
}
mainapi.Libraries.targetinfo = targetinfo

function mainapi:UpdateTextGUI(afterload)
	if not afterload and not mainapi.Loaded then return end
	if textgui.Button.Enabled then
		local right = textgui.Children.AbsolutePosition.X > (gui.AbsoluteSize.X / 2)
		VapeLogo.Visible = textguiwatermark.Enabled
		VapeLogo.Position = right and UDim2.new(1 / VapeTextScale.Scale, -113, 0, 6) or UDim2.fromOffset(0, 6)
		VapeLogoShadow.Visible = textguishadow.Enabled
		VapeLabelCustom.Text = textguibox.Value
		VapeLabelCustom.FontFace = textguifontcustom.Value
		VapeLabelCustom.Visible = VapeLabelCustom.Text ~= '' and textguitext.Enabled
		VapeLabelCustomShadow.Visible = VapeLabelCustom.Visible and textguishadow.Enabled
		VapeLabelSorter.HorizontalAlignment = right and Enum.HorizontalAlignment.Right or Enum.HorizontalAlignment.Left
		VapeLabelHolder.Size = UDim2.fromScale(1 / VapeTextScale.Scale, 1)
		VapeLabelHolder.Position = UDim2.fromOffset(right and 3 or 0, 11 + (VapeLogo.Visible and VapeLogo.Size.Y.Offset or 0) + (VapeLabelCustom.Visible and 28 or 0) + (textguibackground.Enabled and 3 or 0))
		if VapeLabelCustom.Visible then
			local size = getfontsize(removeTags(VapeLabelCustom.Text), VapeLabelCustom.TextSize, VapeLabelCustom.FontFace)
			VapeLabelCustom.Size = UDim2.fromOffset(size.X, size.Y)
			VapeLabelCustom.Position = UDim2.new(right and 1 / VapeTextScale.Scale or 0, right and -size.X or 0, 0, (VapeLogo.Visible and 32 or 8))
		end

		local found = {}
		for _, v in VapeLabels do
			if v.Enabled then
				table.insert(found, v.Object.Name)
			end
			v.Object:Destroy()
		end
		table.clear(VapeLabels)

		local info = TweenInfo.new(0.3, Enum.EasingStyle.Exponential)
		for i, v in mainapi.Modules do
			if textguimodules.Enabled and table.find(textguimoduleslist.ListEnabled, i) then continue end
			if textguirender.Enabled and v.Category == 'Render' then continue end
			if v.Enabled or table.find(found, i) then
				local holder = Instance.new('Frame')
				holder.Name = i
				holder.Size = UDim2.fromOffset()
				holder.BackgroundTransparency = 1
				holder.ClipsDescendants = true
				holder.Parent = VapeLabelHolder
				local holderbackground
				local holdsilentlorline
				if textguibackground.Enabled then
					holderbackground = Instance.new('Frame')
					holderbackground.Size = UDim2.new(1, 3, 1, 0)
					holderbackground.BackgroundColor3 = color.Dark(uipallet.Main, 0.15)
					holderbackground.BackgroundTransparency = textguibackgroundtransparency.Value
					holderbackground.BorderSizePixel = 0
					holderbackground.Parent = holder
					local holderline = Instance.new('Frame')
					holderline.Size = UDim2.new(1, 0, 0, 1)
					holderline.Position = UDim2.new(0, 0, 1, -1)
					holderline.BackgroundColor3 = Color3.new()
					holderline.BackgroundTransparency = 0.928 + (0.072 * math.clamp((textguibackgroundtransparency.Value - 0.5) / 0.5, 0, 1))
					holderline.BorderSizePixel = 0
					holderline.Parent = holderbackground
					local holderline2 = holderline:Clone()
					holderline2.Name = 'Line'
					holderline2.Position = UDim2.new()
					holderline2.Parent = holderbackground
					holdsilentlorline = Instance.new('Frame')
					holdsilentlorline.Size = UDim2.new(0, 2, 1, 0)
					holdsilentlorline.Position = right and UDim2.new(1, -5, 0, 0) or UDim2.new()
					holdsilentlorline.BorderSizePixel = 0
					holdsilentlorline.Parent = holderbackground
				end
				local holdertext = Instance.new('TextLabel')
				holdertext.Position = UDim2.fromOffset(right and 3 or 6, 2)
				holdertext.BackgroundTransparency = 1
				holdertext.BorderSizePixel = 0
				holdertext.Text = i..(v.ExtraText and " <font color='#A8A8A8'>"..v.ExtraText()..'</font>' or '')
				holdertext.TextSize = 15
				holdertext.FontFace = textguifont.Value
				holdertext.RichText = true
				local size = getfontsize(removeTags(holdertext.Text), holdertext.TextSize, holdertext.FontFace)
				holdertext.Size = UDim2.fromOffset(size.X, size.Y)
				if textguishadow.Enabled then
					local holderdrop = holdertext:Clone()
					holderdrop.Position = UDim2.fromOffset(holdertext.Position.X.Offset + 1, holdertext.Position.Y.Offset + 1)
					holderdrop.Text = removeTags(holdertext.Text)
					holderdrop.TextColor3 = Color3.new()
					holderdrop.Parent = holder
				end
				holdertext.Parent = holder
				local holdersize = UDim2.fromOffset(size.X + 10, size.Y + (textguibackground.Enabled and 5 or 3))
				if textguianimations.Enabled then
					if not table.find(found, i) then
						tween:Tween(holder, info, {
							Size = holdersize
						})
					else
						holder.Size = holdersize
						if not v.Enabled then
							tween:Tween(holder, info, {
								Size = UDim2.fromOffset()
							})
						end
					end
				else
					holder.Size = v.Enabled and holdersize or UDim2.fromOffset()
				end
				table.insert(VapeLabels, {
					Object = holder,
					Text = holdertext,
					Background = holderbackground,
					Color = holdsilentlorline,
					Enabled = v.Enabled
				})
			end
		end

		if textguisort.Value == 'Alphabetical' then
			table.sort(VapeLabels, function(a, b)
				return a.Text.Text < b.Text.Text
			end)
		else
			table.sort(VapeLabels, function(a, b)
				return a.Text.Size.X.Offset > b.Text.Size.X.Offset
			end)
		end

		for i, v in VapeLabels do
			if v.Color then
				v.Color.Parent.Line.Visible = i ~= 1
			end
			v.Object.LayoutOrder = i
		end
	end

	mainapi:UpdateGUI(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value, true)
end

function mainapi:UpdateGUI(hue, sat, val, default)
	if mainapi.Loaded == nil then return end
	if not default and mainapi.GUIColor.Rainbow then return end
	if textgui.Button.Enabled then
		VapeLogoGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromHSV(hue, sat, val)),
			ColorSequenceKeypoint.new(1, textguigradient.Enabled and Color3.fromHSV(mainapi:Color((hue - 0.075) % 1)) or Color3.fromHSV(hue, sat, val))
		})
		VapeLogoGradient2.Color = textguigradient.Enabled and textguigradientv4.Enabled and VapeLogoGradient.Color or ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
			ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
		})
		VapeLabelCustom.TextColor3 = textguicolorcustomtoggle.Enabled and Color3.fromHSV(textguicolorcustom.Hue, textguicolorcustom.Sat, textguicolorcustom.Value) or VapeLogoGradient.Color.Keypoints[2].Value

		local customcolor = textguicolordrop.Value == 'Custom color' and Color3.fromHSV(textguicolor.Hue, textguicolor.Sat, textguicolor.Value) or nil
		for i, v in VapeLabels do
			v.Text.TextColor3 = customcolor or (mainapi.GUIColor.Rainbow and Color3.fromHSV(mainapi:Color((hue - ((textguigradient and i + 2 or i) * 0.025)) % 1)) or VapeLogoGradient.Color.Keypoints[2].Value)
			if v.Color then
				v.Color.BackgroundColor3 = v.Text.TextColor3
			end
			if textguibackgroundtint.Enabled and v.Background then
				v.Background.BackgroundColor3 = color.Dark(v.Text.TextColor3, 0.75)
			end
		end
	end

	if not clickgui.Visible and not mainapi.Legit.Window.Visible then return end
	local rainbow = mainapi.GUIColor.Rainbow and mainapi.RainbowMode.Value ~= 'Retro'

	for i, v in mainapi.Categories do
		if i == 'Main' then
			local logo = (v.Object and v.Object:FindFirstChild('VapeLogo', true)) or (mainapi.PremiumShell and mainapi.PremiumShell:FindFirstChild('VapeLogo', true))
			local dot = logo and logo:FindFirstChild('V4Logo')
			if dot then dot.BackgroundColor3 = Color3.fromHSV(hue, sat, val) end
			if mainapi.PremiumGlow then mainapi.PremiumGlow.ImageColor3 = Color3.fromHSV(hue, sat, val) end
			for _, button in v.Buttons do
				if button.Enabled then
					if button.ApplyState then
						button.ApplyState(true)
					else
						button.Object.TextColor3 = rainbow and Color3.fromHSV(mainapi:Color((hue - (button.Index * 0.025)) % 1)) or Color3.fromHSV(hue, sat, val)
						if button.Icon then
							button.Icon.ImageColor3 = button.Object.TextColor3
						end
					end
				end
			end
		end

		if v.Options then
			for _, option in v.Options do
				if option.Color then
					option:Color(hue, sat, val, rainbow)
				end
			end
		end

		if v.Type == 'CategoryList' then
			v.Object.Children.Add.AddButton.ImageColor3 = rainbow and Color3.fromHSV(mainapi:Color(hue % 1)) or Color3.fromHSV(hue, sat, val)
			if v.Selected then
				v.Selected.BackgroundColor3 = rainbow and Color3.fromHSV(mainapi:Color(hue % 1)) or Color3.fromHSV(hue, sat, val)
				v.Selected.Title.TextColor3 = mainapi.GUIColor.Rainbow and Color3.new(0.19, 0.19, 0.19) or mainapi:TextColor(hue, sat, val)
				v.Selected.Dots.Dots.ImageColor3 = v.Selected.Title.TextColor3
				v.Selected.Bind.Icon.ImageColor3 = v.Selected.Title.TextColor3
				v.Selected.Bind.TextLabel.TextColor3 = v.Selected.Title.TextColor3
			end
		end
	end

	for _, button in mainapi.Modules do
		if button.Enabled then
			button.Object.BackgroundColor3 = rainbow and Color3.fromHSV(mainapi:Color((hue - (button.Index * 0.025)) % 1)) or Color3.fromHSV(hue, sat, val)
			button.Object.TextColor3 = mainapi.GUIColor.Rainbow and Color3.new(0.19, 0.19, 0.19) or mainapi:TextColor(hue, sat, val)
			button.Object.UIGradient.Enabled = rainbow and mainapi.RainbowMode.Value == 'Gradient'
			if button.Object.UIGradient.Enabled then
				button.Object.BackgroundColor3 = Color3.new(1, 1, 1)
				button.Object.UIGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromHSV(mainapi:Color((hue - (button.Index * 0.025)) % 1))),
					ColorSequenceKeypoint.new(1, Color3.fromHSV(mainapi:Color((hue - ((button.Index + 1) * 0.025)) % 1)))
				})
			end
			button.Object.Bind.Icon.ImageColor3 = button.Object.TextColor3
			button.Object.Bind.TextLabel.TextColor3 = button.Object.TextColor3
			button.Object.Dots.Dots.ImageColor3 = button.Object.TextColor3
			local accentline = button.Object:FindFirstChild('AccentLine')
			if accentline then
				accentline.BackgroundColor3 = button.Object.BackgroundColor3
				accentline.BackgroundTransparency = 0
			end
			local activeStroke = button.Object:FindFirstChildOfClass('UIStroke')
			if activeStroke then
				activeStroke.Color = button.Object.BackgroundColor3
				activeStroke.Transparency = 0.25
			end
		end

		for _, option in button.Options do
			if option.Color then
				option:Color(hue, sat, val, rainbow)
			end
		end
	end

	for i, v in mainapi.Overlays.Toggles do
		if v.Enabled then
			tween:Cancel(v.Object.Knob)
			v.Object.Knob.BackgroundColor3 = rainbow and Color3.fromHSV(mainapi:Color((hue - (i * 0.075)) % 1)) or Color3.fromHSV(hue, sat, val)
		end
	end

	if mainapi.Legit.Icon then
		mainapi.Legit.Icon.ImageColor3 = Color3.fromHSV(hue, sat, val)
	end

	if mainapi.Legit.Window.Visible then
		for _, v in mainapi.Legit.Modules do
			if v.Enabled then
				tween:Cancel(v.Object.Knob)
				v.Object.Knob.BackgroundColor3 = Color3.fromHSV(hue, sat, val)
			end

			for _, option in v.Options do
				if option.Color then
					option:Color(hue, sat, val, rainbow)
				end
			end
		end
	end
end

mainapi:Clean(notifications.ChildRemoved:Connect(function()
	for i, v in notifications:GetChildren() do
		tween:Tween(v, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
			Position = UDim2.new(1, 0, 1, -(29 + (78 * i)))
		})
	end
end))

mainapi:Clean(inputService.InputBegan:Connect(function(inputObj)
	if not inputService:GetFocusedTextBox() and inputObj.KeyCode ~= Enum.KeyCode.Unknown then
		table.insert(mainapi.HeldKeybinds, inputObj.KeyCode.Name)
		if mainapi.Binding then return end

		if checkKeybinds(mainapi.HeldKeybinds, mainapi.Keybind, inputObj.KeyCode.Name) then
			if mainapi.ThreadFix then
				setthreadidentity(8)
			end
			for _, v in mainapi.Windows do
				v.Visible = false
			end
			clickgui.Visible = not clickgui.Visible
			tooltip.Visible = false
			mainapi:BlurCheck()
		end

		local toggled = false
		for i, v in mainapi.Modules do
			if checkKeybinds(mainapi.HeldKeybinds, v.Bind, inputObj.KeyCode.Name) then
				toggled = true
				if mainapi.ToggleNotifications.Enabled then
					mainapi:CreateNotification('Module Toggled', i.."<font color='#FFFFFF'> has been </font>"..(not v.Enabled and "<font color='#5AFF5A'>Enabled</font>" or "<font color='#FF5A5A'>Disabled</font>").."<font color='#FFFFFF'>!</font>", 0.75)
				end
				v:Toggle(true)
			end
		end
		if toggled then
			mainapi:UpdateTextGUI()
		end

		for _, v in mainapi.Profiles do
			if checkKeybinds(mainapi.HeldKeybinds, v.Bind, inputObj.KeyCode.Name) and v.Name ~= mainapi.Profile then
				mainapi:Save(v.Name)
				mainapi:Load(true)
				break
			end
		end
	end
end))

mainapi:Clean(inputService.InputEnded:Connect(function(inputObj)
	if not inputService:GetFocusedTextBox() and inputObj.KeyCode ~= Enum.KeyCode.Unknown then
		if mainapi.Binding then
			if not mainapi.MultiKeybind.Enabled then
				mainapi.HeldKeybinds = {inputObj.KeyCode.Name}
			end
			mainapi.Binding:SetBind(checkKeybinds(mainapi.HeldKeybinds, mainapi.Binding.Bind, inputObj.KeyCode.Name) and {} or mainapi.HeldKeybinds, true)
			mainapi.Binding = nil
		end
	end

	local ind = table.find(mainapi.HeldKeybinds, inputObj.KeyCode.Name)
	if ind then
		table.remove(mainapi.HeldKeybinds, ind)
	end
end))

if inputService.TouchEnabled then
	local button = Instance.new("TextButton")
	button.Position = UDim2.new(1, -30, 0, 0)
	button.Text = "Vape"
	button.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.Size = UDim2.new(0, 30, 0, 20)
	button.BorderSizePixel = 0
	button.BackgroundTransparency = 0.5
	button.Parent = gui
	button.MouseButton1Click:Connect(function()
		if mainapi.ThreadFix then
			setthreadidentity(8)
		end
		for _, v in mainapi.Windows do
			v.Visible = false
		end
		clickgui.Visible = not clickgui.Visible
		tooltip.Visible = false
		mainapi:BlurCheck()
	end)
	shared.VapeButton = button
end

return mainapi
