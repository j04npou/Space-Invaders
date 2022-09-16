extends Node2D

signal extra_live

var score = 0
var extra_live_added = false

func _ready():
	update_lives(3)

func _on_points(points):	
	score += points
	var tmpScore = str(score)
	while tmpScore.length() < 4:
		tmpScore = "0" + tmpScore
	$score1.text = tmpScore
	
	if score > $"/root/PlayerVariables".hiscore:
		$"/root/PlayerVariables".hiscore = score
		$hiscore.text = tmpScore
		
	if score > 1500 and !extra_live_added:
		emit_signal("extra_live")
		extra_live_added = true

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
