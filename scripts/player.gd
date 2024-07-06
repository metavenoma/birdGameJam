extends CharacterBody2D

var move : = 3
var maxPos : = 56
var minPos : = 1024
var hunger : float = 10
@onready var _animated_sprite = $AnimatedSprite2D
const MAX_SPEED : = 500
const ACCEL : = 1500
const FRICTION : = 800
const GRAVITY : float = -2.5
var input = Vector2.ZERO

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		_animated_sprite.play("flying")
	elif Input.is_action_pressed("ui_down"):
		_animated_sprite.play("diving")
	else:
		_animated_sprite.play("idle")
	player_movement(delta)
	
func get_input():
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()
	
func player_movement(delta):
	input = get_input()
	
	hunger -= .03
	if hunger < 0:
		get_parent().game_over()
	if self.position.y < minPos:
		self.position.y -= GRAVITY
	if input.y == 0:
		if self.rotation <= .1:
			self.rotation += .025
		elif self.rotation >= .3  :
			self.rotation += -.050
	if self.position.y <= maxPos && input.y == -1:
		velocity = Vector2.ZERO
		return
	elif self.position.y >= minPos && input.y == 1:
		velocity = Vector2.ZERO
		return
	elif input == Vector2.ZERO:
		if velocity.length() > (FRICTION * delta):
			velocity -= velocity.normalized() * (FRICTION * delta)
		else:
			velocity = Vector2.ZERO
	else:
			velocity += (input * ACCEL * delta)
			if input.y == -1:
				if self.rotation >= -.45:
					self.rotation += -.04
			velocity += (input * ACCEL * delta)
			if input.y == 1:
				if self.rotation <= .45:
					self.rotation += .04
			velocity = velocity.limit_length(MAX_SPEED)
	move_and_slide()
#func _physics_process(delta):
#
	#_animated_sprite.play("flying")
	#if Input.is_action_pressed("ui_up") && position.y != minPos:
		#position.y -= move 
	#if Input.is_action_pressed("ui_down") && position.y != maxPos:
		#position.y += move
