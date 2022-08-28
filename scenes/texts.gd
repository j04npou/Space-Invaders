extends Node2D

var score = 0
var lives = 3

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
