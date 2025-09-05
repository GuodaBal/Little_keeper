extends Area2D

@export var next_area = ""

func _on_body_entered(body: Node2D) -> void:
	#GlobalSignals.switch_area.emit(next_area)
	if body.is_in_group("Player"):
		GlobalSignals.switch_area.emit(next_area)
		#DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/scene_switching.dialogue"), "start", [self])

func switch():
	GlobalSignals.switch_area.emit(next_area)
