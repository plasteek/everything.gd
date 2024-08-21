<p align="center">
    <h1 align="center">AudioManager</h1>
    <p align="center">Manager Your Audio in One Place in One Object</p>
</p>

# Introduction

Annoying with multiple AudioStreamPlayer? Fret no more. Now just use 1 object to play all your sound effects and musics!

# Usage

```gdscript
var manager = $AudioManager

manager.play("track_name_here", {
    "pitch": 1,
    "volume": 0
    # This is used for background music
    # Where you don't want to stop it and make it keep
    # playing in the background
    "persistent": false
})
manager.play_random() # Play random audio stream

# Managing background audio
manager.resume_persistent_audios()
manager.stop_persistent_audios()

manager.get_available_tracks()
manager.get_track_length_ms()
```
