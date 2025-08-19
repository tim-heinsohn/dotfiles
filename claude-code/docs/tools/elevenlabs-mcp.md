# ElevenLabs MCP Integration

## Overview
The ElevenLabs MCP server provides Claude with text-to-speech capabilities using the ElevenLabs API. This enables Claude to generate realistic speech from text using various voices and languages.

## Critical Setup Steps

### 1. Installation
```bash
# Install ElevenLabs MCP server
mcp-install install elevenlabs

# Integrate with Claude Code
mcp-install integrate elevenlabs
```

### 2. Authentication Required
- **API Key**: Get from https://elevenlabs.io/app/settings/api-keys
- **Voice ID**: Choose from https://elevenlabs.io/app/voice-lab
- **Configuration**: Add to `~/.elevenlabs-mcp/elevenlabs-mcp/.env`:
  ```
  ELEVENLABS_API_KEY=your_api_key_here
  ELEVENLABS_VOICE_ID=your_default_voice_id
  ```

## Available Tools

### `text_to_speech`
Convert text to speech using ElevenLabs API.

**Parameters:**
- `text` (string): Text to convert
- `voice_id` (string): Voice ID (optional, uses default)
- `model_id` (string): Model ID (optional, defaults to "eleven_monolingual_v1")
- `stability` (number): 0.0-1.0 (optional)
- `similarity_boost` (number): 0.0-1.0 (optional)
- `style` (number): 0.0-1.0 (optional)

**Example:**
```
Convert "Hello, welcome to our presentation" to speech with stability 0.5 and similarity boost 0.8.
```

### `list_voices`
Get available voices from ElevenLabs.

**Example:**
```
Show me all available ElevenLabs voices.
```

### `get_voice`
Get detailed information about a specific voice.

**Parameters:**
- `voice_id` (string): Voice ID to retrieve info for

## Rate Limiting

### API Limits
- **Free tier**: 10,000 characters/month
- **Starter tier**: 30,000 characters/month
- **Creator tier**: 100,000 characters/month
- **Pro tier**: 500,000 characters/month

### Best Practices
- Cache generated audio when possible
- Batch small text snippets together
- Monitor usage via ElevenLabs dashboard
- Implement exponential backoff for retries

## Voice Settings

### Recommended Parameters
- **Stability**: 0.3-0.7 (lower = more expressive)
- **Similarity Boost**: 0.5-0.9 (higher = closer to original)
- **Style**: 0.0-0.9 (higher = more dramatic)

### Popular Voices
- **Rachel**: American female
- **Domi**: American male
- **Bella**: American female
- **Antoni**: American male

## Security Considerations
- Never commit API keys to version control
- Use environment variables for sensitive data
- Rotate API keys regularly
- Monitor API usage for anomalies

## Troubleshooting

### Common Issues
1. **"Invalid API key"**: Verify API key is correct and active
2. **"Voice not found"**: Check voice_id exists in your account
3. **"Rate limit exceeded"**: Check usage and upgrade plan if needed
4. **Audio quality issues**: Adjust stability and similarity settings

### Debug Commands
```bash
# Check MCP server status
claude mcp list

# Test API connectivity
curl -H "xi-api-key: YOUR_API_KEY" https://api.elevenlabs.io/v1/voices

# View logs
claude mcp logs elevenlabs
```

## Multi-language Support
- Use model_id "eleven_multilingual_v2" for non-English text
- Supports multiple languages and accents
- Test pronunciation with short samples first