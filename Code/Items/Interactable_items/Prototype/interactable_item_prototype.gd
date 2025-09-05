extends StaticBody2D

@export var item_name = ""

func interact():
	DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/item_interactions/day_"+str(GlobalVariables.current_day)+".dialogue"), "look_at_"+item_name)
