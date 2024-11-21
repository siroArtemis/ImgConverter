@echo off
rem === 初期設定 ===
set inkscape1="%ProgramFiles%\Inkscape\bin\inkscape.com"

rem 出力する画像の解像度（DPI）の指定
set dpi=300

rem 出力形式の指定
rem emf､png､pdf､svgなどの出力形式に対応
set format=emf

rem 入力確認
if "%~1"=="" (
    echo エラー: 画像ファイルまたはフォルダを指定してください。
    echo 使用方法: ConvertImage.cmd [画像ファイルまたはフォルダのパス]
    pause
    exit /b 1
)
set inputPath=%~1

rem 処理内容の確認
cls
echo === 処理内容 ===
echo 変換対象: %inputPath%
echo 出力先: 入力ファイルと同じディレクトリ
echo 解像度: %dpi%
echo 出力形式: %format%
echo =================
set /p confirm="上記設定で実行しますか？ (Y/N): "
if /i not "%confirm%"=="Y" (
    echo 処理をキャンセルしました。
    pause
    exit /b 0
)

rem 変換開始
cls
set count=0
set success=0
set failed=0

if exist "%inputPath%\*" (
    for %%f in ("%inputPath%\*.svg" "%inputPath%\*.pdf" "%inputPath%\*.png" "%inputPath%\*.jpg") do call :ConvertFile "%%f"
) else (
    call :ConvertFile "%inputPath%"
)

rem 結果表示
echo 処理が完了しました。
echo 処理対象ファイル数: %count%
echo 成功: %success%
echo 失敗: %failed%
pause
exit /b 0

:ConvertFile
set /a count+=1
set inputFile=%~1
set inputDir=%~dp1
set fileName=%~n1
set outputFile=%inputDir%%fileName%.%format%

echo [%count%] 処理中: %inputFile%
%inkscape1% --export-filename="%outputFile%" --export-dpi=%dpi% "%inputFile%"
if exist "%outputFile%" (
    echo [%count%] 成功: %outputFile%
    set /a success+=1
) else (
    echo [%count%] 失敗: %inputFile%
    set /a failed+=1
)
goto :eof