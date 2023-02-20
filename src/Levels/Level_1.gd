extends Node2D

#export(PackedScene) var game_completed_scene : PackedScene
#export(PackedScene) var game_lost_scene : PackedScene


func _on_SpawnPoint_wave_set_completed():
#	get_tree().change_scene_to(game_completed_scene)
	get_tree().change_scene("res://src/UI/GameCompleted.tscn")
	pass # Replace with function body.


func _on_Player_player_died():
#	get_tree().change_scene_to(game_lost_scene)
	get_tree().change_scene("res://src/UI/GameLost.tscn")
	pass # Replace with function body.
