#pragma once


#define MUTEX_API __declspec(dllexport)


#ifdef __cplusplus
extern "C" {
#endif
	MUTEX_API void Win_Beep(int freq, int dur);
	MUTEX_API unsigned long long int Win_CreateMutex(char* mutexSz);
	MUTEX_API bool Win_ReleaseMutex(unsigned long long int handle);
	MUTEX_API unsigned long long int Win_OpenMutex(char* mutexSz);
	MUTEX_API bool Win_CloseHandle(unsigned long long int handle);
	MUTEX_API unsigned int Win_WaitForSingleObject(unsigned long long int handle, unsigned int milliSec);
	MUTEX_API bool Win_CopyToClipboard(char* sz);
	MUTEX_API char* Win_CopyFromClipboard(char* szBuffer);
	MUTEX_API bool Win_CopyToClipboardDbl(double* pDbl, int num);
	MUTEX_API double* Win_CopyFromClipboardDbl(double* pDblBuffer, int num);
	MUTEX_API __int64 Win_QueryPerformanceCounter();
	MUTEX_API __int64 Win_QueryPerformanceFrequency();
	MUTEX_API void Win_PerformancePause(double millisec);
	MUTEX_API __int64 Win_WaitForCount(__int64 count);
	MUTEX_API bool Win_InitSpeechEngine();
	MUTEX_API void Win_ShutdownSpeechEngine();
	MUTEX_API bool Win_Speak(char* outSz, bool bSychronous);
	MUTEX_API void Win_InitCueSystem(char* sz);
	MUTEX_API void Win_SetCue(int cue);
	MUTEX_API int Win_WaitForCue(int cue);
	MUTEX_API void Win_ShutdownCueSystem();
	MUTEX_API double FindMetric(int w, int h, unsigned short* im, unsigned short* imBack, int* X, int* Y, int numPts, int sz, int r);
	// 03_12_20
	MUTEX_API void QualityPrint(char* sz, int x, int y, int szz, int r, int g, int b);
#ifdef __cplusplus
}
#endif
