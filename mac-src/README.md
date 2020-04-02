# Not Paradox Launcher for MAC OS

This app was designed to replace the Paradox Launcher recently added in Cities: Skylines.
It might or might not work with other games from Paradox.

If you have other games from Paradox Interactive installed, make a backup for the file "**launcherpath**", located in "~/Library/Preferences/Paradox Interactive/" before starting this launcher.

## What's it for

The app was designed for Cities: Skylines (Steam) but it should work with all Paradox Interactive games that use their launcher (untested)  
The source code here is for the Mac version of the launcher (compiled with Lazarus 2.0.6, FPC 3) 
Steam Overlay is working!

## Features

- Fast startup with low memory usage (unlike Paradox Launcher that has a Chromium browser embedded)
- Automatically start the game instead of having to hit another play button
- Automatically closes after starting the game freeing up used memory (unlike remaining active in the background)
- No data collection, no ads, no advertisements, no constant communications with remote servers
- Option to automatically load last save game
- Option to force a specific window mode (windowed / borderless window / fullscreen)
- Option to force Open GL (useful if you have problems)
- Option to limit FPS
- Option to disable game log files (increases load speed but errors can't be easily identified if they occur)
- Option to disable Steam Workshop and/or mods
- Option to specify any other launch options you might need

## Installation

- download the latest release from the **Releases** page
- Extract the application bundle and move it to a location of your choosing
- Start **Not Paradox Launcher** app once to set it up
- Start the game from Steam as usual

## Uninstall

- delete the app **Not Paradox Launcher**
- delete the file **launcherpath** from "~/Library/Preferences/Paradox Interactive/"
