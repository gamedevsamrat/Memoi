extends CharacterBody2D

@export var speed = 250
@export var jump_force = -700
@export var gravity = 1000

@onready var camera = $Camera2D  

func _ready():
	camera.position_smoothing_enabled = true
	camera.position_smoothing_speed = 8.0  
	camera.zoom = Vector2(1.0, 1.0)  
	camera.make_current()  

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	var can_move = is_on_floor() or velocity.y < 0

	var direction = Input.get_axis("ui_left", "ui_right")
	if can_move:
		velocity.x = direction * speed
	else:
		velocity.x = 0  

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force

	move_and_slide()
