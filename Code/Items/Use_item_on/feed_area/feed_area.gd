extends StaticBody2D

var dm = DialogueManager
var lowering_gently = true
var item_fed = null

func feed(item:InventoryItem):
	if !GlobalVariables.eye_is_fed:
		item_fed = item
		if GlobalVariables.current_day == 4:
			dm.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/feed_options.dialogue"), "feed_last", [self])
		else:
			dm.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/feed_options.dialogue"), "feed_default", [self])
	else:
		dm.show_dialogue_balloon(load("res://Resources/Dialogue/eye.dialogue"), "feed_after_fed")
	#if GlobalVariables.current_day == 4:
		#GlobalSignals.start_ending.emit()

func feeding():
	print_debug("feeding")
	dm.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/day_"+str(GlobalVariables.current_day)+".dialogue"), "lower_offering", [self])
	await dm.dialogue_ended
	print_debug("feeding now")
	match(item_fed.category):
		1:
			dm.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/day_"+str(GlobalVariables.current_day)+".dialogue"), "feed_safe", [self])
		2:
			dm.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/day_"+str(GlobalVariables.current_day)+".dialogue"), "feed_strange", [self])
		3:
			dm.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/day_"+str(GlobalVariables.current_day)+".dialogue"), "feed_wild", [self])
	GlobalVariables.eye_is_fed = true
	GlobalSignals.item_fed.emit(item_fed)
	await DialogueManager.dialogue_ended
	end_day()

func end_day():
	if GlobalVariables.current_day != 4:
		GlobalVariables.current_day += 1
		GlobalSignals.day_end.emit()
		GlobalVariables.eye_is_fed = false
		GlobalVariables.mission_given = false
		GlobalSignals.clear_inventory.emit()
		GlobalSignals.switch_area.emit("Crater", 1.0)

func defect():
	dm.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/day_"+str(GlobalVariables.current_day)+".dialogue"), "refuse", [self])

func binding():
	dm.show_dialogue_balloon(load("res://Resources/Dialogue/Cutscenes/day_"+str(GlobalVariables.current_day)+".dialogue"), "bind_the_rim", [self])

func c_print(v):
	print_debug(v)
