local TableHelper = {}
TableHelper.Version = 2

--[[

TABLE HELPER v2
by piber
some code based on publically available lua references

Make sure this is located in MOD/scripts/tablehelper.lua otherwise it wont load properly!

Do not edit this script file as it could conflict with the release version of this file used by other mods. If you find a bug or need to something changed, let me know.

-------

Table Helper's goals:
- Make it easier to manipulate lua tables

Table Helper contains functions that let you copy, fill, and loop through tables in different ways.

]]


--creates a new table with the same values as the table provided
function TableHelper.CopyTable(tableToCopy)

	local table2 = {}
	
	for i, value in pairs(tableToCopy) do
	
		if type(value) == "table" then
			table2[i] = TableHelper.CopyTable(value)
		else
			table2[i] = value
		end
		
	end
	
	return table2
	
end

--fills the table with values from another table
function TableHelper.FillTable(tableToFill, tableToFillFrom)

	for i, value in pairs(tableToFillFrom) do
	
		if tableToFill[i] ~= nil then
		
			if type(value) == "table" then
				
				if type(tableToFill[i]) ~= "table" then
					tableToFill[i] = {}
				end
				
				tableToFill[i] = TableHelper.FillTable(tableToFill[i], value)
				
			else
				tableToFill[i] = value
			end
			
		else
		
			if type(value) == "table" then
				
				if type(tableToFill[i]) ~= "table" then
					tableToFill[i] = {}
				end
				
				tableToFill[i] = TableHelper.FillTable({}, value)
				
			else
				tableToFill[i] = value
			end
			
		end
		
	end
	
	return tableToFill
	
end

--loops through numbered tables in reverse, useful if you want to remove stuff within a loop (since the values move down if you do)
local function ripairs_it(tableToCheck,i)

	i = i - 1
	
	local value = tableToCheck[i]
	
	if value == nil then
		return value
	end
	
	return i, value
	
end
function TableHelper.ripairs(tableToCheck)
	return ripairs_it, tableToCheck, #tableToCheck+1
end

--returns true if the value is in the table
function TableHelper.IsInTable(valueToCheck, tableToCheck)

	for i, value in pairs(tableToCheck) do
	
		if value == valueToCheck then
			return true
		end
		
	end
	
	return false
	
end

--removes all instances of the value from the table, returns true if it removed anything
function TableHelper.RemoveFromTable(valueToRemove, tableToCheck)

	local removedAnything = false
	
	for i, value in TableHelper.ripairs(tableToCheck) do
	
		if value == valueToRemove then
			table.remove(tableToCheck, i)
			removedAnything = true
		end
		
	end
	
	return removedAnything
	
end


return TableHelper
