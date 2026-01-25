local wezterm = require("wezterm")
local config = {}

-- フォント
config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })
config.font_size = 13.0

-- カラースキーム
config.color_scheme = "Tokyo Night"

-- ウィンドウ設定
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 4,
	right = 4,
	top = 4,
	bottom = 4,
}
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()

	-- 画面サイズを取得
	local screen = wezterm.gui.screens().active
	local width = screen.width
	local height = screen.height - 300 -- 下部に300pxの余白

	-- ウィンドウサイズと位置を設定
	gui_window:set_position(0, 0) -- 左上に配置
	gui_window:set_inner_size(width, height)
end)

-- タブバー
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.colors = {
	tab_bar = {
		-- アクティブなタブの色（目立つ色に）
		active_tab = {
			bg_color = "#2b2042",
			fg_color = "#c0caf5",
			intensity = "Bold",
		},
		-- 非アクティブなタブの色
		inactive_tab = {
			bg_color = "#1a1b26",
			fg_color = "#a9b1d6",
		},
	},
	-- 選択範囲の色を見やすくする
	selection_bg = "#364a82",
	selection_fg = "#c0caf5",
}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	-- paneの現在のディレクトリ情報を取得
	local cwd_uri = tab.active_pane.current_working_dir
	local title = ""

	if cwd_uri then
		-- "file://hostname/path/to/dir" という形式で来るので、パス部分のみ抽出
		local path = cwd_uri.file_path
		-- パスの最後のディレクトリ名だけを取得
		title = path:gsub("(.*[/\\])(.*)", "%2")

		-- もしルート直下などで空になった場合はパス全体を表示
		if title == "" then
			title = path
		end
	else
		-- ディレクトリが取得できない場合は、プロセス名やデフォルトのタイトルを使用
		title = tab.active_pane.title
	end

	-- アクティブなタブと非アクティブなタブで見た目を変える
	if tab.is_active then
		return {
			{ Background = { Color = "#7aa2f7" } },
			{ Foreground = { Color = "#1f2335" } },
			{ Text = " " .. title .. " " },
		}
	end

	return " " .. title .. " "
end)

-- スクロールバック
config.scrollback_lines = 10000

-- 透明
config.window_background_opacity = 0.85

-- キーバインド
config.keys = {
	-- タブ移動(Cmd+[ / Cmd+])
	{ key = "[", mods = "CMD", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "]", mods = "CMD", action = wezterm.action.ActivateTabRelative(1) },

	-- ペイン分割(Cmd+D / Cmd+Shift+D)
	{ key = "d", mods = "CMD", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "d", mods = "CMD|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- ペイン移動(Cmd+Shift+Arrow)
	{ key = "LeftArrow", mods = "CMD|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "CMD|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "CMD|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "CMD|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },

	-- ペインクローズ(Cmd+w)
	{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
}

-- パフォーマンス
config.front_end = "WebGpu"
config.max_fps = 120

return config
