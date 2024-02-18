@echo off 
CHCP 65001

echo Entering command in unicode charset

echo Current directory: %CD%

echo Extracting only character speech lines:

for %%a in (%*) do ugrep "message|msgvoicesync" %%a > "cleaned_%%~na.txt" && ^
echo Created file "cleaned_%%~na.txt" from %%~nxa && ^
perl -i -pe "s/message,|,fc(\d{5})[a-z]?,?|msgvoicesync,Live2D_(\d{2}),|vc(\d{5,6})_(\d{6})|_men//g" "cleaned_%%~na.txt" && ^
perl -i -pe "s/\n/\n\n/g" "cleaned_%%~na.txt" && ^
perl -i -pe "s/<br>/\n/g" "cleaned_%%~na.txt" && ^
perl -i -pe "s/,/:\n/g" "cleaned_%%~na.txt" && ^
echo Formatted script file "cleaned_%%~na.txt"

echo Done.

pause