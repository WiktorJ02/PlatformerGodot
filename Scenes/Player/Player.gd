extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

@export var MAX_SPEED : int = 200
@export var JUMP_VELOCITY : int = 300
@export var gravity : float = 900
@export var acceleration : int = 15

var was_moving = false

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 2000:
			velocity.y = 2000
		if velocity.y > 0:
			anim.play("fall")
	# Jump
	if is_on_floor():
		
		if Input.is_action_just_pressed("Jump"):
			velocity.y -= JUMP_VELOCITY
			anim.play("jump")
			move_and_slide()

	# Movement
	if Input.is_action_pressed("Right"):
		velocity.x += acceleration
		anim.flip_h = false
		if is_on_floor() && velocity.x > 0:
			anim.play("run")
		was_moving = true
	elif Input.is_action_pressed("Left"):
		velocity.x -= acceleration
		anim.flip_h = true
		if is_on_floor() && velocity.x < 0:
			anim.play("run")
		was_moving = true
	else:
		velocity.x = lerp(velocity.x,0.0,0.2)
		was_moving = false
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	if is_on_floor() && !was_moving:
		anim.play("idle")
	move_and_slide()
	
	
		
