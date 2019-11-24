set ns [new Simulator]

set tf [open 4.tr w]
$ns trace-all $tf

set nf [open 4.nam w]
$ns namtrace-all $nf

$ns color 1 red
$ns color 2 blue

proc finish {} {
	global ns nf tf
	$ns flush-trace
	close $tf
	close $nf
	exec nam 4.nam &
	exec awk -f 4.awk 4.tr &
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]

$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n0 $n3 1Mb 10ms DropTail
$ns duplex-link $n0 $n4 1Mb 100ms DropTail
$ns duplex-link $n0 $n5 1Mb 100ms DropTail
$ns duplex-link $n0 $n6 1Mb 90ms DropTail

$ns queue-limit $n0 $n1 2
$ns queue-limit $n0 $n2 2
$ns queue-limit $n0 $n3 2
$ns queue-limit $n0 $n4 2
$ns queue-limit $n0 $n5 2
$ns queue-limit $n0 $n6 1

set p1 [new Agent/Ping]
$p1 set fid_ 1
$ns attach-agent $n1 $p1

set p2 [new Agent/Ping]
$p1 set fid_ 2
$ns attach-agent $n2 $p2

set p3 [new Agent/Ping]
$ns attach-agent $n3 $p3

set p4 [new Agent/Ping]
$p4 set fid_ 1
$ns attach-agent $n4 $p4

set p5 [new Agent/Ping]
$p5 set fid_ 2
$ns attach-agent $n5 $p5

set p6 [new Agent/Ping]
$ns attach-agent $n6 $p6

$ns connect $p1 $p4
$ns connect $p2 $p5
$ns connect $p3 $p6

Agent/Ping instproc recv { from rtt } {
 $self instvar node_
 puts "node [$node_ id] received ping from $from in time $rtt ms" 
 }

$ns at 0.1 "$p1 send"
$ns at 0.2 "$p4 send"
$ns at 0.3 "$p2 send"
$ns at 0.4 "$p5 send"
$ns at 0.5 "$p3 send"
$ns at 0.6 "$p6 send"
$ns at 0.7 "$p1 send"
$ns at 0.8 "$p4 send"
$ns at 0.9 "$p2 send"
$ns at 1.0 "$p5 send"
$ns at 1.1 "$p3 send"
$ns at 1.2 "$p6 send"
$ns at 1.5 "finish"
$ns run







