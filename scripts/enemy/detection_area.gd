extends Area2D
class_name DetectionArea

export(NodePath) onready var enemy = get_node(enemy) as KinematicBody2D


func on_body_entered(body: player):
	enemy.player_ref = body
	pass # Replace with function body.


func on_body_exited(body: player):
	enemy.player_ref = null
	pass # Replace with function body.
