set ns [new Simulator]

set tf [open 2.tr w]
$ns trace-all $tf

set nf [open 2.nam w]
$ns namtrace-all $nf

proc finish {} {
	global ns nf tf
	$ns flush-trace
	close  $tf
	close $nf
	exec awk -f 2.awk 2.tr &
	exec nam 2.nam &
	exit 0
}

set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]

$ns duplex-link $n1 $n2 2Mb 10ms DropTail 
$ns duplex-link $n3 $n2 2Mb 10ms DropTail
$ns duplex-link $n2 $n4 900kb 10ms DropTail

$ns queue-limit $n2 $n4 10

set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1

set sink1 [new Agent/TCPSink]
$ns attach-agent $n4 $sink1
$ns connect $tcp1 $sink1

set tcp2 [new Agent/TCP]
$ns attach-agent $n3 $tcp2

set sink2 [new Agent/TCPSink]
$ns attach-agent $n4 $sink2
$ns connect $tcp2 $sink2

set telnet [new Application/Telnet]
$telnet set type_ TELNET
$telnet set interval_ 0
$telnet attach-agent $tcp1

set ftp [new Application/FTP]
$ftp set type_ FTP
$ftp attach-agent $tcp2

$ns at 0.5 "$telnet start"
$ns at 2 "$ftp start"
$ns at 5 "$telnet stop"
$ns at 6 "$ftp stop"
$ns at 7 "finish"

$ns gen-map
$ns run

