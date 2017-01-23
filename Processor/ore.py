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
		
    
    elif selection == "btod":
		a = raw_input("Input binary integer: ")
		print "Decimal form: %s" %(int(a, 2))
		
		
    elif selection == "dtob":
		a = input("Input decimal integer: ")
		print "Binary form: %s" %(bin(a)[2:])
		
	
    elif selection == "diceroll":
		a = random.randint(1, 6)
		print "Dice rolled %s" %(a)
		
    elif selection == "rps":
		a = raw_input("Rock Paper or Scissors? r/p/s: ")
		b = random.randint(1, 3)
		if b == 1:
			c = "rock"
		elif b == 2:
			c = "paper"
		elif b == 3:
			c = "scissors"
		
		if a == "r":
			if c =="rock":
				state = "tie"
				print "AI chose rock, you %s" %(state)
			elif c == "paper":
				state = "lose"
				print "AI chose paper, you %s" %(state)
			elif c == "scissors":
				state = "win"
				print "AI chose scissors, you %s" %(state)
		elif a == "p":
			if c =="rock":
				state = "win"
				print "AI chose rock, you %s" %(state)
			elif c == "paper":
				state = "tie"
				print "AI chose paper, you %s" %(state)
			elif c == "scissors":
				state = "lose"
				print "AI chose scissors, you %s" %(state)
		elif a == "s":
			if c =="rock":
				state = "lose"
				print "AI chose rock, you %s" %(state)
			elif c == "paper":
				state = "win"
				print "AI chose paper, you %s" %(state)
			elif c == "scissors":
				state = "tie"
				print "AI chose scissors, you %s" %(state)
		elif a == "dynamite" or a == "d":
			print "Well aren't you clever?"
		else:
			print "AI chose %s but you didn't choose anything, so it won by forfeit"  %(c)
	
    elif selection == "help":
		print "Commands:"
		print "or: combine bytes into short"
		print "deor: split short into bytes"
		print "btod: convert binary to decimal"
		print "dtob: convert decimal to binary"
		print "diceroll: roll a die"
		print "rps: play rock paper scissors"
		print "exit: close this program"
		
    elif selection == "nanoseconds":
        print (
"""\nLatency Comparison Numbers
Light travels 29.9792458 centimeters per ns, or 98.333% of a foot
Light travels 299.79 meters per us, or 3/4 of the distance around an olympic track 
Light travels 186.28 miles per ms, or 86 miles above the distance from earth to the Karman line
--------------------------
L1 cache reference                           0.5 ns
Branch mispredict                            5   ns
L2 cache reference                           7   ns                      14x L1 cache
Mutex lock/unlock                           25   ns
Main memory reference                      100   ns                      20x L2 cache, 200x L1 cache
Compress 1K bytes with Zippy             3,000   ns        3 us
Send 1K bytes over 1 Gbps network       10,000   ns       10 us
Read 4K randomly from SSD*             150,000   ns      150 us          ~1GB/sec SSD
Read 1 MB sequentially from memory     250,000   ns      250 us
Round trip within same datacenter      500,000   ns      500 us
Read 1 MB sequentially from SSD*     1,000,000   ns    1,000 us    1 ms  ~1GB/sec SSD, 4X memory
Disk seek                           10,000,000   ns   10,000 us   10 ms  20x datacenter roundtrip
Read 1 MB sequentially from disk    20,000,000   ns   20,000 us   20 ms  80x memory, 20X SSD
Send packet CA->Netherlands->CA    150,000,000   ns  150,000 us  150 ms\n""")
        
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
		print "I'd just like to interject for a moment..." 

        
    elif selection == "exit":
        exit = True
        
    else:
        print "Invalid entry: type 'help' for instruction"    