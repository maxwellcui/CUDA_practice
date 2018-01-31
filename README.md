# Nvidia CUDA C/C++ GPU parallel computation practice codes ||  - ( ゜- ゜)つロ 乾杯~ - 
- Author: Zhaoyuan "Maxwell" Cui
- Physics department, University of Arizona
- Don't remember since when I started learning CUDA...╮(￣▽￣)╭

## Introduction
This repository collects my personal codes of CUDA C/C++ practice. The book I am reading for learning CUDA is [Professional CUDA C Programming](https://www.amazon.com/Professional-CUDA-Programming-John-Cheng/dp/1118739329/ref=sr_1_1?ie=UTF8&qid=1517113438&sr=8-1&keywords=professional+cuda+c). This book is really a step-by-step guide so it's a life saver to me. Although the book was written when CUDA 6.0 was just realesed, the contents are still pretty good for a beginner or at least for an experimental particle physicist. Most of the codes and toptics in this respository are based on this book. I also have a copy of [CUDA by Example: An Introduction to General-Purpose GPU Programming](https://www.amazon.com/dp/0131387685/ref=sxbs_sxwds-stvp_1?pf_rd_m=ATVPDKIKX0DER&pf_rd_p=3341940462&pd_rd_wg=ahygr&pf_rd_r=KK2H0J9Q9VJ2DTAR4ETV&pf_rd_s=desktop-sx-bottom-slot&pf_rd_t=301&pd_rd_i=0131387685&pd_rd_w=y5mLi&pf_rd_i=cuda+c+example&pd_rd_r=27ab79a5-1f63-40e8-8651-36f6d77fc613&ie=UTF8&qid=1517115654&sr=1), which does not really help too much. In case you want a book to learn from the ground, I hope my experience can help.

While I have the feeling that GPU could be a strong tool
in experimental HEP, I don't have a clear idea on how to use it yet. Neverthelss, I just want to start learning it. Who knows
if one day I can use them in my research (true reason is that using GPU for physics research sounds cool).

## Device
The GPU I am using is `Nvidia GeForce GTX 750 Ti` with 2GB memory and 640 CUDA cores. More info can be found in [(•̀ᴗ•́)و ̑̑](http://www.geforce.com/hardware/desktop-gpus/geforce-gtx-750-ti). You can also get one from Amazon by paying about $120 [ヽ(･ω･｡)ﾉ]( https://www.amazon.com/s/ref=nb_sb_noss_1?url=search-alias%3Daps&field-keywords=gtx+750+ti).

I have also started using the service from Paperspace. I am using their GPU+ plan, which provides the access to a `Nvidia Quadro M4000` with 8GB memory and 1664 CUDA cores. In case you also want to use their services, here is a promotion code for $10. [Register here](https://www.paperspace.com/&R=A2CBVDK) or use `A2CBVDK` when you need it.

## Resources
> [CUDA Toolkit Download](https://developer.nvidia.com/cuda-downloads)
>
> [A useful page that helps install CUDA on Ubuntu 14.04 LTS](https://askubuntu.com/questions/451672/installing-and-testing-cuda-in-ubuntu-14-04)
>
> [CUDA C Best Practices Guide](http://docs.nvidia.com/cuda/cuda-c-best-practices-guide/index.html#axzz4hZHAX7Yc)
>
> [CUDA C Programming Guide](http://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html#axzz4hZHAX7Yc)
>
> [NVIDIA CUDA Compiler Driver NVCC](http://docs.nvidia.com/cuda/cuda-compiler-driver-nvcc/#axzz442waKnbZ)



**中文吐槽
真正的目的是学会如何100%利用战术核显卡来突破次元壁（误）(　´_ゝ｀)**
