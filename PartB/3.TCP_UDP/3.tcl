set ns [new Simulator]

set tf [open 3.tr w]
$ns trace-all $tf

set nf [open 3.nam w]
$ns namtrace-all $nf

proc finish {} {
	global ns nf tf
	$ns flush-trace
	close $tf
	close $nf
	exec awk -f 3.awk 3.tr &
	exec nam 3.nam &
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns color 1 red

$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n3 $n2 0.5Mb 9ms DropTail

$ns queue-limit $n2 $n3 10

set tcp [new Agent/TCP]
$tcp set fid_ 1
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp 
set udp [new Agent/UDP]
$ns attach-agent $n1 $udp
set null [new Agent/Null]
$ns attach-agent $n3 $null
set cbr [new Application/Traffic/CBR]
$cbr set packetsize_ 512
$cbr set interval_ 0.05
$cbr attach-agent $udp

$ns connect $tcp $sink
$ns connect $udp $null

$ns at 0.0 "$ftp start"
$ns at 0.5 "$cbr start"
$ns at 5.0 "$ftp stop"
$ns at 5.5 "$cbr stop"
$ns at 7 "finish"

$ns run



