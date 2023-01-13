extends KinematicBody2D

onready var _animated_sprite = $AnimatedSprite
export (int) var speed = 200
export var bullet_speed = 1000
export var firerate = 0.2
var can_fire = true
var vel = Vector2()
var projectile = preload("res://scenes/projectile.tscn")

func _physics_process(delta):
	var axisX = Input.get_action_strength("right") - Input.get_action_strength("left")
	var axisY = Input.get_action_strength("up") - Input.get_action_strength("down")
	vel = Vector2()
	var screen_size = get_viewport_rect().size
	var position
	
	if Input.is_action_pressed("exit"):
		get_tree().quit()
		
	if Input.is_action_pressed("interact"):
	#	current weapon feels like bubble gun (spd = 200; bulletspd = 1000; firerate = .2)
		var bullet_inst = projectile.instance()
		bullet_inst.position = $projectileSpawner.get_global_position()
		bullet_inst.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_inst)
		can_fire = false
		yield(get_tree().create_timer(firerate), "timeout")
		can_fire = true
		
	if axisX > 0:#r
		_animated_sprite.play("move")
		_animated_sprite.flip_h = false
		vel.x += 1
	elif axisX < 0:#l
		_animated_sprite.play("move")
		_animated_sprite.flip_h = true
		vel.x -= 1
	elif axisY > 0:#d
		_animated_sprite.play("move")
		vel.y -= 1
	elif axisY < 0:#u
		_animated_sprite.play("move")
		vel.y += 1
	else:
		_animated_sprite.play("idle")
	vel = vel.normalized() * speed
	vel = move_and_slide(vel)
#	position.x = clamp(position.x, 0, screen_size.x)
#	position.y = clamp(position.y, 0, screen_size.y)

