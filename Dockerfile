FROM nixos/nix

COPY . /leetcode.nvim

RUN nix-channel --update
RUN nix build --extra-experimental-features 'nix-command flakes' /leetcode.nvim

RUN mkdir -p /root/.cache/nvim

ENTRYPOINT ["/result/bin/nvim"]
CMD ["leetcode.nvim"]
