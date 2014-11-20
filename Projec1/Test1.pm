package Test1;

sub new {
        my $class = shift;
        my $self = {};
        bless $self, $class;
        return $self;
}

sub getValue {
        my $self = shift;
        $self{theValue};
}

sub setValue {
        my $self = shift;
        my $value = shift;
        $self{theValue} = $value;
} 