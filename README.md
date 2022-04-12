# Mod Config Menu

Mod Config Menu is a library for [The Binding of Isaac: Repentance](https://store.steampowered.com/app/1426300/The_Binding_of_Isaac_Repentance/) that allows other mods to have a settings menu.

Credit goes to piber20 for originally creating this library and Chifilly for updating it for Repentance.

This is a forked version of Mod Config Menu by Zamiel that removes all of the hacks that override internal Lua functionality, which causes problems with other things in the Isaac ecosystem.

---

## Mod Developer API

When Mod Config Menu is installed, a global `ModConfigMenu` is available which contains all the following functions.

The settings added will show up in the order the functions are called.

___Disclaimer__: Some of the following information may be incorrect. I quickly threw this together in a couple of hours, and only did some quick parsing of the code to try and figure out how it works and the flow. Anyone is free to create an issue or pull request with corrections._

### Functions

#### Category Functions

##### GetCategoryIDByName([categoryName](#categoryName): string): number

Returns the category ID based off of the `categoryName` provided.
Returns `nil` if not a valid category.
Returns what was provided if `categoryName` is not a `string`.

##### UpdateCategory([categoryName](#categoryName): string, [categoryData](#categoryData): [categoryData](#categoryData))

Updates a category with the supplied data.

##### SetCategoryInfo([categoryName](#categoryName): string, info: string)

Changes category info.

##### RemoveCategory([categoryName](#categoryName): string)

Removes a category entirely.

---

#### Subcategory Functions

##### GetSubcategoryIDByName(category: string|number, [subcategoryName](#subcategoryName): string): number

Returns the subcategory ID based off of the `category` (which is either the category name or category ID) and `subcategoryName` provided.
Returns `nil` if not a valid category or subcategory.
Returns what was provided if `category` is not a `string` or `number` or `subcategoryName` is not a `string`.

##### UpdateSubcategory([categoryName](#categoryName): string, [subcategoryName](#subcategoryName): string, [subcategoryData](#subcategoryData): [subcategoryData](#subcategoryData))

Updates a subcategory with the supplied data.

##### RemoveSubcategory([categoryName](#categoryName): string, [subcategoryName](#subcategoryName): string)

Removes a subcategory entirely.

---

#### Setting Functions

##### AddSetting([categoryName](#categoryName): string, [subcategoryName](#subcategoryName): string, [settingTable](#settingTable): [settingTable](#settingTable))

Add a new setting to the supplied category and subcategory with the provided data.

##### RemoveSetting([categoryName](#categoryName): string, [subcategoryName](#subcategoryName): string, settingAttribute: string)

Remove the setting at the provided category, subcategory and attribute

##### AddText([categoryName](#categoryName): string, [subcategoryName](#subcategoryName): string, text: string, color: string)

Add text into the mod config menu under the provided category and subcategory.

##### AddTitle([categoryName](#categoryName): string, [subcategoryName](#subcategoryName): string, text: string, color: string)

Add a title to the mod config menu under the provided category and subcategory.

##### AddSpace([categoryName](#categoryName): string, [subcategoryName](#subcategoryName): string)

Add a space to the mod config menu under the provided category and subcategory.

##### SimpleAddSetting(settingType: [OptionType](#OptionType), [categoryName](#categoryName): string, [subcategoryName](#subcategoryName): string, configTableAttribute: ?, minValue: number, maxValue: number, modifyBy: number, defaultValue: any, displayText: string, [displayValueProxies](#displayValueProxies), [displayDevice](#displayDevice): boolean, info: string, color: string, functionName: string)

Create a setting without using a table.

`functionName` = The name of the function it was called from (only used in error messages, and _really_ only used internally).

---

_All of the individual `Add*` functions below can be achieved with just `AddSetting` and providing the `Type` parameter in [`settingTable`](#settingTable) to be a [`ModConfigMenu.OptionType`](#OptionType). That is also the way I recommend, because I haven't been able to fully understand the code yet, so I don't know what some of the parameters are for, and how the "overrides" are set up._
_Any help figuring out what all the parameters and "overrides" are so I can make this readme more accurate would be appreciated._

##### AddBooleanSetting([categoryName](#categoryName): string, [subcategoryName](#subcategoryName): string, configTableAttribute: ?, defaultValue: boolean, displayText: string, [displayValueProxies](#displayValueProxies): table, info: string, color: string)

Add a boolean setting under the provided category and subcategory.

##### AddNumberSetting([categoryName](#categoryName): string, [subcategoryName](#subcategoryName): string, configTableAttribute: ?, minValue: number, maxValue: number, modifyBy: number, defaultValue: number, displayText: string, [displayValueProxies](#displayValueProxies), info: string, color: string)

Add a number value setting under the provided category and subcategory.

##### AddScrollSetting([categoryName](#categoryName): string, [subcategoryName](#subcategoryName): string, configTableAttribute: ?, defaultValue: number, displayText: string, info: string, color: string)

Add a slider setting under the provided category and subcategory.

##### AddKeyboardSetting([categoryName](#categoryName): string, [subcategoryName](#subcategoryName): string, configTableAttribute: ?, defaultValue: number, displayText: string, [displayDevice](#displayDevice): boolean, info: string, color: string)

Add a keyboard keybinding setting.

##### AddControllerSetting([categoryName](#categoryName): string, [subcategoryName](#subcategoryName): string, configTableAttribute: ?, defaultValue: number, displayText: string, [displayDevice](#displayDevice): boolean, info: string, color: string)

Add a controller keybinding setting.

---

### Variables and Parameters

#### Common Parameters

##### categoryName

What needs to be chosen on the left to go to your settings menu.

##### subcategoryName

The secondary section within your tab the setting is in. This is a tab list at the top of your menu.

##### categoryData

A table of data for the category.

```lua
{
    Name = string -- the name of the category
    Info = string -- the description of the category
    IsOld = boolean -- not sure of the purpose, only seems to turn the text red
}
```

##### subcategoryData

A table of data for the subcategory.

```lua
    Name = string -- the name of the category
    Info = string -- the description of the category
```

##### settingTable

A table of data for the setting.

```lua
{
    -- the type of the setting, see OptionType for more information
    Type = ModConfigMenu.OptionType,

    -- the identifier for the setting
    Attribute = string,

    -- the default value for the setting
    Default = any,

    -- a function that returns the current value of the setting
    CurrentSetting = function(),

    -- the minimum value of numeric settings
    Minimum = number,

    -- the maximum value of numeric settings
    Maximum = number,

    -- a function that returns a string of how the setting will display in the settings menu
    Display = function(),

    -- a function that is called whenever the setting is changed (can be used to save your settings for example)
    OnChange = function(),

    -- a table of strings that's used as the information for the setting
    Info = { string },

    -- the colour of the setting
    Color = string,
}
```

##### displayValueProxies

A table that denotes what text will be displayed based on the setting value as the index.

```lua
-- this will make "true" show as "On" and "false" show as "Off"
{
    [true] = "On",
    [false] = "Off"
}

-- or

-- this will make 0 show "Sometimes", 1 show "Never" and 2 show "Always"
{
    [0] = "Sometimes",
    [1] = "Never",
    [2] = "Always"
},
```

##### displayDevice

Whether the display text should be suffixed with the control device (`(keyboard)` or `(controller)`).

---

#### Enums

##### OptionType

All these option types are in the `ModConfigMenu.OptionType` enum.

`TEXT` = Plain text.
`SPACE` = A paragraph-type gap rendered in the menu.
`SCROLL` = A slider-bar for numeric values.
`BOOLEAN` = A boolean (true or false).
`NUMBER` = A numeric value.
`KEYBIND_KEYBOARD` = A keybind for keyboards.
`KEYBIND_CONTROLLER` = A keybind for controllers.
`TITLE` = Heading-style text.
