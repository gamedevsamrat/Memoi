extends TextureProgressBar

@export var timer_duration: float = 30.0  

var time_left: float

func _ready():
	time_left = timer_duration
	value = max_value 
	set_process(true)

func _process(delta):
	time_left -= delta
	value = (time_left / timer_duration) * max_value 

	if time_left <= 0:
		transition_to_level1result()

func transition_to_level1result():
	var co_count = get_tree().get_nodes_in_group("co_group").size()
	var ae_count = get_tree().get_nodes_in_group("ae_group").size()
	
	var level1result_scene = load("res://scenes/level1result.tscn").instantiate()
	level1result_scene.co_data = co_count 
	level1result_scene.ae_data = ae_count 

	get_tree().root.add_child(level1result_scene)
	get_tree().current_scene.queue_free()
