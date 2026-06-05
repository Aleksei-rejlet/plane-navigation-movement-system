pragma SPARK_Mode(on);

package body PCU is

   procedure EnableAlarm is
   begin
      AlarmON := True;
      if (AlarmCnt < Integer'Last) -- catching prove mistake if overflow happens in a system
      then 
         AlarmCnt := AlarmCnt + 1;
      else AlarmCnt := 0; -- if alarmcnt more than integer then it sets to 0 again
      end if;
      
      
   end EnableAlarm;
   
   procedure DisableAlarm is
   begin
      AlarmON := False;
   end DisableAlarm;
   
   function isEnabledAlarm return Boolean is
   begin 
      return AlarmON;
   end isEnabledAlarm;
   
   procedure RecordModeButtonPressed is
   begin 
      ModeButtonPressed := True;
   end RecordModeButtonPressed;
   
   procedure RecordModeButtonNotPressed is
   begin
      ModeButtonPressed := False;
      
   end RecordModeButtonNotPressed;
   
   function isModeButtonPressed return Boolean is
   begin 
      return ModeButtonPressed;
   end isModeButtonPressed;
   
   procedure ToggleMode is
   begin -- basic toggling mode if its on then its off and othervise 
      if ModeON then
         ModeON := False;
      else
         ModeON := True;
      end if;
      ModeIndicatorON := ModeON;
   
           
   end ToggleMode;
   
   function isEnabledMode return Boolean is
   begin
      return ModeON;   
   end isEnabledMode;
   
   function isEnabledModeIndicator return Boolean is
   begin
      return ModeIndicatorON;
   end isEnabledModeIndicator;
   

end PCU;
