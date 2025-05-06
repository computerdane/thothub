{
  githubId = 209050082;
  sshKeys = {
    default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDIPLz8u9B6CEFgUyOtdFTJmkbNA3A9xoKA94UMirGrz";
  };
  minecraftAccounts = [
    {
      name = "ipv6_dotsh";
      uuid = "33879815-699c-4a15-b04c-2dce27a570be";
    }
  ];
  hashedPassword = "$y$j9T$oJqQwqnYd8ayfR23efUHe.$uPpIB0xVA3HsvUqe/u.J.sBaNjXQYJM.Lzng5925.hA";
  shell = "fish";
  wireguardPeers = [
    {
      Endpoint = "four.zak9.s99.sh:51820";
      PublicKey = "7Rbjel+ivF1LD76TfcYgYLyxhe89b3r7vlF3iG6dYE4=";
      AllowedIPs = [
        "172.31.100.0/24"
        "172.31.0.0/16"
        "fd00:100::/64"
        "fd00:100::/32"
        "2001:470:be1c::/52"
      ];
    }
  ];
}
