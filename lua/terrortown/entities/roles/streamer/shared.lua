if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_stream.vmt")
end

roles.InitCustomTeam(ROLE.name, {
	icon = "vgui/ttt/dynamic/roles/icon_stream",
	color = Color(153, 0, 153, 255)
})

function ROLE:PreInitialize()
	self.color = Color(153, 0, 153, 255)

	self.abbr = "stream" -- abbreviation
	self.radarColor = Color(153, 0, 153) -- color if someone is using the radar
	self.surviveBonus = 2 -- bonus multiplier for every survive while another player was killed
	self.scoreKillsMultiplier = 3 -- multiplier for kill of player of another team
	self.scoreTeamKillsMultiplier = -8 -- multiplier for teamkill
	self.preventWin = false -- set true if role can't win (maybe because of own / special win conditions)
	self.defaultTeam = TEAM_STREAMER -- the team name: roles with same team name are working together
	self.defaultEquipment = SPECIAL_EQUIPMENT -- here you can set up your own default equipment
	self.isOmniscientRole = true -- can see if ppl are MIA

	self.conVarData = {
		pct = 0.15, -- necessary: percentage of getting this role selected (per player)
		maximum = 1, -- maximum amount of roles in a round
		minPlayers = 6, -- minimum amount of players until this role is able to get selected
		random = 30,
		credits = 1, -- the starting credits of a specific role
		togglable = true, -- option to toggle a role for a client if possible (F1 menu)
		shopFallback = SHOP_DISABLED,
	}
end

if SERVER then

	hook.Add("PlayerDroppedWeapon", "SetLastOwner", function(ply, wep)
  		if not IsValid(ply) or not IsValid(wep) then return end

  		wep.lastOwner = ply
	end)

	hook.Add("WeaponEquip", "StreamerItemEquip", function(weapon, ply)
		-- set simp role to the weapon giver
		if (ply:GetSubRole() == ROLE_STREAMER) then
		    local role = ROLE_SIMP
		    local team = TEAM_STREAMER
		    local donator = weapon.lastOwner

		    print("Streamer has picked up a " .. tostring(weapon) .. " dropped by " .. tostring(donator) .. " who has this team " .. tostring(team))

		    if (donator:GetSubRole() == ROLE_STREAMER or not donator:Alive() or not donator:IsPlayer()) then return end --skip if streamer picks up a weapon

		    events.Trigger(EVENT_NEW_SIMP,ply,donator)
		    donator:SetRole(role, team) -- added the team parameter mainly for the Jackal right now
		    SendFullStateUpdate()
		    donator:UpdateTeam(team) 
		    donator:PrintMessage(HUD_PRINTTALK, "You are now a SIMP for " .. ply:Nick() .. " on team Streamer.")
		    donator:PrintMessage(HUD_PRINTCENTER, "You are now a SIMP for " .. ply:Nick() .. " on team Streamer.")
		    timer.Simple(0.5, function() SendFullStateUpdate() end)
		        
		    local mode = GetConVar("ttt2_simp_reveal_mode"):GetInt()
		    local players = player.GetAll()

		    if mode ~= 0 then --if mode 0 reveal to no one
				for i = 1, #players do
					local v = players[i]
			        if (mode == 1 and v:GetTeam() == TEAM_STREAMER) then --reveal to streamer team only

			        	v:PrintMessage(HUD_PRINTTALK, donator:Nick() .. " is SIMPING for " .. ply:Nick())
			            v:PrintMessage(HUD_PRINTCENTER, donator:Nick() .. " is SIMPING for " .. ply:Nick())

			        elseif (mode == 2) then --reveal to everyone (No specifics)

			            v:PrintMessage(HUD_PRINTTALK, "The Streamer has a new SIMP!")
			            v:PrintMessage(HUD_PRINTCENTER, "The Streamer has a new SIMP!")

			        elseif (mode == 3) then --reveal to everyone (with specifics)

			        	v:PrintMessage(HUD_PRINTTALK, donator:Nick() .. " is a SIMP!")
			            v:PrintMessage(HUD_PRINTCENTER, donator:Nick() .. " is a SIMP!")

			        end
			    end
		    end
		end
	end)
end

if CLIENT then
  function ROLE:AddToSettingsMenu(parent)
    local form = vgui.CreateTTT2Form(parent, "header_roles_additional")

    form:MakeComboBox({
    	serverConvar = "ttt2_simp_reveal_mode",
    	label = "How should simp reveals happen? (Def: 1)",
    	choices = {
			"0 - Not Revealed",
			"1 - Revealed to Streamer Team",
			"2 - Revealed to All (Without Player Specifics)",
			"3 - Revealed to All (Including Player)"
		},
		numStart = 0
    })

  end
end