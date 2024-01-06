@echo off
setlocal EnableDelayedExpansion

:: Change la page de code pour mieux gérer les caractères accentués
chcp 65001 > nul

:: Dans set "searchPath=" mettez le chemin d'accès ou sont vos base de données après le "="
:: Dans set set "savePath=" mettez le chemin d'accès ou vous voulez que les résultats soient exportés après le "=", le fichier texte se créera automatiquement
set "searchPath=D:\InfoLeaks\osint\baseded"
set "savePath=D:\InfoLeaks\osint\checked"

:: Définit la couleur de la console
color 04
cls

echo.
echo.
echo                          ***************************************************************
echo                          *                    DB String Checker                        *
echo                          *                       Par Vicious                           *
echo                          *                     Discord: wodxx.                         *
echo                          ***************************************************************
echo                          *   Recherche rapide de pseudo/mail/IP/uuid/name/tel          *
echo                          *   C'est plus utile si vous avez des base de données.        *
echo                          ***************************************************************
echo.
echo.

:debut
:: Demande le string à rechercher et le nom du fichier texte exportés souhaité.
echo Entrez les pseudos à chercher (separés par un espace) / ex: Pseudo1 Pseudo2 Pseudo 3
echo Vous pouvez aussi rechercher un seul pseudo à la fois ou un e-mail, IP's ou autres ...
echo.
set /p mots="Recherche :"
if /i "%mots%"=="exit" goto fin

echo Entrez le nom du fichier de sortie (sans extension) :
set /p filename="Nom du fichier: "
set "outputFile=!savePath!\!filename!.txt"

:: Verification de l'existence du fichier de sortie
if exist "!outputFile!" del "!outputFile!"

:: Lancement de la recherche
echo Recherche dans les fichiers de !searchPath!...
echo Recherche dans les fichiers de !searchPath!... > "!outputFile!"
echo.

for %%m in (%mots%) do (
    for /r "%searchPath%" %%f in (*) do (
        findstr /n /i /C:"%%m" "%%f" > nul && (
            echo Trouvé dans %%f
            echo Trouvé dans %%f >> "!outputFile!"
            findstr /n /i /C:"%%m" "%%f"
            findstr /n /i /C:"%%m" "%%f" >> "!outputFile!"
            echo.
        )
    )
)


:: Indication de fin de recherche
echo.
echo Recherche terminée. Verifiez les résultats dans !outputFile!.
echo Appuyez sur une touche pour refaire une recherche
pause > nul
cls  :: Efface la console
goto debut

:fin
echo Ciao
pause > nul
exit
