PhoneDrop - Send photos from iPhone to PC instantly
====================================================

REQUIREMENTS
  - Node.js installed (https://nodejs.org) 
    If not installed, PhoneDrop.bat will try to install it automatically via winget.

HOW TO USE
  1. Double-click PhoneDrop.bat
  2. Your browser opens automatically
  3. Scan the QR code with your iPhone (must be on same WiFi)
  4. Take a photo or pick from gallery -> tap Send to PC
  5. File appears instantly in the "received" folder

NOTES
  - Both devices must be on the same WiFi network
  - Only accessible on your local network (LAN), not the internet
  - Files are saved in the "received" folder next to PhoneDrop.bat
  - Close the terminal window to stop the server
  - Max file size: 50MB

WANT A REAL .EXE?
  Install Node.js, then run this once in the folder:
    npm install -g pkg
    pkg dist-bundle/index.js --target node18-win-x64 --output PhoneDrop.exe
  This compiles a true standalone exe with no dependencies.
