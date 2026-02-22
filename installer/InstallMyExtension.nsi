!include "MUI2.nsh"
Name "InstallMyExtension"
OutFile "InstallMyExtension.exe"
InstallDir "$PROGRAMFILES\\MyExt"
RequestExecutionLevel admin
Page instfiles

Section "Install"
  SetOutPath "$INSTDIR"
  CreateDirectory "$INSTDIR\\extensions"

  ; Tải CRX từ GitHub Pages (PowerShell)
  nsExec::ExecToLog 'powershell -NoProfile -Command "Invoke-WebRequest -Uri \"https://manh0206.github.io/RBSR/releases/my_extension.crx\" -OutFile \"$env:ProgramFiles\\MyExt\\extensions\\my_extension.crx\" -UseBasicParsing"'

  ; Ghi registry để Chrome/Edge force-install (system-wide)
  WriteRegStr HKLM "SOFTWARE\\Google\\Chrome\\Extensions\\eigimahkcfmpgdmndoogednoopbjmang" "update_url" "https://manh0206.github.io/RBSR/releases/updates.xml"
  WriteRegStr HKLM "SOFTWARE\\Microsoft\\Edge\\Extensions\\eigimahkcfmpgdmndoogednoopbjmang" "update_url" "https://manh0206.github.io/RBSR/releases/updates.xml"

  ; Tùy: ghi entry uninstall (hiển thị trong Add/Remove Programs)
  WriteRegStr HKLM "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\InstallMyExtension" "DisplayName" "InstallMyExtension"
  WriteRegStr HKLM "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\InstallMyExtension" "UninstallString" "$INSTDIR\\Uninstall.exe"

  WriteUninstaller "$INSTDIR\\Uninstall.exe"
SectionEnd

Section "Uninstall"
  DeleteRegKey HKLM "SOFTWARE\\Google\\Chrome\\Extensions\\eigimahkcfmpgdmndoogednoopbjmang"
  DeleteRegKey HKLM "SOFTWARE\\Microsoft\\Edge\\Extensions\\eigimahkcfmpgdmndoogednoopbjmang"
  DeleteRegKey HKLM "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\InstallMyExtension"
  RMDir /r "$INSTDIR"
  Delete "$INSTDIR\\Uninstall.exe"
SectionEnd
