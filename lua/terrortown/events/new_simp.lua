if CLIENT then
	EVENT.icon = Material("vgui/ttt/vskin/events/new_simp")
	EVENT.title = "title_event_new_simp"

	function EVENT:GetText()
		return {
			{
				string = "desc_event_new_simp",
				params = {
					streamer = self.event.streamer.nick,
					simp = self.event.simp.nick,
					irole = roles.GetByIndex(self.event.simp.role).name,
					iteam = self.event.simp.team,
				},
				translateParams = true
			}
		}
	end
end

if SERVER then
	function EVENT:Trigger(streamer, simp)
		self:AddAffectedPlayers(
			{streamer:SteamID64(), simp:SteamID64()},
			{streamer:Nick(), simp:Nick()}
		)

		return self:Add({
			streamer = {
				nick = streamer:Nick(),
				sid64 = streamer:SteamID64()
			},
			simp = {
				nick = simp:Nick(),
				sid64 = simp:SteamID64(),
				role = simp:GetSubRole(),
				team = simp:GetTeam(),
			}
		})
	end

	function EVENT:CalculateScore()
		local event = self.event

		self:SetPlayerScore(event.streamer.sid64, {
			score = 1
		})
	end
end

function EVENT:Serialize()
	return self.event.flood.nick .. " has infected " .. self.event.infected.nick .. "."
end
