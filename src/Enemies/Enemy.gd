extends KinematicBody2D

enum EnemyType { Creeper, Shooter, Mage }

export (int) var health : int = 5
export (int) var max_health : int = 5
export (float) var damage: float = 1.0
export(float) var move_speed : float = 500.0
export (float) var shoot_distance : float = 10
export (EnemyType) var enemy_type : int = EnemyType.Creeper

onready var gun_barrel_exit = get_node("Guns/GunBarrelExit")
onready var health_bar : TextureProgress = $HealthBar
var enemy_behavior : FuncRef
var weapon : Node2D
var player : Node2D
var can_fire : bool
var is_dead : bool
var death_sound : AudioStreamPlayer2D


func _ready():
	death_sound = $DeathSound
	can_fire = true
	is_dead = false
	randomize()
	
	var players = get_tree().get_nodes_in_group("Player")
	player = players[randi() % players.size()]
	
	health_bar.value = health
	(health_bar as Range).max_value = max_health

	match enemy_type:
		EnemyType.Creeper:
			enemy_behavior = funcref(self, "creeper_enemy_behavior")
		EnemyType.Shooter:
			enemy_behavior = funcref(self, "shooter_enemy_behavior")
			weapon = get_node("Guns/Pistol")
		EnemyType.Mage:
			enemy_behavior = funcref(self, "mage_enemy_behavior")


	
	pass # Replace with function body.


func _physics_process(_delta: float):
	look_at(player.get_global_position())
	
	enemy_behavior.call_func()
	
	# creeper_enemy_behavior()
	# var direction : Vector2 = player.get_global_position() - get_global_position()
	# direction = direction.normalized()
	# var _unused = move_and_slide(direction * move_speed)
	
	pass



func creeper_enemy_behavior():
	var direction : Vector2 = player.get_global_position() - get_global_position()
	direction = direction.normalized()
	
	var _unused = move_and_slide(direction * move_speed)
	
	pass



func shooter_enemy_behavior():
	var direction : Vector2 = player.get_global_position() - get_global_position()
	var distance : float = direction.length()

	if distance <= shoot_distance:
		if can_fire:
			can_fire = false
			fire(direction)
			yield(get_tree().create_timer(weapon.fire_rate), "timeout")
			can_fire = true
	else:
		creeper_enemy_behavior()
	
	return



func fire(direction: Vector2):
	var shoot_angle : float = direction.normalized().angle() 
	var bullet : Node2D = weapon.generate_bullet(shoot_angle)

	bullet.position = gun_barrel_exit.get_global_position()
	bullet.rotation = rotation

	get_tree().get_root().add_child(bullet)
	
	pass



func take_damage(external_damage: float) -> void:
	if is_dead:
		return
	
	health -= (external_damage as int)

	if health <= 0:
		health = 0
		die()
	
	health_bar.value = health
	
	pass


func die() -> void:
	# var _unused = self.connect("finished", death_sound, "_on_die")
	# set_physics_process(false)
	is_dead = true
	self.set_physics_process(false)
	death_sound.play()
	yield(death_sound, "finished")
	print("death sound completed, now ready to delete node from scene")
	self.queue_free()
	
	pass


# func _on_HitBox_body_entered(body: Node):
# 	if body.is_in_group("Bullet"):
# 		body.call_deferred("queue_free")
# 		health -= body.damage
# 		print (health as String + " === Enemy Has Been Hit")
# 	pass # Replace with function body.

