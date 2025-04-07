ASM = nasm

SRC_DIR = src
BUILD_DIR = build

all: $(BUILD_DIR)\main_floppy.img

$(BUILD_DIR)\main_floppy.img: $(BUILD_DIR)\main.bin
	copy /Y $(BUILD_DIR)\main.bin $(BUILD_DIR)\main_floppy.img
	powershell -Command "Set-Content -Path $(BUILD_DIR)\main_floppy.img -Value ([byte[]](Get-Content -Path $(BUILD_DIR)\main_floppy.img -Encoding Byte)) -Encoding Byte; $s = [System.IO.File]::OpenWrite('$(BUILD_DIR)\main_floppy.img'); $s.SetLength(1474560); $s.Close()"

$(BUILD_DIR)\main.bin: $(SRC_DIR)\main.asm
	$(ASM) $(SRC_DIR)\main.asm -f bin -o $(BUILD_DIR)\main.bin

clean:
	del /Q $(BUILD_DIR)\*
