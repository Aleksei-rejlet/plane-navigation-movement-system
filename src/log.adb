
-- Author:              A. Ireland
--
-- Address:             School Mathematical & Computer Sciences
--                      Heriot-Watt University
--                      Edinburgh, EH14 4AS
--
-- E-mail:              a.ireland@hw.ac.uk
--
-- Last modified:       30.6.2025
--
-- Filename:            log.adb
--
-- Description:         Provides logger that records state information on the
--                      component parts of the SPU at run-time.

pragma SPARK_Mode (Off);
with Text_IO, AoA, HSU, PCU, SPU;
use type AoA.Sensor_Type;
use type HSU.Position;
package body Log is

   package Sensor_INOUT is new Text_IO.Enumeration_IO(AoA.Sensor_Type);
   -- use Sensor_INOUT;
   package Integer_INOUT is new Text_IO.Integer_IO(Integer);
   -- use Integer_INOUT;

   Log_File: Text_IO.File_Type;
   
   procedure Update is

   begin
      -- Update log file
	  Text_IO.Put(Log_File, "| ");
      Integer_INOUT.Put(Log_File, AoA.Read_Sensor(1), 4);
      Integer_INOUT.Put(Log_File, AoA.Read_Sensor(2), 7);
      Integer_INOUT.Put(Log_File, AoA.Read_Sensor(3), 7);
      if AoA.Read_Sensor_Majority = 61 then
	 Text_IO.Put(Log_File, "  UNDEF  | ");
      else
	 Integer_INOUT.Put(Log_File, AoA.Read_Sensor_Majority, 7);
	 Text_IO.Put(Log_File, "  | ");
      end if;
      if PCU.isModeButtonPressed then
	     Text_IO.Put(Log_File, "PRESSED |");
      else
         Text_IO.Put(Log_File, "        |");
      end if;
	  if PCU.isEnabledModeIndicator then
	     Text_IO.Put(Log_File, "   ON      |");
      else
         Text_IO.Put(Log_File, "     OFF   |");
      end if;
	  if PCU.isEnabledAlarm then
         Text_IO.Put(Log_File, "   ON      |");
      else
         Text_IO.Put(Log_File, "     OFF   |");
      end if;
	  Integer_INOUT.Put(Log_File, PCU.AlarmCnt, 6);
	  Text_IO.Put(Log_File, "   |  ");
	  if HSU.TailplaneState = HSU.UP then
         Text_IO.Put(Log_File, " UP     ");
      elsif HSU.TailplaneState = HSU.DOWN then
         Text_IO.Put(Log_File, " DOWN   ");
      else 
	     Text_IO.Put(Log_File, " NORMAL ");
      end if;
	  Text_IO.Put(Log_File, "  | ");
      Text_IO.New_Line(Log_File);            
   end Update;      
      
   procedure Open_File is
   begin
      Text_IO.Create(Log_File, Text_IO.Out_File, "log.dat");
	  Text_IO.Put_Line(Log_File," ");
Text_IO.Put_Line(Log_File,
                                                                
               "|-------------------------------------------------------------------------------------|");
	  Text_IO.Put_Line(Log_File,                                             
               "|                                       SPS LOG                                       |");
	  Text_IO.Put_Line(Log_File,   
               "|-------------------------------------------------------------------------------------|");		   
	  Text_IO.Put_Line(Log_File,
               "|            AoA             |                   PCU                     |    HSU     |");
		Text_IO.Put_Line(Log_File,  
               "|----------------------------|-------------------------------------------|------------|");   
          Text_IO.Put_Line(Log_File,
               "|                            | STALL PREVENT MODE  |         ALARM       |            |");
          Text_IO.Put_Line(Log_File,
               "|                            |---------------------|---------------------|  TAILPLANE |");
	  Text_IO.Put_Line(Log_File,
               "| SEN-1  SEN-2  SEN-3  MAJOR | BUTTON  | INDICATOR |   STATE   |  COUNT  |  POSITION  |");
	  Text_IO.Put_Line(Log_File,  
               "|-------------------------------------------------------------------------------------|");
	 -- Text_IO.New_Line(Log_File);            
   end Open_File;

   procedure Close_File is
   begin
      Text_IO.Put_Line(Log_File,
		       "|-------------------------------------------------------------------------------------|");
      Text_IO.Put_Line(Log_File, "   Note: SPS = Stall Prevention System; AoA = Angle of Attack (sensor unit); ");
      Text_IO.Put_Line(Log_File, "         PCU = Pilot's Console Unit; HSU = Horizontal Stabilizer Unit. ");
      Text_IO.Put_Line(Log_File, " ");
      Text_IO.Close(Log_File);
   end Close_File;

end Log;
