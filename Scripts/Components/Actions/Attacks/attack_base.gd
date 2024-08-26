class_name Attack extends Action

## This is a template class to extend. 
## [br]Use this to guarantee that attacks have a use method and will not
## [br]crash when being used in a player or boss

# Export variables
@export_category("Player Settings")
## Damage value to apply
@export var damage: int = 10
## The type of damage the weapon will deal
@export var damage_type: DamageType.Type = DamageType.Type.PHYSICAL
