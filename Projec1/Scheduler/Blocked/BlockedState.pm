package BlockedState;
use strict;              #Nos ponemos serios
use Thread::Queue;

my $blockedQueue = new Thread::Queue;    # Cola de bloqueados

######################################################################
#Constructor de la clase
#
sub new {
	my $this = shift
	  ; #Cogemos la clase que somos o una referencia a la clase (si soy un objeto)
	my $class = ref($this) || $this;    #Averiguo la clase a la que pertenezco

	my $self =
	  {}; #Inicializamos la tabla hash que contendrá las var. de instancia (NOMBRE Y EDAD)

	bless $self, $class;    #Perl nos tiene que dar el visto bueno (bendecirla)
	return ($self);         #Devolvemos la clase recién construida
}

######################################################################
#Métodos de acceso a los datos de la clase
#

#AgregarBloqueado

sub addBlocked {
	print " agrego a bloqueados " . $_[0] . " \n";
	$blockedQueue->enqueue( $_[0] );
}

sub getNextBlocked {

	return $blockedQueue->dequeue();

}

sub getAmuont {

	my $amount = $$blockedQueue->pending;
	print " tiene " . $amount . scalar " elementos  \n";

}

######################################################################
#Destructor
#

sub DESTROY {
	my $self = shift;    #El primer parámetro de un metodo es la  clase
	                     #delete ($self->{NOMBRE});
	                     #delete ($self->{EDAD});
}

#Fin
1;
