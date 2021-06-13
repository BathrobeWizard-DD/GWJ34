extends Node2D

onready var top_pin = get_node("PinJoint2D16")
onready var bottom_pin = get_node("PinJoint2D15")

func set_top_pin(node):
	top_pin.node_a = node.get_path()

func set_bottom_pin(node):
	bottom_pin.node_b = node.get_path()

func set_position_pin_joint(position_given):
	bottom_pin.position = position_given
	get_node("RigidBody2D15").position = position_given
