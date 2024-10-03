class_name Chain extends Node2D

@export var LINKS : Sprite2D
@export var TIP : CharacterBody2D

var direction := Vector2(0,0)
var tip := Vector2(0,0)

const SPEED = 15

var flying = false
var hooked = false

func shoot(dir: Vector2) -> void:
	direction = dir.normalized()
	flying = true
	tip = self.global_position

func release() -> void:
	flying = false
	hooked = false
	tip = Vector2(0,0)

func _process(_delta: float) -> void:
	self.visible = flying or hooked
	if not self.visible:
		return
	var tip_loc = to_local(tip)

	LINKS.rotation = self.position.angle_to_point(tip_loc) - deg_to_rad(270)
	TIP.rotation = self.position.angle_to_point(tip_loc) - deg_to_rad(270)
	LINKS.position = tip_loc
	LINKS.region_rect.size.y = tip_loc.length()
	
	if LINKS.region_rect.size.y > 800:
		release()

func _physics_process(_delta: float) -> void:
	TIP.global_position = tip
	if flying:
		if TIP.move_and_collide(direction * SPEED):
			hooked = true
			flying = false
	tip = TIP.global_position
