#Compile the program

NC=nvcc
OBJS=mat.o

mat.o : mat.cu
	$(NC) -c $^

mat : $(OBJS)
	$(NC) -o $@ $^
.PHONY : clean
clean:
	rm $(OBJS)
