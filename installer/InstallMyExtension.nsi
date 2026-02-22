!include "MUI2.nsh"
Name "InstallMyExtension"
OutFile "InstallMyExtension.exe"
InstallDir "$PROGRAMFILES\\MyExt"
Page instfiles

Section "Install"
  SetOutPath "$INSTDIR"
  CreateDirectory "$INSTDIR\\extensions"

  ; Ghi registry để Chrome force-install (system-wide). Yêu cầu chạy installer bằng Admin.
  WriteRegStr HKLM "SOFTWARE\\Google\\Chrome\\Extensions\\eigimahkcfmpgdmndoogednoopbjmang" "update_url" "https://<username>.github.io/<repo>/updates.xml"
  WriteRegStr HKLM "SOFTWARE\\Microsoft\\Edge\\Extensions\\eigimahkcfmpgdmndoogednoopbjmang" "update_url" "https://<username>.github.io/<repo>/updates.xml"

  WriteUninstaller "$INSTDIR\\Uninstall.exe"
SectionEnd

Section "Uninstall"
  DeleteRegKey HKLM "SOFTWARE\\Google\\Chrome\\Extensions\\eigimahkcfmpgdmndoogednoopbjmang"
  DeleteRegKey HKLM "SOFTWARE\\Microsoft\\Edge\\Extensions\\eigimahkcfmpgdmndoogednoopbjmang"
  RMDir /r "$INSTDIR"
  Delete "$INSTDIR\\Uninstall.exe"
SectionEnd
