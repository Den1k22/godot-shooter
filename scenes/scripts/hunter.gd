extends CharacterBody2D

var active: bool = false
var speed: int = 200
var can_attack: bool = false
var health: int = 100

func _ready() -> void:
	$NavigationAgent2D.path_desired_distance = 4.0
	$NavigationAgent2D.target_desired_distance = 4.0
	$NavigationAgent2D.target_position = Globals.player_pos

	
func _physics_process(_delta: float) -> void:
	if active:
		var next_path_pos: Vector2 = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_pos - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		var look_angle = direction.angle()
		rotation = look_angle + PI / 2

func hit():
	health -= 10
	if health <= 0:
		queue_free()


func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true
	$AnimationPlayer.play("walk")


func _on_notice_area_body_exited(_body: Node2D) -> void:
	active = false

func _on_navigation_timer_timeout() -> void:
	if active:
		$NavigationAgent2D.target_position = Globals.player_pos


func _on_attack_area_body_entered(_body: Node2D) -> void:
	can_attack = true
	$AnimationPlayer.play("attack")


func _on_attack_area_body_exited(_body: Node2D) -> void:
	can_attack = false


func attack():
	if can_attack:
		Globals.health -= 20
