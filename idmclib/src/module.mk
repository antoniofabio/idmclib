LIB_SRC:= $(wildcard src/*.c)
LIB_OBJ:= $(LIB_SRC:%.c=%.o)
LIB_HEADERS:= $(wildcard include/idmclib/*.h) include/idmclib/version.h

SRC += $(LIB_SRC)
TOCLEAN += src/libidmclib.a $(LIB_OBJ)

$(LIB_OBJ):%.o:%.c $(LIB_HEADERS)

src/libidmclib.a: $(LIB_OBJ)
	$(AR) rcs $@ $(LIB_OBJ)
