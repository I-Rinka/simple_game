.386
.model flat,stdcall
option casemap:none
includelib msvcrt.lib
includelib acllib.lib
include inc\acllib.inc
include inc\sharedVar.inc
include inc\iconPosition.inc
include inc\view.inc
include inc\msvcrt.inc
include inc\model.inc

printf proto C :dword,:vararg

.data
coord sbyte "%d,%d",10,0
now_window sbyte "current Window: %d",10,0

.code
	;�жϵ���������Ƿ��ھ��ο��ڣ��Ƿ���1�������򷵻�0,ע�⣬bottomһ���up����Ϊ��������ۿ����ĵײ�����windows����ϵ�����Ͻ�Ϊ0
	is_inside_the_rect proc C x:dword,y:dword,left:dword,right:dword,up:dword,bottom:dword
		mov eax,x
		mov ebx,y
		.if	eax <= left
			mov eax,0
		.elseif	eax >= right
			mov eax,0
		.elseif ebx >= bottom
			mov eax,0
		.elseif ebx <= up
			mov eax,0
		.else	
			mov eax,1
		.endif	
		ret
	is_inside_the_rect endp

	iface_mouseEvent proc C x:dword,y:dword,button:dword,event:dword
		mov ecx,event
		cmp ecx,BUTTON_DOWN
		jne not_click
			

			invoke	printf,offset now_window,currWindow ;���������Ľ���

			.if	currWindow == 0;��ʼ�˵�
				;��ʼ�˵��Ŀ�ʼ��
				invoke is_inside_the_rect,x,y,menu_start_game_left,menu_start_game_right,menu_start_game_up,menu_start_game_bottom
					.if eax == 1
						
						invoke printf,offset coord,x,y ;����˿�ʼ������¼�
						invoke KeyboardEvent,0
					.endif


				;��ʼ�˵����˳���
				invoke is_inside_the_rect,x,y,menu_exit_game_left,menu_exit_game_right,menu_exit_game_up,menu_exit_game_bottom
					.if eax == 1

						invoke printf,offset coord,x,y ;����˺���¼�
						invoke KeyboardEvent,1
					.endif

			.elseif currWindow == 1 ;��Ϸ������
				invoke is_inside_the_rect,x,y,gaming_house_left,gaming_house_right,gaming_house_up,gaming_house_bottom
					.if eax == 1
						
						invoke printf,offset coord,x,y ;����˷���
						invoke KeyboardEvent,1
					.endif
					;action
					;	���������������
						invoke KeyboardEvent,0

			.elseif currWindow == 2 ;���յ÷�
				invoke is_inside_the_rect,x,y,final_score_house_left,final_score_house_right,final_score_house_up,final_score_house_bottom
					.if eax == 1
						
						invoke printf,offset coord,x,y ;����˷���
						invoke KeyboardEvent,1
					.endif

				invoke is_inside_the_rect,x,y,final_score_restart_left,final_score_restart_right,final_score_restart_up,final_score_restart_bottom
					.if eax == 1

						invoke printf,offset coord,x,y ;��������¿�ʼ
						invoke KeyboardEvent,0
					.endif

			.elseif	currWindow == 3 ;��Ү����ͨ���ˣ�
				
				;���ӣ��������˵�
				invoke is_inside_the_rect,x,y,pass_game_house_left,pass_game_house_right,pass_game_house_up,pass_game_house_bottom
					.if eax == 1

						invoke printf,offset coord,x,y ;����˺���¼�
						invoke KeyboardEvent,1
					.endif

				;���¿�ʼ��Ϸ
				invoke is_inside_the_rect,x,y,pass_game_continue_left,pass_game_continue_right,pass_game_continue_up,pass_game_continue_bottom
					.if eax == 1
						
						invoke printf,offset coord,x,y ;����˺���¼�
						invoke KeyboardEvent,0
					.endif
			
			.endif



		not_click:
		ret 
	iface_mouseEvent endp


end