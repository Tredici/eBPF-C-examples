

BPF_SRC := main_bpf
CC = gcc
CLANG := clang
BPFTOOL := bpftool
LIBBPF := -lbpf
CFLAGS_LIBBPF := -I/usr/include/bpf
CFLAGS := -g -O2 -Wall -Werror $(CFLAGS_LIBBPF)
APP_NAME := main

.PHONY: all
all: $(APP_NAME)

.PHONY: clean
clean:
	rm -rf $(APP_NAME) *.o *.skel.h vmlinux.h

$(APP_NAME): $(APP_NAME).o
	$(CC) $(CFLAGS) $^ -o $@ $(LIBBPF) -lz -lelf

$(APP_NAME).o: $(APP_NAME).c $(BPF_SRC).skel.h $(APP_NAME).h
	$(CC) $(CFLAGS) -c $< -o $@

# we could live with a hand-built version of vmlinux.h, but it is more
# convenient to create it with bpftool
vmlinux.h:
	$(BPFTOOL) btf dump file /sys/kernel/btf/vmlinux format c > $@

$(BPF_SRC).skel.h: $(BPF_SRC).o
	$(BPFTOOL) gen skeleton $< > $@

$(BPF_SRC).o: $(BPF_SRC).c vmlinux.h
	$(CLANG) $(CFLAGS) -target bpf $(TARGET_ARCH) -c $< -o $@
