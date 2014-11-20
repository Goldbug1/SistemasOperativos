package Scheduler;

  use strict;
 
  use BlockedState;
  use ReadyState;

  my $blockedState= BlockedState->new();
  my $readyState = ReadyState->new();
  
 
   
  
  
  ######################################################################
  #Constructor de la clase
  #

  sub new {
     my $this=shift; #Cogemos la clase que somos o una referencia a la clase (si soy un objeto)
     my $class = ref($this) || $this; #Averiguo la clase a la que pertenezco
	 my $self={}; #Inicializamos la tabla hash que contendrá las var. de instancia (NOMBRE Y EDAD)
     
       bless $self, $class; #Perl nos tiene que dar el visto bueno (bendecirla)
     return ($self); #Devolvemos la clase recién construida
  }
  
  ######################################################################
  #Métodos de clase
  #######################################################################

 
  # devuelve en un proceso deacuerdo a tipo de SCHEDULER : RR , FIFO ..
  # Parametros : -
  # Retorna : id de proceso.
  
  sub getNextProcess{
  	# Se debe agregar la logica de scheduler para obtener el proximo proceso .
  	# ahora esta devolviendo el siguente listo. 
        
       my $self=shift; #El primer parámetro de un metodo es la  clase
 
        my $DataElement = $readyState->getNextReady(); 
         { 
            print "Saco elemento listo".$DataElement." \n";
        } 
        
        return $DataElement;
  }
  
 # agrega un proceso a listos , 
 # Parametros : id de proceso.
 # Retorna : OK o ERROR
 
  sub addProcess {
       my $self=shift;
       my $idProcess=$_[0];
       # my ($idProcess,$rvector1,$rvector2) = @_;
   
        $readyState->addReady($idProcess);
        
         print "agrego  elemento listo \n";
        
        return 'OK';
  }
  
  
  
  sub dummy {
	
   addReady(9999);
   addReady(9999);


}
  

  ######################################################################
  #Destructor
  #

  sub DESTROY {
        my $self=shift; #El primer parámetro de un metodo es la  clase
     
  }

  #Fin
  1;