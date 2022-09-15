extends Node2D

var score = 0

func _ready():
	update_lives(3)

func _on_points(points):
	print(points)
	score += points
	var tmpScore = str(score)
	while tmpScore.length() < 4:
		tmpScore = "0" + tmpScore
	$score1.text = tmpScore
	
	if score > $"/root/PlayerVariables".hiscore:
		$"/root/PlayerVariables".hiscore = score
		$hiscore.text = tmpScore

func update_lives(lives):
	$lives.text = str(lives)
	if lives == 4:
		$lives_draw1.visible = true
		$lives_draw2.visible = true
		$lives_draw3.visible = true
	elif lives == 3:
		$lives_draw1.visible = true
		$lives_draw2.visible = true
		$lives_draw3.visible = false
	elif lives == 2:
		$lives_draw1.visible = true
		$lives_draw2.visible = false
		$lives_draw3.visible = false
	elif lives == 1:
		$lives_draw1.visible = false
		$lives_draw2.visible = false
		$lives_draw3.visible = false
