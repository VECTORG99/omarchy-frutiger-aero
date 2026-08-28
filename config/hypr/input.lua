-- Control your input devices.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
-- NOTE: kb_layout and kb_variant are intentionally commented out to preserve user's existing keyboard layout.
-- Uncomment and set your preferred layout (e.g., "us", "latam", "de", "fr", "gb").
hl.config({
	input = {
		-- kb_layout = "us",
		-- kb_variant = "intl",

		kb_options = "compose:caps", -- ,grp:alts_toggle

		-- Change speed of keyboard repeat.
		repeat_rate = 40,
		repeat_delay = 250,

		-- Start with numlock on by default.
		numlock_by_default = true,

		-- No mouse acceleration: 1:1 pointer-to-motion mapping. The Hyprland
		-- default (adaptive) ramps cursor speed with mouse velocity, which
		-- feels like unstable sensitivity. Flat keeps it predictable.
		accel_profile = "flat",

		-- Sensitivity 0 (default). Set explicitly so future edits don't
		-- silently drift from the repo standard.
		sensitivity = 0,

		touchpad = {
			-- Use natural (inverse) scrolling.
			-- natural_scroll = true,

			-- Use two-finger clicks for right-click instead of lower-right corner.
			clickfinger_behavior = true,

			-- Control the speed of your scrolling.
			scroll_factor = 0.4,

			-- Enable the touchpad while typing.
			-- disable_while_typing = false,

			-- Left-click-and-drag with three fingers.
			-- drag_3fg = 1,
		},
	},
})

-- Scroll nicely in the terminal.
o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })

-- Enable touchpad gestures for changing workspaces.
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
-- hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Enable touchpad gestures for moving focus (helpful on scrolling layout).
-- hl.gesture({ fingers = 3, direction = "left", action = function() hl.dispatch(hl.dsp.focus({ direction = "l" })) end })
-- hl.gesture({ fingers = 3, direction = "right", action = function() hl.dispatch(hl.dsp.focus({ direction = "r" })) end })