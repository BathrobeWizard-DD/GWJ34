extends Button

export(PackedScene) var scene: PackedScene



func _on_PressedSound_finished() -> void:
	get_tree().change_scene_to(scene)


func _on_Play_button_down() -> void:
	$PressedSound.play()
