extends CharacterBody2D

@export var initial_speed := 600.0
@export var max_speed := 1200.0
@export var speed_increment := 50.0
@export var speed_increment_interval := 15.0

@export var paddle_width := 200.0  
@export var min_paddle_width := 100.0  
@export var max_paddle_width := 300.0  
@export var width_decrement := 10.0 

const FIXED_Y := 573  

var speed: float
var current_width: float

func _ready():
	speed = initial_speed
	current_width = paddle_width
	
	var speed_timer = Timer.new()
	add_child(speed_timer)
	speed_timer.wait_time = speed_increment_interval
	speed_timer.connect("timeout", Callable(self, "_on_difficulty_increase"))
	speed_timer.start()
	
	$CollisionShape2D.shape.size.x = current_width

func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed
	move_and_slide()
	
	position.y = FIXED_Y

func _on_difficulty_increase():
	speed = min(speed + speed_increment, max_speed)
	current_width = max(current_width - width_decrement, min_paddle_width)
	$CollisionShape2D.shape.size.x = current_width
	
