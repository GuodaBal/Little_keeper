extends StaticBody2D

@onready var giant_eye := $GiantEye
@onready var large_eye := $LargeEye
@onready var small_eye := $SmallEye

var dm = DialogueManager

func _ready() -> void:
	match GlobalVariables.current_day:
		1:
			giant_eye.visible = false
			large_eye.visible = false
			small_eye.visible = false
		2:
			giant_eye.visible = false
			large_eye.visible = false
			small_eye.visible = true
			for child in small_eye.get_children():
				child.play("idle")
		3:
			giant_eye.visible = false
			small_eye.visible = false
			large_eye.visible = true
			for child in large_eye.get_children():
				child.play("idle")
		4:
			giant_eye.visible = true
			small_eye.visible = false
			large_eye.visible = false
			for child in giant_eye.get_children():
				child.play("idle")

func interact():
	if GlobalVariables.eye_is_fed:
		dm.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/day_"+str(GlobalVariables.current_day)+".dialogue"), "after_feeding")
	else:
		dm.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/day_"+str(GlobalVariables.current_day)+".dialogue"), "start_day")
	#DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/eye.dialogue"), "before_feed_day_"+str(GlobalVariables.current_day))
