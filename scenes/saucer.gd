extends Node2D

var speed = 200
var direction = 1
var active = false
var nextDirection = -1

func _ready():
	visible = false

func _process(delta):
	if !active:
		return
	position.x += direction * speed * delta
	if position.x < -25 or position.x > 625:
		var tween = get_tree().create_tween()
		tween.tween_property($AnimatedSprite, "modulate", Color(1,1,1,0), 0.2)
	if position.x < -70 or position.x > 670:
		print("bye!!")
		active = false
#		visible = false
		$Timer.start()

func die():
	$AnimatedSprite.animation = "death"
	$saucer.collision_layer = 0
	$saucer.collision_mask = 0
	$AnimatedSprite.play()
	active = false

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()
	$Timer.start()
	visible = false

func _on_Timer_timeout():
	activate()
	
# warning-ignore:function_conflicts_variable
func activate():
	active = true
	visible = true
	$AnimatedSprite.animation = "default"
	$saucer.collision_layer = 1
	$saucer.collision_mask = 1
	direction = nextDirection
	if nextDirection > 0:
		position.x = -25
	else:
		position.x = 625
	print("saucer!!!")
	
	$AnimatedSprite.modulate = Color(1,1,1,0)
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite, "modulate", Color(1,1,1,1), 0.2)

func _on_grid_saucercall():
	activate()

func _on_canon_shot():
	nextDirection = -nextDirection
