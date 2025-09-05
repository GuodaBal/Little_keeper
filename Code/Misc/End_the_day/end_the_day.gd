extends Area2D

var player

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
		DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/end_day_option.dialogue"), "start", [self])

func end_day():
	GlobalSignals.day_end.emit()
	GlobalVariables.current_day += 1
	GlobalVariables.eye_is_fed = false
	player.inventory.clear()
	GlobalSignals.switch_area.emit("Camp")
	#get_tree().change_scene_to_file("res://Code/Areas/Test/test_area_day_"+str(GlobalVariables.current_day)+".tscn")
