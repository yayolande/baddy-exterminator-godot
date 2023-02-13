extends Control


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
	emit_signal("exit_to_main_menu")
	togglePauseMenu()
	
	pass # Replace with function body.
