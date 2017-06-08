#Compile the program

NC=nvcc
OBJS=mat.o

mat : $(OBJS)
	$(NC) -o $@ $^

mat.o : mat.cu
	$(NC) -c $^


.PHONY : clean
clean:
	rm $(OBJS)
