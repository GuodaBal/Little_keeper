extends StaticBody2D

var dm = DialogueManager

func interact():
	if GlobalVariables.eye_is_fed:
		dm.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/day_"+str(GlobalVariables.current_day)+".dialogue"), "after_feeding")
	else:
		dm.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/day_"+str(GlobalVariables.current_day)+".dialogue"), "start_day")
	#DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/eye.dialogue"), "before_feed_day_"+str(GlobalVariables.current_day))
