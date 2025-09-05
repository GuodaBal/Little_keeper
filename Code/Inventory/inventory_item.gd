extends Resource

class_name InventoryItem

@export var item_name : String = ""
@export var sprite : Texture2D
@export var category : int = 0

#Category -> weirdness level. 1 = safe, 2 = strange, 3 = wild
#0 = default/no category (not an item given to the eye. Unsure if it will be used)
