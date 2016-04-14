
DIR     := ./debug
ELF     := $(DIR)/main_exe
#SOURCES:= $(wildcard *.cpp) $(wildcard *.c) $(wildcard *.cc) $(wildcard *.h)
OCPP    := $(patsubst %.cpp, $(DIR)/%.o, $(wildcard *.cpp))
OC      := $(patsubst %.c, $(DIR)/%.co, $(wildcard *.c))
OCC	    := $(patsubst %.cc, $(DIR)/%.cco, $(wildcard *.cc))
OBJS    := $(OC) $(OCC) $(OCPP)

CC      := g++
INCLUDE :=                                       #用于包含其它路径的头文件
LIBS    :=                                       #用于包含动/静态库文件
DEFINES :=                                       #用于条件编译
CFLAGS  := -g  -Wall $(DEFINES) $(INCLUDE)       #调试
#CFLAGS := -O2 -Wall $(DEFINES) $(INCLUDE)       #发布

all     : cleanln mkdebug $(ELF) copy
cleanln :
	@rm -rf ./main_exe
mkdebug :
	@if [ ! -d $(DIR) ]; then mkdir $(DIR); fi;  # @ 用于不显示这条命令; - 用于忽略错误,继续make
$(ELF)  : $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS) $(addprefix -l,$(LIBS))
$(DIR)/%.o  : %.cpp
	$(CC) -c $(CFLAGS) $< -o $@
$(DIR)/%.co : %.c
	$(CC) -c $(CFLAGS) $< -o $@
$(DIR)/%.cco: %.cc
	$(CC) -c $(CFLAGS) $< -o $@
copy    :
	@ln -s $(ELF) ./main_exe

.PHONY  : rebuild clean
rebuild : clean all
clean   :
	@rm -rf $(DIR) ./main_exe
