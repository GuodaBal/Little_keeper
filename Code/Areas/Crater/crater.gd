extends Node2D

var dm = DialogueManager

func _ready() -> void:
	if !GlobalVariables.has_visited_crater:
		GlobalSignals.player_can_move.emit(false)
		var player = get_tree().get_first_node_in_group("Player")
		player.position = $PrologueCutscenePosition.position
		
		GlobalVariables.has_visited_crater = true
		var instance = load("res://Code/UI/Title_cards/title_card.tscn").instantiate()
		add_child(instance)
		instance.done.connect(play_prologue)
	elif !GlobalVariables.mission_given:
		GlobalVariables.mission_given = true
		DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/day_"+str(GlobalVariables.current_day)+".dialogue"), "start_day")
	#else:
		#GlobalVariables.ending_choice = "crowned"
		#GlobalSignals.start_ending.emit()
		#var instance = load("res://Code/UI/Title_cards/title_card_defected.tscn").instantiate()
		#add_child(instance)

func play_prologue():
	print_debug("prologue")
	#dm.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/prologue.dialogue"), "intro")
	#await dm.dialogue_ended
	#dm.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/day_1.dialogue"), "start_day")
	#await dm.dialogue_ended
	#GlobalSignals.player_can_move.emit(true)
	#GlobalSignals.inventory_visible.emit(true)
	GlobalVariables.mission_given = true

func c_print(a):
	print_debug(a)
