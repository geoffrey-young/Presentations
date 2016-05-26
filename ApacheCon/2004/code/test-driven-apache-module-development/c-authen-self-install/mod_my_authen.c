#include "httpd.h"
#include "http_config.h"
#include "http_request.h"
#include "http_protocol.h"

module AP_MODULE_DECLARE_DATA my_authen_module;

static int authen_handler(request_rec *r) {

  const char *sent_pw;

  /* Get the client-supplied credentials */
  int response = ap_get_basic_auth_pw(r, &sent_pw);

  if (response != OK) {
      return response;
  }

  /* Perform some custom user/password validation */
  if (strcmp(r->user, sent_pw) == 0) {
    return OK;
  }

  /* Whoops, bad credentials */
  ap_note_basic_auth_failure(r);
  return HTTP_UNAUTHORIZED; 
}

static void register_hooks(apr_pool_t *p)
{
  ap_hook_check_user_id(authen_handler, NULL, NULL, APR_HOOK_FIRST);
}

module AP_MODULE_DECLARE_DATA my_authen_module =
{
  STANDARD20_MODULE_STUFF,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  register_hooks
};
