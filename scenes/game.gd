extends Node2D

var lives = 3
var level = 0
var grid_height = [0,2,4,5,5,5,6,6,6]

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
	lives -= 1
	$texts.update_lives(lives)
	if lives < 1:
		print("GAME OVER")
		_on_gameOver()
		
func _on_gameOver():
	stop_all_processes()
	$GameOver.gameOver()

func _on_Respawn_timer_timeout():
	$grid.set_process(true)
	$canon.set_process(true)
	$saucer.set_process(true)
	get_tree().call_group("enemyBullets", "set_process",true)


func _on_texts_extra_live():
	lives += 1
	$AudioStream_ExtraLive.play()
	$texts.update_lives(lives)


func _on_grid_level_up():
	level += 1
	if level > 8:
		level = 1
		
	print("LEVEL UP" + str(level))
	$grid.queue_free()
	get_tree().call_group("bunkers", "queue_free")
	get_tree().call_group("enemyBullets", "disable_bullet")
	$levelUpTimer.start()

func _on_levelUpTimer_timeout():
	var grid = preload("res://scenes/grid.tscn").instance()
	self.add_child(grid,true)
	create_bunkers(Vector2(86,591))
	create_bunkers(Vector2(207,591))
	create_bunkers(Vector2(328,591))
	create_bunkers(Vector2(449,591))
	$canon.position.x = 60
	_on_Respawn_timer_timeout()
#	var _reload = $Bunker1.reload_current_scene()
	
	init_grid_height()
	
func create_bunkers(pos):
	var bunker = preload("res://scenes/bunker.tscn").instance()
	self.add_child(bunker,true)
	bunker.position = pos
