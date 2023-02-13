extends Node2D

export(Array, Resource) var spawn_data : Array
export(PackedScene) var item_to_spawn : PackedScene
export(NodePath) var environment_to_spawn_to : NodePath

var interval_spawn : float = 0.0
var quantity_per_spawn : int = 0
var max_item_spawned : int = 0
var current_spawn_resource : Resource

var processing : bool = true
var time_accumulator : float = 0
var spawn_points : Array


func _ready():
	spawn_points = get_children()
	(spawn_data as Array).invert()		# Reverse the order so as to pop element from the back of the array (better performace wise)

	processing = true

	assert(item_to_spawn != null, "The required exported variable 'item_to_spawn' is not set for node " + self.name)
	assert(environment_to_spawn_to != null, "node [" + self.name + "] haven't defined the required 'environment_to_spawn_to', which help establishing were the item/unit will be spawned after the countdown")
	
	pass

func _process(delta):
	time_accumulator += delta
	
	if processing:
		processing = spawn_process(time_accumulator)
	
	pass

func spawn_process(time : float) -> bool :
	var can_process = true

	if time >= interval_spawn:
		var count : int = spawn_points.size()

		for n in quantity_per_spawn:
			var random = randi() % count
			var random_point : Node2D = spawn_points[random]
			var item : Node2D = item_to_spawn.instance();

			item.global_position = random_point.global_position
			item.global_rotation = random_point.global_rotation
			get_node(environment_to_spawn_to).add_child(item)
			pass

		time = 0
		can_process = fetch_spawn_data()
		pass
	
	return can_process

func fetch_spawn_data() -> bool :
	time_accumulator = 0
	var is_ok : bool = false
	
	current_spawn_resource = spawn_data.pop_back()
	if current_spawn_resource == null :
		return is_ok
	
	is_ok = true
	interval_spawn = current_spawn_resource.interval_spawn
	quantity_per_spawn = current_spawn_resource.quantity_per_spawn
	max_item_spawned = current_spawn_resource.max_spawn

	return is_ok
