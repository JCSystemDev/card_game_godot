extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _ready():
	color_rect.visible = false

func load_scene(target_scene: PackedScene, transition: String):
	animation_player.play(transition)
	await animation_player.animation_finished
	get_tree().change_scene_to_packed(target_scene)
	animation_player.play_backwards(transition)
	await animation_player.animation_finished
	color_rect.visible = false
	
func reaload_scene(transition: String):
	animation_player.play(transition)
	await animation_player.animation_finished
	get_tree().reload_current_scene()
	animation_player.play_backwards(transition)
	await animation_player.animation_finished
	color_rect.visible = false
	
func quit_transition(transition: String):
	animation_player.play(transition)
	await animation_player.animation_finished
	get_tree().quit()
