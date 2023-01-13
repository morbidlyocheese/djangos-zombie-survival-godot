extends RigidBody2D

const speed = 100
var vel = Vector2.ZERO
export var weap_vel = 25

func _physics_process(delta):
	translate(vel * speed * delta)
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
