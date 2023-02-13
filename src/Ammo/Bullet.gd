extends RigidBody2D

export (Array, Texture) var images
var damage : float = .5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func destroy():
	call_deferred("queue_free")
	
	pass


func _on_VisibilityNotifier2D_screen_exited():
	destroy()
	
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	var is_same_object : bool = self.get_instance_id() == body.get_instance_id()
	
	if body.is_in_group("Damageable"):
		body.take_damage(damage)
		print("Bullet Damaged : " + body.name)
		print("Health Remaining : " + body.health as String)
		destroy()
	elif body.is_in_group("Bullet") and not is_same_object:
		print ("Collider with a Bullet")
		destroy()
	elif true and not is_same_object:
		print("Collided with something")
		destroy()
	
	
	pass


