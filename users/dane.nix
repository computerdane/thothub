{
  githubId = 6487079;
  sshKeys = {
    laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJuxIieYmJTQPyVhQW6Hyt2rzpaQajJwyw/wMdNg5VVY";
    pcs = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILygTablfeGg4QW8UUk7fMJ7Otrnafkb5n4NEbfeMwzt";
    phone = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIeXM/afFCGyO69zC7+Dhw6jcY5y7vnaAIXkI5RTY/Pu";
    fatusb = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJLvONY5rvgbkp9ytyCuqFgU5u+h91Eol72URbGFhM0i";
  };
  minecraftAccounts = [
    {
      name = "Dane47";
      uuid = "6cfede5c-8117-4673-bd7d-0a17bbab69e2";
    }
  ];
  hashedPassword = "$y$j9T$duOHjV.NtZGClDklpYtZq0$/Ba3XQVvZrdZ6L7qAKxFO1Gks/ukzyvk6DygkEW5b/3";
  shell = "fish";
  wireguardPeers = [
    {
      Endpoint = "nf6.sh:51820";
      PublicKey = "XPhFzmjrJQ4sR3ZHHTVslHIcagKn67jzuE1HkPbkgXk=";
      AllowedIPs = [
        "10.105.0.0/16"
        "2600:1700:591:3b3e::/64"
      ];
    }
  ];
}
