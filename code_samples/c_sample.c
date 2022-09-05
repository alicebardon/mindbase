#include <stdio.h> //$ include an external module (inline) $$
//$ This is a C struct (block)
struct student {
    char firstName[50];
    int roll;
    float marks;
} s[5];
//$$ End capture

int main(int argc, char *argv[]) { //$ This is how you declare the main function in C $$
    int i;
    printf("Enter information of students:\n");

    // storing information
    for (i = 0; i < 5; ++i) {
        s[i].roll = i + 1;
        printf("\nFor roll number%d,\n", s[i].roll); //$ printing to the terminal (stdout) $$
        printf("Enter first name: ");
        scanf("%s", s[i].firstName);
        printf("Enter marks: ");
        scanf("%f", &s[i].marks); //$ getting user input$$
    }
    printf("Displaying Information:\n\n"); // I do NOT want to see this comment on Mindbase

    // displaying information
    //$ for loop (block)
    for (i = 0; i < 5; ++i) {
        printf("\nRoll number: %d\n", i + 1);
        printf("First name: ");
        puts(s[i].firstName);
        printf("Marks: %.1f", s[i].marks);
        printf("\n");
    } //$$ end capture
    return 0;
}
