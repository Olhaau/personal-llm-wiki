#!/usr/bin/env python3

import sys
from youtube_transcript_api import YouTubeTranscriptApi
import re


def extract_video_id(url):
    """Extract video ID from YouTube URL"""
    patterns = [
        r"(?:youtube\.com\/watch\?v=|youtu\.be\/)([^&\n?#]+)",
        r"youtube\.com\/embed\/([^&\n?#]+)",
        r"youtube\.com\/v\/([^&\n?#]+)",
    ]

    for pattern in patterns:
        match = re.search(pattern, url)
        if match:
            return match.group(1)

    return None


def get_transcript(video_url, language="en"):
    """Get transcript for a YouTube video"""
    video_id = extract_video_id(video_url)
    if not video_id:
        print("Error: Could not extract video ID from URL")
        return None

    try:
        # Create API instance and get transcript list
        api = YouTubeTranscriptApi()
        transcript_list = api.list(video_id)

        # Try to find the requested language
        transcript_data = None
        try:
            transcript = transcript_list.find_transcript([language])
            transcript_data = transcript.fetch()
        except:
            # If not found, try auto-generated English
            try:
                transcript = transcript_list.find_generated_transcript(["en"])
                print(
                    f"Warning: {language} transcript not found, using auto-generated English"
                )
                transcript_data = transcript.fetch()
            except:
                try:
                    # Get any available transcript
                    for transcript in transcript_list:
                        transcript_data = transcript.fetch()
                        print(
                            f"Warning: Using available transcript in {transcript.language_code}"
                        )
                        break
                except:
                    print("Error: No transcripts available for this video")
                    return None

        # Format the transcript
        formatted_transcript = ""
        for entry in transcript_data:
            # Clean up the text
            text = entry.text.replace("\n", " ").strip()
            if text:
                formatted_transcript += f"{text} "

        return formatted_transcript.strip()

    except Exception as e:
        print(f"Error: {str(e)}")
        return None


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 get_transcript.py <youtube_url> [language]")
        sys.exit(1)

    url = sys.argv[1]
    language = sys.argv[2] if len(sys.argv) > 2 else "en"

    print(f"Getting transcript for: {url}")
    transcript = get_transcript(url, language)

    if transcript:
        print("\n" + "=" * 50)
        print("TRANSCRIPT:")
        print("=" * 50)
        print(transcript)

        # Also save to file
        video_id = extract_video_id(url)
        filename = f"transcript_{video_id}.txt"
        with open(filename, "w", encoding="utf-8") as f:
            f.write(transcript)
        print(f"\nTranscript saved to: {filename}")
    else:
        print("Failed to get transcript")
