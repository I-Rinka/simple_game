.386
.model flat,stdcall
option casemap:none

includelib msvcrt.lib
includelib acllib.lib


include inc\acllib.inc
include inc\sharedVar.inc

printf proto c:dword,:vararg

.data
hellomsg sbyte "gogogo!%d,%d"


.code
main proc;�ο�ʼ�ĵط�
;	invoke printf,offset hellomsg
	mov psin[0],0FFFFh
	mov psin[4],03h;��ʾ�������±��ʾ�ֽ�ƫ��������Ԫ��ƫ����
	invoke printf,offset hellomsg,psin[4],psin[0]

	ret
main endp

end main