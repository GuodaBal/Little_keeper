extends Control

@onready var player_inventory = preload("res://Resources/inventory_placeholder.tres")
@onready var slots = $ColorRect/GridContainer.get_children() as Array
@onready var columns = $ColorRect/GridContainer.columns

var currently_selected = 0

func _ready() -> void:
	select_item(0)
	update_slots()
	GlobalSignals.update_inventory.connect(update_slots)
	GlobalSignals.inventory_visible.connect(change_visibility)
	GlobalSignals.start_ending.connect(change_visibility.bind(false))

func update_slots():
	for index in range(slots.size()):
		slots[index].update(player_inventory.items[index])

func select_item(item_index):
	player_inventory.select_item(item_index)
	for index in range(slots.size()):
		slots[index].deselect()
	slots[item_index].select()
	currently_selected = item_index


#func Use_current_item():
	#if player_inventory.items[currently_selected].

func _input(event: InputEvent) -> void:
	if !get_tree().get_first_node_in_group("Player").can_interact:
		return
	if Input.is_action_just_pressed("inv_left"):
		if currently_selected != 0 && (currently_selected % columns) != 0:
			currently_selected -= 1
			select_item(currently_selected)
	elif Input.is_action_just_pressed("inv_right"):
		if currently_selected != (slots.size() - 1) && ((currently_selected + 1) % columns) != 0:
			currently_selected += 1
			select_item(currently_selected)
	#elif Input.is_action_just_pressed("inv_down"):
		#if (currently_selected + columns) < slots.size():
			#currently_selected += columns
			#Select_item(currently_selected)
	#elif Input.is_action_just_pressed("inv_up"):
		#if (currently_selected - columns) >= 0:
			#currently_selected -= columns
			#Select_item(currently_selected)
		
func change_visibility(tf):
	visible = tf
