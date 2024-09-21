extends Area2D
var game_zone: PackedScene = load("res://Scenes/game_zone.tscn")
var enemy_name: String
@export var zone_name: String
@onready var timer = $Timer

func _on_body_entered(body):
	if body.is_in_group("player"):
		timer.start()

func _on_body_exited(body):
	if body.is_in_group("player"):
		timer.stop()

func _on_timer_timeout():
	get_tree().paused = true
	DataManager.in_battle = true
	DataManager._get_enemies(zone_name)
	DataManager.enemy_summon = DataManager.enemies_list[randi_range(0, DataManager.enemies_list.size() - 1)]
	Transition.load_scene(game_zone, "transition")
	AudioManager.play_sound("Summon.wav")
