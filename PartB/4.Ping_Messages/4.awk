BEGIN{
	drop=0;
}
{
	if($1=="d")
		drop++;

}
END{
	print("Packets dropped:",drop);
}
