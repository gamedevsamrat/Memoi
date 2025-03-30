extends CharacterBody2D

@export var speed := 300.0  # Basket movement speed

func _physics_process(delta):
	var direction := 0

	if Input.is_action_pressed("ui_left"):
		direction = -1
	elif Input.is_action_pressed("ui_right"):
		direction = 1

	velocity.x = direction * speed
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body is RigidBody2D:  # Check if it's a fruit
		print("Caught:", body.name)  # Print the fruit's name in the debugger
		body.queue_free()  # Remove fruit after catching
