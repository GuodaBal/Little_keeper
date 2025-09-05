extends CharacterBody2D

@export var char_name = ""

func interact():
	print_debug(GlobalVariables.given_item_types.back())
	print_debug(GlobalVariables.eye_is_fed)
	DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/Cultists/cultist_lines.dialogue"), char_name)
