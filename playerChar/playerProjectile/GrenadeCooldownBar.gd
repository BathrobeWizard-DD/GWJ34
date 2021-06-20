extends Control

func blink():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("Blink")

func set_value(val: int):
	$Box/Progress.value = val
