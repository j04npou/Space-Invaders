extends Node2D

export var bulletType = 0
var rng = RandomNumberGenerator.new()
var speed = 200
var speed_value = 200
var anim
var active = false
var steps = 0
var stepsTable = [30,10,11,8,7]
var pointsTable = [0,200,1000,2000,3000]
var playerScore = 0

func _ready():
	add_to_group("enemyBullets")
	$RollingAnim.visible = false
	$SquigglyAnim.visible = false
	$PlungerAnim.visible = false
	
	if bulletType == 0:
		anim = $RollingAnim
	elif bulletType == 1:
		anim = $SquigglyAnim
	else:
		anim = $PlungerAnim
		
	anim.visible = false
	anim.animation = "default"
		
func _process(delta):
	if !active:
		var stepsToFire = stepsTable[0]
		for i in pointsTable.size():
			if playerScore > pointsTable[i]:
				stepsToFire = stepsTable[i]
		
		var stepMin = stepsToFire * 10
		
		for i in get_tree().get_nodes_in_group("enemyBullets"):
			if i.active:
				if i.steps < stepMin:
					stepMin = i.steps

		if stepMin  >= stepsToFire * 10:
			shot()
		else:
			return
		
	rng.randomize()
	position.y += speed * delta
	steps += speed * delta
	if position.y > 725:
		position.y = 725
		speed = 0
		explota()
	if position.y > 570:
		modulate = Color(0,1,0,1)
	else:
		modulate = Color(1,1,1,1)

func _on_Area2D_body_entered(body):
	body.get_parent().die()
	explota()

func _on_Area2D_area_entered(area):
	print("area "+area.name)
#	queue_free()

func explota():
	$Area2D.collision_layer=0
	$Area2D.collision_mask=0
	speed = 0
	steps = 0
	$Timer.start()
	anim.play("explosion")

func shot():
	active = true
	anim.visible = true
	speed = speed_value
	position.y = 450
	position.x = rng.randi_range(65, 550)
	anim.play("default")
	$Area2D.collision_layer=1
	$Area2D.collision_mask=1

func _on_Timer_timeout():
	anim.visible = false
	active = false
