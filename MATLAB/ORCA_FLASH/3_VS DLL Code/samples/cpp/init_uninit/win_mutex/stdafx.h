// stdafx.h : include file for standard system include files,
// or project specific include files that are used frequently, but
// are changed infrequently
//

#pragma once

#include "targetver.h"


//#define WIN32_LEAN_AND_MEAN             // Exclude rarely-used stuff from Windows headers
// Windows Header Files:
#include <windows.h>
#include "../../flash_relay/support.h"
#include <stdio.h>
#include <tchar.h>

// TODO: reference additional headers your program requires here
#include <gdiplus.h>
#include "Include\sapi.h"
#include "Include\sphelper.h"

void GdiDrawTest(WCHAR* wsz, int x, int y, int sz, int r, int g, int b);
void GdiFillRect(int x, int y, int sx, int sy, int r, int g, int b);
void GdiDrawRect(int x, int y, int sx, int sy, int r, int g, int b);
void GdiInit();
void GdiShutdown();
