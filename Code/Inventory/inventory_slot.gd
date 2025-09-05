extends Panel

@onready var item_sprite := $CenterContainer/Panel/ItemSprite
@onready var selection_sprite := $Selection_sprite

var is_empty = true
var is_selected = false

func _ready() -> void:
	selection_sprite.visible = false

func update(item: InventoryItem):
	if !item:
		item_sprite.visible = false
		is_empty = true
	else:
		item_sprite.visible = true
		item_sprite.texture = item.sprite
		is_empty = false

func select():
	is_selected = true
	selection_sprite.visible = true

func deselect():
	is_selected = false
	selection_sprite.visible = false
