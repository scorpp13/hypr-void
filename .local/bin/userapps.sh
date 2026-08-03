#!/usr/bin/bash

gum style \
	--foreground 7 --border-foreground 7 --border rounded --bold \
	--align center --width 35 --margin "0 2" --padding "1 0" \
	'U S E R   D E F I N E D   A P P S'

echo ""

my_browser=$BROWSER
my_gui_fm=$GUI_FM
my_terminal=$TERMINAL
my_cli_fm=$CLI_FM
my_mediaplayer=$MEDIAPLAYER
my_volume_control=$VOLUME_CONTROL

if gum confirm "Choose your Browser"; then
browser="$(gum input --value="" --placeholder="Default is $BROWSER" \
--placeholder.foreground="8")"
	if [[ ! $browser ]]; then
		my_browser=$BROWSER
		else my_browser=$browser
	fi
	else my_browser=$BROWSER
fi
sb=$(gum style --foreground 2 --faint "Your selected browser is ")
mb=$(gum style --foreground 10 --bold "$my_browser")
gum join --horizontal "$sb" "$mb"

if gum confirm "Choose your gui-FileManager"; then
gui_fm="$(gum input --value="" --placeholder="Default is $GUI_FM" \
--placeholder.foreground="8")"
	if [[ ! $gui_fm ]]; then
		my_gui_fm=$GUI_FM
		else my_gui_fm=$gui_fm
	fi
	else my_gui_fm=$GUI_FM
fi
sgf=$(gum style --foreground 2 --faint "Your selected gui-FileManager is ")
mgf=$(gum style --foreground 10 --bold "$my_gui_fm")
gum join --horizontal "$sgf" "$mgf"

if gum confirm "Choose your Terminal"; then
terminal="$(gum input --value="" --placeholder="Default is $TERMINAL" \
--placeholder.foreground="8")"
	if [[ ! $terminal ]]; then
		my_terminal=$TERMINAL
		else my_terminal=$terminal
	fi
	else my_terminal=$TERMINAL
fi
st=$(gum style --foreground 2 --faint "Your selected Terminal is ")
mt=$(gum style --foreground 10 --bold "$my_terminal")
gum join --horizontal "$st" "$mt"

if gum confirm "Choose your cli-FileManager"; then
cli_fm="$(gum input --value="" --placeholder="Default is $CLI_FM" \
--placeholder.foreground="8")"
	if [[ ! $cli_fm ]]; then
		my_cli_fm=$CLI_FM
		else my_cli_fm=$cli_fm
	fi
	else my_cli_fm=$CLI_FM
fi
scf=$(gum style --foreground 2 --faint "Your selected cli-FileManager is ")
mcf=$(gum style --foreground 10 --bold "$my_cli_fm")
gum join --horizontal "$scf" "$mcf"

if gum confirm "Choose your MediaPlayer"; then
mediaplayer="$(gum input --value="" --placeholder="Default is $MEDIAPLAYER" \
--placeholder.foreground="8")"
	if [[ ! $mediaplayer ]]; then
		my_mediaplayer=$MEDIAPLAYER
		else my_mediaplayer=$mediaplayer
	fi
	else my_mediaplayer=$MEDIAPLAYER
fi
sm=$(gum style --foreground 2 --faint "Your selected MediaPlayer is ")
mm=$(gum style --foreground 10 --bold "$my_mediaplayer")
gum join --horizontal "$sm" "$mm"

if gum confirm "Choose your Volume Control"; then
volume_control="$(gum input --value="" --placeholder="Default is $VOLUME_CONTROL" \
--placeholder.foreground="8")"
	if [[ ! $volume_control ]]; then
		my_volume_control=$VOLUME_CONTROL
		else my_volume_control=$volume_control
	fi
	else my_volume_control=$VOLUME_CONTROL
fi
svc=$(gum style --foreground 2 --faint "Your selected Volume Control is ")
mvc=$(gum style --foreground 10 --bold "$my_volume_control")
gum join --horizontal "$svc" "$mvc"

echo ""

if gum confirm --prompt.foreground="11" \
	"Confirm assigning the choosed apps as environment variables"; then
	gum spin -- sleep 0.5 --

cat > "$HOME"/.config/hypr/conf/userapps.lua<< EOF
hl.env("BROWSER", "$my_browser")
hl.env("GUI_FM", "$my_gui_fm")
hl.env("TERMINAL", "$my_terminal")
hl.env("CLI_FM", "$my_cli_fm")
hl.env("MEDIAPLAYER", "$my_mediaplayer")
hl.env("VOLUME_CONTROL", "$my_volume_control")
EOF

	elif [ $? -eq 130 ]; then
		exit 130
	else exit;
fi

hyprctl reload
hyprctl dispatch "hl.dsp.exec_cmd('~/.config/waybar/launch.sh')"
notify-send "Your preffered apps assigned as environment variables"
