extends Node2D

var dm = DialogueManager

func _ready() -> void:
	if !GlobalVariables.has_visited_crater:
		GlobalVariables.has_visited_crater = true
		var instance = load("res://Code/UI/Title_cards/title_card.tscn").instantiate()
		add_child(instance)
		instance.done.connect(play_prologue)
	else:
		var instance = load("res://Code/UI/Title_cards/title_card_defected.tscn").instantiate()
		add_child(instance)

func play_prologue():
	pass
	#dm.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/prologue.dialogue"), "intro")
	#await dm.dialogue_ended
	#dm.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/day_1.dialogue"), "start_day")

func c_print(a):
	print_debug(a)
