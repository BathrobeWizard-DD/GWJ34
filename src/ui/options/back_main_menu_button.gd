extends Button

export(NodePath) var menu_root 

var _main_menu = load("res://levels/main_menu.tscn")


func _on_MainMenuButton_pressed() -> void:
	get_tree().get_root().add_child(_main_menu.instance())
	get_node(menu_root).queue_free()
