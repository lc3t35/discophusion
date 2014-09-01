docker run -t -i --rm --link=discomaster:discomaster --volumes-from discomaster --dns=[8.8.8.8] discophusion/discotest $*
