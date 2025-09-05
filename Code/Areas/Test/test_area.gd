extends Node2D

@onready var animation := $AnimationPlayer

func _on_eye_eye_fed_wild() -> void:
	await DialogueManager.dialogue_ended
	var player = get_tree().get_first_node_in_group("Player")
	player.set_can_interact(false)
	animation.play("correct_item_given1")
	await animation.animation_finished
	DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/test_cutscene.dialogue"))
	await DialogueManager.dialogue_ended
	animation.play("correct_item_given2")
	await animation.animation_finished
	player.set_can_interact(true)
