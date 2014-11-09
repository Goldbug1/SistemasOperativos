package Scheduler;

 use strict; #Nos ponemos serios
 


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
  #Métodos de acceso a los datos de la clase
  #

 
  ######################################################################
  #Métodos de la clase
  #

  sub getNextProcess{
       my $self=shift; #El primer parámetro de un metodo es la  clase
 
        my $DataElement = $_[0]->getNextReady();
        
         { 
            print "Saco elemento listo".$DataElement." \n";
        } 
  }

  ######################################################################
  #Destructor
  #

  sub DESTROY {
        my $self=shift; #El primer parámetro de un metodo es la  clase
     
  }

  #Fin
  1;