-- replicated convars have to be created on both client and server
CreateConVar("ttt2_simp_reveal_mode", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})

hook.Add("TTTUlxDynamicRCVars", "TTTUlxDynamicStreamCVars", function(tbl)
	tbl[ROLE_STREAMER] = tbl[ROLE_STREAMER] or {}

	table.insert(tbl[ROLE_STREAMER], {
		cvar = "ttt2_simp_reveal_mode",
		combobox = true,
		desc = "How should simp reveals happen? (Def: 1)",
		choices = {
			"0 - Not Revealed",
			"1 - Revealed to Streamer Team",
			"2 - Revealed to All (Without Player Specifics)",
			"3 - Revealed to All (Including Player)"
		},
		numStart = 0
	})
end)