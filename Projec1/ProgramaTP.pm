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
  use constant INTERRUP_STOP=>-1;
  use constant INTERRUP_READY=>0;
  use constant INTERRUP_FINISH=>1;
  use constant INTERRUP_CHANNEL=>2;  
  
  # semaforos
  my $semInterrup = Thread::Semaphore->new();
  
  
  my $OI=Channel->new();
  my $schdler=Scheduler->new();
  my $core=Core->new();
  
  
  my $countProgram	= 0;
  my $interrup:shared= INTERRUP_STOP; # (-1) :Core detenido . 0 ): no hay interrupcion . 1) : Termino secuencia del proceso actual . 2) : solicitudEntrada/Salida
  
  # Informacion de los procesos.
  my @ProccesInfo;
  my @DataThread ;
  
##################Principal##########################
  
sub listenerScheduler{
	
	while (true)  {
		
		 $semInterrup->down();
		
		if ($interrup==INTERRUP_FINISH ) { # finalizo proceso
		
		  	
				$schdler->getNextProcess();
				print "schedulerNextProcess \n";
				$interrup = INTERRUP_READY;
			
	    }		
	   $semInterrup->up();
	
	}
	
	
}

sub listenerOI {
	my $count =0;
	
	while (true)  {
		
		$semInterrup->down();
			
		if ($interrup==INTERRUP_CHANNEL) {
			
				$count ++;
				#print "procesando EntradaSalida...\n";
				if ($count==3){
				    print "finaliza OI.\n";
					
					$interrup=INTERRUP_READY; # finalizo
					
				}
			
			
			
		 }
		 $semInterrup->up();		
	}
	
}

sub listenerCore{
	my $countCore=0;
	while (true)  {
	 # print "procesando Core ".$interrup."\n";
		
		$semInterrup->down();
		if ($interrup==INTERRUP_READY) {
			
				$countCore ++;
				#print "procesando Core...\n";
				if ($countCore==3){
				    print "finaliza Procesamento.\n";
					
					$interrup=INTERRUP_CHANNEL; # finalizo proceso
				    $countCore=0;	
				}
				
		}
		
	$semInterrup->up();
		  	
	}
	
}

sub loggerTp {
	
	print $_[0];
	
}

sub mInitialization {
	
	loggerTp("Inicializando...\n");
	
	mLoadProcess();
	
    $thrScheduler = threads->create(\&listenerScheduler);
    loggerTp("Scheduler....OK\n");
    
    $thrCore = threads->create(\&listenerCore);
    loggerTp("Core.........OK\n");
    
    $thrOI = threads->create(\&listenerOI);
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
	    
	    print $row[@_1]."\n";
	    #foreach my $element (@$row) {
	    #    print $element, "\n";
	    #}
	    
	}
	
}

  mInitialization(); # inicializa los hilos y la tabla ProcessInfo.
 
  mEnqueueProcess();
 

 


 #sleep(10);
 $semInterrup->down();
 $interrup=INTERRUP_READY;
  print "interrpu " .$interrup." ..OK\n";
$semInterrup->up();
 sleep(2);

print "Threa FIN\n";
  