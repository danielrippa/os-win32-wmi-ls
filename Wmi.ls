
  do ->

    { build-path } = dependency 'os.filesystem.Path'
    { type } = dependency 'reflection.Type'
    { get-com-object } = dependency 'os.win32.com.ComObject'

    cimv2 = build-path <[ root cimv2 ]>

    wmi-namespace = (resource = '', path = cimv2, host = '.') ->

      type '< String >' resource ; type '< String >' path ; type '< String >' host

      scheme = 'winmgmts'

      namespace = build-path [ "#scheme:", host ] ++ [ path ]

      if resource isnt ''

        namespace = build-path [ namespace, resource ]

      namespace

    wmi-service = (namespace = wmi-namespace!) -> type '< String >' namespace ; get-com-object namespace

    {
      wmi-namespace, wmi-service
    }

