<?php header("content-type: text/plain; charset=utf-8"); ?>
Headers received:
<?php
 
/**
 * @author Wouter Hobble
 * @copyright 2008
 */
 
foreach ($_SERVER as $k => $v)
{
	if( substr($k, 0, 5) == 'HTTP_')
	{
		print "\n". $k. "\t". $v;
	}
}
?>