extends KinematicBody2D

export (float) var GRAVITY = 20
export (float) var MAX_SPEED = 400
export (float) var MIN_SPEED = 50
export (float) var JUMP_HEIGTH = 2
export (float) var ACCELERATION = 50
export (float) var ACCELERATIONLEFT = 50

const UP = Vector2(0,-1)
var motion = Vector2()
var real_jump = -425 * JUMP_HEIGTH
var right = true

func _physics_process(delta):
	var friction = false
	motion.y += GRAVITY
	if right:
		motion.x = 100
	else:
		motion.x = -100
	if Input.is_action_pressed("ui_right"):
		if right:
			motion.x = min(MAX_SPEED , motion.x + ACCELERATION)
			run_rigth_fast()
		else:
			motion.x = min(-MIN_SPEED , motion.x + ACCELERATION)
			run_left_low()
	elif Input.is_action_pressed("ui_left"):
		if right:
			motion.x = max( MIN_SPEED , motion.x - ACCELERATIONLEFT)
			run_right_low()
		else:
			motion.x = max(-MAX_SPEED , motion.x - ACCELERATION)
			run_left_fast()
	else:
		if right:
			run_rigth()
		else:
			run_left()
		friction = true
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = real_jump	
		if friction == true:
			motion.x = lerp(motion.x , 0 , 0.3)
			#inercia (desde, hasta, porcentaje de rozamiento)
	else:
		if friction == true:
			motion.x = lerp(motion.x , 0 , 0.1)
		if motion.y < 0:
			$PlayerAnimatedSprite.play("Jump")
		else:
			$PlayerAnimatedSprite.play("Fall")
		
	motion = move_and_slide(motion, UP)

func run_rigth():
	$PlayerAnimatedSprite.set_flip_h(false)
	$PlayerAnimatedSprite.play("Run")
	
func run_rigth_fast():
	$PlayerAnimatedSprite.set_flip_h(false)
	$PlayerAnimatedSprite.play("Run_fast")
	
func run_right_low():
	$PlayerAnimatedSprite.set_flip_h(false)
	$PlayerAnimatedSprite.play("Run_low")
	
func run_left():
	$PlayerAnimatedSprite.set_flip_h(true)
	$PlayerAnimatedSprite.play("Run")
	
func run_left_fast():
	$PlayerAnimatedSprite.set_flip_h(true)
	$PlayerAnimatedSprite.play("Run_fast")
	
func run_left_low():
	$PlayerAnimatedSprite.set_flip_h(true)
	$PlayerAnimatedSprite.play("Run_low")




func _on_Area2D_area_entered(area):
	if area.is_in_group('flip_right'):
		right = true
	if area.is_in_group('flip_left'):
		right = false