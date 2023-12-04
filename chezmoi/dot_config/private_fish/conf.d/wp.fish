function wp
	cp "$WALLPAPER"/wallpaper$argv "$WALLPAPER"/current
	nohup swaybg -m fill -i "$WALLPAPER"/current &
	sudo cp "$WALLPAPER"/current /usr/share/sddm/themes/sugar-dark/current
end
