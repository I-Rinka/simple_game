.386
.model flat,stdcall
option casemap:none

includelib msvcrt.lib
includelib acllib.lib


include inc\acllib.inc
include inc\sharedVar.inc
include inc\controller.inc ;CONTROLLER

printf proto c:dword,:vararg

.data
hello sbyte	"hello",0

.code

main proc;�ο�ʼ�ĵط�

	invoke	init_first
	invoke	initWindow,offset hello,DEFAULT,DEFAULT,500,500

	invoke registerMouseEvent,iface_mouseEvent ;��C����һ���ĵ��÷�ʽ

	invoke	init_second

	ret
main endp


end main