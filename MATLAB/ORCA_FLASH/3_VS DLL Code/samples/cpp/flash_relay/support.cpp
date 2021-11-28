#pragma once
#include "stdafx.h"
#include "support.h"
#include <stdlib.h>
#include <string>
#include <sstream>

using namespace std;
#pragma warning(disable : 4996) //has to be added to each file that has deprecated functions in it


bool CopyToClipboard(string strData)
{

	if (OpenClipboard(NULL))
	{
		// Empty the Clipboard. This also has the effect
		// of allowing Windows to free the memory associated
		// with any data that is in the Clipboard
		EmptyClipboard();

		// Ok. We have the Clipboard locked and it's empty. 
		// Now let's allocate the global memory for our data.

		// Here I'm simply using the GlobalAlloc function to 
		// allocate a block of data equal to the text in the
		// "to clipboard" edit control plus one character for the
		// terminating null character required when sending
		// ANSI text to the Clipboard.
		HGLOBAL hClipboardData;
		hClipboardData = GlobalAlloc(GMEM_DDESHARE, strData.length() + 1);

		// Calling GlobalLock returns to me a pointer to the 
		// data associated with the handle returned from 
		// GlobalAlloc
		char * pchData;
		pchData = (char*)GlobalLock(hClipboardData);

		// At this point, all I need to do is use the standard 
		// C/C++ strcpy function to copy the data from the local 
		// variable to the global memory.
		strcpy(pchData, LPCSTR(strData.c_str()));

		// Once done, I unlock the memory - remember you 
		// don't call GlobalFree because Windows will free the 
		// memory automatically when EmptyClipboard is next 
		// called. 
		GlobalUnlock(hClipboardData);

		// Now, set the Clipboard data by specifying that 
		// ANSI text is being used and passing the handle to
		// the global memory.
		SetClipboardData(CF_TEXT, hClipboardData);

		// Finally, when finished I simply close the Clipboard
		// which has the effect of unlocking it so that other
		// applications can examine or modify its contents.
		CloseClipboard();
	}
	else return false;

	return true;
}
bool CopyFromClipboard(string& strData)
{
	// Test to see if we can open the clipboard first.
	if (OpenClipboard(NULL))
	{
		// Retrieve the Clipboard data (specifying that 
		// we want ANSI text (via the CF_TEXT value).
		HANDLE hClipboardData = GetClipboardData(CF_TEXT);

		// Call GlobalLock so that to retrieve a pointer
		// to the data associated with the handle returned
		// from GetClipboardData.
		char *pchData = (char*)GlobalLock(hClipboardData);

		// Set a local CString variable to the data
		// and then update the dialog with the Clipboard data
		strData = pchData;

		// Unlock the global memory.
		GlobalUnlock(hClipboardData);

		// Finally, when finished I simply close the Clipboard
		// which has the effect of unlocking it so that other
		// applications can examine or modify its contents.
		CloseClipboard();
	}
	else return false;

	return true;
}



void con(char* str, int x, int y){
	HDC dc=GetDC(NULL);
	TextOutA(dc,x,y,str,(int)strlen(str));
	ReleaseDC(NULL,dc);
}
void con(INT8* str, int x, int y) {
	HDC dc = GetDC(NULL);
	TextOutA(dc, x, y, (char*)str, (int)strlen((char*)str));
	ReleaseDC(NULL, dc);
}
void con(const char* str, int x, int y) {
	HDC dc = GetDC(NULL);
	TextOutA(dc, x, y, str, (int)strlen(str));
	ReleaseDC(NULL, dc);
}
void con(int in,int x, int y)
{
	HDC dc=GetDC(NULL);
	char buff[100]={0};
	_ltoa_s(in,buff,10);
	TextOutA(dc,x,y,"            ",7);
	TextOutA(dc,x,y,buff,(int)strlen(buff));
	ReleaseDC(NULL,dc);
}
void con(double in, int x, int y) {
	std::stringstream ss;
	ss << in;
	con(ss.str().c_str(), x, y);



}
void con(unsigned short in, int x, int y) {
	std::stringstream ss;
	ss << in;
	con(ss.str().c_str(), x, y);
}
void con(unsigned int in, int x, int y) {
	std::stringstream ss;
	ss << in;
	con(ss.str().c_str(), x, y);
}
void con(WCHAR* str, int x, int y)
{
			int len=WideCharToMultiByte(CP_ACP,0,str,-1,NULL,0,NULL,NULL);
			char* bnn=new char[len];
			memset(bnn,0,len);
			WideCharToMultiByte(CP_ACP,0,str,-1,bnn,len,NULL,NULL);
			con(bnn,x,y);
			delete bnn;
}
void display_error()
{
LPVOID lpMsgBuf;
	FormatMessage( 
    FORMAT_MESSAGE_ALLOCATE_BUFFER | 
    FORMAT_MESSAGE_FROM_SYSTEM | 
    FORMAT_MESSAGE_IGNORE_INSERTS,
    NULL,
    GetLastError(),
    MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
    (LPTSTR) &lpMsgBuf,
    0,
    NULL );


	con((WCHAR*)lpMsgBuf, 0, 100);


}
