extends Node

@onready var eye := $Dialogue/Eye
@onready var narrator := $Dialogue/Narrator
@onready var cultist := $Dialogue/Cultist

var current_speaker = null

func _ready() -> void:
	GlobalSignals.dialogue_spoken.connect(play_dialogue)
	GlobalSignals.dialogue_stopped.connect(stop_dialogue)
	#DialogueManagerLabel.spoke.connect(play_dialogue)
	#DialogueManagerLabel.finished_typing.connect(stop_dialogue)
	#eye.play()


func play_dialogue():
	if current_speaker && !current_speaker.playing:
		current_speaker.play()

func stop_dialogue():
	if current_speaker:
		current_speaker.stop()
