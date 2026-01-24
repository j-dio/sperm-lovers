extends Area3D

@export var speed: float = 30.0
@export var lifetime: float = 0.1
@export var damage: int = 2
@export var alert_radius: float = 12.0

var direction := Vector3.FORWARD

func _ready() -> void:
	get_tree().create_timer(lifetime).timeout.connect(queue_free)
	body_entered.connect(_on_body_entered)
	print("Bullet ready, monitoring: ", monitoring)

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_body_entered(body: Node3D) -> void:
	print("Bullet hit: ", body.name, " Groups: ", body.get_groups())

	if body.is_in_group("enemies"):
		body.take_damage(damage)
		alert_nearby_enemies(body.global_position)

	if body.is_in_group("enemies") or body.is_in_group("walls"):
		queue_free()


func alert_nearby_enemies(hit_position: Vector3) -> void:
	for enemy in get_tree().get_nodes_in_group("enemies"):
		if not is_instance_valid(enemy):
			continue
		if not enemy.has_method("become_aggro"):
			continue
		var dist = enemy.global_position.distance_to(hit_position)
		if dist <= alert_radius:
			enemy.become_aggro()
