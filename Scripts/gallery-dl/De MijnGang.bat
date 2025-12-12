@ECHO OFF
gallery-dl -c facebook.conf "https://www.facebook.com/demijngang/"

ECHO Finished downloading.
POWERSHELL -c "(New-Object Media.SoundPlayer 'C:\Windows\Media\Alarm10.wav').PlaySync()"
PAUSE