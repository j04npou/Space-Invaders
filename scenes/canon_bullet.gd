extends Node2D

signal bulletReady

var speed = 700

func _ready():
	$AnimatedSprite.animation = "default"

func _process(delta):
	position.y -= speed * delta
	if position.y < 120:
		speed = 0
		$AnimatedSprite.play("explosion")
	if position.y > 570:
		modulate = $"/root/PlayerVariables".green
	else:
		modulate = $"/root/PlayerVariables".blue

func _on_Area2D_body_entered(body):
#	print(body.name)
	$CanonBullet.collision_layer = 0
	$CanonBullet.collision_mask = 0
	body.get_parent().die()
	$AnimatedSprite.play("explosion")
	speed = 0
	if "alien" in body.name:
		$AnimatedSprite.visible = false
	if position.y > 570:
		modulate = $"/root/PlayerVariables".green

func _on_AnimatedSprite_animation_finished():
	emit_signal("bulletReady")
	queue_free()
