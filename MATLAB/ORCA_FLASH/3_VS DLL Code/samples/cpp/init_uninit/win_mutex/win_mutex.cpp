// win_mutex.cpp : Defines the exported functions for the DLL application.
//

#include "stdafx.h"
#include "win_mutex.h"
#include <string>
#include <sstream>
using namespace std;

HANDLE h = NULL;
bool bInfo = false;
ISpVoice * pVoice = NULL;
bool EngineStarted = false;
string sz_cue;

#ifdef __cplusplus
extern "C" {
#endif
	MUTEX_API void Win_Beep(int freq, int dur) {
		Beep(freq, dur);
	}
	MUTEX_API unsigned long long int Win_CreateMutex(char* mutexSz)
	{

		const WCHAR *pwcsName;
		// required size
		int nChars = MultiByteToWideChar(CP_ACP, 0, mutexSz, -1, NULL, 0);
		// allocate it
		pwcsName = new WCHAR[nChars];
		MultiByteToWideChar(CP_ACP, 0, mutexSz, -1, (LPWSTR)pwcsName, nChars);

	
		HANDLE ghMutex = CreateMutex(
			NULL,              // default security attributes
			FALSE,             // initially not owned
		pwcsName
		);             // unnamed mutex
		if (bInfo) {
			display_error();
			con("CreateMutex", 0, 0);
		}

		h = ghMutex;
		delete[] pwcsName;
		return (unsigned long long int)ghMutex;

		//HANDLE WINAPI CreateMutex(
		//	_In_opt_ LPSECURITY_ATTRIBUTES lpMutexAttributes,
		//	_In_     BOOL                  bInitialOwner,
		//	_In_opt_ LPCTSTR               lpName
		//);

	}
	MUTEX_API bool Win_ReleaseMutex(unsigned long long int handle)
	{
		 bool bl = ReleaseMutex((HANDLE)handle);
		 if (bInfo) {
			 display_error();
			 con("ReleaseMutex", 0, 0);
		 }
		 return bl;

		//BOOL WINAPI ReleaseMutex(
		//	_In_ HANDLE hMutex
		//);

	}
	MUTEX_API unsigned long long int Win_OpenMutex(char* mutexSz)
	{
		const WCHAR *pwcsName;
		// required size
		int nChars = MultiByteToWideChar(CP_ACP, 0, mutexSz, -1, NULL, 0);
		// allocate it
		pwcsName = new WCHAR[nChars];
		MultiByteToWideChar(CP_ACP, 0, mutexSz, -1, (LPWSTR)pwcsName, nChars);

		HANDLE hMutex = OpenMutex(
			MUTEX_ALL_ACCESS,            // request full access
			FALSE,                       // handle not inheritable
			pwcsName);  // object name
		if (bInfo) {
			display_error();
			con("OpenMutex", 0, 0);
		}
		delete pwcsName;
		return (unsigned long long int)hMutex;

		//HANDLE WINAPI OpenMutex(
		//	_In_ DWORD   dwDesiredAccess,
		//	_In_ BOOL    bInheritHandle,
		//	_In_ LPCTSTR lpName
		//);
		
	}
	MUTEX_API bool Win_CloseHandle(unsigned long long int handle)
	{

		bool bl = CloseHandle((HANDLE)handle);
		if (bInfo) {
			display_error();
			con("CloseHandle", 0, 0);
		}
		return bl;

		//BOOL WINAPI CloseHandle(
		//	_In_ HANDLE hObject
		//);
	}
	MUTEX_API unsigned int Win_WaitForSingleObject(unsigned long long int handle, unsigned int milliSec)
	{

		 DWORD ret = WaitForSingleObject((HANDLE)handle, milliSec);

		display_error();
		con("WaitForSingleObject", 0, 0);
		return ret;

		//DWORD WINAPI WaitForSingleObject(
		//	_In_ HANDLE hHandle,
		//	_In_ DWORD  dwMilliseconds
		//);
	}
	MUTEX_API bool Win_CopyToClipboard(char* sz) {
	
		//con(sz, 10, 20);
		return CopyToClipboard(sz);
	}
	MUTEX_API char* Win_CopyFromClipboard(char* szBuffer) {
		string sz = "";
		CopyFromClipboard(sz); //could be improved by sending szBuffer directly to this function
		strcpy(szBuffer, (char*)sz.c_str());
		//con(szBuffer, 10, 40);
		return szBuffer ;
	}
	MUTEX_API bool Win_CopyToClipboardDbl(double* pDbl, int num) {
		std::ostringstream oss;
		//would be better to have a private format of doubles but this will do
		for (int f = 0; f < num - 1; f++) {
			oss << pDbl[f] << ' ';
		}
		oss << pDbl[num - 1];
		//con((char*)oss.str().c_str(), 10, 40);
		return CopyToClipboard(oss.str());
	}
	MUTEX_API double* Win_CopyFromClipboardDbl(double* pDbl, int num) {
		string sz = "";
		CopyFromClipboard(sz); //could be improved by sending szBuffer directly to this function
		std::stringstream ss(sz);
		for (int f = 0; f < num; f++) {
			ss >> pDbl[f];
		}
		return pDbl;
	}
	MUTEX_API __int64 Win_QueryPerformanceCounter() {
		LARGE_INTEGER counter;
		QueryPerformanceCounter(&counter);
		return counter.QuadPart;
	}
	MUTEX_API __int64 Win_QueryPerformanceFrequency() {
		LARGE_INTEGER iFrequency;
		QueryPerformanceFrequency(&iFrequency);
		return iFrequency.QuadPart;
	}
	MUTEX_API void Win_PerformancePause(double millisec) {
		__int64 start = Win_QueryPerformanceCounter();
		__int64 freq = Win_QueryPerformanceFrequency();
		int x = 0;
		while ((Win_QueryPerformanceCounter() - start)*1000.0/freq < millisec) {
			//spin
			x++;
		}
	}
	MUTEX_API __int64 Win_WaitForCount(__int64 count) {
		__int64 tm = Win_QueryPerformanceCounter();
		while (tm < count) {
			tm = Win_QueryPerformanceCounter();
		}
		return tm;
	}

	MUTEX_API bool Win_InitSpeechEngine()													//init TTS engine
	{
		if (EngineStarted)
			return true;

		if (FAILED(::CoInitialize(NULL)))
			return false;

		HRESULT hr = CoCreateInstance(CLSID_SpVoice, NULL, CLSCTX_ALL, IID_ISpVoice, (void **)&pVoice);
		if (!SUCCEEDED(hr))
		{
			::CoUninitialize();
			return false;
		}

		return true;
	}
	MUTEX_API void Win_ShutdownSpeechEngine()													//deinit TTS engine
	{
		if (!EngineStarted)
			return;

		pVoice->Release();
		pVoice = NULL;

		::CoUninitialize();
	}
	MUTEX_API bool Win_Speak(char* outSz, bool bSychronous)							//text to speech
	{
		const WCHAR *pwcsName;
		// required size
		int nChars = MultiByteToWideChar(CP_ACP, 0, outSz, -1, NULL, 0);
		// allocate it
		pwcsName = new WCHAR[nChars];
		MultiByteToWideChar(CP_ACP, 0, outSz, -1, (LPWSTR)pwcsName, nChars);
		HRESULT hr;

		if (!bSychronous)
			hr = pVoice->Speak(pwcsName, SPF_ASYNC, NULL);
		else
			hr = pVoice->Speak(pwcsName, SPF_DEFAULT, NULL);

		delete[] pwcsName;
		if (SUCCEEDED(hr))
			return true;
		else
			return false;
	}
	MUTEX_API void Win_InitCueSystem(char* sz) {
		//set the name of the file which holds the current set cue
		sz_cue = sz;
	
	}
	MUTEX_API void Win_SetCue(int cue) {
		HANDLE hFile = CreateFileA((LPCSTR)sz_cue.c_str(),
			GENERIC_WRITE | GENERIC_READ,
			FILE_SHARE_WRITE | FILE_SHARE_READ,
			NULL,
			OPEN_ALWAYS,
			FILE_ATTRIBUTE_NORMAL,
			NULL);
		DWORD dwBytesWritten = 0;
		WriteFile(hFile, (LPCVOID)&cue, (DWORD)sizeof(int), (LPDWORD)&dwBytesWritten, NULL);
		CloseHandle(hFile);
	}
	MUTEX_API int Win_WaitForCue(int cue) {

		DWORD dwBytesRead = 0;
		int   current_cue = 0;
		while (current_cue != cue) {
			HANDLE hFile = CreateFileA((LPCSTR)sz_cue.c_str(),
				GENERIC_WRITE | GENERIC_READ,
				FILE_SHARE_READ | FILE_SHARE_READ,
				NULL,
				OPEN_EXISTING,
				FILE_ATTRIBUTE_NORMAL,
				NULL);
			ReadFile(hFile, (LPVOID)&current_cue, (DWORD)sizeof(int), (LPDWORD)&dwBytesRead, NULL);
			CloseHandle(hFile);
			Sleep(500);
		}
	
		return current_cue;
	}

	MUTEX_API void Win_ShutdownCueSystem() {


	}

	MUTEX_API double FindMetric(int w, int h, unsigned short* im, unsigned short* imBack, int* X, int* Y, int numPts, int sz, int r) {
		double r2 = r * r;
		double score = 0.0;
		for (int f = 0; f < numPts; f++) {
			//find the centre of mass
			double xm = 0, ym = 0, tot = 0;
			for (int i_x = -sz; i_x <= sz; i_x++) {
				for (int i_y = -sz; i_y <= sz; i_y++) {
					xm += double(im[X[f] - 1 + i_x + w * (Y[f] - 1 + i_y)]) * i_x;
					ym += double(im[X[f] - 1 + i_x + w * (Y[f] - 1 + i_y)]) * i_y;
					tot += double(im[X[f] - 1 + i_x + w * (Y[f] - 1 + i_y)]);
				}
			}
			xm /= tot;
			ym /= tot;
			////con(xm, 0, 20 * f);
			////con(ym, 50, 20 * f);
			////con(tot, 100, 20 * f);
			tot = 0.0;
			int tot_cnt = 0;
			for (int i_x = -sz; i_x <= sz; i_x++) {
				for (int i_y = -sz; i_y <= sz; i_y++) {
					if ((i_x - xm)*(i_x - xm) + (i_y - ym)*(i_y - ym) < r2) {
						tot += double(im[int(round(X[f] + xm) + i_x) + w * int(round(Y[f] + ym) + i_y)]);
						tot_cnt++;
					}
				}
			}
			if (tot_cnt > 0) {
				score = im[int(round(xm) + w * round(ym))] / tot;
			}
			con(score, 0, 20 * f);

				

		}
	
		return score;
	}


	//03_12_20
	MUTEX_API void QualityPrint(char* sz, int x, int y, int szz, int r, int g, int b) {
		
		const size_t cSize = strlen(sz) + 1;
		wchar_t* wc = new wchar_t[cSize];
		mbstowcs(wc, sz, cSize);


		GdiInit();
		GdiFillRect(0, 0, 1200, 400, 255, 255, 255);
		GdiDrawRect(0, 0, 1200, 400, 0,0,0);
		GdiDrawTest(wc, x, y, szz, r, g, b);

		delete[] wc;
		GdiShutdown();
		//
	}
#ifdef __cplusplus
}
#endif





