#!/bin/bash
# PORTMASTER: blues.brothers.zip, Blues Brothers.sh

XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

if [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
elif [ -d "$XDG_DATA_HOME/PortMaster/" ]; then
  controlfolder="$XDG_DATA_HOME/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi

source $controlfolder/control.txt

get_controls

GAMEDIR="/$directory/ports/bluesbrothers/"
cd $GAMEDIR

$ESUDO chmod 666 /dev/tty1
$GPTOKEYB "blues" &
SDL_GAMECONTROLLERCONFIG="$sdl_controllerconfig" LD_LIBRARY_PATH="$GAMEDIR/libs":LD_LIBRARY_PATH ./blues --fullscreen --filter=nearest --datapath="$GAMEDIR/gamedata" 2>&1 | tee $GAMEDIR/log.txt
$ESUDO kill -9 $(pidof oga_controls)
$ESUDO systemctl restart oga_events &
printf "\033c" > /dev/tty1

