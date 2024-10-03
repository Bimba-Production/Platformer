class_name Player extends CharacterBody2D

const GRAVITY_ACCELERATION = 12
const GRAVITY = 32
const CHAIN_PULL = 40
var ORIENTATION = 1

@export var SPRITE : Sprite2D
@export var ANIMATION_PLAYER : AnimationPlayer
@export var CHAIN : Chain

var chain_velocity := Vector2(0,0)
var direction = 0

func apply_gravity(delta) -> void:
	velocity.y = lerp(velocity.y, velocity.y + GRAVITY, GRAVITY * delta)

func _update_direction() -> void:
	direction = Input.get_axis("move_left", "move_right")
	
func update_player_orientation() -> void:
	if direction != 0:
		scale.x = scale.y * direction
		ORIENTATION = direction

func update_velocity(delta, speed, acceleration, deacceleration) -> void:
	if direction:
		velocity.x = lerp(velocity.x, speed * direction, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, deacceleration * delta)

func _physics_process(delta) -> void:
	_update_direction()
	
	if CHAIN.hooked:
		chain_velocity = to_local(CHAIN.tip).normalized() * CHAIN_PULL
		chain_velocity.x *= ORIENTATION
		if is_on_floor():
			chain_velocity.y *= 0.65
		else:
			chain_velocity.y *= 0.75
	else:
		chain_velocity = Vector2(0,0)
	velocity += chain_velocity

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			CHAIN.shoot(event.position - get_viewport().size * 0.5)
		else:
			CHAIN.release()
