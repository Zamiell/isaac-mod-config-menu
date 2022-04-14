# Getting Started with Mod Config Menu

If you want to add config options to your Binding of Isaac mod, then instead of programming your own menu system from scratch, you can register your mod's configuration options with [Mod Config Menu](https://github.com/Zamiell/isaac-mod-config-menu), or MCM for short. MCM is a mod that provides an extendable in-game menu.

Currently, there are two versions of MCM available on the Steam Workshop. The documentation in this repository should work with either of them:

 - [Mod Config Menu Pure](https://steamcommunity.com/sharedfiles/filedetails/?id=2681875787)
 - [Mod Config Menu - Continued](https://steamcommunity.com/sharedfiles/filedetails/?id=2487535818)

<br>

## The `ModConfigMenu` Global Variable

The first thing you want to do is check for the existence of the `ModConfigMenu` global variable. If it exists then you can proceed.

```lua
local function modConfigMenuInit()
  if ModConfigMenu == nil then
    return
  end

  -- Insert code here to add the menu options for your mod
end
```

<br>

## Common Scenarios

In most cases, you will be providing the player with multiple choice options. This can take the form of "on/off" or "A/B/C".

### On/Off

On/off looks like this:

```lua
-- Specify a table of the MCM settings for this mod, along with their default values
local settings = {
  myBoolean = false,
}

ModConfigMenu.AddSetting(
  "My Settings Page", -- This should be unique for your mod
  "Tab 1", -- If you don't want multiple tabs, then set this to nil
  {
    Type = ModConfigMenu.OptionType.BOOLEAN,
    CurrentSetting = function()
      return settings.myBoolean
    end,
    Display = function()
      return "My Boolean: " .. (settings.myBoolean and "on" or "off")
    end,
    OnChange = function(b)
      settings.myBoolean = b
    end,
    Info = { -- This can also be a function instead of a table
      "Info on 1st line",
      "More info on 2nd line",
    }
  }
)
```

### A/B/C (multiple choice)

If you need 3 or more options then that looks like this:

```lua
local choices = {
  "A",
  "B",
  "C",
}

-- Specify a table of the MCM settings for this mod, along with their default values
local settings = {
  myMultipleChoice = choices[1] -- The first choice by default
}

ModConfigMenu.AddSetting(
  "My Settings Page",
  "Tab 1",
  {
    Type = ModConfigMenu.OptionType.NUMBER,
    CurrentSetting = function()
      return settings.myMultipleChoice
    end,
    Minimum = 1,
    Maximum = #choices,
    Display = function()
      return "My Multiple Choice: " .. choices[settings.myMultipleChoice]
    end,
    OnChange = function(n)
      -- You could also choose to save the string instead of the number
      settings.myMultipleChoice = n
    end,
    -- Text in the "Info" section will automatically word-wrap, unlike in the main section above
    Info = { "Info on 1st line" }
  }
)
```

### Scroll Bar

A scroll bar is a multiple choice option that renders as a scroll bar with 10 bars. The player can choose between 0 and 10 out of 10 for a total of 11 options.

This is commonly used to get a decimal number between 0 and 1 (by i.e. dividing by 10).

```lua
local settings = {}
settings.myScrollBar = 0

ModConfigMenu.AddSetting(
  "My Settings Page",
  "Tab 1",
  {
    Type = ModConfigMenu.OptionType.SCROLL,
    CurrentSetting = function()
      return settings.myScrollBar
    end,
    Display = function()
      return "My Scroll Bar: $scroll" .. settings.myScrollBar
    end,
    OnChange = function(n)
      settings.myScrollBar = n
    end,
    Info = { "Info on 1st line" }
  }
)
```

<br>

## Layout

You can add a title, text, or vertical spacer like this:

```lua
ModConfigMenu.AddTitle("My Settings Page", "Tab 1", "My Title")
ModConfigMenu.AddText("My Settings Page", "Tab 1", "My Text")
ModConfigMenu.AddSpace("My Settings Page", "Tab 1")
```

<br>

## Saving and Loading

### Saving

You are responsible for saving your settings, which can be as simple as:

```lua
local json = require("json")

local mod = RegisterMod("MyMod", 1)

-- If your mod does not store any other save data, then you can simply run the "save" function in
-- every MCM "OnChange" function. Otherwise, you need to run it on both the "OnChange" functions and
-- MC_PRE_GAME_EXIT.
local function save()
  -- TODO: use pcall to gracefully handle failure
  local jsonString = json.encode(settings)
  mod:SaveData(jsonString)
end
```

### Loading

You are also responsible for loading your saved settings, which can be as simple as:

```lua
-- If your mod does not store any other save data, then you can simply run the "load" function
-- during mod initialization. Otherwise, you need to run it on both initialization and at the
-- beginning of a run.
local function load()
  if not mod:HasData() then
    return
  end

  -- TODO: use pcall to gracefully handle failure
  -- TODO: add checks for validate the data
  local jsonString = mod:LoadData()
  settings = json.decode(jsonString)
end
```

### IsaacScript

If you are coding your mod using TypeScript, then the [IsaacScript](https://isaacscript.github.io/) standard library has a save data manager that you should use instead of handling saving and loading yourself manually.

```ts
// Config.ts
export class Config {
  feature1 = true;
  feature2 = 1;
  // and so on
}

// modConfigMenu.ts
const v = {
  persistent: {
    config: new Config(),
  }
}

function modConfigMenuInit() {
  saveDataManager("modConfigMenu", v);
}
```

<br>

## Further Reading

See the [Mod Reference](https://wofsauge.github.io/IsaacDocs/rep/ModReference.html) documentation for related saving and loading information.

For more options, check out the Mod Config Menu [README](README.md).
