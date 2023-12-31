local wezterm = require("wezterm")
local mux = wezterm.mux
function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "tokyonight-night"
	else
		return "Gruvbox (Gogh)"
	end
end

function return_bg_image(appearance)
	if appearance:find("Dark") then
		return "/Users/inust/Downloads/cyberpunk.jpeg"
	else
		return "/Users/inust/Downloads/snowtown.jpeg"
	end
end

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- wezterm.on('gui-startup', function()
--   local project_dir = wezterm.home_dir .. '~/CLionProjects/momenti-core'
--    local tab, main_pane, window = mux.spawn_window {
--     cwd = project_dir,
--   }
--   local nnn_pane = main_pane:split {
--     direction = 'Right',
--     cwd = project_dir,
-- 		size = 0.3
--   }
--   nnn_pane:send_text 'nnn \n'
--   -- NOTE: '\n' will execute the command, otherwise it will be only pasted
--    local lazygit_pane = nnn_pane:split {
--     direction = 'Bottom',
--     cwd = project_dir,
-- 		size = 0.5
--   }
--   lazygit_pane:send_text 'lazygit \n'
-- end)

local selected_scheme = "tokyonight"
local scheme = wezterm.get_builtin_color_schemes()[selected_scheme]

local C_ACTIVE_BG = scheme.selection_bg
local C_ACTIVE_FG = scheme.ansi[6]
local C_BG = scheme.background
local C_HL_1 = scheme.ansi[5]
local C_HL_2 = scheme.ansi[4]
local C_INACTIVE_FG
local bg = wezterm.color.parse(scheme.background)
local h, s, l, a = bg:hsla()
if l > 0.5 then
	C_INACTIVE_FG = bg:complement_ryb():darken(0.3)
else
	C_INACTIVE_FG = bg:complement_ryb():lighten(0.3)
end

scheme.tab_bar = {
	background = C_BG,
	new_tab = {
		bg_color = C_BG,
		fg_color = C_HL_2,
	},
	active_tab = {
		bg_color = C_ACTIVE_BG,
		fg_color = C_ACTIVE_FG,
	},
	inactive_tab = {
		bg_color = C_BG,
		fg_color = C_INACTIVE_FG,
	},
	inactive_tab_hover = {
		bg_color = C_BG,
		fg_color = C_INACTIVE_FG,
	},
}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	if tab.is_active then
		return {
			{ Foreground = { Color = C_HL_1 } },
			{ Text = " " .. tab.tab_index + 1 },
			{ Foreground = { Color = C_HL_2 } },
			{ Text = ": " },
			{ Foreground = { Color = C_ACTIVE_FG } },
			{ Text = tab.active_pane.title .. " " },
			{ Background = { Color = C_BG } },
			{ Foreground = { Color = C_HL_1 } },
			{ Text = "|" },
		}
	end
	return {
		{ Foreground = { Color = C_HL_1 } },
		{ Text = " " .. tab.tab_index + 1 },
		{ Foreground = { Color = C_HL_2 } },
		{ Text = ": " },
		{ Foreground = { Color = C_INACTIVE_FG } },
		{ Text = tab.active_pane.title .. " " },
		{ Foreground = { Color = C_HL_1 } },
		{ Text = "|" },
	}
end)

return {
	color_schemes = {
		[selected_scheme] = scheme,
	},
	color_scheme = selected_scheme,
	hide_tab_bar_if_only_one_tab = true,
	adjust_window_size_when_changing_font_size = false,
	selection_word_boundary = " \t\n{}[]()\"'`,;:│=&!%",
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	window_background_opacity = 1.0,
	text_background_opacity = 1.0,
	line_height = 1.3,
	font = wezterm.font_with_fallback({ "Berkeley Mono", { family = "Symbols Nerd Font", scale = 0.75 } }),
	window_frame = {
		-- The font used in the tab bar.
		-- Roboto Bold is the default; this font is bundled
		-- with wezterm.
		-- Whatever font is selected here, it will have the
		-- main font setting appended to it to pick up any
		-- fallback fonts you may have used there.
		font = wezterm.font({ family = "Roboto", weight = "Bold" }),

		-- The size of the font in the tab bar.
		-- Default to 10.0 on Windows but 12.0 on other systems
		font_size = 12.0,

		-- The overall background color of the tab bar when
		-- the window is focused
		active_titlebar_bg = "#FBF1C7",
		-- The overall background color of the tab bar when
		-- the window is not focused
		inactive_titlebar_bg = "#FBF1C7",
	},
	tab_max_width = 96,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,

	colors = {
		tab_bar = {
			-- The color of the inactive tab bar edge/divider
			inactive_tab_edge = "#FBF1C7",
		},
	},
}
