extends StaticBody2D

var player

func interact():
	if !player:
		player = get_tree().get_first_node_in_group("Player")
	DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/end_day_option.dialogue"), "start", [self])

func end_day():
	GlobalVariables.current_day += 1
	GlobalSignals.day_end.emit()
	GlobalVariables.eye_is_fed = false
	GlobalVariables.mission_given = false
	player.inventory.clear()
	GlobalSignals.switch_area.emit("Camp")
	#get_tree().change_scene_to_file("res://Code/Areas/Test/test_area_day_"+str(GlobalVariables.current_day)+".tscn")
