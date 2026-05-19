repeat task.wait() until game:IsLoaded()
if shared.vape then shared.vape:Uninject(); shared.VapeExecuted = false end

if identifyexecutor and ({identifyexecutor()})[1] == 'Argon' then
	getgenv().setthreadidentity = nil
end

shared.OLD_SETTHREADIDENTITY = shared.OLD_SETTHREADIDENTITY or getgenv().setthreadidentity or function() end
getgenv().setthreadidentity = function(...)
	local args = {...}
	local suc, err = pcall(function()
		return shared.OLD_SETTHREADIDENTITY(unpack(args))
	end)
	if not suc and shared.VoidDev then
		warn(`SETTHREADIDENTITY ERROR: {tostring(err)}`)
	end
	return suc and err
end
getgenv().run = function(func)
	local suc, err = pcall(function() func() end)
	if (not suc) then
		warn('Error in module! Error log: '..debug.traceback(tostring(err)))
	end
end

local vape
local baseLoadstring = loadstring
pcall(function()
	if type(getgenv) == "function" then
		local genv = getgenv()
		if type(genv) == "table" and type(genv.loadstring) == "function" then
			baseLoadstring = genv.loadstring
		end
	end
end)
local loadstring = function(...)
	local res, err = baseLoadstring(...)
	if err and vape then
		vape:CreateNotification('Silentware', 'Failed to load : '..err, 30, 'alert')
	end
	return res, err
end
if hookfunction == nil then getgenv().hookfunction = function() end end
local queue_on_teleport = queue_on_teleport or function() end
local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)
	return suc and res ~= nil and res ~= ''
end
getgenv().cloneref = function(obj) return obj end
local cloneref = cloneref or function(obj)
	return obj
end
local playersService = cloneref(game:GetService('Players'))

local isInkGame = false

local savingTable = {
	"TeleportExploitAutowinEnabled",
	"NoSilentwareModules",
	"VapeCustomProfile",
	"ProfilesDisabled",
	"CheatEngineMode",
	"ClosetCheatMode",
	"NoAutoExecute",
	"VapeDeveloper",
	"CustomCommit",
	"TestingMode",
	"VapePrivate",
	"VoidDev"
}

local oldtbl = {}
local function finishLoading()
	vape.Init = nil
	vape:Load()
	task.spawn(function()
		repeat
			shared.VapeFullyLoaded = vape.Loaded
			vape:Save()
			task.wait(10)
		until not vape.Loaded
	end)

	if not isInkGame then

		local teleportedServers
		vape:Clean(playersService.LocalPlayer.OnTeleport:Connect(function()
			if (not teleportedServers) and (not shared.VapeIndependent) then
				teleportedServers = true
				local repo = tostring(shared.SilentwareRepo or "VapeSilentware/vapesilentware")
				local branch = tostring(shared.CustomCommit or shared.SilentwareBranch or "main")
				local teleportScript = [[
					repeat task.wait() until game:IsLoaded()
					if getgenv and not getgenv().shared then shared.CheatEngineMode = true; getgenv().shared = {}; end
					shared.VapeSwitchServers = true
					shared.vapereload = true
					if shared.VapeDeveloper or shared.VoidDev then
						if isfile('vape/NewMainScript.lua') then
							loadstring(readfile("vape/NewMainScript.lua"))()
						else
							loadstring(game:HttpGet("https://raw.githubusercontent.com/]]..repo..[[/]]..branch..[[/NewMainScript.lua", true))()
						end
					else
						loadstring(game:HttpGet("https://raw.githubusercontent.com/]]..repo..[[/]]..branch..[[/NewMainScript.lua", true))()
					end
				]]
				for _, v in pairs(savingTable) do
					if shared[v] ~= nil then
						teleportScript = 'shared.'..tostring(v).." = "..tostring(shared[v]).."\n"..teleportScript
					end
				end
				if shared.VoidDev then
					teleportScript = 'shared.VoidDev = true\n'..teleportScript
				end
				vape:Save()
				queue_on_teleport(teleportScript)
			end
		end))
	end

	if isInkGame or not shared.vapereload then
		if not vape.Categories then return end
		if type(vape.Keybind) ~= "table" or #vape.Keybind == 0 then
			vape.Keybind = {'RightShift'}
			pcall(function()
				vape.Categories.Main.Options.Bind:SetBind(vape.Keybind)
			end)
		end
		if vape.Categories.Main.Options['GUI bind indicator'].Enabled then
			vape:CreateNotification('Finished Loading', vape.VapeButton and 'Press the button in the top right to open GUI' or 'Press '..table.concat(vape.Keybind, ' + '):upper()..' to open GUI', 5)
		end
	end
end

local gui = 'new'
if not isfolder('vape/assets') then
	makefolder('vape/assets')
end

local function showSilentwareGithubOnlyError(reason)
	local message = 'you have to use the github version'
	pcall(function()
		game:GetService('StarterGui'):SetCore('SendNotification', {
			Title = 'Silentware blocked',
			Text = message,
			Duration = 12
		})
	end)
	pcall(function()
		local guiParent = game:GetService('CoreGui')
		local screen = Instance.new('ScreenGui')
		screen.Name = 'SilentwareGithubOnlyError'
		screen.IgnoreGuiInset = true
		screen.ResetOnSpawn = false
		screen.DisplayOrder = 999999
		screen.Parent = guiParent
		local shade = Instance.new('Frame')
		shade.Size = UDim2.fromScale(1, 1)
		shade.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		shade.BackgroundTransparency = 0.22
		shade.BorderSizePixel = 0
		shade.Parent = screen
		local card = Instance.new('Frame')
		card.AnchorPoint = Vector2.new(0.5, 0.5)
		card.Position = UDim2.fromScale(0.5, 0.5)
		card.Size = UDim2.fromOffset(420, 168)
		card.BackgroundColor3 = Color3.fromRGB(8, 14, 12)
		card.BorderSizePixel = 0
		card.Parent = shade
		local corner = Instance.new('UICorner')
		corner.CornerRadius = UDim.new(0, 18)
		corner.Parent = card
		local stroke = Instance.new('UIStroke')
		stroke.Color = Color3.fromRGB(64, 95, 76)
		stroke.Transparency = 0.32
		stroke.Thickness = 1
		stroke.Parent = card
		local accent = Instance.new('Frame')
		accent.Size = UDim2.new(1, -36, 0, 2)
		accent.Position = UDim2.fromOffset(18, 58)
		accent.BackgroundColor3 = Color3.fromRGB(56, 215, 139)
		accent.BorderSizePixel = 0
		accent.Parent = card
		local accentCorner = Instance.new('UICorner')
		accentCorner.CornerRadius = UDim.new(1, 0)
		accentCorner.Parent = accent
		local title = Instance.new('TextLabel')
		title.Size = UDim2.new(1, -36, 0, 28)
		title.Position = UDim2.fromOffset(18, 18)
		title.BackgroundTransparency = 1
		title.Text = 'Silentware blocked'
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = Color3.fromRGB(241, 250, 246)
		title.TextSize = 20
		title.Font = Enum.Font.GothamSemibold
		title.Parent = card
		local body = Instance.new('TextLabel')
		body.Size = UDim2.new(1, -36, 0, 74)
		body.Position = UDim2.fromOffset(18, 74)
		body.BackgroundTransparency = 1
		body.Text = message..'\n'..tostring(reason or '')
		body.TextWrapped = true
		body.TextXAlignment = Enum.TextXAlignment.Left
		body.TextYAlignment = Enum.TextYAlignment.Top
		body.TextColor3 = Color3.fromRGB(153, 184, 168)
		body.TextSize = 13
		body.Font = Enum.Font.Gotham
		body.Parent = card
	end)
	error(message, 0)
end

local swRepo = tostring(shared.SilentwareRepo or "VapeSilentware/vapesilentware")
local swBranch = tostring(shared.CustomCommit or shared.SilentwareBranch or "main")
if shared.SilentwareRequireGithub ~= false and (swRepo ~= 'VapeSilentware/vapesilentware' or swBranch ~= 'main') then
	showSilentwareGithubOnlyError('Expected VapeSilentware/vapesilentware/main, got '..swRepo..'/'..swBranch)
end
local function stripBom(str)
	if type(str) ~= "string" then
		return str
	end
	str = str:gsub("\239\187\191", "")
	str = str:gsub("^\255\254", "")
	str = str:gsub("^\254\255", "")
	return str
end
local function fetchSilentwareFile(path)
	local repos = {swRepo, "VapeSilentware/vapesilentware"}
	local branches = {swBranch, "main"}
	for _, branch in ipairs(branches) do
		for _, repo in ipairs(repos) do
			local suc, res = pcall(function()
				return game:HttpGet("https://raw.githubusercontent.com/"..repo.."/"..branch.."/"..path, true)
			end)
			if suc and res and res ~= "404: Not Found" then
				return stripBom(res)
			end
		end
	end
	error("Failed to fetch "..tostring(path))
end

-- Some executors/loadstring environments do not expose getgenv().pload as a plain
-- global inside main.lua. Keep a local reference and provide a safe fallback loader so
-- main.lua can still fetch required project files without crashing at the GUI load line.
local pload = (shared and shared.pload) or (type(getgenv) == "function" and getgenv().pload)
if type(pload) ~= "function" then
	pload = function(fileName, isImportant, required)
		fileName = tostring(fileName or "")
		local source
		local fetched, fetchErr = pcall(function()
			source = fetchSilentwareFile(fileName)
		end)
		if not fetched or type(source) ~= "string" then
			local msg = "Failed to fetch "..fileName..": "..tostring(fetchErr)
			if isImportant then error(msg, 0) else warn(msg) end
			return nil
		end

		local chunk, compileErr = loadstring(source)
		if type(chunk) ~= "function" then
			source = source:gsub("\239\187\191", ""):gsub("^[%z\1-\9\11-\12\14-\31]+", "")
			chunk, compileErr = loadstring(source)
		end
		if type(chunk) ~= "function" then
			local msg = "Failed to compile "..fileName..": "..tostring(compileErr)
			if isImportant then error(msg, 0) else warn(msg) end
			return nil
		end

		local ran, result = pcall(chunk)
		if not ran then
			local msg = "Failed to run "..fileName..": "..tostring(result)
			if isImportant then error(msg, 0) else warn(msg) end
			return nil
		end
		if required and result == nil then
			local msg = "Required file returned nil: "..fileName
			if isImportant then error(msg, 0) else warn(msg) end
			return nil
		end
		return result
	end
	shared.pload = pload
	if type(getgenv) == "function" then
		getgenv().pload = pload
	end
end
local swSource = fetchSilentwareFile("libraries/SilentwareFunctions.lua")
local swChunk, swCompileErr = loadstring(swSource)
if type(swChunk) ~= "function" then
	-- Retry with stronger leading-control-byte cleanup for executors that pass BOM/control chars through oddly.
	swSource = swSource:gsub("^[%z\1-\9\11-\12\14-\31]+", "")
	swChunk, swCompileErr = loadstring(swSource)
end
if type(swChunk) ~= "function" then
	error("Failed to compile libraries/SilentwareFunctions.lua: "..tostring(swCompileErr))
end
local SWFunctions = swChunk()
if type(SWFunctions) ~= "table" or type(SWFunctions.GlobaliseObject) ~= "function" then
	error("libraries/SilentwareFunctions.lua returned invalid data")
end
--pload('libraries/SilentwareFunctions.lua', true, true)
SWFunctions.GlobaliseObject("SilentwareFunctions", SWFunctions)
SWFunctions.GlobaliseObject("SWFunctions", SWFunctions)

local function loadSilentwareAccess()
	local fallback = {
		Tier = 'free',
		Level = 0,
		Reason = 'Access library unavailable; using free tier.',
		Levels = {free = 0, standard = 1, premium = 2, beta = 3, admin = 4},
		DisplayNames = {free = 'Free', standard = 'Standard', premium = 'Premium', beta = 'Beta', admin = 'Admin'},
		CanUseModule = function(self, category, moduleName)
			local required = ({Combat = 'standard', Blatant = 'premium', Render = 'free', Utility = 'free', World = 'standard', Misc = 'free', Inventory = 'standard', Minigames = 'standard', Legit = 'free'})[category] or 'free'
			local levels = self.Levels
			return (self.Level or 0) >= (levels[required] or 0), required, levels[required] or 0
		end,
		CheckKey = function(self) return self end,
		AdminLogin = function() return false, 'Access library unavailable.' end,
		GrantKey = function() return false, 'Access library unavailable.' end,
		RevokeKey = function() return false, 'Access library unavailable.' end,
		SetUserTier = function() return false, 'Access library unavailable.' end
	}
	local source
	local ok, err = pcall(function()
		source = fetchSilentwareFile('libraries/access.lua')
	end)
	if not ok or type(source) ~= 'string' then
		shared.SilentwareAccess = fallback
		return fallback
	end
	local chunk, compileErr = loadstring(source)
	if type(chunk) ~= 'function' then
		warn('Failed to compile libraries/access.lua: '..tostring(compileErr))
		shared.SilentwareAccess = fallback
		return fallback
	end
	local ran, access = pcall(chunk)
	if not ran or type(access) ~= 'table' then
		warn('Failed to run libraries/access.lua: '..tostring(access))
		shared.SilentwareAccess = fallback
		return fallback
	end
	if type(access.Check) == 'function' then
		local checked, checkErr = pcall(function()
			access:Check()
		end)
		if not checked then warn('Silentware access check failed: '..tostring(checkErr)) end
	end
	shared.SilentwareAccess = access
	if access.Blocked then
		error('Silentware access blocked: '..tostring(access.Reason or 'access denied'), 0)
	end
	return access
end

local SilentwareAccess = loadSilentwareAccess()
SWFunctions.GlobaliseObject('SilentwareAccess', SilentwareAccess)

vape = pload('guis/'..gui..'.lua', true, true)
if type(vape) ~= "table" or type(vape.Load) ~= "function" then
	error("guis/new.lua failed to load a valid GUI object")
end
shared.vape = vape
getgenv().vape = vape
getgenv().GuiLibrary = vape
shared.GuiLibrary = vape
shared.VapeExecuted = true

getgenv().InfoNotification = function(title, msg, dur)
	--warn('info', tostring(title), tostring(msg), tostring(dur))
	vape:CreateNotification(title, msg, dur)
end
getgenv().warningNotification = function(title, msg, dur)
	--warn('warn', tostring(title), tostring(msg), tostring(dur))
	vape:CreateNotification(title, msg, dur, 'warning')
end
getgenv().errorNotification = function(title, msg, dur)
	--warn("error", tostring(title), tostring(msg), tostring(dur))
	vape:CreateNotification(title, msg, dur, 'alert')
end
if shared.CheatEngineMode then
	InfoNotification("Silentware | CheatEngineMode", "Due to your executor not supporting some functions \n some modules might be missing!", 5) 
end
local bedwarsID = {
	game = {6872274481, 8444591321, 8560631822},
	lobby = {6872265039}
}
local InkGameID = {
	main = {99567941238278, 125009265613167}
}
if not shared.VapeIndependent then
	isInkGame = table.find(InkGameID.main, game.PlaceId)
	if not isInkGame then
		pload('games/universal.lua', true)
		if not shared.NoSilentwareModules then
			pload('games/SWUniversal.lua', true)
		end
	end
	local fileName1 = game.PlaceId..".lua"
	local fileName2 = game.PlaceId..".lua"
	--local fileName3
	local isGame = table.find(bedwarsID.game, game.PlaceId)
	local isLobby = table.find(bedwarsID.lobby, game.PlaceId)
	local CE = shared.CheatEngineMode and "CE" or ""
	if isGame then
		if game.PlaceId ~= 6872274481 then vape.Place = 6872274481 end
		fileName1 = CE.."6872274481.lua"
		fileName2 = "SW6872274481.lua"
	end
	if isLobby then
		fileName1 = CE.."6872265039.lua"
		fileName2 = "SW6872265039.lua"
	end
	if not (isGame or isLobby) then fileName2 = "SW"..fileName2 end
	if isInkGame then
		vape.Place = 99567941238278
		pload('games/99567941238278.lua')
	else
		warn("[CheatEngineMode]: ", tostring(shared.CheatEngineMode))
		warn("[TestingMode]: ", tostring(shared.TestingMode))
		warn("[FileName1]: ", tostring(fileName1), " [FileName2]: ", tostring(fileName2), " [FileName3]: ", tostring(fileName3))

		pload('games/'..tostring(fileName1))
		if not shared.NoSilentwareModules then
			pload('games/'..tostring(fileName2))
		end
	end
	finishLoading()
else
	vape.Init = finishLoading
	return vape
end
