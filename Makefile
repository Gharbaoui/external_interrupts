PROJECT_NAME ?= main
LIBOPENCM3_DIR := ./external/libopencm3
LIBOPENCM3_INC_PATH := $(LIBOPENCM3_DIR)/include
LIBOPENCM3_LIB_PATH := $(LIBOPENCM3_DIR)/lib
LIBOPENCM3_STM32_LIB_NAME := libopencm3_stm32f4.a

BUILD_DIR := build

SRC_DIR := ./src
INC_DIR := ./src
SRC_FILES := $(wildcard $(SRC_DIR)/*.c) $(wildcard $(SRC_DIR)/*/*.c)
OBJ_FILES := $(patsubst %.c, $(BUILD_DIR)/%.o, $(notdir $(SRC_FILES)))


PREFIX := arm-none-eabi
CC := $(PREFIX)-gcc
FP_FLAGS	?= -mfloat-abi=hard -mfpu=fpv4-sp-d16
DEBUG_FLAGS ?= -ggdb3
CFLAGS	= -Os $(DEBUG_FLAGS)\
		  -Wall -Wextra -Wimplicit-function-declaration\
		  -Wredundant-decls -Wmissing-prototypes -Wstrict-prototypes \
		  -Wundef -Wshadow \
		  -mcpu=cortex-m4 -mthumb $(FP_FLAGS) \
		  -Wstrict-prototypes \
			-I$(INC_DIR) -I$(LIBOPENCM3_INC_PATH) \
		  -ffunction-sections -fdata-sections -MD -DSTM32F4

MAP_FILE := $(BUILD_DIR)/$(PROJECT_NAME).map
LD_FLAGS := -T stm32f446re.ld -Map=$(MAP_FILE)

GENERATED_FILES := $(OBJ_FILES) $(patsubst $(BUILD_DIR)/%.o, $(BUILD_DIR)/%.d, $(OBJ_FILES)) $(MAP_FILE) $(PROJECT_NAME).elf

all: build_dir $(PROJECT_NAME)

$(PROJECT_NAME): $(OBJ_FILES)
	$(PREFIX)-ld $(LD_FLAGS) $(OBJ_FILES) $(LIBOPENCM3_LIB_PATH)/$(LIBOPENCM3_STM32_LIB_NAME) -o $(PROJECT_NAME).elf

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c -o $@ $^

$(BUILD_DIR)/%.o: $(SRC_DIR)/*/%.c
	$(CC) $(CFLAGS) -c -o $@ $^

build_dir:
	mkdir -p $(BUILD_DIR)

clean:
	rm -f $(GENERATED_FILES)
re: all clean
