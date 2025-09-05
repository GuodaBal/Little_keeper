extends Resource

class_name Inventory

@export var items: Array[InventoryItem]

var current_index = 0

func add_item(item:InventoryItem):
	for index in items.size():
		if items[index] == null:
			items[index] = item
			break
	GlobalSignals.update_inventory.emit()

func remove_item(item:InventoryItem):
	if items.has(item):
		var index = items.find(item)
		items[index] = null
	GlobalSignals.update_inventory.emit()
func select_item(index):
	current_index = index

func clear():
	for index in items.size():
		items[index] = null
