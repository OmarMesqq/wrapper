#include <stdio.h>
#include "python3.10/Python.h"

void callPython(const char * path) {
    Py_Initialize();
    PyRun_SimpleString("import sys\nsys.path.append('..')");
    const char * filePath = path;
    FILE * filePointer;

    filePointer = fopen(filePath,"r");
    PyRun_SimpleFile(filePointer, filePath);
    Py_Finalize();
}


int main() {
    callPython("../main.py");
    return 0;

}
