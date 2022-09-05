// program to find Armstrong number between intervals

// take an input
const lowNumber = parseInt(prompt('Enter a positive low integer value: ')); //$ in JS const is used often (inline) $$
const highNumber = parseInt(prompt('Enter a positive high integer value: '));

console.log ('Armstrong Numbers:'); //$ printing to the console$$

// looping through lowNumber to highNumber
for (let i = lowNumber; i <= highNumber; i++) {

    // converting number to string
    //$ if you want to later reassign the variable, use 'let' (block)
    let numberOfDigits = i.toString().length;
    //$$

    let sum = 0;

    // create a temporary variable
    let temp = i; // I do NOT want to see this comment on Mindbase

    /* loop through a number to find if
    a number is an Armstrong number */
    while (temp > 0) {

        let remainder = temp % 10;
        sum += remainder ** numberOfDigits; //$ inline comment $$
        // removing last digit from the number
        temp = parseInt(temp / 10); // convert float into integer
    }
    //$ if block
    if (sum == i) {
        console.log(i);
    } //$$
}
