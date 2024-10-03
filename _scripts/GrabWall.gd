class_name GrabWallPlayerState extends PlayerMovementState

@export var SPEED: float = 2.5
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.2

func enter(previous_state) -> void:
	ANIMATION.play("GrabLedge")
	PLAYER.velocity.x = 0
	PLAYER.velocity.y = 0

func update(delta: float) -> void:
	PLAYER.move_and_slide()
	PLAYER.position.y += lerp(0.0, SPEED, ACCELERATION)
	
	if Input.is_action_just_pressed("jump"):
		transition.emit("WallJumpingPlayerState")
	
	if PLAYER.is_on_floor():
		transition.emit("IdlePlayerState")
	elif !PLAYER.is_on_floor() and !PLAYER.is_on_wall():
		transition.emit("FallingPlayerState")
