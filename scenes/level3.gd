extends Node2D
@export var brick_scenes: Array[PackedScene]  
@export var brick_size: Vector2 = Vector2(50, 50)  
@export var brick_padding: Vector2 = Vector2(5, 5)  
@export var testing_mode: bool = false
@export var test_brick_count: int = 3

const AREA_TOP_LEFT = Vector2(26, 17)
const AREA_TOP_RIGHT = Vector2(1125, 17)
const AREA_BOTTOM_RIGHT = Vector2(1125, 358)
const AREA_BOTTOM_LEFT = Vector2(26, 339)
var brick_columns: int
var brick_rows: int
var initial_brick_count: int = 0

func _ready():
	randomize()
	setup_grid()
	
	initial_brick_count = $Bricks.get_child_count()
	print("Initial", initial_brick_count)
	
	var check_timer = Timer.new()
	check_timer.wait_time = 1.0
	check_timer.autostart = true
	check_timer.connect("timeout", Callable(self, "check_brick_status"))
	add_child(check_timer)

func weighted_brick_selection():
	var brick_weights = {
		"Brick1": 0.2,
		"Brick2": 0.2,
		"Brick3": 0.3,
		"Brick4": 0.3
	}
	
	var brick_type_options = []
	for brick_name in brick_weights:
		var matching_scene = brick_scenes.filter(func(scene): 
			return scene.resource_path.get_file().begins_with(brick_name)
		)
		
		if matching_scene.is_empty():
			printerr("No scene found for ", brick_name)
			continue
		
		var num_entries = int(brick_weights[brick_name] * 10)
		for i in range(num_entries):
			brick_type_options.append(matching_scene[0])
	
	return brick_type_options

func setup_grid():
	if brick_scenes.is_empty():
		printerr("No brick scenes assigned!")
		return
	
	var bricks_container = $Bricks  
	
	if testing_mode:
		print("TESTING MODE: Spawning only", test_brick_count, "bricks")
		var brick_type_options = weighted_brick_selection()
		
		for i in range(test_brick_count):
			var brick_type = brick_type_options[randi() % brick_type_options.size()]
			var brick_instance = brick_type.instantiate()
			
			brick_instance.position = Vector2(100 + (i * 100), 100)
			bricks_container.add_child(brick_instance)
		
		print("Testing: Spawned", test_brick_count, "bricks. Destroy them all to verify level advancement.")
		return
	
	var area_width = AREA_TOP_RIGHT.x - AREA_TOP_LEFT.x
	var area_height = AREA_BOTTOM_RIGHT.y - AREA_TOP_RIGHT.y
	
	brick_columns = floor((area_width + brick_padding.x) / (brick_size.x + brick_padding.x))
	brick_rows = floor((area_height + brick_padding.y) / (brick_size.y + brick_padding.y))
	
	brick_columns = int(brick_columns * 1.3)
	brick_rows = int(brick_rows * 1.3)
	
	var total_width = (brick_columns * brick_size.x) + ((brick_columns - 1) * brick_padding.x)
	var total_height = (brick_rows * brick_size.y) + ((brick_rows - 1) * brick_padding.y)
	
	var start_x = AREA_TOP_LEFT.x + max(0, (area_width - total_width) / 2)
	var start_y = AREA_TOP_LEFT.y + max(0, (area_height - total_height) / 2)
	
	var brick_type_options = weighted_brick_selection()
	
	for row in range(brick_rows):
		for col in range(brick_columns):
			var brick_type = brick_type_options[randi() % brick_type_options.size()]
			var brick_instance = brick_type.instantiate()
			
			var pos_x = start_x + (col * (brick_size.x + brick_padding.x))
			var pos_y = start_y + (row * (brick_size.y + brick_padding.y))
			
			if pos_x + brick_size.x <= AREA_TOP_RIGHT.x and pos_y + brick_size.y <= AREA_BOTTOM_RIGHT.y:
				brick_instance.position = Vector2(pos_x, pos_y)
				bricks_container.add_child(brick_instance)
	
	print("Spawned ", brick_columns, " columns and ", brick_rows, " rows of bricks")

func _on_wall_bottom_body_entered(body):
	if body.name == "Ball": 
		print("Ball fell!")
		
		var ball = body
		if ball.has_node("Camera2D"):
			var camera = ball.get_node("Camera2D")
			camera.set_process(false)
			camera.enabled = false
		
		await get_tree().create_timer(0.5).timeout  
		get_tree().change_scene_to_file("res://scenes/main.tscn")

func check_brick_status():
	if not is_instance_valid($Bricks):
		print("Bricks node is not valid")
		return
		
	var current_count = $Bricks.get_child_count()
	
	if current_count != initial_brick_count:
		print("Current brick count: ", current_count, " (started with ", initial_brick_count, ")")
		initial_brick_count = current_count 
	
	if current_count == 0:
		print("Moving to L 4...")

		for child in get_children():
			if child is Timer:
				child.stop()
				
		await get_tree().create_timer(1.0).timeout  
		get_tree().change_scene_to_file("res://scenes/level4.tscn")
		
		
		
