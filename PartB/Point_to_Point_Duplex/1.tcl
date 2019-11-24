set ns [new Simulator]

set tf [open 1.tr w]
$ns trace-all $tf

set nf [open 1.nam w]
$ns namtrace-all $nf

proc finish {} {
	global ns nf tf
	$ns flush-trace
	close  $tf
	close $nf
	exec awk -f 1.awk 1.tr &
	exec nam 1.nam &
	exit 0
}

set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n1 $n2 10Mb 10ms DropTail 
$ns duplex-link $n2 $n3 0.4Mb 20ms DropTail

$ns queue-limit $n1 $n2 10
$ns queue-limit $n2 $n3 10

set udp [new Agent/UDP]
$ns attach-agent $n1 $udp

set null [new Agent/Null]
$ns attach-agent $n3 $null

set cbr [new Application/Traffic/CBR]
$cbr set packetsize_ 512
$cbr set interval_ 0

$ns connect $udp $null

$cbr attach-agent $udp

$ns at 0 "$cbr start"
$ns at 2.5 "$cbr stop"
$ns at 2.5 "finish"

$ns run


