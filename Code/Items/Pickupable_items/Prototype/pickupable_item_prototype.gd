extends StaticBody2D

@export var item: InventoryItem

@onready var sprite := $Sprite2D

var player

func _ready() -> void:
	if item.sprite:
		sprite.texture = item.sprite

#Ask if player wants to pick up item
func ask_pick_up(player):
	self.player = player
	DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/item_interactions/day_"+str(GlobalVariables.current_day)+".dialogue"), "pick_up_"+item.item_name, [self])

func pick_up():
	player.inventory.add_item(item)
	queue_free()
	return item
