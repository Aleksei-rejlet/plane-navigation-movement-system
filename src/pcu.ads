--
-- Author:              A. Ireland
-- Updated:             30.6.2025
-- Description:         Implements the Pilot's Console Unit (PCU).

pragma SPARK_Mode (On); 
package  PCU

is
   pragma Elaborate_Body; 
   
   AlarmON:           Boolean; -- Alarm state
   AlarmCnt:          Integer; -- Counts number of enable Alarm events
   ModeButtonPressed: Boolean; -- State of Mode Button, i.e., True if pressed; otherwise False
   ModeON:            Boolean; -- State of stall prevention Mode
   ModeIndicatorON:   Boolean; -- State of stall prevention Mode Indicator (reflects Mode state)
   
   -- enables Alarm
   procedure EnableAlarm
   with
     Global  => (Output   => AlarmON,
                 In_Out   => AlarmCnt),
     Depends => (AlarmON  => null,
	         AlarmCnt => AlarmCnt);

   -- disables Alarm
   procedure DisableAlarm
   with
     Global  => (Output  => AlarmON),
     Depends => (AlarmON => null);
   
   -- returns True if Alarm is enabled; otherwise returns False
   function isEnabledAlarm return Boolean
   with
     Global => (Input => AlarmON),
     Depends => (isEnabledAlarm'Result => AlarmON);

   -- sets ModeButtonPressed to True
   -- required for system log, i.e., env.Update and log.Update
   procedure RecordModeButtonPressed
   with 
      Global  => (Output => ModeButtonPressed),
      Depends => (ModeButtonPressed => null);
	  
   -- sets ModeButtonPressed to False
   -- required for system log, i.e., env.Update and log.Update
   procedure RecordModeButtonNotPressed
   with 
      Global  => (Output => ModeButtonPressed),
      Depends => (ModeButtonPressed => null);
	  
   -- returns True if ModeButtonPressed is True; otherwise returns False
   -- required for system log, i.e., env.Update and log.Update
   function isModeButtonPressed return Boolean 
   with
      Global  => (Input => ModeButtonPressed),
      Depends => (isModeButtonPressed'Result => ModeButtonPressed);
	  
   -- Toggles stall prevention Mode and Mode Indicator states
   procedure ToggleMode
   with
     Global => (In_Out => ModeON,
	        Output => ModeIndicatorON),
     Depends => (ModeON => ModeON,
	         ModeIndicatorON => ModeON);

   -- returns True if stall prevention Mode state is True; otherwise returns False
   function isEnabledMode return Boolean
   with
     Global => (Input => ModeON),
     Depends => (isEnabledMode'Result => ModeON);

   -- returns True if stall prevention Mode Indicator state is True; otherwise returns False
   function isEnabledModeIndicator return Boolean
   with
     Global => (Input => ModeIndicatorON),
     Depends => (isEnabledModeIndicator'Result => ModeIndicatorON);
	 
end PCU;


