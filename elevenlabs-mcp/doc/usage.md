# ElevenLabs MCP Server Usage

## Overview
The ElevenLabs MCP server provides Claude with text-to-speech capabilities using the ElevenLabs API. This enables Claude to generate realistic speech from text using various voices and languages.

## Features

### Core Capabilities
- **Text-to-Speech**: Convert text to high-quality audio using ElevenLabs voices
- **Voice Selection**: Choose from pre-made voices or custom cloned voices
- **Language Support**: Generate speech in multiple languages and accents
- **Audio Formats**: Output audio in various formats (mp3, wav, etc.)
- **Voice Settings**: Customize stability, similarity, and style parameters

### Available Tools

#### `text_to_speech`
Convert text to speech using ElevenLabs API.

**Parameters:**
- `text` (string): The text to convert to speech
- `voice_id` (string): The voice ID to use (optional, uses default if not provided)
- `model_id` (string): The model ID to use (optional, defaults to "eleven_monolingual_v1")
- `stability` (number): Voice stability setting 0.0-1.0 (optional)
- `similarity_boost` (number): Voice similarity boost 0.0-1.0 (optional)
- `style` (number): Voice style exaggeration 0.0-1.0 (optional)

**Returns:**
- Audio file path or base64 encoded audio data

#### `list_voices`
Get available voices from ElevenLabs.

**Returns:**
- List of voice objects with voice_id, name, category, and language support

#### `get_voice`
Get detailed information about a specific voice.

**Parameters:**
- `voice_id` (string): The voice ID to retrieve information for

**Returns:**
- Detailed voice information including samples and settings

## Usage Examples

### Basic Text-to-Speech
```
Convert this text to speech using the default voice.
```

### Custom Voice Selection
```
Generate speech for "Hello, welcome to our presentation" using voice_id "pNInz6obpgDQGcFmaJgB".
```

### Voice with Settings
```
Convert "Welcome to our tutorial" to speech with stability 0.5 and similarity boost 0.8.
```

### List Available Voices
```
Show me all available ElevenLabs voices.
```

## Authentication

### Required Credentials
- **ElevenLabs API Key**: Get from https://elevenlabs.io/app/settings/api-keys
- **Default Voice ID**: Choose from your available voices at https://elevenlabs.io/app/voice-lab

### Setup Steps
1. Create an ElevenLabs account at https://elevenlabs.io
2. Navigate to Settings → API Keys
3. Generate a new API key
4. Add the API key to your `.env` file:
   ```
   ELEVENLABS_API_KEY=your_api_key_here
   ELEVENLABS_VOICE_ID=your_default_voice_id
   ```

## Rate Limiting

### ElevenLabs API Limits
- **Free tier**: 10,000 characters per month
- **Starter tier**: 30,000 characters per month
- **Creator tier**: 100,000 characters per month
- **Pro tier**: 500,000 characters per month

### Best Practices
- Cache generated audio when possible
- Batch small text snippets together
- Monitor usage via the ElevenLabs dashboard
- Implement exponential backoff for retry logic

## Voice Selection

### Pre-made Voices
- **Rachel**: American female voice
- **Domi**: American male voice  
- **Bella**: American female voice
- **Antoni**: American male voice
- ** Elli**: American female voice
- **Josh**: American male voice

### Custom Voices
- Create custom voices using VoiceLab
- Clone your own voice or others with permission
- Professional voice cloning available with paid tiers

## Audio Quality Settings

### Recommended Settings
- **Stability**: 0.3-0.7 (lower = more expressive, higher = more consistent)
- **Similarity Boost**: 0.5-0.9 (higher = closer to original voice)
- **Style**: 0.0-0.9 (higher = more dramatic/expressive)

### Audio Formats
- **MP3**: Compressed, smaller file size
- **WAV**: Uncompressed, higher quality
- **PCM**: Raw audio data

## Troubleshooting

### Common Issues

#### "Invalid API key"
- Verify your API key is correct and active
- Check if your API key has sufficient permissions
- Ensure the API key is properly set in the .env file

#### "Voice not found"
- Verify the voice_id exists in your account
- Check if the voice is shared/public or owned by you
- Use `list_voices` to get valid voice IDs

#### "Rate limit exceeded"
- Check your ElevenLabs dashboard for usage
- Upgrade your plan if needed
- Implement rate limiting in your usage patterns

#### Audio Quality Issues
- Adjust stability and similarity settings
- Try different voice models
- Ensure text is properly formatted and punctuated

### Debug Commands
```bash
# Check MCP server status
claude mcp list

# Test API connectivity
curl -H "xi-api-key: YOUR_API_KEY" https://api.elevenlabs.io/v1/voices

# View logs
claude mcp logs elevenlabs
```

## Security Considerations

### API Key Security
- Never commit API keys to version control
- Use environment variables for sensitive data
- Rotate API keys regularly
- Monitor API usage for anomalies

### Audio Storage
- Generated audio files may contain sensitive content
- Implement appropriate file cleanup policies
- Consider encryption for stored audio files
- Be aware of data retention policies

## Advanced Usage

### Multi-language Support
- Use model_id "eleven_multilingual_v2" for non-English text
- Specify language codes in voice settings
- Test pronunciation with short samples first

### Voice Design
- Create custom voice profiles for different use cases
- Adjust settings per-content type (narration vs dialogue)
- A/B test different voice configurations
- Document preferred settings for consistency