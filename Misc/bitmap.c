#include<windows.h>

#include <stdio.h>
#include <stdlib.h>

#include <GL/gl.h>
#include <GL/glu.h>
#include <glut.h>

//standard window function
void reshape(int w, int h)
{
   glViewport(0, 0, (GLsizei) w, (GLsizei) h);
   glMatrixMode(GL_PROJECTION);
   glLoadIdentity();
   glOrtho (0, w, 0, h, -1.0, 1.0);
   glMatrixMode(GL_MODELVIEW);
}

//bitmap display config
GLubyte rasters[6400];
float color[3] = {1.0, 0.592, 0.211};

unsigned char byte = 255;

rasters[3000] = byte;

void display()
{
	glClear(GL_COLOR_BUFFER_BIT);
	glColor3f (color[0], color[1], color[2]); //RBG/255
	glRasterPos2i (0, 0);
	glBitmap (256, 200, 0.0, 0.0, 0.0, 0.0, rasters); 
	glFlush();
}

void keyboard(unsigned char key, int x, int y)
{
   switch (key) {
      case 27:
		 exit(0);
   }
}

int main(int argc, char** argv)
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
	glutInitWindowSize(1024, 800);
	glutInitWindowPosition(1024, 800);
	glutCreateWindow(argv[0]);
	glPixelStorei (GL_UNPACK_ALIGNMENT, 1);
	glClearColor (0.0, 0.0, 0.0, 0.0);
   
	while(1) {
		glutReshapeFunc(reshape);
		glutKeyboardFunc(keyboard);
		glutDisplayFunc(display);
		glutMainLoop();
	}
   
}