﻿using System.Collections.Generic;

public class LuaInventory {
    public string GetItem(int index) {
        if (index > Inventory.inventory.Count) {
            UnitaleUtil.DisplayLuaError("Getting an item", "Out of bounds. You tried to access item number " + index + 1 + " in your inventory, but you only have " + Inventory.inventory.Count + " items.");
            return "";
        }
        return Inventory.inventory[index-1].Name;
    }
    
    public int GetType(int index) {
        if (index > Inventory.inventory.Count) {
            UnitaleUtil.DisplayLuaError("Getting an item", "Out of bounds. You tried to access item number " + index + 1 + " in your inventory, but you only have " + Inventory.inventory.Count + " items.");
            return -1;
        }
        return Inventory.inventory[index-1].Type;
    }

    public void SetItem(int index, string Name) { Inventory.SetItem(index-1, Name); }

    public bool AddItem(string Name, int index = 8) {
        if (index == 8)
            return Inventory.AddItem(Name);
        else if (index > 0 && Inventory.inventory.Count < 8) {
            if (index > Inventory.inventory.Count + 1)
                index = Inventory.inventory.Count + 1;
            
            List<UnderItem> inv = new List<UnderItem>();
            bool result = false;
            for (var i = 0; i <= Inventory.inventory.Count; i++) {
                if (i == index - 1) {
                    inv.Add(new UnderItem(Name));
                    result = true;
                }
                if (i == Inventory.inventory.Count)
                    break;
                inv.Add(Inventory.inventory[i]);
            }
            Inventory.inventory = inv;
            return result;
        }
        return false;
    }
    
    public void RemoveItem(int index) {
        if (Inventory.inventory.Count > 0 && (index < 1 || index > Inventory.inventory.Count))
            UnitaleUtil.DisplayLuaError("Removing an item", "Cannot remove item number " + index + " from an Inventory with " + Inventory.inventory.Count
                + " items.\nRemember that the first item in the inventory is #1.");
        else if (Inventory.inventory.Count == 0)
            UnitaleUtil.DisplayLuaError("Removing an item", "Cannot remove an item when the inventory is empty.");
        
        Inventory.inventory.RemoveAt(index-1);
    }

    public void AddCustomItems(string[] names, int[] types) {
        Inventory.addedItems.AddRange(names);
        Inventory.addedItemsTypes.AddRange(types);
    }

    public void SetInventory(string[] names) { Inventory.SetItemList(names); }

    public int ItemCount {
        get { return Inventory.inventory.Count; }
    }

    public bool NoDelete {
        get { return Inventory.usedItemNoDelete; }
        set { Inventory.usedItemNoDelete = value; }
    }

    public void SetAmount(int amount) {
        Inventory.tempAmount = amount;
    }
}