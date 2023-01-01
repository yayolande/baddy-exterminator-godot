extends Node2D

enum AmmoType { StandardAmmo , RifleAmmo, ShotgunAmmo }

export var damage : float = 1
export var bullet_speed : float = 500.0
export var fire_rate : float = .3
export var bullet_timeout : float = 1
export(AmmoType) var ammo : int = AmmoType.StandardAmmo

var BulletStandard : PackedScene = preload("res://src/Ammo/Bullet.tscn")
var BulletRifle : PackedScene = preload("res://src/Ammo/BulletRiffle.tscn")
var ShotgunBullet : PackedScene = preload("res://src/Ammo/ShotgunAreaEffect.tscn")
# var BulletShotgun : PackedScene = preload()
var Bullet : PackedScene
var move_bullet : FuncRef


func _ready():
	if ammo == AmmoType.StandardAmmo :
		Bullet = BulletStandard
		move_bullet = funcref (self, "move_bullet_standard_ammo")
	elif ammo == AmmoType.RifleAmmo:
		Bullet = BulletRifle
		move_bullet = funcref (self, "move_bullet_standard_ammo")
	elif ammo == AmmoType.ShotgunAmmo :
		Bullet = ShotgunBullet
		move_bullet = funcref (self, "move_bullet_shotgun")

	pass # Replace with function body.



func generate_bullet (shot_angle: float) -> Node2D:
	var bullet = Bullet.instance()
	bullet.damage = damage
	move_bullet.call_func(bullet, shot_angle)

	return bullet



func move_bullet_standard_ammo (bullet: Node, shot_angle: float) -> void:
	var impulse_force = Vector2(1, 0) * bullet_speed;
	bullet.apply_impulse(Vector2.ZERO, impulse_force.rotated(shot_angle))

	pass



func move_bullet_shotgun (bullet: Node, shot_angle: float) -> void:
	print ("Fire Not IMPLEMENTED YET !")
	bullet.visible = shot_angle
	bullet.get_node("TimeEffect").wait_time = bullet_timeout

	pass
