#!/usr/bin/perl
package Process;

use strict; #Nos ponemos serios


  ######################################################################
  #Constructor de la clase
  #

  sub new {
     my $this=shift; #Cogemos la clase que somos o una referencia a la clase (si soy un objeto)
     my $class = ref($this) || $this; #Averiguo la clase a la que pertenezco

     my $self={};
     
     $self ->{idProceso} = @_[1] ; 
     $self ->{timeArrive}   =@_[2];     
     $self ->{alias}   = @_[3] ; 
	 $self ->{type}   =@_[4]; 
	 $self ->{threadB}   =@_[5] ; 
	 
     
     bless $self, $class; #Perl nos tiene que dar el visto bueno (bendecirla)
     return ($self); #Devolvemos la clase recién construida
  }





  ######################################################################
  #Destructor
  #

  sub DESTROY {
        my $self=shift; #El primer parámetro de un metodo es la  clase
        delete ($self->{idProceso});  
 
  }

  #Fin
  1;