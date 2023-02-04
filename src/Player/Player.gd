extends KinematicBody2D

signal health_changed
signal max_health_changed
signal player_died
signal bullet_count_changed

export(int) var health : int = 7
export(int) var max_health : int = 7
export(float) var speed : float = 500.0
export(float) var force : float = 2000.0
# var bullet : PackedScene = preload ("res://src/Ammo/Bullet.tscn")
onready var gun_barrel_exit = get_node("Guns/GunBarrelExit")
var is_player_alive : bool = true
var direction : Vector2

var weapons : Array
var weapon : Node2D
var weapon_clip_size : int 
var weapon_remaining_bullet : int
var can_fire : bool = true


func _init():
	direction = Vector2.ZERO
	is_player_alive = true
	
	pass


func _ready():
	weapons.push_front($Guns/Pistol)
	weapons.push_front($Guns/Rifle)
	weapons.push_front($Guns/Shotgun)

	weapon = cyle_through_weapons()

	emit_signal("max_health_changed", max_health)
	emit_signal("health_changed", health)
	emit_signal("bullet_count_changed", {"clip_size": weapon_clip_size, "remaining_bullet": weapon_remaining_bullet})

	pass # Replace with function body.


func _process(_delta: float):
	if Input.is_action_pressed("move_up"):
		direction.y = - 1
	elif Input.is_action_pressed("move_down"):
		direction.y = 1
	
	if Input.is_action_pressed("move_right"):
		direction.x = 1
	elif Input.is_action_pressed("move_left"):
		direction.x = -1
	
	if Input.is_action_pressed("fire") && can_fire :
		can_fire = false
		fire()
		yield(get_tree().create_timer(weapon.fire_rate), "timeout")
		can_fire = true
	
	if Input.is_action_just_pressed("weapon_swap"):
		var _unused = cyle_through_weapons()
		can_fire = true
	
#	if Input.is_action_just_pressed("super_move"):
#		get_tree().paused = !get_tree().paused
	
	pass

func _unhandled_input(event):
	if event.is_action_pressed("super_power"):
		self.get_tree().paused = ! self.get_tree().paused
	
	pass


func _physics_process(_delta: float):
	var velocity : Vector2 = direction.normalized() * speed
	var _unused = move_and_slide(velocity)

	direction = Vector2.ZERO	# Reset direction after moving object
	look_at(get_global_mouse_position())
	
	pass


# ############################################
# ############################################
# User Defined Function
# ############################################
# ############################################


func fire():
	var bullet : Node2D = weapon.generate_bullet(rotation)

	bullet.position = gun_barrel_exit.get_global_position()
	bullet.rotation = rotation

	get_tree().get_root().add_child(bullet)

	return



func cyle_through_weapons() -> Node2D:
	weapon = weapons.pop_back()
	weapons.push_front(weapon)

	return weapon


func take_damage(external_damage: float) -> void:
	health -= (external_damage as int)
	
	if health < 0:
		health = 0
		emit_signal("player_died")
	else:
		emit_signal("health_changed", health)

	if health == 0 and is_player_alive:
		emit_signal("player_died")
		is_player_alive = false

	
	pass


func _on_HitBoxArea_body_entered(body):
	if body.is_in_group("Enemy"):
		var enemy_damage = body.damage
		take_damage(enemy_damage)
	
	pass # Replace with function body.
