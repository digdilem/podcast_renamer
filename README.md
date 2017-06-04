# podcast_renamer
Renames podcasts fetched with podget. 

There are a number of other projects out there that claim to rename podcasts and MP3 files using tags, but none either worked reliably, or did exactly what I want - so I wrote this.

It:

Cycles through all .mp3 files in a directory and...

1. Renames the file based on a simple set of rules. 
2. Copies the renamed file to a backup directory.
3. Moves the renamed file to a target directory.

Run once after the podcast fetcher has done its thing.

Requires MP3::Tag 

It's rough and ready - feel free to improve. 
