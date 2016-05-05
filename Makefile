# ----------------- compiler options -----------------
DIR     := ./debug
ELF     := $(DIR)/main_exe
#SOURCES := $(wildcard *.cpp) $(wildcard *.cp) $(wildcard *.cxx) $(wildcard *.cx) $(wildcard *.cc) $(wildcard *.c) $(wildcard *.h)
OCP     := $(patsubst %.cp*,$(DIR)/%.cpo,$(wildcard *.cp*))
OCX     := $(patsubst %.cx*,$(DIR)/%.cxo,$(wildcard *.cx*))
OCC     := $(patsubst %.cc,$(DIR)/%.cco,$(wildcard *.cc))
OC      := $(patsubst %.c,$(DIR)/%.co,$(wildcard *.c))
OBJS    := $(OCP) $(OCX) $(OCC) $(OC)

CC      := g++
#CC      := gcc
#CC      := clang++
#用于包含其它路径的头文件
INCLUDE := 
#用于包含动/静态库文件
LIBS    := 
LIBDIR  := 
#用于条件编译
DEFINES := 
CFLAGS  := -g -Wall $(DEFINES) $(addprefix -I,$(INCLUDE)) $(addprefix -D,$(DEFINES))  #调试
#CFLAGS  := -O2 -Wall $(DEFINES) $(addprefix -I,$(INCLUDE)) $(addprefix -D,$(DEFINES))  #发布

# ---------------------- target ----------------------
all     : mkdebug $(ELF)
	@rm -rf ./main_exe
	ln -s $(ELF) ./main_exe
mkdebug :
	@if [ ! -d $(DIR) ]; then mkdir $(DIR); fi;  # @ 用于不显示这条命令; - 用于忽略错误,继续make
$(ELF)  : $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS) $(addprefix -L,$(LIBDIR)) $(addprefix -l,$(LIBS))
$(DIR)/%.cpo  : %.cp*
	$(CC) -c $(CFLAGS) $< -o $@
$(DIR)/%.cxo: %.cx*
	$(CC) -c $(CFLAGS) $< -o $@
$(DIR)/%.cco: %.cc
	$(CC) -c $(CFLAGS) $< -o $@
$(DIR)/%.co : %.c
	$(CC) -c $(CFLAGS) $< -o $@

.PHONY  : rebuild clean
rebuild : clean all
clean   :
	rm -rf $(DIR) ./main_exe
