extends Node2D

@onready var animation_player := $AnimationPlayer
@onready var centered_camera := $Camera2D

var dm = DialogueManager

func start_intro_cutscene():
	#dm.show_dialogue_balloon(load("res://Resources/Dialogue/test_dialogue.dialogue"))
	#centered_camera.enabled = true
	#GlobalSignals.player_camera_on.emit(false)
	#dm.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/opening.dialogue"), "line_1")
	#await dm.dialogue_ended
	#GlobalSignals.player_can_move.emit("false")
	##[SFX] amb_forest_night starts, very low.
	#animation_player.play("camera_move_up")
	#await animation_player.animation_finished
	#dm.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/opening.dialogue"), "line_2", [self])
	#await dm.dialogue_ended
	#GlobalSignals.player_can_move.emit("true")
	#GlobalSignals.player_camera_on.emit(true)
	#centered_camera.enabled = false
	GlobalSignals.switch_area.emit("Crater", 1.0)
