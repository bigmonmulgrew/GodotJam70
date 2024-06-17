extends Node
class_name AudioMaster

var MusicFadeTime = 0
var QueuedMusicFadeVal = 0
var QueuedMusic = null
#time in seconds between MusicFading
var MusicFade = 1

var SFXMultipler = 1

func _ready():
	
	$MusicAudio.play(0)
	
func _process(delta):
	if QueuedMusic != null:
		MusicFadeTime=clamp(MusicFadeTime-delta,0,MusicFade)
		if MusicFadeTime <= 0 && $MusicAudio.stream != QueuedMusic:
			$MusicAudio.stream = QueuedMusic
			$MusicAudio.play(0)
			QueuedMusic = null
	else:
		if $MusicAudio.stream != null:
			MusicFadeTime=clamp(MusicFadeTime+delta,0,MusicFade)
	#move music fade value be time between the lowest and highest points
	QueuedMusicFadeVal = lerp(-80,0,(MusicFadeTime/MusicFade))
		
	if $MusicAudio.volume_db != QueuedMusicFadeVal:
		$MusicAudio.volume_db = QueuedMusicFadeVal

#sound - sound file, pitch should remain, volume is in db so it adds or removes based on what you want
func play_sfx(sound, pitch:float = 1, volumeDB:float = 0):
	var TSound:AudioStreamPlayer = AudioStreamPlayer.new()
	TSound.stream = sound
	TSound.pitch_scale = pitch
	TSound.volume_db = volumeDB
	TSound.volume_db = ((TSound.volume_db+80)*SFXMultipler)-80
	TSound.finished.connect(_killsound.bind(TSound as Node))
	$SoundEffects.add_child(TSound)
	TSound.play(0)
	
func play_sfx_world(sound, Position:Vector2, pitch:float = 1, volumeDB:float = 0):
	var TSound:AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	TSound.global_position = Position
	TSound.stream = sound
	TSound.pitch_scale = pitch
	TSound.volume_db = volumeDB
	TSound.volume_db = ((TSound.volume_db+80)*SFXMultipler)-80
	TSound.finished.connect(_killsound.bind(TSound as Node))
	$SoundEffects.add_child(TSound)
	TSound.play(0)
	
func _killsound(Sound:Node):
	Sound.queue_free()
	
#float should only be used between 0,1 but can be used at a higher volume
func SetSoundVolume(Multipler:float):
	if $SoundEffects.get_child_count() > 0:
		for Sound in $SoundEffects.get_children():
			#casts to audio stream player
			var LSound:AudioStreamPlayer = (Sound as AudioStreamPlayer)
			#if it can not cast to audio stream player directly cast to the 2D one (i wish the inheritence allowed my just to use AudioStreamPlayer But it breaks when parent casting)
			if(LSound == null):
				var LSound2D:AudioStreamPlayer2D = (Sound as AudioStreamPlayer2D)
				if LSound2D.get_playback_position() >= LSound2D.stream.get_length():
					LSound2D.volume_db = ((LSound2D.volume_db+80)*Multipler)-80
			else: #delete sound if its time is up w
				if LSound.get_playback_position() >= LSound.stream.get_length():
					LSound.volume_db = ((LSound.volume_db+80)*Multipler)-80
	SFXMultipler = Multipler
	
func play_music(sound):
	QueuedMusic = sound
