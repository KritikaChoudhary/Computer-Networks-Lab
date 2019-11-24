BEGIN{
	fpkt=cpkt=fsize=csize=0;
}
{
	if($1=="r")
	{
		if($5=="tcp")
		{
			fpkt++;
			fsize=$6;
		}
		else if($5=="cbr")
		{
			cpkt++;
			csize=$6;
		}
	}
}
END{
	print("Throughput CBR:",fpkt*fsize/5);
	print("Throughput FTP:",cpkt*csize/5);

}

