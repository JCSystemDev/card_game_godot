extends CanvasLayer
@onready var world_scene: PackedScene = load("res://Scenes/world.tscn")
@onready var accept_button: Button = $"Choose Character/Accept"
@onready var player_name: LineEdit = $"Choose Character/LineEdit"

func _ready():
	player_name.set_text(DataManager.player_stats_default[0]["player_name"])
	accept_button.set_disabled(true)

func parallax_bg(delta_time) -> void:
	get_node("ParallaxBackground").scroll_base_offset -= Vector2(1, 1) * 250 * delta_time	

func _process(delta):
	parallax_bg(delta)


func _on_accept_pressed():
	DataManager.player_stats_default[0]["player_name"] = player_name.text
	DataManager._new_game()
	AudioManager.play_sound("Equip.wav")
	Transition.load_scene(world_scene, "transition")
	accept_button.set_disabled(true)


func _on_a_type_pressed():
	AudioManager.play_sound("Accept.wav")
	DataManager._get_player_texture("res://Assets/Sprites/Player/EggBoy.png", "res://Assets/Sprites/Portraits/EggBoy.png")
	if player_name.text != "":
		accept_button.set_disabled(false)


func _on_b_type_pressed():
	AudioManager.play_sound("Accept.wav")
	DataManager._get_player_texture("res://Assets/Sprites/Player/EggGirl.png", "res://Assets/Sprites/Portraits/EggGirl.png")
	if player_name.text != "":
		accept_button.set_disabled(false)
