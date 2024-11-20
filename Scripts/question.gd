class_name Question
extends Node2D

@onready var question_node = $"."
@onready var question_label: Label = $Question
@onready var answer_a: Button = $"Button A"
@onready var answer_b: Button = $"Button B"
@onready var answer_c: Button = $"Button C"
@onready var answer_d: Button = $"Button D"
@onready var time_label: Label = $Time
@onready var timer: Timer = $Time/Timer
@onready var game_zone: GameZone = $".."
var countdown_time
var current_answer
var question_count: int = 0

func _ready():
	question_node.hide()
	get_tree().paused = false
	AudioManager.play_music("17 - Fight.ogg")
	await get_tree().create_timer(2).timeout
	_call_question()
	
func update_time_label():
	time_label.text = str(countdown_time)

func _on_timer_tick():
	countdown_time -= 1  
	update_time_label() 
	if countdown_time <= 0:
		timer.stop()
		question_node.hide()
		AudioManager.play_sound("Down Stats.wav")
		await get_tree().create_timer(1).timeout
		game_zone.player.current_hp -= 1
		AudioManager.play_sound("Attack Phase.wav")
		await get_tree().create_timer(1).timeout
		question_count += 1
		_call_question()

func _on_button_a_pressed():
	current_answer = answer_a.text
	_check_answer()

func _on_button_b_pressed():
	current_answer = answer_b.text
	_check_answer()
	

func _on_button_c_pressed():
	current_answer = answer_c.text
	_check_answer()

func _on_button_d_pressed():
	current_answer = answer_d.text
	_check_answer()


func _call_question():
	countdown_time = 10
	question_node.show()
	timer.start()
	update_time_label() 
	DataManager._get_question(DataManager.question_list[question_count])
	question_label.text = DataManager.current_question
	answer_a.text = DataManager.current_options[0]
	answer_b.text = DataManager.current_options[1]
	answer_c.text = DataManager.current_options[2]
	answer_d.text = DataManager.current_options[3]

func _check_answer():
	question_node.hide()
	if current_answer == DataManager.current_answer:
		AudioManager.play_sound("Magic.wav")
		await get_tree().create_timer(1).timeout
		game_zone.npc.current_hp -= 1
		AudioManager.play_sound("Attack Phase.wav")
	else:
		AudioManager.play_sound("Down Stats.wav")
		await get_tree().create_timer(1).timeout
		game_zone.player.current_hp -= 1
		AudioManager.play_sound("Attack Phase.wav")
	await get_tree().create_timer(1).timeout
	question_count += 1
	_call_question()
