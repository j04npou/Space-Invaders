extends Node2D

var lives = 3

func _ready():
	stop_all_processes()
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	modulate = Color(1,1,1,0)
	tween.tween_property(self, "modulate", Color(1,1,1,1), 2.5)

func stop_all_processes():
	$grid.set_process(false)
	$canon.set_process(false)
	$saucer.set_process(false)
	get_tree().call_group("enemyBullets", "disable_bullet")
	$Respawn_timer.start()

func _on_canon_canonHit():
	stop_all_processes()
	substract_lives()

func substract_lives():
	if lives > 0:
		lives -= 1
		$texts.update_lives(lives)
	else:
		print("GAME OVER")
		$GameOver.gameOver()
		
func _on_Respawn_timer_timeout():
	$grid.set_process(true)
	$canon.set_process(true)
	$saucer.set_process(true)
	get_tree().call_group("enemyBullets", "set_process",true)
