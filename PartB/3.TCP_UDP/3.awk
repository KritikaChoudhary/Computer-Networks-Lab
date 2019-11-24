BEGIN{
	tsent=treceive=usent=ureceive=0;
}
{
	if($1=="+")
	{
		if($5=="tcp")
		tsent++;
		else if($5=="cbr")
		usent++;
	}
	else if($1=="r")
	{
		if($5=="tcp")
		treceive++;
		else if($5=="cbr")
		ureceive++;
	}
}
END{
	print("TCP:\nSent:%d\tReceived:%d\nUDP:\nSent:%d\tReceived:%d\n",tsent,treceive,usent,ureceive);
}
