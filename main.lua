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
		vape:CreateNotification('Vape', 'Failed to load : '..err, 30, 'alert')
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

local swRepo = tostring(shared.SilentwareRepo or "VapeSilentware/vapesilentware")
local swBranch = tostring(shared.CustomCommit or shared.SilentwareBranch or "main")
local function fetchSilentwareFile(path)
	local repos = {swRepo, "VapeSilentware/vapesilentware", "VapeSilentware/SWRewrite"}
	local branches = {swBranch, "main"}
	for _, branch in ipairs(branches) do
		for _, repo in ipairs(repos) do
			local suc, res = pcall(function()
				return game:HttpGet("https://raw.githubusercontent.com/"..repo.."/"..branch.."/"..path, true)
			end)
			if suc and res and res ~= "404: Not Found" then
				return res
			end
		end
	end
	error("Failed to fetch "..tostring(path))
end
local swChunk, swCompileErr = loadstring(fetchSilentwareFile("libraries/SilentwareFunctions.lua"))
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

vape = pload('guis/'..gui..'.lua', true, true)
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
