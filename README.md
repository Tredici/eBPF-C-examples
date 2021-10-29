# Descrizione

Esempio di come usare BPF con kprobe.

Basta usare:

LIBBPF_API struct bpf_link *
bpf_program__attach_kprobe(struct bpf_program *prog, bool retprobe,
         const char *func_name);


## Esempi
Per fare delle prove si possono usare "kernel_clone" (in altre versioni del kernel si chiama "_do_fork") e "__x64_sys_execve" (dipende dall'architettura, cercare "*excve" in /proc/kallsys per trovare la variante presente).


