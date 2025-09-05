extends Node2D

func _ready() -> void:
	GlobalSignals.start_ending.connect(start_ending)
	
func start_ending():
	if GlobalVariables.ending_choice == "crowned" && GlobalVariables.given_item_types.count(3) >= 3:
		await DialogueManager.dialogue_ended
		DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/endings.dialogue"), "crowned_ending")
		GlobalSignals.player_can_move.emit(false)
		await DialogueManager.dialogue_ended
		var instance = load("res://Code/UI/Title_cards/title_card_crowned.tscn").instantiate()
		add_child(instance)
	elif GlobalVariables.ending_choice == "crowned":
		await DialogueManager.dialogue_ended
		DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/endings.dialogue"), "tended_ending")
		GlobalSignals.player_can_move.emit(false)
		await DialogueManager.dialogue_ended
		var instance = load("res://Code/UI/Title_cards/title_card_tended.tscn").instantiate()
		add_child(instance)
	elif GlobalVariables.ending_choice == "bound" && GlobalVariables.given_item_types.count(3) >= 2:
		await DialogueManager.dialogue_ended
		DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/endings.dialogue"), "bound_ending_2")
		GlobalSignals.player_can_move.emit(false)
		await DialogueManager.dialogue_ended
		var instance = load("res://Code/UI/Title_cards/title_card_bound_2.tscn").instantiate()
		add_child(instance)
	elif GlobalVariables.ending_choice == "bound":
		await DialogueManager.dialogue_ended
		DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/endings.dialogue"), "bound_ending")
		GlobalSignals.player_can_move.emit(false)
		await DialogueManager.dialogue_ended
		var instance = load("res://Code/UI/Title_cards/title_card_bound.tscn").instantiate()
		add_child(instance)
	elif GlobalVariables.ending_choice == "defected":
		await DialogueManager.dialogue_ended
		DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/endings.dialogue"), "defected_ending")
		GlobalSignals.player_can_move.emit(false)
		await DialogueManager.dialogue_ended
		var instance = load("res://Code/UI/Title_cards/title_card_defected.tscn").instantiate()
		add_child(instance)
