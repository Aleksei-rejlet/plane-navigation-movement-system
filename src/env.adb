
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
-- Filename:            env.adb
--
-- Description:         Provides the drivers required for simulating the
--                      environment in which the SPS operates.

pragma SPARK_Mode (Off);
with Text_IO, AoA, HSU, PCU; 
use type AoA.Sensor_Type;

package body Env is

   Env_File: Text_IO.File_Type;

   package Integer_INOUT is new Text_IO.Integer_IO(Integer);

   procedure Update is
      
      Sensor_1: Integer;
      Sensor_2: Integer;
      Sensor_3: Integer;
      
      SPM_button_signal: Integer;

   begin
      -- Update env file
      -- Update AoA sensor readings
      Integer_INOUT.Get(Env_File, Sensor_1);
      Integer_INOUT.Get(Env_File, Sensor_2);
      Integer_INOUT.Get(Env_File, Sensor_3);
      AoA.Write_Sensors(Sensor_1, Sensor_2, Sensor_3);

      -- Update Stall Prevent Mode
      Integer_INOUT.Get(Env_File, SPM_button_signal);
      if SPM_button_signal = 1 then
         PCU.ToggleMode;
         PCU.RecordModeButtonPressed;
      else 
	 PCU.RecordModeButtonNotPressed;
      end if;
      Text_IO.Put('.');      
   end Update;

   function At_End return Boolean is
   begin
      return Text_IO.End_Of_File(Env_File);
   end At_End;

   procedure Open_File is
   begin
      Text_IO.Open(Env_File, Text_IO.In_File, "env.dat");
   end Open_File;

   procedure Close_File is
   begin
      Text_IO.Close(Env_File);
      Text_IO.Put_Line(" [ complete ]");
   end Close_File;

end Env;
