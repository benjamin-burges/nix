{ config, pkgs, ... }:

{
  home.username = "nix";
  home.homeDirectory = "/home/nix";
  home.stateVersion = "23.11";
 
  home.packages = with pkgs; [

  ];

  home.file = {

  };

  programs.vim = {
    enable = true;
    settings = { number = true; };
  };

  programs.neovim = { 
    enable = true;
    extraConfig = ''
      set number
    '';
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "afowler";
    };
  };

   # Git
   programs.git = {
     enable = true;
#     package = pkgs.gitFull;
#     config.credential.helper = "libsecret";
     userName = "benjamin-burges";
     userEmail = "b.burges@hotmail.com";
     extraConfig = {
       init.defaultBranch = "master";
#       credential.helper = "${
#         pkgs.git.override { withLibsecret = true; }
#       }/bin/git-credential-libsecret";
     };
   };


  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;
}
