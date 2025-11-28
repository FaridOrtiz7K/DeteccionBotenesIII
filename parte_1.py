import time
import csv
import pyautogui
import sys

# Configuración de seguridad
print("Script iniciado. Presiona Ctrl+C en la terminal para detener.")

def main():
    # Ruta del archivo CSV
    file_path = r"C:\Users\cmf05\Documents\AutoHotkey\Move poles.csv"
    
    try:
        # Leer el archivo CSV
        with open(file_path, 'r', newline='', encoding='utf-8') as csvfile:
            csv_reader = csv.reader(csvfile)
            rows = list(csv_reader)
            
        # Saltar la primera fila (encabezados) y procesar 54 pasos
        for i in range(2, min(56, len(rows))):  # Desde fila 2 hasta 55
            if len(rows[i]) < 3:
                continue
                
            id_val = rows[i][0].strip()
            move = rows[i][1].strip()
            line = rows[i][2].strip()
            
            if move == "0":
                continue
                
            if move == "1":
                print(f"Procesando ID: {id_val} - Línea: {line}")
                
                # Secuencia de acciones
                pyautogui.click(70, 266)    # Select pole
                time.sleep(2)
                
                pyautogui.click(170, 189)   # Seleccionar en mapa
                time.sleep(2)
                
                pyautogui.click(327, 381)   # Select Agregar ruta de GE
                time.sleep(1)
                
                pyautogui.click(1396, 608)  # Archivo
                time.sleep(3)
                
                pyautogui.click(1406, 634)  # Abrir
                time.sleep(3)
                
                pyautogui.click(1120, 666)  # Documents
                time.sleep(3)
                
                pyautogui.click(1411, 840)  # File name case
                time.sleep(3)
                
                # Escribir el nombre del archivo
                pyautogui.write(f'MP {line}.kml')
                time.sleep(3)
                
                pyautogui.press('enter')
                time.sleep(2)
                
                pyautogui.click(327, 381)   # Select Agregar ruta de GE
                time.sleep(2)
                
                pyautogui.click(1406, 675)  # Cargar ruta
                time.sleep(2)
                
                pyautogui.click(170, 189)   # Seleccionar en mapa
                time.sleep(2)
                
                pyautogui.click(566, 312)   # Mover por trazo
                time.sleep(2)
                
                pyautogui.click(357, 979)   # Limpiar trazo
                time.sleep(2)
                
                pyautogui.click(302, 313)   # Modo seleccion
                time.sleep(2)
                
                pyautogui.click(70, 266)    # Select Pole
                time.sleep(2)
                pyautogui.press('down')
                time.sleep(2)
                
        print("¡Todas las operaciones completadas!")
        
    except FileNotFoundError:
        print(f"Error: No se pudo encontrar el archivo {file_path}")
    except Exception as e:
        print(f"Error inesperado: {str(e)}")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nScript interrumpido por el usuario")
        sys.exit()