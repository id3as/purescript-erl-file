-module(erl_fileLib@foreign).
-export([ensureDir_/1, fileSize/1, isDir/1, isFile/1, isRegular/1, mkTemp_/0]).

ensureDir_(Name) -> fun () ->
  filelib:ensure_dir(Name)
end.

fileSize(Name) -> fun () ->
  filelib:file_size(Name)
end.

isDir(Name) -> fun () ->
  filelib:is_dir(Name)
end.

isFile(Name) -> fun() ->
  filelib:is_file(Name)
end.

isRegular(Name) -> fun() ->
  filelib:is_regular(Name)
end.

mkTemp_() -> fun() ->
  case os:type() of
    {unix, _} ->
      erlang:list_to_binary(string:chomp(os:cmd("mktemp -t -d -q pserl.XXXXXXXX")));
    _ ->
      Temp = case os:getenv("TEMP") of
                false -> file:get_cwd();
                Val -> Val
             end,

      Rand = integer_to_list(base64:encode(crypto:strong_rand_bytes(16))),
      Path = filename:join(Temp, Rand),
      ok = filelib:ensure_dir(Path),
      erlang:list_to_binary(Path)
  end
end.
