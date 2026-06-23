#include <stdio.h>

#include <magic.h>

void get_mime(const char *filepath, char *out_buf, int *out_size) {
    magic_t magic;
    const char *mime_type;

    magic = magic_open(MAGIC_MIME_TYPE);
    magic_load(magic, NULL);
    mime_type = magic_file(magic, filepath);

    *out_size = snprintf(out_buf, 1024, "%s", mime_type);
    magic_close(magic);
}
