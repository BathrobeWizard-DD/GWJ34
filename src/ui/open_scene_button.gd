extends Button

export(PackedScene) var scene: PackedScene



func _on_PressedSound_finished() -> void:
	get_tree().get_root().add_child(scene.instance())
	get_parent().get_parent().queue_free()


func _on_Play_button_down() -> void:
	$PressedSound.play()
