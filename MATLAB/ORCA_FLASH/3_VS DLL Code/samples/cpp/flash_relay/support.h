#pragma once
#include "windows.h"
#include <string>
#include <sstream>
/////functions declared///////////////
void display_error();
void con(char* str, int x, int y);
void con(INT8* str, int x, int y);
void con(WCHAR* str, int x, int y);
void con(int in,int x, int y);
void con(unsigned short in, int x, int y);
void con(unsigned int in, int x, int y);
void con(double in, int x, int y);
bool CopyToClipboard(std::string strData);
bool CopyFromClipboard(std::string& strData);

