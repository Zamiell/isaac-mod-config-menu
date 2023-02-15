# API

<!-- markdownlint-disable MD001 -->

When Mod Config Menu is installed, a global `ModConfigMenu` is available which contains all the following functions.

The settings added will show up in the order the functions are called.

___Disclaimer__: Some of the following information may be incorrect. I quickly threw this together in a couple of hours, and only did some quick parsing of the code to try and figure out how it works and the flow. Anyone is free to create an issue or pull request with corrections._

### Functions

#### Category Functions

##### GetCategoryIDByName([categoryName](#categoryname): string): number

Returns the category ID based off of the `categoryName` provided.
Returns `nil` if not a valid category.
Returns what was provided if `categoryName` is not a `string`.

##### UpdateCategory([categoryName](#categoryname): string, [categoryData](#categorydata): [categoryData](#categorydata))

Updates a category with the supplied data.

##### SetCategoryInfo([categoryName](#categoryname): string, info: string)

Changes category info.

##### RemoveCategory([categoryName](#categoryname): string)

Removes a category entirely.

#### Subcategory Functions

##### GetSubcategoryIDByName(category: string|number, [subcategoryName](#subcategoryname): string): number

Returns the subcategory ID based off of the `category` (which is either the category name or category ID) and `subcategoryName` provided.
Returns `nil` if not a valid category or subcategory.
Returns what was provided if `category` is not a `string` or `number` or `subcategoryName` is not a `string`.

##### UpdateSubcategory([categoryName](#categoryname): string, [subcategoryName](#subcategoryname): string, [subcategoryData](#subcategorydata): [subcategoryData](#subcategorydata))

Updates a subcategory with the supplied data.

##### RemoveSubcategory([categoryName](#categoryname): string, [subcategoryName](#subcategoryname): string)

Removes a subcategory entirely.

#### Setting Functions

##### AddSetting([categoryName](#categoryname): string, [subcategoryName](#subcategoryname): string, [settingTable](#settingtable): [settingTable](#settingtable))

Add a new setting to the supplied category and subcategory with the provided data.

##### RemoveSetting([categoryName](#categoryname): string, [subcategoryName](#subcategoryname): string, settingAttribute: string)

Remove the setting at the provided category, subcategory and attribute

##### AddText([categoryName](#categoryname): string, [subcategoryName](#subcategoryname): string, text: string, color: RGBArray)

Add text into the mod config menu under the provided category and subcategory.

##### AddTitle([categoryName](#categoryname): string, [subcategoryName](#subcategoryname): string, text: string, color: RGBArray)

Add a title to the mod config menu under the provided category and subcategory.

##### AddSpace([categoryName](#categoryname): string, [subcategoryName](#subcategoryname): string)

Add a space to the mod config menu under the provided category and subcategory.

##### SimpleAddSetting(settingType: [OptionType](#optiontype), [categoryName](#categoryname): string, [subcategoryName](#subcategoryname): string, configTableAttribute: ?, minValue: number, maxValue: number, modifyBy: number, defaultValue: any, displayText: string, [displayValueProxies](#displayvalueproxies), [displayDevice](#displaydevice): boolean, info: string, color: RGBArray, functionName: string)

Create a setting without using a table.

`functionName` = The name of the function it was called from (only used in error messages, and _really_ only used internally).

Any `Add` functions that take `categoryName` and `configTableAttribute` will store its data in `ModConfigMenu.Config[categoryName][configTableAttribute]`. Other versions of Mod Config Menu may auto-save this data to file. However, this version of Mod Config Menu does not. Make sure you save and load your data as appropriate.

_All of the individual `Add*` functions below can be achieved with just `AddSetting` and providing the `Type` parameter in [`settingTable`](#settingtable) to be a [`ModConfigMenu.OptionType`](#optiontype). That is also the way I recommend, because I haven't been able to fully understand the code yet, so I don't know what some of the parameters are for, and how the "overrides" are set up._
_Any help figuring out what all the parameters and "overrides" are so I can make this readme more accurate would be appreciated._

##### AddBooleanSetting([categoryName](#categoryname): string, [subcategoryName](#subcategoryname): string, configTableAttribute: ?, defaultValue: boolean, displayText: string, [displayValueProxies](#displayvalueproxies): table, info: string, color: RGBArray)

Add a boolean setting under the provided category and subcategory.

##### AddNumberSetting([categoryName](#categoryname): string, [subcategoryName](#subcategoryname): string, configTableAttribute: ?, minValue: number, maxValue: number, modifyBy: number, defaultValue: number, displayText: string, [displayValueProxies](#displayvalueproxies), info: string, color: RGBArray)

Add a number value setting under the provided category and subcategory.

##### AddScrollSetting([categoryName](#categoryname): string, [subcategoryName](#subcategoryname): string, configTableAttribute: ?, defaultValue: number, displayText: string, info: string, color: RGBArray)

Add a slider setting under the provided category and subcategory.

##### AddKeyboardSetting([categoryName](#categoryname): string, [subcategoryName](#subcategoryname): string, configTableAttribute: ?, defaultValue: number, displayText: string, [displayDevice](#displaydevice): boolean, info: string, color: RGBArray)

Add a keyboard keybinding setting.

##### AddControllerSetting([categoryName](#categoryname): string, [subcategoryName](#subcategoryname): string, configTableAttribute: ?, defaultValue: number, displayText: string, [displayDevice](#displaydevice): boolean, info: string, color: RGBArray)

Add a controller keybinding setting.

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

    -- the color of the setting (values are floats between 0 and 1)
    Color = { r, g, b },
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
