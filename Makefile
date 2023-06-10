# Directories
MSPGCC_ROOT_DIR = /home/tom/dev/tools/msp430-gcc
MSPGCC_BIN_DIR = $(MSPGCC_ROOT_DIR)/bin
MSPGCC_INCLUDE_DIR = $(MSPGCC_ROOT_DIR)/include
INCLUDE_DIRS = $(MSPGCC_INCLUDE_DIR)
LIB_DIRS = $(MSPGCC_INCLUDE_DIR)
BUILD_DIR = build
OBJ_DIR = $(BUILD_DIR)/obj
BIN_DIR = $(BUILD_DIR)/bin
TI_CCS_DIR = /home/tom/dev/tools/ccs1120/ccs
DEBUG_BIN_DIR = $(TI_CCS_DIR)/ccs_base/DebugServer/bin
DEBUG_DRIVERS_DIR = $(TI_CCS_DIR)/ccs_base/DebugServer/drivers

# Toolchain
CC = $(MSPGCC_BIN_DIR)/msp430-elf-gcc
DEBUG = LD_LIBRARY_PATH=$(DEBUG_DRIVERS_DIR) $(DEBUG_BIN_DIR)/mspdebug

# Files
TARGET = $(BIN_DIR)/blink

SOURCES = main.c \
					led.c

OBJECT_NAMES = $(SOURCES:.c=.o)
OBJECTS = $(patsubst %,$(OBJ_DIR)/%,$(OBJECT_NAMES))

# Flags
MCU = msp430g2553
WFLAGS = -Wall -Wextra -Wshadow
CFLAGS = -mmcu=$(MCU) $(WFLAGS) $(addprefix -I, $(INCLUDE_DIRS)) -Og -g
LDFLAGS = -mmcu=$(MCU) $(addprefix -L, $(LIB_DIRS))

# Build
## Linking
$(TARGET): $(OBJECTS)
	@mkdir -p $(dir $@)
	$(CC) $(LDFLAGS) $^ -o $@


## Compiling
$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $^

# Phonies
.PHONY: all clean flash

all: $(TARGET)

clean:
	rm -r $(BUILD_DIR)

flash:
	$(DEBUG) tilib "prog $(TARGET)"
