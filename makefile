INCLUDE = include/
LIB = lib/
SRCS = scene.cpp light.cpp model.cpp mesh.cpp material.cpp io.cpp camera.cpp glconfig.cpp main.cpp
OBJS = ${SRCS:.cpp=.o}
CFLAGS = -O2 -std=c++11 -Wall -Wno-deprecated-declarations -I${INCLUDE}
CC = g++

atview : ${OBJS}
	g++ ${CFLAGS} ${OBJS} -o atview -framework OpenGL -framework Cocoa -L${LIB} -lassimp -lfreeimage -lglfw -lanttweakbar
	install_name_tool -change /usr/local/opt/assimp/lib/libassimp.4.dylib @executable_path/libassimp.dylib atview
	install_name_tool -change /usr/local/opt/glfw/lib/libglfw.3.dylib @executable_path/libglfw.dylib atview
	mkdir -p bin
	mv atview bin/
	cp ${LIB}*.dylib bin/

run : atview
	bin/atview

.cpp.o : ${HEADERS}
	${CC} -c ${CFLAGS} $<

clean :
	rm -rf bin ${OBJS}
