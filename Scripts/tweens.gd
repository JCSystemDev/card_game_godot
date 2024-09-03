class_name Tweens extends Node

func _shake_tween(node: Node2D):
	var shake = create_tween()
	for times in 5:
		shake.tween_property(node,"position", Vector2(node.position.x + 5,node.position.y),0.025)
		shake.tween_property(node,"position", Vector2(node.position.x - 5,node.position.y),0.025)
	shake.tween_property(node,"position", Vector2(node.position.x,node.position.y),0.025)
