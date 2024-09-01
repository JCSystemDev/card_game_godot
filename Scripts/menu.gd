extends Control
@onready var game: PackedScene = load("res://Scenes/world.tscn")
@onready var new_game: Button = $"Buttons/New Game"
@onready var quit_game: Button = $"Buttons/Quit Game"

func _ready():
	Transition.animation_player.play_backwards("transition")
	AudioManager.play_music("Main Menu.mp3")
	new_game.grab_focus()

func parallax_bg(delta_time) -> void:
	get_node("ParallaxBackground").scroll_base_offset -= Vector2(1, 0) * 100 * delta_time	

func _process(delta):
	parallax_bg(delta)

func _on_quit_game_pressed():
	AudioManager.play_sound("Discard.wav")
	Transition.quit_transition("transition")

func _on_new_game_pressed():
	AudioManager.play_sound("Equip.wav")
	Transition.load_scene(game, "transition")

func _on_continue_game_pressed():
	pass # Replace with function body.
