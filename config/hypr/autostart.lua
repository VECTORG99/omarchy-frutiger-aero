-- Extra autostart processes.
-- Vista startup chime — only plays if the .wav file exists (not included in repo, see issue #11)
o.exec_on_start("sleep 2 && [ -f ~/.config/omarchy/sounds/vista-startup.wav ] && paplay --volume=45000 ~/.config/omarchy/sounds/vista-startup.wav || true")
o.exec_on_start("sleep 3 && bash ~/.config/eww/scripts/eww-theme.sh auto && ~/.local/bin/eww daemon")
-- Restore saved inactive_opacity value (issue #6)
o.exec_on_start("sleep 1 && bash ~/.config/eww/scripts/opacity.sh apply")
