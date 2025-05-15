{
    inputs = { } ;
    outputs = { self } :
        {
            lib.generator =
                {
                    host ,
                    host-name ,
                    identity-file ,
                    known-hosts ,
                    nixpkgs ,
                    port ,
                    system ,
                    user
                } :
                    let
                        pkgs = import nixpkgs { inherit system ; } ;
                        in
                            pkgs.writeShellApplication
                                {
                                    name = "ssh-configure" ;
                                    runtimeInputs = [ pkgs.coreutils pkgs.openssh ] ;
                                    text =
                                        ''
                                            ( cat > /mount/target <<EOF
                                            Host ${ host }
                                            HostName ${ host-name }
                                            IdentityFile ${ identity-file }
                                            Port ${ port }
                                            User ${ user }
                                            UserKnownHostsFile ${ known-hosts }
                                            EOF
                                            chmod 0400 /mount/target
                                        '' ;
                                } ;
        } ;
}