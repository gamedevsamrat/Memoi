extends CharacterBody2D

@export var speed = 400  

func _physics_process(delta):
	var direction = 0
	if Input.is_action_pressed("ui_left"):
		direction = -1
	elif Input.is_action_pressed("ui_right"):
		direction = 1
	
	velocity.x = direction * speed
	velocity.y = 0 
	
	
	var viewport_width = get_viewport_rect().size.x
	move_and_slide()
	
	global_position.x = clamp(global_position.x, 0 + $CollisionShape2D.shape.extents.x, viewport_width - $CollisionShape2D.shape.extents.x)
