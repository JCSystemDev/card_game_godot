extends CanvasLayer

@onready var avatar_sprite: Sprite2D = $"Character Avatar/Avatar"
@onready var avatar_name: Label = $"Character Avatar/Name"
@onready var avatar_dialogue: Label = $Dialogue
@onready var dialogue_animation: AnimationPlayer = $AnimationPlayer
@onready var dialogue_box: CanvasLayer = $"."
@onready var next_button: Button = $"Next Button"
@onready var yes_button: Button = $"Yes Button"
@onready var no_button: Button = $"No Button"

var battle: bool = false
var line_state
enum line{start, challenge, negative}


func _ready():
	line_state = line.start
	dialogue_box.visible = false

func _load_dialogue_box(_line: String, _texture: Texture2D, _name: String):
	avatar_sprite.set_texture(_texture)
	avatar_name.set_text(_name)
	avatar_dialogue.set_text(_line)
	dialogue_animation.play("write_text")
			
func _on_yes_button_pressed():
	dialogue_box.visible = false
	battle = true

func _on_no_button_pressed():
	dialogue_animation.play("RESET")
	line_state = line.negative
	yes_button.visible = false
	no_button.visible = false
