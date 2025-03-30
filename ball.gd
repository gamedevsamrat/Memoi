extends CharacterBody2D

@export var initial_speed := 400.0
@export var max_speed := 1000.0
@export var speed_increment := 30.0
@export var brick_speed_boost := 20.0  
@export var speed_increment_interval := 10.0

var speed: float
var velocity_direction: Vector2

func _ready():
	randomize()
	speed = initial_speed
	velocity_direction = Vector2(randf_range(-1, 1), -1).normalized()
	
	var speed_timer = Timer.new()
	add_child(speed_timer)
	speed_timer.wait_time = speed_increment_interval
	speed_timer.connect("timeout", Callable(self, "_on_speed_increase"))
	speed_timer.start()

func _physics_process(delta):
	var collision = move_and_collide(velocity_direction * speed * delta)
	
	if collision:
		var collider = collision.get_collider()
		
		velocity_direction = velocity_direction.bounce(collision.get_normal())
		velocity_direction = velocity_direction.rotated(randf_range(-0.1, 0.1))
		
		if collider is StaticBody2D and collider.has_method("hit"):
			collider.hit()
			increase_speed(collider)

func _on_speed_increase():
	speed = min(speed + speed_increment, max_speed)
	print("Ball speed increased to: ", speed)

func increase_speed(brick):
	if "Brick1" in brick.name or "Brick2" in brick.name:
		speed = min(speed + brick_speed_boost, max_speed)
	elif "Brick3" in brick.name or "Brick4" in brick.name:
		speed = min(speed + brick_speed_boost * 1.5, max_speed) 

	print("Ball speed increased: ", speed)

func reset_ball():
	speed = initial_speed
	velocity_direction = Vector2(randf_range(-1, 1), -1).normalized()
