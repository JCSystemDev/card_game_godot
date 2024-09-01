class_name PlayerCharacter extends CharacterBody2D

var direction = Vector2()
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	DataManager.move_speed = 3

func _physics_process(_delta):
	if(Input.is_action_pressed("up") and direction.x == 0):
		direction.y = -DataManager.move_speed
		animation_player.play("walk_up")
	elif(Input.is_action_pressed("down") and direction.x == 0):
		direction.y = DataManager.move_speed
		animation_player.play("walk_down")
	elif(Input.is_action_pressed("left") and direction.y == 0):
		direction.x = -DataManager.move_speed
		animation_player.play("walk_left")
	elif(Input.is_action_pressed("right") and direction.y == 0):
		direction.x = DataManager.move_speed
		animation_player.play("walk_right")
	elif(Input.is_action_just_released("up")):
		animation_player.play("idle_up")
		direction = Vector2.ZERO	
	elif(Input.is_action_just_released("down")):
		animation_player.play("idle_down")
		direction = Vector2.ZERO
	elif(Input.is_action_just_released("left")):
		animation_player.play("idle_left")
		direction = Vector2.ZERO
	elif(Input.is_action_just_released("right")):
		animation_player.play("idle_right")
		direction = Vector2.ZERO
	move_and_collide(direction)


func _on_dialogue_detector_body_entered(body):
	if body.is_in_group("enemy"):
		pass
