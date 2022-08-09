extends Node2D

var speed = 200
var direction = 1
var active = false
var nextDirection = -1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !active:
		return
	position.x += direction * speed * delta
	if position.x < -25 or position.x > 625:
		print("bye!!")
		active = false
		visible = false
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

func _on_grid_saucercall():
	activate()

func _on_canon_shot():
	nextDirection = -nextDirection
