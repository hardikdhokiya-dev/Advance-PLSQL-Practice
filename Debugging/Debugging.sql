/*
    dbms_debug package
    
    JDWP - Java Debug Wire Protocol
    
    we should not use Compile For Debug ooption otherwise --> performance, subprogram will be locked, data remain unchanged and we can not rollback it
    
    when we are debugging, we are actually running that code, so if there is any DML operation or commit in our code,we might have unintensional change in the data and we cannot roll it back.
    
    We can not the compile the entire package
    
    
*/