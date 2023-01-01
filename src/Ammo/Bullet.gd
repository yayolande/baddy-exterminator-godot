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
	if body.is_in_group("Damageable"):
		body.take_damage(damage)
		print("Bullet Damaged : " + body.name)
		print("Health Remaining : " + body.health as String)
		# destroy()
		visible = true
	
	destroy()
	
	pass


