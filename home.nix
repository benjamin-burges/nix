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
     userName = "benjamin-burges";
     userEmail = "b.burges@hotmail.com";
     extraConfig = {
       init.defaultBranch = "master";
     };
   };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;
}
