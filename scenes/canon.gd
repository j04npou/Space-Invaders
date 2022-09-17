extends Node2D

var speed = 170
var isBulletReady = true
signal shot #connect to saucer to change direction based on number of fires
signal canonHit #connect to game to control global death animation

func _process(delta):
	visible=true
	if Input.is_action_pressed("ui_left"):
		position.x -= speed * delta
	elif Input.is_action_pressed("ui_right"):
		position.x += speed * delta
		
	$"/root/PlayerVariables".canonX = position.x
		
	if Input.is_action_pressed("ui_accept") and isBulletReady:
		isBulletReady = false
		var bullet = preload("res://scenes/canon_bullet.tscn").instance()
		get_parent().add_child(bullet)
		bullet.position = position - Vector2(0,10)
		bullet.connect("bulletReady", self, "_on_bulletReady")
		emit_signal("shot")
	if position.x < 60:
		position.x = 60
	elif position.x > 540:
		position.x = 540

func _on_bulletReady():
	isBulletReady = true
	
func die():
	$AudioStreamPlayer.play()
	$Canon.collision_layer = 0
	$Canon.collision_mask = 0
	$AnimatedSprite.play("death")
	emit_signal("canonHit")

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.animation = "default"
	visible = false
	position.x = 60
	$Canon.collision_layer = 1
	$Canon.collision_mask = 1
	$AnimatedSprite.stop()
	set_process(false)
