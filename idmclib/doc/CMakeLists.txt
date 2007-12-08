ADD_CUSTOM_COMMAND(
    OUTPUT    ${idmclib_BINARY_DIR}/doc/manual.html
    DEPENDS   ${idmclib_SOURCE_DIR}/doc/manual.texinfo
    COMMAND   texi2html
    ARGS      ${idmclib_SOURCE_DIR}/doc/manual.texinfo
)

ADD_CUSTOM_COMMAND(
    OUTPUT    ${idmclib_BINARY_DIR}/doc/manual.pdf
    DEPENDS   ${idmclib_SOURCE_DIR}/doc/manual.texinfo
    COMMAND   texi2pdf
    ARGS      ${idmclib_SOURCE_DIR}/doc/manual.texinfo
)

IF(NOT TEXI2HTML)
ELSE(NOT TEXI2HTML)
ADD_CUSTOM_TARGET(html-doc ALL echo
  DEPENDS ${idmclib_BINARY_DIR}/doc/manual.html)
INSTALL(FILES ${idmclib_BINARY_DIR}/doc/manual.html DESTINATION lib/idmclib/doc)
ENDIF(NOT TEXI2HTML)

IF(NOT TEXI2PDF)
ELSE(NOT TEXI2PDF)
ADD_CUSTOM_TARGET(pdf-doc ALL echo
  DEPENDS ${idmclib_BINARY_DIR}/doc/manual.pdf)
INSTALL(FILES ${idmclib_BINARY_DIR}/doc/manual.pdf DESTINATION lib/idmclib/doc)
ENDIF(NOT TEXI2PDF)
