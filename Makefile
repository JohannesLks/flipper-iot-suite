# Makefile für IoT Suite FAP
CC = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -std=c99 -Os -ffunction-sections -fdata-sections -fno-builtin -nostdlib
LDFLAGS = -Wl,--gc-sections -Wl,--entry=iot_suite_app

# Furi SDK Pfad (wird vom Container gesetzt)
FURI_SDK_PATH ?= /work/_fw

# Include-Verzeichnisse (minimal)
INCLUDES = -I$(FURI_SDK_PATH)/lib/cmsis_core

# Quell-Dateien
SOURCES = src/main.c
OBJECTS = $(SOURCES:.c=.o)
TARGET = iot_suite.fap

# Standard Target
all: $(TARGET)

# FAP erstellen (vereinfacht)
$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^

# Objekt-Dateien kompilieren
%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

# Clean
clean:
	rm -f $(OBJECTS) $(TARGET)

# Phony targets
.PHONY: all clean
