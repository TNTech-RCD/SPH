CC=mpicc
CLIBS= -L/usr/local/lib -lglfw -lGL -lGLU -lX11 -lGLEW -lXxf86vm -lXrandr -lXi -lfreetype -lm -lblink1
CINCLUDES= -I/usr/include/freetype2 -I../blink1-tool
CFLAGS= -DGLFW -O3 -ffast-math -I/usr/local/include -I/usr/include/libdrm -g

all:
	$(CC) $(CINCLUDES) $(CFLAGS) $(CLIBS) -DBLINK1 -L../blink1-tool blink1_light.c liquid_gl.c ogl_utils.c dividers_gl.c particles_gl.c mover_gl.c font_gl.c lodepng.c exit_menu_gl.c rectangle_gl.c renderer.c glfw_utils.c image_gl.c cursor_gl.c background_gl.c controls.c geometry.c hash.c communication.c fluid.c -o ../bin/sph.out $(CLIBS)
