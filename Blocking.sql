DBBC opentran ()
exec sp_who2 56
exec sp_lock 56
KILL 56


-- monitor runnings commands
Declare @database_name as varchar (max)
Set @database_name = 'Shop LV-608.db'
 
Select A.session_id, A.last_request_end_time as [last_batch], A. [Status]
, B. [command], A. [host_name]
, A. [program_name], A. [login_name]
from sys.dm_exec_sessions A
Left Join sys.dm_exec_requests B
On A. [session_id] = B. [session_id]
Where A. [database_id] = db_id (@database_name)
