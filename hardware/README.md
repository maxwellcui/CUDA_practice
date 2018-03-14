# Note (draft)
This note focuses on the hardware ascpect of the GPU. The data about the Fermi and Kepler
architecture are summized from the book _Professional CUDA C Programming_. I will add the 
data for Maxwell and Pascal architecture by myself.

## Specifications
CUDA uses Single Instrution Multiple Thread (SIMT) architecture. The main difference between 
SIMT and SIMD is that SIMT allows threads to execute different instructions while SIMD 
executes in a unified synchronous group.

## Basic structure
### Fermi architecture
I know, this is a piece of antiques in 2018.
- GPU 
	- Streaming Multiprocessors (SM)
		- Thread (CUDA core)
			- Interger arithmetic logic unit (ALU)
			- Floating-point unit (FPU)
		- Shared memory/L1 Cache 
		- Register file
		- Load/Store unit (LD/ST)
		- Special function unit (SFU)
		- Warp scheduler and dispatch unit

**Fermi SM**

![Fermi SM](./fermi_sm.jpg)

**Fermi chip block**
![Fermi architecture](fermi_arch.png)

### Maxwell architecture
**Maxwell SM (SMM)**

![Maxwell_sm](./maxwell_sm.png)

- First generation: GM107 (My GTX 750Ti is based on GM107)
- Second generation: GM204 (ex. GTX 980)


| Contents           | GM107  | Gm204  |
|--------------------|--------|--------|
| CUDA cores         | 640    | 2048   |
| Compute capability | 5.0    | 5.2    |
| Shared memory/SM   | 64kB   | 96kB   |
| Register memory/SM | 256kB  | 256kB  |
| Active blocks/SM   | 32     | 32     |
| L2 Cache size      | 2048kB | 2048kB |
