extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Code/Areas/Test/test_area.tscn")


func _on_controls_pressed() -> void:
	get_tree().change_scene_to_file("res://Code/UI/Controls/controls.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
