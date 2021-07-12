
CREATE FUNCTION [dbo].[SplitString] (@InputString nvarchar(2048),@Delimiter nchar(1)) 
RETURNS @Parts TABLE (Part nvarchar(2048),RowNumber INT) 

AS 
BEGIN    
	 if @InputString IS NULL return     
	 declare @iStart int,@iPos INT,@iRowNumber INT    
	 if substring(@InputString,1,1) = @Delimiter      
	 begin         
	 	SET @iStart = 2         
	 	insert into @Parts values(NULL,NULL)     
	 end     
	 else          
	 	set @iStart = 1 
	 	SET @iRowNumber=1
	 	while 1=1     
	 	begin         
	 		SET @iPos = charindex( @Delimiter, @InputString, @iStart )         
	 		if @iPos = 0                 
	 		set @iPos = len( @InputString )+1         
	 		if @iPos - @iStart > 0
	 		   BEGIN
	 				insert into @Parts values  ( substring( @InputString, @iStart, @iPos-@iStart ),@iRowNumber)
			 		SET @iRowNumber=@iRowNumber+1   	
	 		   END                                
	 		else                 
	 			insert into @Parts values(NULL,NULL)        
	 			SET @iStart = @iPos+1         
	 			if @iStart > len( @InputString )                  
	 			break     
	 	end     
	 	RETURN  
END 