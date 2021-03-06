# Copyright 2001-2004 The Apache Software Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
package Apache::TestSmokePerl;

use strict;
use warnings FATAL => 'all';

use Apache::TestSmoke ();
use ModPerl::Config ();

# a subclass of Apache::TestSmoke that configures mod_perlish things
use vars qw(@ISA);
@ISA = qw(Apache::TestSmoke);

sub build_config_as_string {
    ModPerl::Config::as_string();
}

1;
__END__

