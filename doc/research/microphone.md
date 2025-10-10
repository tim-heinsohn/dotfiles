# Microphone Setup and Recording Guide

## Current Status
Based on system checks, your Yeti microphone is **not currently detected** by the system. The available audio devices are:
- Built-in HDA Intel PCH ALC298 Analog (Card 0, Device 0)
- PulseAudio monitor sources for HDMI and analog outputs

## Checking Microphone Connection

### Verify Physical Connection
1. Ensure the Yeti microphone is properly connected via USB
2. Check if the microphone's LED indicator is lit (indicating power)
3. Try a different USB port if necessary

### System Detection Commands
```bash
# List all audio capture devices
arecord -l

# List PulseAudio sources
pactl list short sources

# Check USB devices (if lsusb is available)
lsusb | grep -i yeti

# Check ALSA devices
ls /dev/snd/
```

### PulseAudio Service Restart
Instead of rebooting the entire system, restart just the PulseAudio service:
```bash
# Restart PulseAudio (user service)
systemctl --user restart pulseaudio

# Or use pulseaudio commands
pulseaudio -k  # Kill current instance
pulseaudio --start  # Start new instance

# Check service status
systemctl --user status pulseaudio
```

## Recording Options

### GUI Applications

#### Audacity (Recommended)
- **Available**: Yes (`/usr/bin/audacity`)
- **Usage**:
  1. Launch Audacity
  2. Select Yeti microphone from dropdown menu
  3. Click record button
  4. Export as WAV/MP3 when done

#### Other GUI Options
- **OBS Studio**: For video/audio recording
- **SimpleScreenRecorder**: Audio and video capture
- **Ardour**: Professional audio workstation

### Command Line Recording

#### Using arecord (ALSA)
```bash
# Record 10 seconds of audio from default device
arecord -d 10 -f cd -t wav test.wav

# Record with specific device (replace hw:0,0 with your device)
arecord -D hw:0,0 -d 10 -f cd -t wav test.wav

# List recording devices first
arecord -l
```

#### Using ffmpeg
```bash
# Record audio from default input
ffmpeg -f alsa -i default -t 10 output.wav

# Record from specific device
ffmpeg -f alsa -i hw:0 -t 10 output.wav

# Record with specific format
ffmpeg -f alsa -ar 44100 -ac 2 -i default -t 10 output.wav
```

#### Using parecord (PulseAudio)
```bash
# Record from default source
parecord --file-format wav test.wav

# List available sources first
pactl list short sources
```

## Troubleshooting

### If Yeti is Not Detected
1. **Reconnect USB**: Unplug and replug the USB cable
2. **Check USB Cable**: Try a different USB cable
3. **USB Port**: Try different USB ports (preferably USB 2.0)
4. **Service Restart**: Restart PulseAudio service instead of full system reboot
5. **Check Power**: Ensure the microphone's mute button is not engaged

### After Connection
1. **Set as Default**: Configure as default input device in system settings
2. **Test Recording**: Use simple commands to verify functionality
3. **Adjust Levels**: Set appropriate input levels to avoid clipping

### Quick Test Command
```bash
# Record a 5-second test
arecord -d 5 -f cd -t wav /tmp/test.wav && aplay /tmp/test.wav
```

## Next Steps
1. Check physical connection and power
2. Run detection commands again
3. If not detected, restart PulseAudio service: `systemctl --user restart pulseaudio`
4. Once detected, use Audacity for GUI recording or arecord/ffmpeg for CLI
5. Test with the quick test command above

## Service Restart Commands
Instead of rebooting the entire system when troubleshooting audio issues:
```bash
# Quick PulseAudio restart
pulseaudio -k && pulseaudio --start

# Full service restart
systemctl --user restart pulseaudio

# Check if service is running
systemctl --user is-active pulseaudio
```