extends CanvasLayer

@onready var animation_player := $AnimationPlayer

var is_screen_black = true

signal animation_finished

func _ready() -> void:
	animation_player.animation_finished.connect(emit_finished)

func play_fade_in(speed = 1.0):
	animation_player.play("fade_in", -1, speed)
	is_screen_black = false

func play_fade_out(speed = 1.0):
	animation_player.play("fade_out", -1, speed)
	is_screen_black = true

func is_playing():
	return animation_player.is_playing()

func emit_finished(unused_var):
	animation_finished.emit()
