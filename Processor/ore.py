import random

exit = False

while exit == False:

    selection = raw_input("> ")

    if selection == "or":
        a = input("Input high: ")
        b = input("Input low: ")
    
        a = a << 8
     
        result = a|b
    
        print "OR result: %s" %(result) 
        
    
    elif selection == "deor":
        a = input("Input short: ")
    
        x = (a >> 8) &0xff
        y = a &0xff
    
        print "High: %s  Low: %s" %(x, y)
        

    elif selection == "help":
        print "Commands:"
        print "or: combine bytes into short"
        print "deor: split short into bytes"
        print "exit: close this program"
        
        
    elif selection == "joke":
        joke = random.randint(0, 4)
        if joke == 0:
            print "There are 10 types of people in the world: those who know binary, and those who don't." 
        elif joke == 1:
            print "How many programmers does it take to change a lightbulb? None!, that's a hardware issue."
        elif joke == 2: 
            print "Why can't people who use Github stay in a stable relationship? They have commitment issues!"
        elif joke == 3:
            print ("There are 10 types of people in the world: people who find this joke unfunny, and people who don't know about it")
        elif joke == 4:
            print "How did pirates collaborate before computers? Pier to pier networking!" #/u/Gornoo
            
     
    elif selection == "linux":
        print ("""I'd just like to interject for moment. What you're refering to as Linux, is in fact, GNU/Linux, or as I've recently taken to calling it, GNU plus Linux. Linux is not an operating system unto itself, but rather another free component of a fully functioning GNU system made useful by the GNU corelibs, shell utilities and vital system components comprising a full OS as defined by POSIX. Many computer users run a modified version of the GNU system every day, without realizing it. Through a peculiar turn of events, the version of GNU which is widely used today is often called Linux, and many of its users are not aware that it is basically the GNU system, developed by the GNU Project. There really is a Linux, and these people are using it, but it is just a part of the system they use. Linux is the kernel: the program in the system that allocates the machine's resources to the other programs that you run. The kernel is an essential part of an operating system, but useless by itself; it can only function in the context of a complete operating system. Linux is normally used in combination with the GNU operating system: the whole system is basically GNU with Linux added, or GNU/Linux. All the so-called Linux distributions are really distributions of GNU/Linux!""")
        
    elif selection == "exit":
        exit = True
        
    else:
        print "Invalid entry: type 'help' for instruction"    