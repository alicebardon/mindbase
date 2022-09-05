
<?php //$ Every PHP script starts like this $$
      // This is a sample script from Paul Conrad's Independent Study
      // This script will call the function named foo showing case insensitivity.
      function foo($my_string) {
              echo "$"."my_string = $my_string<br>"; // I do NOT want to see this comment on Mindbase
      }
      //$ PHP is not case sensitive
      foo("foo is foo");
      Foo("Foo is foo");
      FoO("FoO is foo");
      FOO("FOO is foo");
      //$$
      //$ ending a PHP script
 ?> //$$
