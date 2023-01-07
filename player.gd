extends KinematicBody2D

onready var _animated_sprite = $AnimatedSprite
export (int) var speed = 200
var vel = Vector2()

func get_input():
	vel = Vector2()
	if Input.is_action_pressed("right"):
		_animated_sprite.play("move")
		_animated_sprite.flip_h = false
		vel.x += 1
	if Input.is_action_pressed("left"):
		_animated_sprite.play("move")
		_animated_sprite.flip_h = true
		vel.x -= 1
	if Input.is_action_pressed("down"):
		vel.y += 1
	if Input.is_action_pressed("up"):
		vel.y -= 1
	else:
		_animated_sprite.stop()
	vel = vel.normalized() * speed
		

func _physics_process(_delta):
	get_input()
	vel = move_and_slide(vel)

