extends Action
class_name Attack

## This is a template class to extend. 
## [br]Use this to guarantee that attacks have a use method and will not
## [br]crash when being used in a player or boss

# Export variables
## Damage value to apply
@export var damage: int = 10
