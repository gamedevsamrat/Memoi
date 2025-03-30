extends Node2D

@export var speed: float = 300
@onready var area = $Area2D
@onready var nav_agent = $NavigationAgent2D
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var collision_polygon = $CollisionPolygon2D 

var target_position: Vector2

func _ready():
	visible = false  
	
	if animation_player:
		animation_player.play("arrowani")
	
	var co_nodes = get_tree().get_nodes_in_group("co_target")
	if co_nodes.size() > 0:
		target_position = co_nodes[0].global_position
		nav_agent.target_position = target_position
	
	area.body_entered.connect(_on_area_body_entered)

func activate():
	visible = true  

func _physics_process(delta):
	if nav_agent.is_navigation_finished():
		return
	
	var next_target = nav_agent.get_next_path_position()
	var direction = global_position.direction_to(next_target)

	global_position += direction * speed * delta
	
	var target_direction = global_position.direction_to(target_position)
	rotation = target_direction.angle()
	
	sprite.rotation = PI / 2
	queue_redraw()
	
	if global_position.distance_to(target_position) < 10:
		queue_free()

func _on_area_body_entered(body):
	print("Body entered", body.name) 
	if body.is_in_group("co_target") or body.is_in_group("walls"):
		queue_free()
