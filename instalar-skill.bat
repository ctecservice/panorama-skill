@echo off
setlocal

rem Instala a skill panorama na pasta global de skills de agentes.
rem Arquivo local do mantenedor - nao versionado (ver .gitignore).

set "ORIGEM=%~dp0"
set "DESTINO=%USERPROFILE%\.agents\skills\panorama-skill"

if not exist "%DESTINO%" mkdir "%DESTINO%"
if not exist "%DESTINO%\templates" mkdir "%DESTINO%\templates"

copy /Y "%ORIGEM%SKILL.md" "%DESTINO%\SKILL.md" >nul
copy /Y "%ORIGEM%README.md" "%DESTINO%\README.md" >nul
copy /Y "%ORIGEM%README.en.md" "%DESTINO%\README.en.md" >nul
copy /Y "%ORIGEM%LICENSE" "%DESTINO%\LICENSE" >nul
copy /Y "%ORIGEM%templates\panorama-atual.template.md" "%DESTINO%\templates\panorama-atual.template.md" >nul

echo.
echo Skill "panorama" instalada em %DESTINO%
echo Reinicie o opencode (ou o seu agente) para recarregar as skills.
echo.
pause
endlocal
