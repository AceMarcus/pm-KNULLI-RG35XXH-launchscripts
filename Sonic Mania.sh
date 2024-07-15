#!/bin/bash
# PORTMASTER: sonic.mania.zip, Sonic Mania.sh

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

$ESUDO chmod 666 /dev/tty1

GAMEDIR="/$directory/ports/sonicmania"
cd $GAMEDIR

$GPTOKEYB "RSDKv5" &
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$GAMEDIR/libs" SDL_GAMECONTROLLERCONFIG="$sdl_controllerconfig" ./RSDKv5 2>&1 | tee $GAMEDIR/log.txt
$ESUDO kill -9 $(pidof gptokeyb)
$ESUDO systemctl restart oga_events &
printf "\033c" > /dev/tty1

