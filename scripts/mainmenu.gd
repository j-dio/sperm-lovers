extends Node3D

@onready var camera_pivot: Node3D = $CameraPivot

var max_angle := 12.0      # small = cinematic
var speed := 0.25          # LOWER = slower
var time := 0.0

func _process(delta: float) -> void:
	time += delta * speed
	camera_pivot.rotation_degrees.y = sin(time) * max_angle
