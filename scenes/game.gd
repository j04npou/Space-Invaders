extends Node2D

func _on_canon_canonHit():
	$grid.set_process(false)
	$canon.set_process(false)
	$saucer.set_process(false)
	get_tree().call_group("enemyBullets", "disable_bullet")
#	restar vidas
	$Respawn_timer.start()

func _on_Respawn_timer_timeout():
	$grid.set_process(true)
	$canon.set_process(true)
	$saucer.set_process(true)
	get_tree().call_group("enemyBullets", "set_process",true)
