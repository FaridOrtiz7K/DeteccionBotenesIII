#Persistent
SetTitleMatchMode, 2

; Define the hotkey to exit the script
Esc::ExitApp

; Define a hotkey to start the actions
F2::PerformActions()

; Function to perform the clicks and actions
PerformActions() {
    ; Check if the CSV file exists
    if (!FileExist("C:\Users\cmf05\Documents\AutoHotkey\RA distances.csv")) {
        MsgBox, The specified CSV file does not exist!
        return
    }

    ; Read the CSV file
    FileRead, csvContent, C:\Users\cmf05\Documents\AutoHotkey\RA distances.csv
    lines := StrSplit(csvContent, "`n")  ; Split into lines (correct delimiter for newlines)
    
    ; Check if we have enough lines
    if (lines.MaxIndex() < 1)  ; Ensure at least 1 line exists
    {
        MsgBox, Not enough data in the CSV file!
        return
    }

    numRa := 1 ; Initialize the variable
    
    Loop, 57 { ; Loop 64 times
			Click, 316, 215 ; Select Agregar ruta de GE
            Sleep, 1000
            
            Click, 1396, 608 ; Archivo
            Sleep, 3000
            
            Click, 1406, 634 ; Abrir 
            Sleep, 3000
            
            Click, 1120, 666 ; Documents
            Sleep, 3000
            
			Click, 1411, 840 ; File name case
            Sleep, 3000 
        Send, RA %numRa%.kml ; Use the variable
        Sleep, 3000
        Send, {Enter}    
        Sleep, 2000 ; Wait 4 seconds
        	Click, 316, 215 ; Select Agregar ruta de GE
        Sleep, 2000 ; Wait 2 seconds
            Click, 1406, 675 ; Cargar ruta
            Sleep, 2000
        Click, 1575, 437 ; Select Longitud Medida
        Sleep, 1000
        ; Press delete key
        Send, {Backspace}
        Sleep, 1000  ; Small wait before writing the value
        Click, 1575, 437 ; Select Longitud Medida
        Sleep, 1000
        ; Press delete key
        Send, {Backspace}
        Sleep, 1000  ; Small wait before writing the value
       
        ; Check if we are at a valid iteration
        if (numRa <= lines.MaxIndex())  ; Ensure we don't go beyond available lines
        {
            ; Split the current line into columns
            values := StrSplit(lines[numRa], ",")  ; Access the appropriate line based on numRa

            ; Ensure the second column exists
            if (values.MaxIndex() >= 2)  
            {
                ; Ensure the correct click is made before writing the value
                Click, 1575, 437 ; Click to focus the input field
                Sleep, 1000  ; Wait 1 second to ensure the field is focused

                ; Show the value being sent for debugging
               ; MsgBox, Sending value: % values[2]

                ; Write the value from the second column (B1 for the first iteration)
                Send, % values[2]  ; Send the value from the second column
                Sleep, 1000  ; Wait 1 second after sending the value to ensure the program processes it

                ; Left click at (1260, 197) Insertar
                Click, 1260, 197
                Sleep, 3000  ; Wait 3 seconds
            }
        }
        
        ; Every 10 steps, press Ctrl + S
        if (Mod(A_Index, 10) = 0) { ; Using Mod for clarity
            Send, ^s ; Press Ctrl + S
            Sleep, 6000 ; Wait 6 seconds
        }

        numRa++ ; Increment the variable
    }

    Send, ^s ; Press Ctrl + S at the end
    MsgBox, The script has finished! ; Notify the user
    return
}
