﻿
ListLines Off

	;making the 1920*1080 (actual desktop resolution) set as 1024*768 (in game settings resolution)

	;===========PLEASE SET ME UP===========
	SysGet, VirtualScreenWidth, 78
	SysGet, VirtualScreenHeight, 79
	
	global sreenWidth   := VirtualScreenWidth
	global screenHeight := VirtualScreenHeight
	
	;=======================================================================
	;=========================GUI===========================================
	;=======================================================================
	Gui, Add, Tab2,, Desktop|Game settings|Information  ; Tab2 vs. Tab requires [v1.0.47.05+].
	Gui, Add, Text,, This AHK is supposed to help`n get killstreak sounds when playing Blockade 3D
	Gui, Add, Text,, Make sure you are playing with one screen and fullscreen
	Gui, Add, Text,, Please check the Game settings resolution`n and select the right resolution
	Gui, Add, Text,, When done, just click Launch`n (a H icon would be in the system tray)
	Gui, Add, Text,, Detected desktop resolution:%sreenWidth%x%screenHeight%
	Gui, Tab, 2
	Gui, Add, Checkbox, vMyCheckboxSameReso gCheckbx checked, Different resolution
	Gui, Add, Text,, Please choose the resolution
	Gui Add, DDL, vcbx w200 hwndhcbx, 1280x600||1280x720||1280x768||1280x800||1280x960||1280x1024||1360x768||1366x768||1400x1050||1440x900||1600x900||1680x1050||1920x1080
	Gui, Tab, 3
	Gui, Add, Text,, CREDITS: freely created by gg64du02 (Steam)`nCREDITS: idea and sounds by [D]arktooth (Steam) with AutoHotKey`n
	Gui, Tab  ; i.e. subsequently-added controls will not belong to the tab control.
	Gui, Add, Button, default xm, OK  ; xm puts it at the bottom left corner.
	Gui, Show
	return

	ButtonOK:
	GuiClose:
	GuiEscape:
	Gui, Submit  ; Save each control's contents to its associated variable.
	MsgBox You entered:`n%MyCheckbox%`n%MyRadio%`n%MyEdit%
	ExitApp


	Checkbx:
	guicontrolget, MyCheckboxSameReso
	guicontrol, enable%MyCheckboxSameReso%, cbx
	return
	;=======================================================================
	;=======================================================================
	;=======================================================================
	
	;TODO insert GUI around here
	;TODO test the screen ration to decide how to do the cross multiplication
	

	;TODO: need to be speed up way more
	;TODO: need to add rejection of fa&lse detection on isTotalOn
	
	nativeDesktopRatio := sreenWidth / screenHeight
	
	;TODO: debugging purpose
	MsgBox nativeDesktopRatio: %nativeDesktopRatio%


	;initialization for uniq killstreak's sounds triggering per life
	2kill := 1
	3kill := 1
	4kill := 1
	5kill := 1
	6kill := 1
	7kill := 1

	killstreakNumber := 0


	;en permanence
	While(1){
		if(isPlayerAlive() =1){
			isTotalOn := isTotalOn()
			if(isTotalOn = 1){
				killstreakNumber++
				;debugging purpose
				;MsgBox %killstreakNumber%
				while(isTotalOn=1){
					isTotalOn := isTotalOn()
					;sleep, 50
				}
			}
			
			;MsgBox %killstreakNumber%
			
			
			
			;debugging purpose
			;if(killstreakNumber != 0){
			;	MsgBox killstreakNumber:%killstreakNumber%
			;}
			
			if(killstreakNumber=2 AND 2kill = 1){
				2_KillSound()
				2kill := 0
			}
			if(killstreakNumber=3 AND 3kill = 1){
				3_KillSound()
				3kill := 0
			}
			if(killstreakNumber=4 AND 4kill = 1){
				4_KillSound()
				4kill := 0
			}
			if(killstreakNumber=5 AND 5kill = 1){
				5_KillSound()
				5kill := 0
			}
			if(killstreakNumber=6 AND 6kill = 1){
				6_KillSound()
				6kill := 0
			}
			if(killstreakNumber=7 AND 7kill = 1){
				7_KillSound()
				7kill := 0
			}
			
		}
		else{
			; reset for uniq killstreak's sounds triggering per life
			2kill := 1
			3kill := 1
			4kill := 1
			5kill := 1
			6kill := 1
			7kill := 1
			
			killstreakNumber := 0
		}
		
		;delay in ms
		;Sleep, 50
		
	}


isTotalOn(){
	;DONE: seems to work
	
	;TopLeftX = 1130
	;TopLeftY = 770
	
	;ok
	static xIsAliveTotal
	static yIsAliveTotal
	xIsAliveTotal := 1117
	yIsAliveTotal := 770
	PixelGetColor, color, xIsAliveTotal, yIsAliveTotal, RGB
	
	
	;FoundPos := RegExMatch("xxxabc123xyz", "abc.*xyz")  ; Returns 4, which is the position where the match was found.
	FoundPos := RegExMatch(color, "0xF.F.F.")  ; Returns 4, which is the position where the match was found.
	;MsgBox %color% %FoundPos%
	
	if(FoundPos = "1"){
		;MsgBox lol
		return 1
	}
	
	return 0
}


;272727
isPlayerAlive()
{
	;global xIsAlive
	;global yIsAlive
	static onceAlive
	
	;for isAlive() function
	if(!onceAlive){
		onceAlive += 1
		static xIsAlive
		static yIsAlive
		global sreenWidth
		global screenHeight
		;MsgBox %sreenWidth%,%screenHeight%
		;xIsAlive := Round(sreenWidth / 2 ,0)+20+7
		;yIsAlive := screenHeight - 34 + 15
		;xIsAlive := 909
		xIsAlive := 960
		yIsAlive := 903
		;MsgBox IsAlive:%xIsAlive%,%yIsAlive%
	}
	
	;PixelGetColor, color, 983, 1046, RGB
	;res
	PixelGetColor, color, xIsAlive, yIsAlive, RGB
	;MsgBox IsAlive:%xIsAlive%,%yIsAlive%
	
	;debugging purpose
	;MsgBox %color%
	if(color = "0x272727"){
	;if(isHPZero() = 1){
		;SoundPlay, mp3/dead.mp3 ;ok res
		return 0
	}
	else{
		;SoundPlay, mp3/censor-beep-sound-effect-256kbit.mp3
		return 1
	}
}


;DONE=========================
;ok
2_KillSound(){
	SoundPlay, mp3/doublekill.mp3
	return
}
3_KillSound(){
	SoundPlay, mp3/multikill.mp3
	return
}
4_KillSound(){
	SoundPlay, mp3/megakill.mp3
	return
}
5_KillSound(){
	SoundPlay, mp3/monsterkill.mp3
	return
}
6_KillSound(){
	SoundPlay, mp3/ultrakill.mp3
	return
}
7_KillSound(){
	SoundPlay, mp3/holyshit.mp3
	return
}