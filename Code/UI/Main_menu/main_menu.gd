extends Control

func _ready() -> void:
	AudioManager.little_offerings.play()
	GlobalVariables.set_to_default()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Code/Main/main.tscn")


func _on_controls_pressed() -> void:
	get_tree().change_scene_to_file("res://Code/UI/Controls/controls.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
