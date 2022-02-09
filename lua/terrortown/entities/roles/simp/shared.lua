if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_simp.vmt")
end

function ROLE:PreInitialize()
	self.color = Color(255, 51, 255, 255)

	self.abbr = "simp" -- abbreviation
	self.radarColor = Color(255, 51, 255) -- color if someone is using the radar
	self.surviveBonus = 2 -- bonus multiplier for every survive while another player was killed
	self.scoreKillsMultiplier = 3 -- multiplier for kill of player of another team
	self.scoreTeamKillsMultiplier = -8 -- multiplier for teamkill
	self.preventWin = false -- set true if role can't win (maybe because of own / special win conditions)
	self.defaultTeam = TEAM_STREAMER -- the team name: roles with same team name are working together
	self.defaultEquipment = SPECIAL_EQUIPMENT -- here you can set up your own default equipment
	self.isOmniscientRole = true -- can see if ppl are MIA
	self.notSelectable = true -- role doesn't start in the game

	self.conVarData = {
		pct = 0.15, -- necessary: percentage of getting this role selected (per player)
		maximum = 1, -- maximum amount of roles in a round
		minPlayers = 5, -- minimum amount of players until this role is able to get selected
		random = 30,
		credits = 1, -- the starting credits of a specific role
		togglable = true, -- option to toggle a role for a client if possible (F1 menu)
		shopFallback = SHOP_DISABLED,
	}
end