# Mod Config Menu Pure

<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD051 -->

## Introduction

Mod Config Menu Pure is a library for [The Binding of Isaac: Repentance](https://store.steampowered.com/app/1426300/The_Binding_of_Isaac_Repentance/) that allows other mods to have a settings menu.

You can find this library [on the Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2681875787).

Credit goes to piber20 for originally creating this library and Chifilly for updating it for Repentance.

This is a forked version of Mod Config Menu by Zamiel that removes all of the hacks that override internal Lua functionality, which causes problems with other things in the Isaac ecosystem. For this reason, it is called the "Pure" version.

As of [vanilla patch v1.7.9b](https://bindingofisaacrebirth.fandom.com/wiki/V1.7.9b), other version of Mod Config Menu will not work anymore, like [Mod Config Menu Continued](https://steamcommunity.com/workshop/filedetails/?id=2487535818), so it is recommended to use this version instead.

<br>

## Using Mod Config Menu for Players

If you are a player of Isaac mods, then using Mod Config Menu should be straightforward. The controls are as follows:

### Keyboard

- By default, you can open the menu by pressing L. (This keyboard binding is customizable from the "Mod Config Menu" sub-menu.) F10 will also always open the menu, which cannot be changed.
- Use the arrow keys or WASD keys to move around.
- E, space, or enter can be used to select an item.
- Esc, backspace, or Q can be used to go back.

### Controller

- By default, you can open the menu by pressing down the right control stick (i.e. R3). (This controller binding is customizable from the "Mod Config Menu" sub-menu.)
- Both control sticks can be used to move around.
- The "a" button can be used to select an item.
- The "b" button can be used to go back.

By default, there will be two sub-menus installed: "General" and "Mod Config Menu". If you have other mods installed, they may add additional menus.

<br>

## Using Mod Config Menu as a Mod Developer

In order to use Mod Config Menu Pure inside of your mod, do not use the `require` or `dofile` or `pcall` or `loadfile` functions. Rather, simply check to see if the global variable of `ModConfigMenu` exists, with something along the lines of:

```lua
local MOD_NAME = "My Mod"
local VERSION = "1.0.0"

local function setupMyModConfigMenuSettings()
  if ModConfigMenu == nil then
    return
  end

  ModConfigMenu.AddSpace(MOD_NAME, "Info")
  ModConfigMenu.AddText(MOD_NAME, "Info", function() return MOD_NAME end)
  ModConfigMenu.AddSpace(MOD_NAME, "Info")
  ModConfigMenu.AddText(MOD_NAME, "Info", function() return "Version " .. VERSION end)
end
```

For more information:

- See [the quick start guide](docs/quick-start.md).
- Also see [the API documentation](docs/api.md).

<br>

## Troubleshooting

Note that the "Pure" version of Mod Config Menu will not work properly if:

- You have subscribed to the "Pure" version and you subscribed to a different version at the same time, which will cause a conflict.
- You are subscribed to a mod that uses a standalone version of Mod Config Menu, which will cause a conflict.
- You are subscribed to a mod uses the `require` or `dofile` or `pcall` or `loadfile` functions to initialize or invoke Mod Config Menu.

<br>

## FAQ

### Does it work with Repentance?

Yes.

### Does it work with the latest version of Repentance?

Yes. In [version 1.7.9b](https://bindingofisaacrebirth.fandom.com/wiki/V1.7.9b), the `loadfile` function was removed from the game. But unlike other versions of Mod Config Menu, Mod Config Menu Pure does not use `loadfile` (or any other hacks), so this version continues to work as it did before.

### Does it work with Afterbirth+?

No, because it uses the Repentance-only API for getting the HUD offset.

### What do I do if Mod Config Menu Pure causes errors or otherwise does not seem to get loaded properly by a particular mod?

This is probably because the mod is using the `require` or `dofile` or `pcall` or `loadfile` functions to initialize or invoke Mod Config Menu. Contact the individual mod author to fix this and do not post a comment here.

### What do I do if Mod Config Menu Pure works properly to configure settings, but does not save the settings for future runs?

Mod Config Menu Pure is not responsible for saving the configuration data of other mods. Doing that is up to the other mods. Thus, if another mod's settings are not being properly saved, then you need to take that issue to the specific mod's developer.

### What is Mod Config Menu Continued?

The original version of Mod Config Menu was made by piber20. [Mod Config Menu Continued](https://steamcommunity.com/sharedfiles/filedetails/?id=2487535818) is an updated version made by Chifilly with the goal of making it work with the Repentance DLC and fixing some bugs. Mod Config Menu Pure is an updated version of Mod Config Menu Continued with the goal of fixing yet more bugs. Thus, Mod Config Menu Continued is not the same thing as Mod Config Menu Pure.

As of December 8, 2022, Mod Config Menu Continued no longer works with the latest version of the game, so you should use Mod Config Menu Pure instead.

### Should I subscribe to multiple versions of Mod Config Menu at the same time?

No. You should only subscribe to one specific version of Mod Config Menu at a time.

### How do I open Mod Config Menu?

See [the "Using Mod Config Menu for Players" section](#using-mod-config-menu-for-players) above.

If the default keyboard/controller bindings do not work, then it is possible you have previously remapped them to something else. In this case, you can use the F10 button on the keyboard, which will always open the menu. Then, you can configure the keyboard/controller bindings to the exact thing that you want.

### What do I do if saving settings for a mod does not work between game launches?

Mod Config Menu is not in charge of saving any data besides the ones in the "General" and "Mod Config Menu" pages. If an individual mod does not properly save its data, then you should contact the author of that mod.

### Does this have the same functionality (i.e. API) as the other versions of Mod Config Menu?

Yes. However, it might not work as a drop-in replacement for mods that use the `require` or `dofile` or `pcall` or `loadfile` functions to initialize or invoke Mod Config Menu. Another common issue is using deprecated properties like `ModConfigMenuOptionType.BOOLEAN` instead of `ModConfigMenu.OptionType.BOOLEAN`. If you are a mod author and you want to switch to the pure version, you should test everything thoroughly.

### What does it mean to "remove API overrides"?

The original version overwrote some of the Lua and Isaac API functions, such as `pcall` and `RequireMod`. This version does not overwrite any API functions.

### How do I tell what version of Mod Config Menu Pure I have?

There are 3 ways:

- You can see the version in the console.
- You can see the version in the game's "log.txt" file. (See the next section.)
- You can see the version at the top of the mod's Lua file. (See the next section.)

### Where is the game's "log.txt" file located?

By default, it is located at the following path:

```text
C:\Users\[username]\Documents\My Games\Binding of Isaac Repentance\log.txt
```

### Where is the Lua code for the mod located?

By default, it is located at the following path:

```text
C:\Program Files (x86)\Steam\steamapps\common\The Binding of Isaac Rebirth\mods\!!mod config menu_2681875787\scripts\modconfig.lua
```

### Where is the save data for the mod located?

By default, it is located at the following path:

```text
C:\Program Files (x86)\Steam\steamapps\common\The Binding of Isaac Rebirth\data\!!mod config menu\save#.dat
```

The `#` corresponds to the number of the save slot that you are playing on.

### How do I reset my Mod Config Menu settings?

You need to delete the save data file that corresponds to the Isaac save slot that you are on. See the previous section.

### Why doesn't Mod Config Menu work for me?

It works for everyone else, so it has to be something wrong with you. Start by uninstalling the game, completely removing all leftover game files, reinstalling the game, and then only subscribing to this mod on the workshop and nothing else. At this point, you will probably have no errors, so you can then start to introduce other things piece by piece until you find the thing that is causing the problem. For more information on where the various game files are located, see [my directories and save files explanation](https://github.com/Zamiell/isaac-faq/blob/main/directories-and-save-files.md).

### What was changed in the last update?

Look at the [commit history](https://github.com/Zamiell/isaac-mod-config-menu/commits/main).
