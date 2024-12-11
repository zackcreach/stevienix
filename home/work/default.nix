{ pkgs, ... }: {
  home.packages = with pkgs; [
    go-task
    argocd
    kubectl
  ];
}
