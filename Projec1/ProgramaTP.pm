#!/usr/bin/perl
  use Thread; 
  use threads::shared;
  use Thread::Semaphore;
 
  use Scheduler;
  use Core;
  use Channel;
  use Process;
  
  # constantes , separa en otra clase
  use constant DEBUG => 0;
  
  use constant TIME_FPS=>1; # sleep entre cada procesamiento 
  
  use constant INTERRUP_EXIT=>-2;
  use constant INTERRUP_STOP=>-1;
  use constant INTERRUP_READY=>0;
  use constant INTERRUP_FINISH=>1;
  use constant INTERRUP_CHANNEL=>2;  
  
  # semaforos
  my $semInterrup = Thread::Semaphore->new();
  
  
  my $OI=Channel->new();
  my $schdler=Scheduler->new();
  my $core=Core->new();
  
  
  my $countProgram:shared	= 0;
  my $interrup:shared       = INTERRUP_STOP; # (-1) :Core detenido . 0 ): no hay interrupcion . 1) : Termino secuencia del proceso actual . 2) : solicitudEntrada/Salida
  
  # Informacion de los procesos.
  my @ProccesInfo;
  my @DataThread ;
  
##################Principal##########################
  
sub listenerScheduler{
	
	while (true)  {
		
		 $semInterrup->down();
		
		if ($interrup==INTERRUP_FINISH ) { # finalizo proceso
		
		  	    print "Scheduler : solicita nuevo proceso  \n";
				 $interrup = INTERRUP_STOP;
				#$schdler->getNextProcess();
				print "schedulerNextProcess \n";
				#$interrup = INTERRUP_READY;
			    
	    }	
		 	
	   $semInterrup->up();
	   
	   sleep(TIME_FPS);
	}
	
	
}

sub listenerOI {
	my $countOI =0;
	
	while (true)  {
		
		$semInterrup->down();
			
		if ($interrup==INTERRUP_CHANNEL) {
			  print "OI -procesa.\n";
				$countOI ++;
				#print "procesando EntradaSalida...\n";
				if ($countOI==3){
				    print "OI - finaliza procesamiento\n";
					
					$interrup=INTERRUP_READY; # finalizo , y pongo en listo
					$countOI=0;
				}
			
		 }
		 $semInterrup->up();	
		 	
	   # Incrementar el contPrograma.
	   $countProgram++;	 
	   sleep(TIME_FPS);
	}
	
}

sub listenerCore{
	my $countCore=0;
	
	while (true)  {
	 # print "procesando Core ".$interrup."\n";
		
		$semInterrup->down();
		if ($interrup==INTERRUP_READY) {
			print "procesa Core .\n";
				$countCore ++;
				#print "procesando Core...\n";
				if ($countCore==4){
				    print "Core-entradaSalida.\n";
					
					$interrup=INTERRUP_CHANNEL; # el proceso solicita entradaSalida
				    	
				}
				if ($countCore==6){
				    print "Core-nuevoProceso.\n";
					
					$interrup=INTERRUP_FINISH; # finalizo el proceso
				    $countCore=0;	
				}
		}
		
	   $semInterrup->up();
	
	   # Core es el encargado de incrementar el contPrograma.
	   $countProgram++;	  	
	   sleep(TIME_FPS);
	}
	
}

sub loggerTp {
	
	print $_[0];
	
}

sub mInitialization {
	
	loggerTp("Inicializando...\n");
	
	mLoadProcess();
	
    $thrScheduler = threads->create(\&listenerScheduler);
    $thrScheduler->detach();
    
    loggerTp("Scheduler....OK\n");
    
    $thrCore = threads->create(\&listenerCore);
    $thrCore->detach();
    loggerTp("Core.........OK\n");
    
    
    $thrOI = threads->create(\&listenerOI);
    $thrOI->detach();
    loggerTp("OI.........OK\n");

}  
  
sub mLoadProcess {
	
	loggerTp("loadProcess.... \n");
	               
	               # idProceso | timeArrive | alias | Type | threadB | idThread 
	 
	 $ProccesInfo = (Process->new(1, 0, "Proceso 1" ,"KLU" , undef),
	                 Process->new(2, 2, "Proceso 2" ,"KLU" , undef) );
	 
	               # idThread | TypeReq | long | state
	               	 
     @DataThread = ([1 , "CPU" , 4 , "AVAIBLE"], 
     				[1 , "OI1" , 2 , "AVAIBLE"],
     				[1 , "CPU" , 4 , "AVAIBLE"], 
     				[2 , "OI1" , 2 , "AVAIBLE"],
     				[2 , "CPU" , 4 , "AVAIBLE"], 
     				[2 , "OI1" , 2 , "AVAIBLE"]);
	
}

sub mEnqueueProcess{
	
	foreach my $row (@ProccesInfo) {
	    
	    print $row."\n";
	    #foreach my $element (@$row) {
	    #    print $element, "\n";
	    #}
	    
	}
	
}

  mInitialization(); # inicializa los hilos y la tabla ProcessInfo.
 
  mEnqueueProcess();
 

 
 print "********** Procesamiento **********\n";

 #sleep(10);
 $semInterrup->down();
 
     $interrup=INTERRUP_READY;
     print "interrpu " .$interrup." ..OK\n";
 
 $semInterrup->up();
 
 
 sleep(20);

 #my @running = threads->list(threads::running);
 # foreach (@running) {
 # 	print "kill thread \n";
 #   $_->kill('KILL')->detach;
 # }
print "contador de programa " .$countProgram."\n";
   
print "Threa FIN\n";
  
