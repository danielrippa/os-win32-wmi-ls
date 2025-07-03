
  do ->

    { build-path } = dependency 'os.filesystem.Path'
    { map-object } = dependency 'unsafe.Object'

    namespace = -> build-path <[ root ]> ++ it

    wmi-namespaces = map-object do

      cim: <[ cimv2 ]>
      subscription: <[ subscription ]>
      wmi: <[ WMI ]>
      ldap: <[ directory LDAP ]>
      storage: <[ Microsoft Windows Storage ]>
      security-center: <[ SecurityCenter2 ]>

      void
      namespace

    {
      wmi-namespaces
    }