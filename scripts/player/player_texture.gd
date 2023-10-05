extends Sprite
class_name playerTexture

var suffix:String="_right"
var normal_attack:bool=false
var second_attack:bool=false
var shield_off:bool=false
var crouching_off:bool=false

export(NodePath) onready var animation = get_node(animation) as AnimationPlayer
export(NodePath) onready var ObjPlayer = get_node(ObjPlayer) as KinematicBody2D

func animate(direction:Vector2) -> void:
	verity_position(direction)
	if ObjPlayer.attacking or ObjPlayer.defending or ObjPlayer.crouching or ObjPlayer.next_to_wall():
		action_behavior()
	elif direction.y!=0:
		vertical_behavior(direction)
	elif ObjPlayer.landing == true:
		animation.play("landing")
		ObjPlayer.set_physics_process(false)
	else:
		horizontal_behavior(direction)
	
func verity_position(direction:Vector2) -> void:
	if direction.x > 0:
		flip_h=false
		suffix="_right"
		ObjPlayer.direction=-1
		position=Vector2.ZERO
		ObjPlayer.wall_ray=Vector2(5.5, 0)
	elif direction.x < 0:
		flip_h=true
		suffix="_left"
		ObjPlayer.direction=1
		position=Vector2(-2, 0)
		ObjPlayer.wall_ray=Vector2(-7.5, 0)

func action_behavior() ->void:
	if ObjPlayer.next_to_wall():
		animation.play("wall_slide")
	elif ObjPlayer.attacking and normal_attack:
		animation.play("attack_1"+suffix)
	elif ObjPlayer.defending and shield_off:
		animation.play("shield")
		shield_off=false
	elif ObjPlayer.crouching and crouching_off:
		animation.play("crounch")
		crouching_off=false

func horizontal_behavior(direction:Vector2) -> void:
	if direction.x != 0:
		animation.play("run")
	else:
		animation.play("idle")

func vertical_behavior(direction:Vector2) -> void:
	if direction.y > 0:
		ObjPlayer.landing = true
		animation.play("fall")
	elif direction.y < 0:
		animation.play("jump")

func on_animation_finished(anim_name:String):
	match anim_name:
		"landing":
			ObjPlayer.landing=false
			ObjPlayer.set_physics_process(true)
		"attack_left":
			normal_attack=false
			ObjPlayer.attacking=false
		"attack_1_left":
			normal_attack=false
			if second_attack:
				animation.play("attack_2"+suffix)
			else:
				ObjPlayer.attacking=false
		"attack_2_left":
			normal_attack=false
			second_attack=false
			ObjPlayer.attacking=false
		"attack_right":
			normal_attack=false
			ObjPlayer.attacking=false
		"attack_1_right":
			normal_attack=false
			if second_attack:
				animation.play("attack_2"+suffix)
			else:
				ObjPlayer.attacking=false
		"attack_2_right":
			normal_attack=false
			second_attack=false
			ObjPlayer.attacking=false
