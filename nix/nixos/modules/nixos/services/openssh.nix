{
  services.openssh = {
    enable = true;
    allowSFTP = true;
    settings = {
      AllowAgentForwarding = false;
      AllowStreamLocalForwarding = false;
      AllowTcpForwarding = false;
      AuthenticationMethods = "publickey";
      HostKeyAlgorithms = "+ssh-rsa";
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
}
