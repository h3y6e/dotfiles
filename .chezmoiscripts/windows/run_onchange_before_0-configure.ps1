Set-StrictMode -Version Latest

$ErrorActionPreference = "Stop"
$PSDefaultParameterValues['*:ErrorAction'] = 'Stop'

Write-Host -ForegroundColor Magenta "setting up configure..."

# キーボードのプロパティ > 速度 > 文字の入力 > 表示までの待ち時間 > 短く
Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Value 0
