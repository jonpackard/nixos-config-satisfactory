# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./satisfactory.nix
    ];

  # Enable cron service
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 * * * *      jonathan    ~/blueprint-backup.sh >> /tmp/blueprint-backup.log"
    ];
  };

  # Configure Satisfactory server
  services.satisfactory = {
    enable = true;
    openFirewall = true;
    maxPlayers = 4;
    autoPause = false;
  };

  # Tailscale VPN
  services.tailscale.enable = true;

  # Enable Flakes and the new command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "satisfactory01"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.ens192.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jonathan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "satisfactory" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDmyVo39UKS1lCS96iEeave2KhmcfyOAvnds70T4/S9uAtO0KBlLBnbZZdsEs7JVTekRt552sippBv/lVT9DH5F7sN34ERtRG21Pyv6WLlpL0hmMdW0oCMm5P7BG35x0CcbNWIqZSOlV1heociteFmiFcypETwTYaoq7LaLeaeI1vaHxkv+7OTh75CeNRFazSpm61NNv6OrW0TuclGKvbdU+94o2fVWSxIb2unt1s8nAhUvqPE0y7IXzc2PU3E5ls5Nt6/PfhmlA3VdCoXWOnlpxkaeYw/0fTE7fMfWtZhRs0MwziL64ptvz7Pm/FLuro3dwQdssbRe1/05Vu1fOp+V6S5RyPH/bIu3B1IYHyzLBeoAr5RHFkns8jecIAOPAnw9BYyvEgbKKGZRjQQ3FmAa3Id2YEQMiwv5zaRg6RD9pTJ/E499jNdlbKTY/rDfvDIya11lZw4QpTk59eZ6fzkSC5EVINedfLttszjcD76X4/Z1uxtOFY85KCm6LBM85wM= jonathan@Jonathans-MacBook-Pro.local"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMIXE2gIbzUH2AmIqCp0qi75zOqxrxhhXCNMi1ehcddyxxCdIv1dn6Kj+hDI0JZRaXRGBrJvc7J8ZXUGAzxzS/RUS4tFqF6LztHa11TJWl+G7QXBRHI7/0g8cnjiRzffTYX0dXuR9wUenEUDao5ZY/ss50xi4UlrtQPdMhKLHEISCoXStA/00lUk7FlLkrpEX9kcVoHN02m9Z03uIgoWoEYIrsMpM5aiEeJMknVQtI68PQ4tW6fVCVIdj9dL1dgO8+CXEBRm4OGOhDYYI5xcaDkAVqpH1UaDshGOC6CPxRDdxrnrQ3WoxqHQd67lC2ADtwOnGEnGkbD5TFM25ZHBmkVZiGVFxJwuUeLbIdmYowmPy/0NulSrHZQgTCVSXSotZbzyBELmq9s7DqhkQ0+uu0wMeE4uH1ekseQWSVKOohIT9V/TwrYX7qCMm1xxQnPSsv7eLHwO4GcvCdWRCvlHMiwlA452BGryHihxS3lVk0LM5ZYa0+jde3MAWN/sfNebE= jon@COMP05"
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  #   firefox
    git
    vim
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

