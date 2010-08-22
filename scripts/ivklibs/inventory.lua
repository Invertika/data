----------------------------------------------------------------------------------
-- Banker Skript                                                                --
--                                                                              --
-- Das Bankerskript stellt die Bankerfunktion zur Verfügung                     --
-- (Kontoverwaltung etc.)                                                       --
----------------------------------------------------------------------------------
--  Copyright 2008 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

module("inventory", package.seeall)

require "scripts/lua/npclib"
require "scripts/ivklibs/itemtable"


function count_inventory(ch)
  local inventory_items={}
  local items = itemtable.GLOBAL_ITEM
  local count
  local id
  for k, v in pairs(items) do
    id = tonumber(k)
    if not (id == nil) and (id > 0) then
      count = mana.chr_inv_count(ch, id)
      if count > 0 then
        inventory_items[id]=count
      end -- if
    end -- if 
  end -- for loop
  return inventory_items
end

function name_inventory(ch)
  local inventory_items={}
  local items = itemtable.GLOBAL_ITEM
  local count
  local id
  for k, v in pairs(items) do
    id = tonumber(k)
    if not (id == nil) and (id > 0) then
      count = mana.chr_inv_count(ch, id)
      if count > 0 then
        inventory_items[id]=v["name"]
      end -- if
    end -- if 
  end -- for loop
  return inventory_items
end

