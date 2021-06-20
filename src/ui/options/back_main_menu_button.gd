extends Button

export(NodePath) var menu_root 

var _main_menu = load("res://levels/main_menu.tscn")


func _on_AudioStreamPlayer_finished() -> void:
	get_tree().change_scene_to(_main_menu)


func _on_BackMainMenuButton_button_down() -> void:
		$PressedSound.play()
