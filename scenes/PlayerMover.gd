extends CharacterBody2D

@export var speed: float = 200
var speed_boost: float = 100
@onready var player_sprite = $player1
@onready var point_light = $PointLight2D
@onready var collision_shape = $CollisionShape2D
@onready var animation_player = $AnimationPlayer 
@export var camera: Camera2D
@export var camera_smoothing: float = 5.0

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	

	if Input.is_action_just_pressed("ui_up"):
		direction.y -= 4
	if Input.is_action_just_pressed("ui_down"):
		direction.y += 4
	if Input.is_action_just_pressed("ui_left"):
		direction.x -= 4
	if Input.is_action_just_pressed("ui_right"):
		direction.x += 4
	

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		

		if animation_player and animation_player.has_animation("charanirun"):
			animation_player.play("charanirun")
	else:

		if animation_player and animation_player.has_animation("charstill"):
			animation_player.play("charstill")
	

	velocity = direction * speed
	move_and_slide()
	

	if camera:
		camera.global_position = camera.global_position.lerp(global_position, camera_smoothing * delta)

func increase_speed():
	speed += speed_boost
	print("Speed increased! New speed: ", speed)
