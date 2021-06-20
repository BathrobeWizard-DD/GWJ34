extends Control

func _input(event):
	if event.is_action_pressed("ui_pause"):
		set_pause(!get_tree().paused)
	
func _on_MainMenu_pressed():
	set_pause(false)

func _on_Resume_pressed():
	set_pause(false)

func set_pause(val):
	get_tree().paused = val
	visible = val
