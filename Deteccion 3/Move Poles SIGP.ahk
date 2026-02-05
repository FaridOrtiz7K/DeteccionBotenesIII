#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

; Safety feature - Esc key to stop the script, Pause to pause
Pause::Pause
Esc::ExitApp

; Hotkey to start the process (F2)
F2::
    ; Read the CSV file
    FilePath := "C:\Users\cmf05\Documents\AutoHotkey\Move poles.csv"
    
    ; Read the entire file
    FileRead, CSVContent, %FilePath%
    if ErrorLevel
    {
        MsgBox, Could not read the CSV file: %FilePath%
        return
    }
    
    ; Split into rows
    Rows := StrSplit(CSVContent, "`n", "`r")
    
    ; Loop through 54 steps
    Loop, 54
    {
        CurrentRow := A_Index + 1 ; Start from row 2
        
        ; Check if we have enough rows
        if (CurrentRow > Rows.Length())
            break
        
        ; Split the current row into columns
        Columns := StrSplit(Rows[CurrentRow], ",")
        
        ; Check if we have at least 3 columns
        if (Columns.Length() < 3)
            continue
        
        ID := Trim(Columns[1])
        Move := Trim(Columns[2])
        Line := Trim(Columns[3])
        
        ; Skip if Move is 0
        if (Move = "0")
            continue
        
        ; Only proceed if Move is 1
        if (Move = "1")
        {
            ; Display current operation
            ToolTip, Processing ID: %ID% - Line: %Line%
            
            ; Perform the sequence of actions
            Click, 70, 266 ; Select pole
            Sleep, 2000        
            
            Click, 170, 189 ; Seleccionar en mapa
            Sleep, 2000
            
            Click, 327, 381 ; Select Agregar ruta de GE
            Sleep, 1000
            
            Click, 1396, 608 ; Archivo
            Sleep, 3000
            
            Click, 1406, 634 ; Abrir 
            Sleep, 3000
            
            Click, 1120, 666 ; Documents
            Sleep, 3000
            
            Click, 1411, 840 ; File name case
            Sleep, 3000            
            
            ; Send the filename with the Line value
            Send, MP %Line%.kml
            Sleep, 3000
            
            Send, {Enter}    
            Sleep, 2000
            
            Click, 327, 381 ; Select Agregar ruta de GE
            Sleep, 2000
            
            Click, 1406, 675 ; Cargar ruta
            Sleep, 2000

            Click, 170, 189 ; Seleccionar en mapa
            Sleep, 2000			
            
            Click, 566, 312 ; Mover por trazo
            Sleep, 2000

            Click, 357, 979 ; Limpiar trazo
            Sleep, 2000

            Click, 302, 313 ; Modo seleccion
            Sleep, 2000			

            Click, 70, 266 ; Select Pole
            Sleep, 2000
            Send, {Down}
            Sleep, 2000				
            
            ; Clear the tooltip
            ToolTip
        }
    }
    
    MsgBox, All operations completed!
return