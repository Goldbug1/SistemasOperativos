package ReadyState;
use strict;
my $readyQueue = new Thread::Queue;    # Cola de listos

sub new {
	my $this = shift; #Cogemos la clase que somos o una referencia a la clase (si soy un objeto)
	my $class = ref($this) || $this;    #Averiguo la clase a la que pertenezco
	my $self = {}; #Inicializamos la tabla hash que contendrá las var. de instancia (NOMBRE Y EDAD)



	bless $self, $class;    #Perl nos tiene que dar el visto bueno (bendecirla)
	return ($self);         #Devolvemos la clase recién construida
}


sub addReady {
	print " Agrego a Listos " . $_[0] . " \n";
	$readyQueue->enqueue( $_[0] );
}

sub getNextReady {

	return $readyQueue->dequeue();

}

sub getAmuont {

	my $amount = $readyQueue->pending;
	print " tiene " . $amount . scalar " elementos  \n";

}