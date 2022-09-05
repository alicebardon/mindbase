class Time(internal var hours: Int, internal var minutes: Int, internal var seconds: Int) //$ define a class $$
//$ defining a function (block)
fun main(args: Array<String>) {
    val start = Time(12, 34, 55)
    val stop = Time(8, 12, 15)
    val diff: Time

    diff = difference(start, stop) // I do NOT want to see this comment on Mindbase

    print("TIME DIFFERENCE: ${start.hours}:${start.minutes}:${start.seconds} - ")
    print("${stop.hours}:${stop.minutes}:${stop.seconds} ")
    print("= ${diff.hours}:${diff.minutes}:${diff.seconds}")
}
//$$
fun difference(start: Time, stop: Time): Time {
    val diff = Time(0, 0, 0)
    //$ an if block
    if (stop.seconds > start.seconds) {
        --start.minutes
        start.seconds += 60
    }
    //$$

    diff.seconds = start.seconds - stop.seconds
    if (stop.minutes > start.minutes) {
        --start.hours //$ decrement operator $$
        start.minutes += 60
    }

    diff.minutes = start.minutes - stop.minutes //$ inline comment $$
    diff.hours = start.hours - stop.hours

    return diff
}
