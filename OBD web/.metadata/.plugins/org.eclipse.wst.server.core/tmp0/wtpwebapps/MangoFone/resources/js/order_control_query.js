
$(function() {
	
});

function leadingZeros(n, digits) {
	var zero = '';
	n = n.toString();
	
	if (n.length < digits) {
	  for (var i = 0; i < digits - n.length; i++)
	    zero += '0';
	}
	return zero + n;
}