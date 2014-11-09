#!/usr/bin/perl
  use Thread; 
  use Scheduler;
  use Core;
  use BlockedState;
  use ReadyState;

  # Variables Globales
  $blockedState= BlockedState->new();
  $readyState = ReadyState->new();
  
  my $schdler=Scheduler->new();
  my $core=Core->new();
  

  my $countProgram	= 0;
  $interrup    		= 0; # (-1) :Core detenido . 0 ): no hay interrupcion . 1) : Termino secuencia del proceso actual . 2) : solicitudEntrada/Salida
  
  # Informacion de los procesos.
  my $ProccesInfo 	='';
  my $DataThread  	='';
  
##################Principal##########################
  
sub dummy {
	
   print "Agrego a listos Valores Dummys\n";
   $readyState->addReady(9999);
	

}
sub listenerScheduler{
	
	while (true)  {
		
		if ($interrup = 1) {
			
			$schdler->getNextProcess($readyState);
			
			$interrup = 0;
	    }		
	}
	
}

sub listenerCore{
	my $count=0;
	while (true)  {
			
		if ($interrup ==0) {
			$count ++;
			print "procesando Core...\n";
			if ($count==10){
			    print "hace I/O...\n";
				
				$interrup = 1; # entrada y salida
				
			}
			
		 }		
	}
	
}

sub mInitialization {
	
	print "Inicializando....\n";
	
	my $thrScheduler = threads->create(\&listenerScheduler);
    
    print "Scheduler....OK\n";
    
    my $thrCore = threads->create(\&listenerCore);
  
    print "Core.........OK\n";
    
    
      
 
    
}  
  
  dummy(); # se cargan valores dummys
  
 mInitialization();
 

 

 

print "Threa FIN\n";
  