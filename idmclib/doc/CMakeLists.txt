ADD_CUSTOM_TARGET(documentation ALL echo
  DEPENDS ${idmclib_BINARY_DIR}/doc/manual.html)

ADD_CUSTOM_COMMAND(
    OUTPUT    ${idmclib_BINARY_DIR}/doc/manual.html
    DEPENDS   ${idmclib_SOURCE_DIR}/doc/manual.texinfo
    COMMAND   texi2html
    ARGS      ${idmclib_SOURCE_DIR}/doc/manual.texinfo
)

INSTALL(FILES manual.html DESTINATION lib/doc)
