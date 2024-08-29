extends Control
@onready var game: PackedScene = load("res://Scenes/world.tscn")
@onready var start_button: Button = $"Buttons/Start Game"

func _ready():
	Transition.animation_player.play_backwards("transition")
	AudioManager.play_music("Main Menu.mp3")
	start_button.grab_focus()

func parallax_bg(delta_time) -> void:
	get_node("ParallaxBackground").scroll_base_offset -= Vector2(1, 0) * 100 * delta_time	

func _on_start_game_pressed():
	Transition.load_scene(game)


func _process(delta):
	parallax_bg(delta)


func _on_quit_game_pressed():
	Transition.quit_transition()
