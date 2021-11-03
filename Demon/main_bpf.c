
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>
#include <bpf/bpf_core_read.h>


char LICENSE[] SEC("license") = "Dual BSD/GPL";

SEC("kprobe/not_a_function")
int BPF_KPROBE(START_HOOK)
{
	bpf_printk("kprobe/not_a_function");
	return 0;
}

SEC("kretprobe/not_a_function")
int BPF_KRETPROBE(END_HOOK)
{
	bpf_printk("kretprobe/not_a_function");
	return 0;
}
