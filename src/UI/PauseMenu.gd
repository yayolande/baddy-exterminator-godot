extends Control

#export(PackedScene) var scene_level_1 : PackedScene
export(String, FILE, "*.tscn") var scene_level_1_path

signal exit_to_main_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("game_pause"):
		togglePauseMenu()
		
	
	pass


func togglePauseMenu() -> void :
	var isGamePaused = get_tree().paused
	get_tree().paused = !isGamePaused
	self.visible = ! self.visible
	
	pass


func _on_ResumeBtn_pressed():
	togglePauseMenu()
	pass # Replace with function body.


func _on_ExitToMainMenuBtn_pressed():
	togglePauseMenu()
	get_tree().paused = false
	emit_signal("exit_to_main_menu")
	get_tree().change_scene("res://src/Levels/GameMenu.tscn")
	
	pass # Replace with function body.


func _on_RestartBtn_pressed():
#	get_tree().change_scene_to(scene_level_1)
#	get_tree().change_scene("res://src/Levels/Level_1.tscn")
	togglePauseMenu()
	get_tree().paused = false
	get_tree().change_scene(scene_level_1_path)
	pass # Replace with function body.


func _on_RetryBtn_pressed():
	_on_RestartBtn_pressed()
	pass # Replace with function body.
