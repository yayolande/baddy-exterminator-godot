extends Control

onready var menuContainer : Control = get_node("ContainerMenu")
var currentButton : Control
var indexCurrentButtonSelection = 0
var levelScene : PackedScene = preload("res://src/Levels/Level_1.tscn")

func _ready():
	# $ContainerMenu/StartGameButton.grab_focus()
	# var menuChildren = $ContainerMenu.get_children();
	# currentButton = menuChildren[indexCurrentButtonSelection] as Control

	currentButton = menuContainer.get_child(indexCurrentButtonSelection) as Control
	currentButton.grab_focus()
	pass

func _process(_delta):
	if Input.is_action_just_pressed("move_up"):
		getPreviousMenuButton()
	if Input.is_action_just_pressed("move_down"):
		getNextMenuButton()
	
	pass


func getNextMenuButton() -> void :
	indexCurrentButtonSelection += 1
	indexCurrentButtonSelection = setCurrentMenuButton(indexCurrentButtonSelection)
	
	return

func getPreviousMenuButton() -> void :
	indexCurrentButtonSelection -= 1
	indexCurrentButtonSelection = setCurrentMenuButton(indexCurrentButtonSelection)

	pass

func setCurrentMenuButton(index : int) -> int :
	var menuItemCount : int = menuContainer.get_child_count()

	if index >= menuItemCount:
		index = 0
	elif index < 0:
		index = menuItemCount - 1
		
	currentButton = menuContainer.get_child(index)
	currentButton.grab_focus()

	return index

# region
func _on_StartGameButton_pressed():
	var _scene = get_tree().change_scene_to(levelScene)
	pass # Replace with function body.


func _on_QuitButton_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_SettingsButton_pressed():
	print("Not Implemented")
	pass # Replace with function body.

# endregion
