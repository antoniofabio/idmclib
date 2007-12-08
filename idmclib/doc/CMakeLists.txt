ADD_CUSTOM_TARGET(documentation ALL echo
  DEPENDS manual.html)

ADD_CUSTOM_COMMAND(
    OUTPUT    manual.html
    DEPENDS   manual.texinfo
    COMMAND   texi2html
    ARGS      manual.texinfo
)

INSTALL(FILES manual.html DESTINATION lib/doc)
