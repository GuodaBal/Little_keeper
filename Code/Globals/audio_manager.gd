extends Node

#Dialogue
@onready var eye := $Dialogue/Eye
@onready var narrator := $Dialogue/Narrator
@onready var cultist := $Dialogue/Cultist

var current_speaker = null

#Music
@onready var join_us := $Music/JoinUs
@onready var little_offerings := $Music/LittleOfferings
@onready var the_crater_of_god := $Music/TheCraterOfGod

var fade_out = null

signal fade_out_done

func _ready() -> void:
	GlobalSignals.dialogue_spoken.connect(play_dialogue)
	GlobalSignals.dialogue_stopped.connect(stop_dialogue)
	GlobalSignals.day_end.connect(change_music_for_day)
	little_offerings.play()
	#DialogueManagerLabel.spoke.connect(play_dialogue)
	#DialogueManagerLabel.finished_typing.connect(stop_dialogue)
	#eye.play()

func _process(delta: float) -> void:
	if !fade_out:
		return
	fade_out.volume_db -= delta * 50
	if fade_out.volume_db <= -78:
		fade_out.stop()
		fade_out = null
		fade_out_done.emit()

func play_dialogue():
	if current_speaker && !current_speaker.playing:
		current_speaker.play()

func stop_dialogue():
	if current_speaker:
		current_speaker.stop()

func change_music_for_day():
	if GlobalVariables.current_day == 2:
		fade_out = little_offerings
		await fade_out_done
		join_us.play()
	if GlobalVariables.current_day == 4:
		fade_out = join_us
		await fade_out_done
		the_crater_of_god.play()
		
