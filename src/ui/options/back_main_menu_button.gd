extends Button

export(NodePath) var menu_root 

var _main_menu = load("res://levels/main_menu.tscn")


func _on_AudioStreamPlayer_finished() -> void:
	get_tree().get_root().add_child(_main_menu.instance())
	get_node(menu_root).queue_free()


func _on_BackMainMenuButton_button_down() -> void:
		$PressedSound.play()
