local httpService = game:GetService('HttpService')
local playersService = game:GetService('Players')
local starterGui = game:GetService('StarterGui')

local requestFunction = (syn and syn.request) or http_request or request or (fluxus and fluxus.request)
local lplr = playersService.LocalPlayer

local ACCESS = {
	Version = 'v1',
	Tier = 'free',
	Level = 0,
	Key = nil,
	Reason = 'Free access',
	Blocked = false,
	Checked = false,
	AdminAuthed = false,
	AdminKey = nil,
	Levels = {
		free = 0,
		standard = 1,
		premium = 2,
		beta = 3,
		admin = 4
	},
	DisplayNames = {
		free = 'Free',
		standard = 'Standard',
		premium = 'Premium',
		beta = 'Beta',
		admin = 'Admin'
	},
	DefaultModuleTiers = {
		Combat = 'standard',
		Blatant = 'premium',
		Render = 'free',
		Utility = 'free',
		World = 'standard',
		Misc = 'free',
		Inventory = 'standard',
		Minigames = 'standard',
		Legit = 'free'
	},
	ModuleOverrides = {},
	Config = {
		WhitelistUrl = 'https://raw.githubusercontent.com/VapeSilentware/vapesilentware/main/profiles/access.json',
		CheckEndpoint = '',
		AdminEndpoint = '',
		ExecutionWebhook = '',
		AllowFreeFallback = true,
		RequireOfficialGithub = true,
		OfficialRepo = 'VapeSilentware/vapesilentware',
		OfficialBranch = 'main',
		LocalKeyFile = 'vape/SilentwareKey.txt'
	}
}

local function notify(title, text, duration)
	pcall(function()
		starterGui:SetCore('SendNotification', {
			Title = tostring(title),
			Text = tostring(text),
			Duration = duration or 8
		})
	end)
end

local function shallowMerge(base, extra)
	if type(extra) ~= 'table' then return base end
	for i, v in pairs(extra) do
		if type(v) == 'table' and type(base[i]) == 'table' then
			shallowMerge(base[i], v)
		else
			base[i] = v
		end
	end
	return base
end

local function decodeJson(raw)
	if type(raw) ~= 'string' or raw == '' then return nil end
	raw = raw:gsub('\239\187\191', '')
	local suc, decoded = pcall(function()
		return httpService:JSONDecode(raw)
	end)
	return suc and decoded or nil
end

local function encodeJson(tab)
	local suc, encoded = pcall(function()
		return httpService:JSONEncode(tab)
	end)
	return suc and encoded or '{}'
end

local function httpGet(url)
	if type(url) ~= 'string' or url == '' then return nil end
	local suc, res = pcall(function()
		return game:HttpGet(url, true)
	end)
	return suc and res or nil
end

local function httpPost(url, payload, headers)
	if type(url) ~= 'string' or url == '' or type(requestFunction) ~= 'function' then return nil end
	local suc, res = pcall(function()
		return requestFunction({
			Url = url,
			Method = 'POST',
			Headers = headers or {['Content-Type'] = 'application/json'},
			Body = type(payload) == 'string' and payload or encodeJson(payload)
		})
	end)
	if not suc or type(res) ~= 'table' then return nil end
	return res.Body or res.body or ''
end

local function getKeyFromDisk(path)
	path = path or ACCESS.Config.LocalKeyFile
	local suc, res = pcall(function()
		if isfile and isfile(path) then
			return readfile(path)
		end
	end)
	if not suc or type(res) ~= 'string' then return nil end
	res = res:gsub('%s+', '')
	return res ~= '' and res or nil
end

local function normaliseTier(tier)
	tier = string.lower(tostring(tier or 'free'))
	if not ACCESS.Levels[tier] then tier = 'free' end
	return tier, ACCESS.Levels[tier]
end

local function cleanString(value)
	value = tostring(value or '')
	value = value:gsub('^%s+', ''):gsub('%s+$', '')
	return value
end

local function applyResult(result, source)
	result = type(result) == 'table' and result or {}
	if result.config then
		ACCESS:Configure(result.config)
	end
	if result.blocked or result.banned or result.revoked then
		ACCESS.Blocked = true
		ACCESS.Reason = tostring(result.reason or result.message or 'This key or account has been revoked.')
		ACCESS.Tier, ACCESS.Level = normaliseTier('free')
		return ACCESS
	end
	local tier = result.tier or result.level or result.rank or result.version
	ACCESS.Tier, ACCESS.Level = normaliseTier(tier)
	ACCESS.Reason = tostring(result.reason or result.message or source or 'Access checked')
	ACCESS.Checked = true
	if result.moduleTiers and type(result.moduleTiers) == 'table' then
		ACCESS.DefaultModuleTiers = result.moduleTiers
	end
	if result.moduleOverrides and type(result.moduleOverrides) == 'table' then
		ACCESS.ModuleOverrides = result.moduleOverrides
	end
	return ACCESS
end

function ACCESS:Configure(config)
	shallowMerge(self.Config, config)
	if type(config) == 'table' then
		if type(config.defaultModuleTiers) == 'table' then self.DefaultModuleTiers = config.defaultModuleTiers end
		if type(config.moduleOverrides) == 'table' then self.ModuleOverrides = config.moduleOverrides end
	end
	return self
end

function ACCESS:GetStoredKey()
	local genvKey
	pcall(function()
		genvKey = getgenv and (getgenv().SilentwareKey or getgenv().SWKey)
	end)
	local key = shared.SilentwareKey or genvKey or getKeyFromDisk(self.Config.LocalKeyFile)
	key = type(key) == 'string' and key:gsub('%s+', '') or nil
	return key ~= '' and key or nil
end

function ACCESS:SaveKey(key)
	key = tostring(key or ''):gsub('%s+', '')
	self.Key = key ~= '' and key or nil
	shared.SilentwareKey = self.Key
	pcall(function()
		if writefile and self.Key then
			writefile(self.Config.LocalKeyFile, self.Key)
		end
	end)
	return self.Key
end

function ACCESS:CheckKey(key)
	key = key or self:GetStoredKey()
	if key then self:SaveKey(key) end
	local payload = {
		key = key,
		userId = lplr and lplr.UserId or 0,
		username = lplr and lplr.Name or 'unknown',
		displayName = lplr and lplr.DisplayName or 'unknown',
		placeId = game.PlaceId,
		jobId = game.JobId,
		version = self.Version
	}

	if self.Config.CheckEndpoint ~= '' then
		local response = httpPost(self.Config.CheckEndpoint, payload)
		local decoded = decodeJson(response)
		if decoded then
			return applyResult(decoded, 'Remote access API')
		end
	end

	local list = decodeJson(httpGet(self.Config.WhitelistUrl))
	if type(list) == 'table' then
		if list.config then self:Configure(list.config) end
		local userData = list.users and list.users[tostring(payload.userId)]
		local keyData = key and list.keys and list.keys[key]
		local revokedReason = key and list.revoked and list.revoked[key]
		if revokedReason then
			return applyResult({blocked = true, reason = tostring(revokedReason)}, 'Static whitelist')
		end
		if type(userData) == 'table' then
			return applyResult(userData, 'Static user whitelist')
		end
		if type(keyData) == 'table' then
			if keyData.expires and tonumber(keyData.expires) and os.time() > tonumber(keyData.expires) then
				return applyResult({blocked = true, reason = 'This key is expired.'}, 'Static key whitelist')
			end
			return applyResult(keyData, 'Static key whitelist')
		end
	end

	if self.Config.AllowFreeFallback then
		return applyResult({tier = 'free', reason = key and 'Key not found; using free tier.' or 'No key provided; using free tier.'}, 'Free fallback')
	end
	return applyResult({blocked = true, reason = 'No valid Silentware key was found.'}, 'Access required')
end

function ACCESS:Check()
	local result = self:CheckKey()
	self:SendExecutionWebhook('execute')
	if self.Blocked then
		notify('Silentware Access', self.Reason, 10)
	end
	return result
end

function ACCESS:GetRequiredTier(category, moduleName)
	if type(self.ModuleOverrides) == 'table' and self.ModuleOverrides[moduleName] then
		return normaliseTier(self.ModuleOverrides[moduleName])
	end
	if tostring(moduleName or ''):lower():find('beta') or tostring(moduleName or ''):lower():find('experimental') then
		return normaliseTier('beta')
	end
	return normaliseTier(self.DefaultModuleTiers[category] or 'free')
end

function ACCESS:CanUseModule(category, moduleName)
	local tier, level = self:GetRequiredTier(category, moduleName)
	return self.Level >= level, tier, level
end

function ACCESS:GetTier()
	return self.Tier, self.Level
end

function ACCESS:HasTier(requiredTier)
	local _, requiredLevel = normaliseTier(requiredTier)
	return (self.Level or 0) >= (requiredLevel or 0), requiredLevel
end

function ACCESS:CanUseFeature(featureName, requiredTier)
	if type(self.ModuleOverrides) == 'table' and self.ModuleOverrides[featureName] then
		requiredTier = self.ModuleOverrides[featureName]
	end
	return self:HasTier(requiredTier or 'free')
end

function ACCESS:GetLockedReason(featureName, requiredTier)
	local allowed = self:CanUseFeature(featureName, requiredTier)
	if allowed then return nil end
	local tier = normaliseTier(requiredTier or 'free')
	return tostring(featureName or 'This feature')..' requires '..tostring(self.DisplayNames[tier] or tier)..' access.'
end

function ACCESS:RefreshAccess(key)
	return self:CheckKey(key or self:GetStoredKey())
end

function ACCESS:LogExecution(eventName)
	return self:SendExecutionWebhook(eventName or 'execute')
end

function ACCESS:SendExecutionWebhook(eventName)
	local url = self.Config.ExecutionWebhook or shared.SilentwareExecutionWebhook or ''
	if type(url) ~= 'string' or url == '' then return false, 'No webhook configured' end
	if not (url:find('https://discord.com/api/webhooks/', 1, true) or url:find('https://discordapp.com/api/webhooks/', 1, true)) then
		return false, 'Webhook URL is not a Discord webhook URL'
	end
	local body = {
		username = 'Silentware Access',
		embeds = {{
			title = 'Silentware execution',
			description = tostring(eventName or 'execute'),
			color = 4058507,
			fields = {
				{name = 'User', value = (lplr and (lplr.Name..' (`'..lplr.UserId..'`)') or 'unknown'), inline = true},
				{name = 'Tier', value = tostring(self.DisplayNames[self.Tier] or self.Tier), inline = true},
				{name = 'Place', value = tostring(game.PlaceId), inline = true},
				{name = 'Job', value = tostring(game.JobId ~= '' and game.JobId or 'private/unknown'), inline = false}
			}
		}}
	}
	local response = httpPost(url, body)
	return response ~= nil, response or 'request failed'
end

function ACCESS:AdminLogin(adminKey)
	adminKey = tostring(adminKey or '')
	if adminKey == '' then return false, 'Enter an admin key.' end
	if shared.SilentwareLocalAdminKey and adminKey == shared.SilentwareLocalAdminKey then
		self.AdminAuthed = true
		self.AdminKey = adminKey
		return true, 'Admin unlocked locally.'
	end
	if self.Config.AdminEndpoint == '' then
		return false, 'No admin endpoint is configured.'
	end
	local response = httpPost(self.Config.AdminEndpoint..'/verify', {adminKey = adminKey, userId = lplr and lplr.UserId or 0})
	local decoded = decodeJson(response)
	if decoded and decoded.ok then
		self.AdminAuthed = true
		self.AdminKey = adminKey
		return true, decoded.message or 'Admin unlocked.'
	end
	return false, decoded and (decoded.message or decoded.reason) or 'Admin verification failed.'
end

function ACCESS:AdminRequest(action, data)
	if not self.AdminAuthed then return false, 'Admin panel is locked.' end
	if self.Config.AdminEndpoint == '' then return false, 'No admin endpoint is configured.' end

	data = type(data) == 'table' and data or {}
	local payload = {
		action = cleanString(action),
		adminKey = self.AdminKey,
		actor = lplr and lplr.UserId or 0
	}

	-- The Cloudflare backend expects grant/revoke fields at the top level.
	-- Older v5 builds nested these under `data`, which made the backend see an empty target
	-- and return `target key must be at least 8 characters` even when the UI textbox was filled.
	for key, value in pairs(data) do
		payload[key] = value
	end
	payload.reason = cleanString(payload.reason or payload.note or 'admin action')
	payload.note = cleanString(payload.note or payload.reason)
	if payload.key and not payload.target then payload.target = payload.key end
	if payload.userId and not payload.target then payload.target = payload.userId end

	local response = httpPost(self.Config.AdminEndpoint, payload, {['Content-Type'] = 'application/json', ['Authorization'] = 'Bearer '..tostring(self.AdminKey or '')})
	local decoded = decodeJson(response)
	if decoded and decoded.ok then
		return true, decoded.message or 'Admin request completed.'
	end
	return false, decoded and (decoded.message or decoded.reason) or 'Admin request failed.'
end

function ACCESS:GrantKey(targetKey, tier, note)
	targetKey = cleanString(targetKey)
	tier = normaliseTier(tier)
	if #targetKey < 8 then return false, 'Target key must be at least 8 characters.' end
	return self:AdminRequest('grantKey', {target = targetKey, key = targetKey, tier = tier, reason = note, note = note})
end

function ACCESS:RevokeKey(targetKey, reason)
	targetKey = cleanString(targetKey)
	if #targetKey < 8 then return false, 'Target key must be at least 8 characters.' end
	return self:AdminRequest('revokeKey', {target = targetKey, key = targetKey, reason = reason, note = reason})
end

function ACCESS:SetUserTier(userId, tier, note)
	userId = cleanString(userId)
	tier = normaliseTier(tier)
	if userId == '' then return false, 'Enter a Roblox user id.' end
	return self:AdminRequest('setUserTier', {target = userId, userId = userId, robloxUserId = userId, tier = tier, reason = note, note = note})
end

ACCESS:Configure(shared.SilentwareAccessConfig or {})
shared.SilentwareAccess = ACCESS
return ACCESS
