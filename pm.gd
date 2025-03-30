extends CharacterBody2D

@export var speed: float = 200.0
@export var max_jump_force: float = 600.0 
@export var min_jump_force: float = 200.0 
@export var gravity: float = 1000.0
@export var max_charge_time: float = 1.0 
@export var respawn_position: Vector2 = Vector2(452, 351) 

@onready var animation_player = $AnimationPlayer 

var facing_direction: int = 1  
var jump_charge: float = 0.0
var is_charging_jump: bool = false

func _ready():
	add_to_group("player")
	
	var death_zones = get_tree().get_nodes_in_group("death_zone")
	for zone in death_zones:
		if zone.has_signal("body_entered"):
			zone.body_entered.connect(_on_death_zone_body_entered)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor() and Input.is_action_pressed("ui_accept"):
		if not is_charging_jump:
			is_charging_jump = true
			jump_charge = 0.0
		jump_charge = min(jump_charge + delta, max_charge_time)
	
	if is_charging_jump and Input.is_action_just_released("ui_accept"):
		var jump_percentage = jump_charge / max_charge_time
		var current_jump_force = lerp(min_jump_force, max_jump_force, jump_percentage)
		
		velocity.y = -current_jump_force  
		velocity.x = facing_direction * (current_jump_force * 0.5)  
		
		is_charging_jump = false
		jump_charge = 0.0
	
	if is_on_floor() and not is_charging_jump:
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * speed
			
			if direction > 0:
				facing_direction = 1
				play_animation("right")
			else:
				facing_direction = -1
				play_animation("left")
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	
	update_animation_state()

func play_animation(anim_name: String):
	if animation_player.has_animation(anim_name) and animation_player.current_animation != anim_name:
		animation_player.play(anim_name)

func update_animation_state():
	if not is_on_floor():
		if facing_direction == 1:
			play_animation("jump_right")
		else:
			play_animation("jump_left")
	elif is_charging_jump:
		if facing_direction == 1:
			play_animation("charge_right")
		else:
			play_animation("charge_left")
	elif is_on_floor() and abs(velocity.x) < 10:
		if facing_direction == 1:
			play_animation("idle_right")
		else:
			play_animation("idle_left")

func respawn():
	global_position = respawn_position
	
	velocity = Vector2.ZERO
	
	is_charging_jump = false
	jump_charge = 0.0
	
	if facing_direction == 1:
		play_animation("idle_right")
	else:
		play_animation("idle_left")

func _on_death_zone_body_entered(body):
	if body == self:
		respawn()
