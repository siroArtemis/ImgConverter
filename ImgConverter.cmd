@echo off
rem === �����ݒ� ===
set inkscape1="%ProgramFiles%\Inkscape\bin\inkscape.com"

rem �o�͂���摜�̉𑜓x�iDPI�j�̎w��
set dpi=300

rem �o�͌`���̎w��
rem emf�png�pdf�svg�Ȃǂ̏o�͌`���ɑΉ�
set format=emf

rem ���͊m�F
if "%~1"=="" (
    echo �G���[: �摜�t�@�C���܂��̓t�H���_���w�肵�Ă��������B
    echo �g�p���@: ConvertImage.cmd [�摜�t�@�C���܂��̓t�H���_�̃p�X]
    pause
    exit /b 1
)
set inputPath=%~1

rem �������e�̊m�F
cls
echo === �������e ===
echo �ϊ��Ώ�: %inputPath%
echo �o�͐�: ���̓t�@�C���Ɠ����f�B���N�g��
echo �𑜓x: %dpi%
echo �o�͌`��: %format%
echo =================
set /p confirm="��L�ݒ�Ŏ��s���܂����H (Y/N): "
if /i not "%confirm%"=="Y" (
    echo �������L�����Z�����܂����B
    pause
    exit /b 0
)

rem �ϊ��J�n
cls
set count=0
set success=0
set failed=0

if exist "%inputPath%\*" (
    for %%f in ("%inputPath%\*.svg" "%inputPath%\*.pdf" "%inputPath%\*.png" "%inputPath%\*.jpg") do call :ConvertFile "%%f"
) else (
    call :ConvertFile "%inputPath%"
)

rem ���ʕ\��
echo �������������܂����B
echo �����Ώۃt�@�C����: %count%
echo ����: %success%
echo ���s: %failed%
pause
exit /b 0

:ConvertFile
set /a count+=1
set inputFile=%~1
set inputDir=%~dp1
set fileName=%~n1
set outputFile=%inputDir%%fileName%.%format%

echo [%count%] ������: %inputFile%
%inkscape1% --export-filename="%outputFile%" --export-dpi=%dpi% "%inputFile%"
if exist "%outputFile%" (
    echo [%count%] ����: %outputFile%
    set /a success+=1
) else (
    echo [%count%] ���s: %inputFile%
    set /a failed+=1
)
goto :eof