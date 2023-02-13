extends Control


#onready var player_health_bar = $PlayerHealthBar
onready var health_bar : TextureProgress = $PlayerHealthBar/HealthBar
onready var health_number : Label = $PlayerHealthBar/HealthNumber
var player : Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var players = get_tree().get_nodes_in_group("Player")
	player = players[0] as Node2D

	var _unused = player.connect("health_changed", self, "_on_player_health_changed")
	_unused = player.connect("max_health_changed", self, "_on_player_max_health_changed")
	_unused = player.connect("bullet_count_changed", self, "_on_player_bullet_count_changed")
	
	# health_bar = player_health_bar.get_node("HealthBar")
	# health_number = player_health_bar.get_node("HealthNumber")
	
	
	var player_current_health = player.health
	health_bar.value = player_current_health
	
	var player_max_health = player.max_health
	health_bar.max_value = player_max_health
	
	health_number.text = "{current_health}/{max_health}".format({"current_health": player_current_health, "max_health": player_max_health})
	
	pass # Replace with function body.





func _on_player_health_changed (health: int):
	health_bar.value = health

	update_health_bar_UI(health, health_bar.max_value as int)
	pass


func _on_player_max_health_changed(max_health: int):
	health_bar.max_value = max_health

	update_health_bar_UI(health_bar.value as int, max_health)
	pass


func _on_player_bullet_count_changed(_bullet_stat: Dictionary):
	print ("Bullet UI Count NOT IMPLEMENTED YET !")
	
	pass


func update_health_bar_UI (health: int, max_health: int) -> void:
	var player_current_health = health
	var player_max_health = max_health
	
	health_bar.value = player_current_health
	health_bar.max_value = player_max_health
	health_number.text = "{current_health}/{max_health}".format({"current_health": player_current_health, "max_health": player_max_health})
	pass


func _on_PauseMenu_exit_to_main_menu():
	var _unuser = get_tree().change_scene("res://src/Levels/GameMenu.tscn")
	print("Quit to Main Menu not implemented yet ! \n Issue with Best Practice for Scene Management.")
	
	pass # Replace with function body.
