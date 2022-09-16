extends Node2D

var lives = 3
var level = 0
var grid_height = [0,2,3,3,3,3,4,4,4]

func init_grid_height():
	for i in get_tree().get_nodes_in_group("enemies"):
		i.position.y += grid_height[level]*$grid.desplazamientoAlienY

func _ready():
	stop_all_processes()
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	modulate = Color(1,1,1,0)
	tween.tween_property(self, "modulate", Color(1,1,1,1), 2.5)
	init_grid_height()

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


func _on_texts_extra_live():
	lives += 1
	$texts.update_lives(lives)


func _on_grid_level_up():
	level += 1
	if level > 8:
		level = 1
		
	print("LEVEL UP" + str(level))
	$grid.queue_free()
	$levelUpTimer.start()

func _on_levelUpTimer_timeout():
	var grid = preload("res://scenes/grid.tscn").instance()
	self.add_child(grid,true)
	
	init_grid_height()
