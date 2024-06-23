extends Node
class_name save_system

##Default save file name in file explorer
var DefaultSaveFileName:String = "SaveFile"

##Save File System
##[br]
##[br]
##Save some data to a savefile based on the savefiles index via an int and a key, works like a dictonary.
##[br]
##[br]
##You can also save data per object easily, aswell as adding data just by a key.

##Adds empty SaveFile0 if it doesnt exist.
func _ready():
	if !savefile_exists(0):
		save_data(0,"DefaultCanDelete",0)
	pass # Replace with function body.

##saves any data to file based on key and the data for a dictionary.
func save_data(savefile:int=0,key:String="Key",value=0):
	var LoadedDict = {}
	var Data = {key:value}
	var file = FileAccess.open("user://"+DefaultSaveFileName+str(savefile), FileAccess.WRITE)
	file.store_string(JSON.stringify(Data))
	file.close()

##returns true or false for a certain savefile
func savefile_exists(savefile:int=0):
	return FileAccess.file_exists("user://"+DefaultSaveFileName+str(savefile))

##gets the entire dictionary of a savefile.
func get_dict_data(savefile:int=0):
	if !savefile_exists(0):
		save_data(savefile,"TEST",null)
		return null
	var file = FileAccess.open("user://"+DefaultSaveFileName+str(savefile), FileAccess.READ).get_as_text()
	var data = JSON.parse_string(file)
	return data

##get specific data from files dictionary based on a key.
func load_data(savefile:int=0,key:String="Key"):
	var Dict = get_dict_data(savefile)
	var data = null
	if(Dict != null):
		if Dict.has(key):
			data = Dict[key]
	return data

##Saves data in a savefile dictionary for each object.
func save_obj_for_object(NodeRef:Node,savefile:int=0,key:String="Key",value=0):
	var ObjectKey:String = "OBJ."+str(NodeRef.get_instance_id())+key
	save_data(savefile,ObjectKey,value)
	
##Loads data from savefile for an object if it exists.
func load_data_from_object(NodeRef:Node,savefile:int=0,key:String="Key"):
	var data = null
	var ObjectKey:String = "OBJ."+str(NodeRef.get_instance_id())+key
	if savefile_exists(0):
		data = load_data(savefile,ObjectKey)
	return data

func wipe_data(savefile:int = 0):
	DirAccess.remove_absolute("user://"+DefaultSaveFileName+str(savefile))
