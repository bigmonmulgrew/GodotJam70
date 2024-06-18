extends Node2D
class_name BaseProjectile

## A base class for projectiles.
##
## A base class that all projectiles should be based on. The base class allows you to set a speed, damage value, damage type, and whether the projectile should explode on impact.
##[br]
##[br]
## The base class methods find and update the base projectile's position in _physics_process(delta). There is then a delete_projectile method and an explode method.
##[br]
##[br]
## Explode is expanded upon in the fireball class.

## The speed at which the projectile travels. Used when you update position.
@export var travel_speed: float = 10
## The damage dealt by the projectile. Used when you remove health from the collision body on collision.
@export var damage_value: int = 10
## The damage type dealt by the projectile. This is used when you remove health from the collision body on collision.
@export var damage_type: DamageType.Type
## A boolean that allows you to set whether the projectile should explode on impact. This allows you to give projectiles slightly different impact behaviours.
@export var impact_explosion: bool = false

## A boolean that states whether the projectile is active. Currently unused, but may be used if you want to stop the projectile moving but keep it in the game.
var projectile_active: bool = true
## A Vector2 that can be used to store the position of the projectile.
var projectile_position: Vector2
## A Vector2 that can be used to store the direction of the projectile.
var projectile_direction: Vector2

var projectile_container: Node2D

##An empty ready() method that can be expanded upon in children classes.
func _ready():
	create_projectile_container()
	projectile_container.add_child(self)
	
# This function looks for a "ProjectileContainer" at the root of the scene tree.
# If it doesn't exist, it creates one and attaches it to the root.
func create_projectile_container():
	# Get the root of the current scene tree
	var root = get_tree().get_root()

	# Find a node named "ProjectileContainer" among the children of the root node
	projectile_container = root.get_node("ProjectileContainer")

	# If it does not exist, create a new Node2D and name it "ProjectileContainer"
	if projectile_container == null:
		projectile_container = Node2D.new()
		projectile_container.name = "ProjectileContainer"

		# Add it to the root node
		root.add_child(projectile_container)
	
## This method calls update_position(delta) on tick, updating the base_projectile's position every frame.
func _physics_process(delta):
	update_position(delta)

## This methods checks if the projectile is currently active. If it is, it changes the position based on direction and speed.
func update_position(delta):
	if projectile_active:
		global_position += projectile_direction * travel_speed

## This method is a nicer way to call queue_free, it is completely unnecessary but makes things a little more readable in children classes
func delete_projectile():
	queue_free()

## This prints "(name) EXPLODEd!!". Fill this out in the appropriate child class that you are designing if the projectile should explode.
func explode():
		print(str(name) + " EXPLODED!!")
