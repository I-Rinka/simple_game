.386
.model flat,stdcall
option casemap:none

includelib msvcrt.lib
includelib acllib.lib
include msvcrt.inc

include inc\sharedVar.inc
include inc\model.inc
include inc\acllib.inc
;include sharedVar.asm

.code
;FlushScore proc C num: dword
;	ret
;FlushScore endp
;loadMenu proc C win:dword
;	ret
;loadMenu endp
;initGameWindow proc C num: dword,speed:dword
;	ret
;initGameWindow endp
;flushGameWindow proc C
;	ret
;flushGameWindow endp

KeyboardEvent proc C windowType:dword
	;�Ĵ���ѹջ
	pushad
	.if currWindow == 0 && windowType == 0
		invoke Window0Type0
	.elseif currWindow == 0 && windowType == 1
		invoke Window0Type1
	.elseif currWindow == 0 && windowType == 2
		invoke Window0Type2
	.elseif currWindow == 1 && windowType == 0
		invoke Window1Type0
	.elseif currWindow == 1 && windowType == 1
		invoke Window1Type1
	.elseif currWindow == 1 && windowType == 2
		invoke Window1Type2
	.elseif currWindow == 2 && windowType == 0
		invoke Window2Type0
	.elseif currWindow == 2 && windowType == 1
		invoke Window2Type1
	.elseif currWindow == 3 && windowType == 0
		invoke Window3Type0
	.elseif currWindow == 3 && windowType == 1
		invoke Window3Type1
	.else
		mov eax,0
	.endif

	;�Ĵ�����ջ
	popad

	ret
KeyboardEvent endp

Window0Type0 proc C
	invoke InitWindow
	ret
Window0Type0 endp

Window0Type1 proc C
	invoke crt_exit,0
	ret
Window0Type1 endp

Window0Type2 proc C
	ret
Window0Type2 endp

Window1Type0 proc C
	local middle1:DWORD

	;test
	;invoke crt_printf,addr szMiddle4Fmt,cdeg

	mov esi,0
	;ѭ��
	ACT1:
	mov eax,pindeg[4*esi]
	sub eax,cdeg
	mov middle1,eax
	push esi
	invoke crt_abs,middle1
	pop esi
	;�жϲ���Ƿ����10
	.if eax < 10
		mov middle1,esi
		;pushad
		;invoke crt_printf,addr szMiddle3Fmt,esi
		;popad
		invoke cancelTimer,0
		invoke loadMenu,2
		ret
	.endif
	;ѭ���ж�
	inc esi
	cmp esi,modelInsertedPinNumber
	jl ACT1;<

	;δ������ײ
	;���б�����һЩ����
	mov eax,cdeg
	mov ebx,modelInsertedPinNumber
	mov pindeg[ebx*4],eax

	dec pinnum

	inc modelInsertedPinNumber

	inc modelScore
	invoke FlushScore,modelScore

	;�ж���Ϸ�Ƿ����
	.if pinnum == 0
		invoke cancelTimer,0
		invoke loadMenu,3
		ret
	.endif

	ret
Window1Type0 endp

Window1Type1 proc C
	invoke cancelTimer,0
	invoke loadMenu,0
	ret
Window1Type1 endp

Window1Type2 proc C
	ret
Window1Type2 endp

Window2Type0 proc C
	invoke Window0Type0
	ret
Window2Type0 endp

Window2Type1 proc C
	invoke loadMenu,0
	ret
Window2Type1 endp

Window3Type0 proc C
	inc modelNowDifficulty
	invoke InitWindow
	ret
Window3Type0 endp

Window3Type1 proc C
	invoke loadMenu,0
	ret
Window3Type1 endp

InitParam proc C
	mov modelScore,0
	mov modelNowDifficulty,5
	ret
InitParam endp

InitWindow proc C
	local middle1:DWORD,middle2:dword

	;�������������
	push 0
	call crt_time
	add esp,4
	push eax
	call crt_srand
	add esp,4

	;��ʼ��cdeg
	invoke crt_rand
	mov edx,0
	mov ecx,360
	div ecx
	mov cdeg,edx
	;invoke crt_printf,addr szMiddle2Fmt,cdeg

	;��ʼ��modelInsertedPinNumber
	mov eax,modelNowDifficulty
	mov modelInsertedPinNumber,eax 

	;��ʼ��pindeg
	invoke crt_memset,addr pindeg,0,360

	lea eax,middle1
	;��ѭ�������������
	mov esi,0
	ACT1:
	invoke crt_rand
	mov edx,0
	mov ecx,36
	div ecx
	mov eax,edx
	mov edx,0
	mov ebx,10
	mul ebx
	mov edx,eax
	mov middle1,edx
	
	;��ѭ�����жϵ�ǰ�����������������Ƿ���ֹ�
	.if esi >= 1
		mov edi,0
		ACT2:
		cmp edx,dword ptr pindeg[4*edi]
		;�����ȣ��򷵻�ACT1����������
		jz ACT1;=
		;�������ȣ������ɺϷ�������ִ�У��ж���ѭ���Ƿ����
		inc edi
		cmp edi,esi
		jl ACT2;<
	.endif
	
	;�ӼĴ����������ڴ�s
	mov dword ptr pindeg[4*esi],edx
	mov middle1,edx
	;pushad
	;invoke crt_printf,addr szMiddle1Fmt,middle1
	;popad
	
	;��ѭ���ж�
	inc esi
	cmp esi,modelNowDifficulty
	jl ACT1 ;<��ת

	;��ʼ��pinnum
	mov eax,modelNowDifficulty
	mov ebx,2
	mul ebx
	mov pinnum,eax

	;����ת��
	mov eax,modelNowDifficulty
	mov ebx,2
	mul ebx
	mov ebx,35
	sub ebx,eax
	;invoke crt_printf,addr szMiddle2Fmt,ebx
	mov modelOmega,ebx

	;����ҳ��
	pushad
	invoke initGameWindow,modelNowDifficulty,modelOmega
	popad

	
	;test
	;mov cdeg,100
	;invoke Window1Type0
	;
	;mov edi,4
	;mov eax,pindeg[edi]
	;mov cdeg,eax
	;
	;invoke Window1Type0
	
	ret
InitWindow endp

end