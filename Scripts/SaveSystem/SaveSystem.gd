extends Node
class_name save_system

var DefaultSaveFileName:String = "SaveFile"

# Called when the node enters the scene tree for the first time.
func _ready():
	if !FileAccess.file_exists("user://"+DefaultSaveFileName+"0"):
		save_data(0,"DefaultCanDelete",0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

##saves any data to file
func save_data(savefile:int=0,key:String="Key",value=0):
	var LoadedDict = {}
	var Data = {key:value}
	var file = FileAccess.open("user://"+DefaultSaveFileName+str(savefile), FileAccess.WRITE)
	file.store_string(JSON.stringify(Data))
	file.close()

##gets the entire dictionary of savefile
func get_dict_data(savefile:int=0):
	if !FileAccess.file_exists("user://"+DefaultSaveFileName+str(savefile)):
		save_data(savefile,"TEST",null)
		return null
	var file = FileAccess.open("user://"+DefaultSaveFileName+str(savefile), FileAccess.READ).get_as_text()
	var data = JSON.parse_string(file)
	return data

##get specific data from files dictionary based on a key
func load_data(savefile:int=0,key:String="Key"):
	var Dict = get_dict_data(savefile)
	var data = Dict[key]
	return data

func save_obj_for_object(NodeRef:Node,savefile:int=0,key:String="Key",value=0):
	var ObjectKey:String = "OBJ."+str(NodeRef.get_instance_id())+key
	save_data(savefile,ObjectKey,value)
	
func load_data_from_object(NodeRef:Node,savefile:int=0,key:String="Key"):
	var data = null
	var ObjectKey:String = "OBJ."+str(NodeRef.get_instance_id())+key
	if FileAccess.file_exists("user://"+DefaultSaveFileName+str(savefile)):
		data = load_data(savefile,ObjectKey)
	return data
