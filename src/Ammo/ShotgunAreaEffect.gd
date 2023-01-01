extends Node2D

var damage = 2
onready var time_effect : Timer = get_node("TimeEffect")
onready var cone_image : Sprite = get_node("Sprite")
var arr : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	time_effect.start()
	pass # Replace with function body.


func _process(_delta):
	var time_left : float = time_effect.time_left
	cone_image.modulate.a = time_left
	# print ("time left : " + (time_left as String))
	
	pass


func destroy():
	call_deferred("queue_free")
	
	pass


func _on_TimeEffect_timeout():
	destroy()
	
	pass # Replace with function body.




func _on_Area2D_body_entered(body:Node):
	var is_a_previous_object = arr.has(body.get_instance_id())

	if body.is_in_group("Damageable") and !is_a_previous_object:
		body.take_damage(damage)
		print("Shotgun Damaged : " + body.name)
		print("Health Remaining : " + body.health as String)

		arr.push_back(body.get_instance_id())
	
	pass # Replace with function body.


