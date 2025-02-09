{ config, lib, pkgs, ... }:

{
  networking.nameservers = [ "208.67.222.222" "208.67.220.220" ];

  networking.interfaces.enp4s0.mtu = 9000;

  networking.firewall.enable = false;

  networking.wireless.enable = false;

  boot.kernel.sysctl = {
    "net.core.rmem_max" = 25165824;
    "net.core.wmem_max" = 25165824;
    "net.ipv4.tcp_rmem" = "4096 16777216 33554432";
    "net.ipv4.tcp_wmem" = "4096 16777216 33554432";
    "net.ipv4.tcp_window_scaling" = 1;
    "net.ipv4.tcp_sack" = 1;
    "net.ipv4.tcp_timestamps" = 1;
    "net.ipv4.tcp_fin_timeout" = 5;
    "net.ipv4.tcp_keepalive_time" = 600;
    "net.core.netdev_max_backlog" = 10000;
    "net.ipv4.tcp_max_syn_backlog" = 4096;
    "net.ipv4.tcp_syn_retries" = 2;
    "net.ipv4.tcp_synack_retries" = 2;
    "net.ipv4.tcp_mtu_probing" = 1;
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_low_latency" = 1;
    "net.ipv4.tcp_no_metrics_save" = 1;
    "net.ipv4.tcp_retries1" = 2;
    "net.ipv4.tcp_retries2" = 3;
    "net.ipv4.tcp_keepalive_intvl" = 60;
    "net.ipv4.tcp_keepalive_probes" = 5;
    "net.ipv4.tcp_abort_on_overflow" = 1;
    "net.ipv4.tcp_moderate_rcvbuf" = 1;
    "net.ipv4.tcp_rfc1337" = 1;
    "net.ipv4.tcp_tw_reuse" = 1;
    "net.ipv4.tcp_max_tw_buckets" = 2000000;
    "net.ipv4.tcp_mem" = "125000000 250000000 262144000";
    "net.ipv4.tcp_slow_start_after_idle" = 0;
    "net.ipv4.tcp_ecn" = 1;
    "net.ipv4.tcp_fack" = 1;
    "net.ipv4.tcp_dsack" = 1;
    "net.ipv4.tcp_retrans_collapse" = 1;
    "net.ipv4.tcp_early_retrans" = 1;
    "net.ipv6.conf.all.disable_ipv6" = 1;
    "net.ipv6.conf.default.disable_ipv6" = 1;
  };
}
