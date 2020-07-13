<?php
function django_password_verify(string $password, string $djangoHash): bool
{
    $password_enc = md5($password);

    if($password_enc == $djangoHash){
      return TRUE;
    }
    else{
      return FALSE;
    }
}

if (django_password_verify("123", "202cb962ac59075b964b07152d234b70") == TRUE){
  print "yoi";
}
else{
  print "tidak yoi";
}
?>
