@ECHO off
setlocal

if '%1==' goto fehler
set CA_VER=%1
set CA_ARC=Cut_Assistant_src_%CA_VER%.ZIP
set CA_BIN_ARC=Cut_Assistant_%CA_VER%.ZIP

svn up %CA_VER%
svn export %CA_VER% Cut_Assistant_%CA_VER%
if exist %CA_ARC% del %CA_ARC%
zip -9 -r %CA_ARC% Cut_Assistant_%CA_VER%

cd Cut_Assistant_%CA_VER%
delphi32 -m cut_assistant.dpr
upx -9 cut_assistant.exe
zip -9 ..\%CA_BIN_ARC% cut_assistant.exe cut_assistant.de.lng license.txt readme.txt news.txt

cd ..
if exist Cut_Assistant_%CA_VER%.build.rar del Cut_Assistant_%CA_VER%.build.zip
rar m Cut_Assistant_%CA_VER%.build.rar Cut_Assistant_%CA_VER%

dir *%CA_VER%*

goto ende
:fehler
echo Fehler: Version muss angegeben werden!

:ende

endlocal