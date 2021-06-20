extends Label

func _process(_delta):
	text = "SCORE: %d\nHIGH SCORE: %d\n" % [Score.score, Score.high_score]
