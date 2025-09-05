extends StaticBody2D

@export var needed_item = "placeholder2"
var done = false

signal correct_item_placed

func interact():
	if done:
		DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/item_interactions/use_on_prototype.dialogue"), "done")
	else:
		DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/item_interactions/use_on_prototype.dialogue"), "dont_have_item")
	
func use_item(item_name):
	if done:
		interact()
		return
	if item_name == needed_item:
		done = true
		correct_item_placed.emit()
	else:
		DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/item_interactions/use_on_prototype.dialogue"), "have_wrong_item")
