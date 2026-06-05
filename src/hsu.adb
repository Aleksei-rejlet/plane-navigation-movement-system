pragma SPARK_Mode (On);
package body HSU is
   

   procedure TailplaneUP is 
   begin -- all functions is pretty straight forward 
      TailplaneState := UP;
   end TailplaneUP;
   
   procedure TailplaneDOWN is
   begin 
      TailplaneState := DOWN;
   end TailplaneDOWN;
   
   procedure TailplaneNORMAL is
   begin 
      TailplaneState := NORMAL;
   end TailplaneNORMAL;
   
   function isTailplaneUP return Boolean is
   begin
      return TailplaneState = UP;
   end isTailplaneUP;
   
   function isTailplaneDOWN return Boolean is
   begin
      return TailplaneState = DOWN;
   end isTailplaneDOWN;
   
   function isTailplaneNORMAL return Boolean is
   begin
      return TailplaneState = NORMAL;
   end isTailplaneNORMAL;

begin -- setting up initial value of tail to normal
   TailplaneState := NORMAL; 
   
end HSU;
