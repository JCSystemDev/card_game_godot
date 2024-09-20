class_name SavePoint extends Node2D
@onready var interaction_area: InteractionArea = $"Interaction Area"

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	DataManager._save_game()
	AudioManager.play_sound("Equip.wav")
