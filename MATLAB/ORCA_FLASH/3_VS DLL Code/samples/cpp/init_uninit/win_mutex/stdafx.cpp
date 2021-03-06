// stdafx.cpp : source file that includes just the standard includes
// win_mutex.pch will be the pre-compiled header
// stdafx.obj will contain the pre-compiled type information

#include "stdafx.h"

// TODO: reference any additional headers you need in STDAFX.H
// and not in this file

//GDI plus functions to provide nice text interface
ULONG_PTR           gdiplusToken;
void GdiInit() {

	Gdiplus::GdiplusStartupInput gdiplusStartupInput;
	Gdiplus::GdiplusStartup(&gdiplusToken, &gdiplusStartupInput, NULL);
}
void GdiShutdown() {
	Gdiplus::GdiplusShutdown(gdiplusToken);
}
void GdiFillRect(int x, int y, int sx, int sy, int r, int g, int b) {
	using namespace Gdiplus;
	HDC hdc = GetDC(NULL);
	Graphics    graphics(hdc);
	SolidBrush solidBrush(Color(255, r , g, b));
	graphics.FillRectangle(&solidBrush, x, y, sx, sy);

	ReleaseDC(NULL, hdc);
}
void GdiDrawRect(int x, int y, int sx, int sy, int r, int g, int b) {
	using namespace Gdiplus;
	HDC hdc = GetDC(NULL);
	Graphics    graphics(hdc);
	Pen pen(Color(255, r, g, b));
	graphics.DrawRectangle(&pen, x, y, sx, sy);

	ReleaseDC(NULL, hdc);
}
void GdiDrawTest(WCHAR* wsz, int x, int y, int sz, int r, int g, int b)
{

	using namespace Gdiplus;
	
	HDC hdc = GetDC(NULL);
	Graphics    graphics(hdc);
	SolidBrush  brush(Color(255, r,g,b));
	FontFamily  fontFamily(L"Times New Roman");
	Font        font(&fontFamily, sz, FontStyleRegular, UnitPixel);
	PointF      pointF(x,y);



	graphics.DrawString(wsz, -1, &font, pointF, &brush);
	ReleaseDC(NULL, hdc);

	
}
