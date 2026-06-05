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
-- Filename:            test_spu.adb
--
-- Description:         Test harness for the SPS. Note that test data and results
--                      are managed via the Env and Log packages respectively.

pragma SPARK_Mode (Off);
with Env, Log, SPU, AoA, HSU, PCU;
use type AoA.Sensor_Type;
procedure Test_SPS is
begin
   Env.Open_File;
   Log.Open_File;
   loop
      exit when Env.At_End;
      Env.Update;
      Log.Update;
      SPU.Controller;
      Log.Update;
   end loop;
   Env.Close_File;
   Log.Close_File;
end Test_SPS;
