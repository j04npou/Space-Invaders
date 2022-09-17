extends Node2D

export var bulletType = 0
#                   plunger                               squiggly
var columnTable = [ [1,7,1,1,1,4,11,1,6,3,1,1,11,9,2,8] , [4,11,1,6,3,1,1,11,9,2,8,2,11,4,7,10] ]
var lastColumnShot = 0
var rng = RandomNumberGenerator.new()
var speed = 250
var speed_value = 250
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
		if $"/root/PlayerVariables".turn == bulletType:
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

				if $"/root/PlayerVariables".turn == bulletType:
					$"/root/PlayerVariables".turn += 1
					if $"/root/PlayerVariables".turn > 2:
						$"/root/PlayerVariables".turn = 0

	if !active:
		return

	rng.randomize()
	position.y += speed * delta
	steps += speed * delta
	if position.y > 725:
		position.y = 725
		speed = 0
		explode()
	if position.y > 570:
		modulate = $"/root/PlayerVariables".green
	else:
		modulate = Color(1,1,1,1)

func _on_Area2D_body_entered(body):
	body.get_parent().die()
	explode()

func _on_Area2D_area_entered(area):
	area.get_parent()._on_AnimatedSprite_animation_finished()
	explode()

func explode():
	$EnemyBullet.collision_layer=0
	$EnemyBullet.collision_mask=0
	speed = 0
	steps = 0
	$Timer.start()
	anim.play("explosion")
	
func disable_bullet():
	set_process(false)
	anim.visible = false
	$EnemyBullet.collision_layer=0
	$EnemyBullet.collision_mask=0
	speed = 0
	steps = 0
	
	active = false

func shot():
	var enemy = null
	
	if bulletType == 0:
		for i in get_tree().get_nodes_in_group("enemies"):
			if i.position.x > $"/root/PlayerVariables".canonX -7 and i.position.x < $"/root/PlayerVariables".canonX +7:
				enemy = i
				break
		if enemy != null:
			for i in get_tree().get_nodes_in_group("enemies"):
					if enemy.position.y < i.position.y and enemy.column == i.column:
						enemy = i
						
	else:
		for i in get_tree().get_nodes_in_group("enemies"):
			if columnTable[bulletType-1][lastColumnShot] == i.column:
				if enemy != null:
					if enemy.position.y < i.position.y:
						enemy = i
				else:
					enemy = i
				
		lastColumnShot += 1
		if lastColumnShot > 14:
			lastColumnShot = 0
		
	if enemy != null:
		active = true
		anim.visible = true
		speed = speed_value
		position.y = enemy.position.y +25
		position.x = enemy.position.x
		anim.play("default")
		$EnemyBullet.collision_layer=1
		$EnemyBullet.collision_mask=1

func _on_Timer_timeout():
	anim.visible = false
	active = false
#	$"/root/PlayerVariables".turn = 0


func _on_texts_points_update(score):
	playerScore = score
