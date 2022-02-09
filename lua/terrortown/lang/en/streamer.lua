local L = LANG.GetLanguageTableReference("en")

-- GENERAL ROLE LANGUAGE STRINGS
L[STREAMER.name] = "Streamer"
L[STREAMER.defaultTeam] = "Team Streamer"
L["hilite_win_" .. STREAMER.defaultTeam] = "THE STREAMER WON!"
L["win_" .. STREAMER.defaultTeam] = "The Streamer has won!"
L["info_popup_" .. STREAMER.name] = [[You are the Streamer, now go get some items from Simps who worship you!]]
L["body_found_" .. STREAMER.abbr] = "They were a streamer. F in chat."
L["search_role_" .. STREAMER.abbr] = "This person was a streamer."
L["target_" .. STREAMER.name] = "Streamer"
L["ttt2_desc_" .. STREAMER.name] = [[The Streamer is on their own team! You can convert others into Simps if they give you items. You must win with your Simps.]]

-- OTHER ROLE LANGUAGE STRINGS
L["title_event_new_simp"] = "New SIMP"
L["desc_event_new_simp"] = "{simp} ({irole} / {iteam}) is SIMPing for {streamer}!"