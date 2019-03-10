local hotkeys_popup = require("awful.hotkeys_popup.widget")
local urxvt_rule_any = {class={"URxvt", "urxvt"}}
for group_name, group_data in pairs({
		["URxvt"] = { color="#659FdF", rule_any=urxvt_rule_any },
		["ZSH"]   = { color="#cF4F40", rule_any=urxvt_rule_any }
	}) do
	hotkeys_popup.group_rules[group_name] = group_data
end

local urxvt_keys = {
	["URxvt"] = {
		{
			modifiers = { "Mod1" },
			keys = {
				c = "copy",
				v = "Paste"
			}
		},
		{
			modifiers = {"Mod1", "Shift"},
			keys = {
				v = "Paste escaped"
			}
		}
	},
	["ZSH"] = {
		{
			modifiers = {},
			keys = {
				Home   = "Beginning of line",
				End    = "End of line",
				Insert = "Overwrite mode",
				Delete = "Delete char",
				Left   = "Backward char",
				Right  = "Forward char",
				Prior  = "Beginning of buffer or history",
				Next   = "End of buffer or history",
			}
		},
		{
			modifiers = { "Mod1" },
			keys = {
				Down  = "Beginning of line",
				Up    = "End of line",
				Left  = "Backward word",
				Right = "Forward word"
			}
		},
		{
			modifiers = { "Control" },
			keys = {
				k = "Kill whole line",
				l = "clear screen"
			}
		}
	}
}

hotkeys_popup.add_hotkeys(urxvt_keys)

-- vim: tabstop=3 noexpandtab shiftwidth=3 softtabstop=3
