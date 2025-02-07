Return-Path: <linux-pwm+bounces-4812-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 621B7A2C1EE
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 12:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F2E18845F5
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 11:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAF91DF733;
	Fri,  7 Feb 2025 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nK0JlBry"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000F11DE2C5;
	Fri,  7 Feb 2025 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929205; cv=none; b=RD7yAN4HOnWZMfEBLTT3PV67ZxtR4LN0LxkceONC5O4NiENStdrK/0zfVZr3j/MuOzU7D+VD1SE1K+RNIL74dvw3vITLvDqyjIjlaS5lZ6KwT04mt1TY69o1c9s2Jp2GFQreGQlhQlQi3aWgFYvFRh86rWsP9QYX/uqGhRUWW8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929205; c=relaxed/simple;
	bh=IuMV62I00q/ewVta9Tr3R2fDYIVWuaOUCNt/jxDCXG0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GED9AcS5IwoYKd/XjPXPxw0ujxMwLprc3+wFDptT37+08+aKpW+9okPQtPh4dZZD01xPV+XLap0v0xghBnvIK/qRO0K7JzzSIhG9cmAiWswDMd0iMQ+lU8OBF5vpsAcz8XJL+41jP6wrsbQQBAZbMQ3zGNmc5AfBx9mzrD4OKRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nK0JlBry; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738929204; x=1770465204;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IuMV62I00q/ewVta9Tr3R2fDYIVWuaOUCNt/jxDCXG0=;
  b=nK0JlBryukN+BmGkkbmJNgdzBbYJOTkze2eWFV8QCl0a/uJqyG0/ji3e
   ggw83YUzPa1iKDOFuaxVk3531Pp5+37QQw94NBWh5ZriYZMc3ZTn1Hy1g
   bonupKYkCT3HUwnohyA1gnsuyYNKgPCNqRiKIeMmWJD/VsY3np9yJ2SqW
   pu9uazgW9dkcpL8R3Zl4tsD8NY4gIs4s2I9yygnXJfEcMhmrGm2k+1FtI
   9AdfKOQGALRrVXY9TPHrvI2uSQ5uyR1sFCA9tN+bBKRk5vBoiDAMRg4We
   L9z4VF6dWQ7+u0HfdSWoI9iDi6gyuPh4wTtYmt1l3pS/Ah8ITE/bpHK47
   Q==;
X-CSE-ConnectionGUID: r55/OU8XRNeV5b0ldCaAeg==
X-CSE-MsgGUID: GDBL6ihEQCW6h+c05lwIHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39260638"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="39260638"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 03:53:23 -0800
X-CSE-ConnectionGUID: ola92a+JTlmI4zNzwLshaw==
X-CSE-MsgGUID: xTo9sHQPTbiL8aqOzyp6Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148722349"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 03:53:20 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 7 Feb 2025 13:53:16 +0200 (EET)
To: Werner Sembach <wse@tuxedocomputers.com>
cc: Hans de Goede <hdegoede@redhat.com>, ukleinek@kernel.org, 
    jdelvare@suse.com, linux@roeck-us.net, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org, 
    linux-hwmon@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] platform/x86/tuxedo: Implement TUXEDO TUXI ACPI
 TFAN via hwmon
In-Reply-To: <358c235f-14e4-43ef-bc82-9ad5d54f0976@tuxedocomputers.com>
Message-ID: <d99bb466-f9e6-9e86-8a0c-55f51655fb6f@linux.intel.com>
References: <20250205162109.222619-1-wse@tuxedocomputers.com> <20250205162109.222619-2-wse@tuxedocomputers.com> <dde736d4-6343-30e3-2bab-6eebbf4515e9@linux.intel.com> <358c235f-14e4-43ef-bc82-9ad5d54f0976@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1481543863-1738929196=:938"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1481543863-1738929196=:938
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 6 Feb 2025, Werner Sembach wrote:
> Am 06.02.25 um 10:51 schrieb Ilpo J=C3=A4rvinen:
> > On Wed, 5 Feb 2025, Werner Sembach wrote:
> >=20
> > > The TUXEDO Sirius 16 Gen1 & Gen2 have the custom TUXEDO Interface (TU=
XI)
> > > ACPI interface which currently consists of the TFAN device. This has =
ACPI
> > > functions to control the built in fans and monitor fan speeds and CPU=
 and
> > > GPU temprature.
> > >=20
> > > This driver implements this TFAN device via the hwmon subsystem with =
an
> > > added temprature check that ensure a minimum fanspeed at certain
> > > tempratures. This allows userspace controlled, but hardware safe, cus=
tom
> > temperatures
> thx for spotting
> >=20
> > > fan curves.
> > >=20
> > > Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>


> > > +=09for (i =3D 0; i < driver_data->fan_count; ++i) {
> > > +=09=09params[0] =3D i;
> > > +=09=09tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE,
> > > +=09=09=09=09 params, 1, &retval);
> > > +=09=09temp =3D retval * 100 - 272000;
> > > +
> > > +=09=09for (j =3D 0; temp_levels[j].temp; ++j) {
> > > +=09=09=09temp_low =3D j =3D=3D 0 ? -272000 : temp_levels[j-1].temp;
> > Please add a define for 272000 magic, or do you actually want to use on=
e
> > of the _kelvin conversion functions in linux/units.h ?
>=20
> I just realized that it should be 273000.
>=20
> Using the conversion functions would make it more complicated because the=
 ec
> pretends to return to a 10th degree precision but actually only return to=
 a
> full degree precission.
>=20
> So i would need to cut of the last digit, convert and then readd it. When=
 i do
> it directly in the code i can just use 273000 instead of 273150 and just
> ignore the last digits.

Fine, but add a local define for it then with a comment about the=20
precision compared with the generic define/conversion functions.

> > Missing spaces around - operator.
> >=20
> > > +=09=09=09temp_high =3D temp_levels[j].temp;
> > > +=09=09=09if (driver_data->temp_level[i] > j)
> > > +=09=09=09=09temp_high -=3D 2000; // hysteresis
> > 2 * MILLIDEGREE_PER_DEGREE ?
> >=20
> > Use define for it so you can place HYSTERESIS into its name and forgo t=
he
> > comment.
> kk
> >=20
> > > +
> > > +=09=09=09if (temp >=3D temp_low && temp < temp_high)
> > > +=09=09=09=09driver_data->temp_level[i] =3D j;
> > > +=09=09}
> > > +=09=09if (temp >=3D temp_high)
> > > +=09=09=09driver_data->temp_level[i] =3D j;
> > This loop should be in a helper I think. Naming it reasonably would als=
o
> > make it easier to understand what the loop does.
> only place i use it, i could just add a comment, but i can also do it in =
a
> separate function.

I know it's the only user but what the loop does is relatively complex,=20
and requires a few variables, etc. Is relatively self-contained=20
algorithmically.

Splitting into two functions, both functions could be more focused and=20
clear on their intent. Cleverly naming the helper function such that it=20
explain what happens in it, can often help to avoid the need to add any=20
comments (comments may be needed at times, but when we can avoid one=20
there's one place less to get out-of-sync with the code, which tends to=20
happen with comments :-)).

But I see Guenther was against some parts of this so please don't take my=
=20
style related comments as overruling his objections.


> > > diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_util.c
> > > b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_util.c
> > > new file mode 100644
> > > index 0000000000000..292b739a161e7
> > > --- /dev/null
> > > +++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_util.c
> > > @@ -0,0 +1,58 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
> > > + */
> > > +
> > > +#include <linux/acpi.h>

Btw just noticed, #include at least for kcalloc/kfree is missing.

> > > +
> > > +#include "acpi_tuxi_init.h"
> > > +
> > Remove empty line but see first what I note below.
> kk
> >=20
> > > +#include "acpi_tuxi_util.h"
> > > +
> > > +static int __acpi_eval_intarray_in_int_out(acpi_handle handle,
> > > +=09=09=09=09=09   acpi_string pathname,
> > > +=09=09=09=09=09   unsigned long long *params,
> > > +=09=09=09=09=09   u32 pcount,
> > > +=09=09=09=09=09   unsigned long long *retval)
> > There's only single caller of this function, so I question the need for
> > using an utility function.
>=20
> It's in preparation for if the TUXI device get another subdevice besides =
TFAN.
>=20
> Currently nothing is planed but i though this doesn't hurt.
>=20
> >=20
> > > +{
> > > +=09struct acpi_object_list arguments;
> > > +=09unsigned long long data;
> > > +=09acpi_status status;
> > > +
> > > +=09if (pcount > 0) {
> > > +=09=09pr_debug("Params:\n");
> > > +
> > > +=09=09arguments.count =3D pcount;
> > > +=09=09arguments.pointer =3D kcalloc(pcount,
> > > sizeof(*arguments.pointer),
> > > +=09=09=09=09=09    GFP_KERNEL);
> > > +=09=09for (int i =3D 0; i < pcount; ++i) {
> > unsigned int
> kk
> >=20
> > > +=09=09=09pr_debug("%llu\n", params[i]);
> > > +
> > > +=09=09=09arguments.pointer[i].type =3D ACPI_TYPE_INTEGER;
> > > +=09=09=09arguments.pointer[i].integer.value =3D params[i];
> > > +=09=09}
> > > +=09=09status =3D acpi_evaluate_integer(handle, pathname, &arguments,
> > > +=09=09=09=09=09       &data);
> > > +=09=09kfree(arguments.pointer);
> > You can use cleanup.h to handle freeing.
> will look into it
>
> > > +=09} else {
> > > +=09=09status =3D acpi_evaluate_integer(handle, pathname, NULL, &data=
);
> > This call should be on the main level. You can use ?: operator for the
> > only parameter you're changing for it between the currently diverging
> > code paths.
>=20
> then the kcalloc call happens every time even if it is not required.

No it won't, you'd allocate only if pcount > 0 (in a similar block as=20
now):

#include <linux/cleanup.h>
#include <linux/slab.h>
=2E..

=09union acpi_object __free(kfree) *obj =3D NULL;

=09if (pcount > 0)
=09=09obj =3D kcalloc(...);

=09=09arguments.count =3D ...;
=09=09arguments.pointer =3D obj;
=09=09...
=09}

=09status =3D acpi_evaluate_integer(handle, pathname,
=09=09=09=09       pcount ? arguments : NULL, &data);
=09if (ACPI_FAILURE(status))
=09=09...

__free() will handle kfree(obj) for you, you don't call kfree() manually.

> also i don't know if ?-operator in a function call is good to read.

It is much better than duplicating almost the same call, by using ?: it=20
is obvious that only single parameter is being altered, whereas on split=20
calls, the code reader has to do the compare.


> > > + * Arg0: Fan index
> > > + * Returns: Speed sensor value in revolutions per minute
> > > + */
> > > +#define TUXI_TFAN_METHOD_GET_FAN_RPM=09=09"GRPM"
> > > +
> > > +int tuxi_tfan_method(struct acpi_device *device, acpi_string method,
> > > +=09=09     unsigned long long *params, u32 pcount,
> > > +=09=09     unsigned long long *retval);
> > > +
> > > +#endif // __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_UTIL_H__
> > >=20
> > What is the reason for splitting this into so many files? Are there goi=
ng
> > to be other users of the code that is split into separate files? For th=
e
> > init/deinit code, surely not.
> >=20
> > It will be considerably harder to track call chains, etc. when the
> > function cannot be found in the same file so you better provide a reall=
y
> > good reason for going so extreme with the split.
>=20
> Same as above: in preparation for the future if there is another TUXI
> subdevice other then TFAN.
>=20
> Also to section of the hwmon logic as I might want to reuse it for other =
odms
> in the future albeit it would then need to get passed the acpi-write func=
tion
> in a dynamic way.
>=20
> And imho it not harder to follow over different files, there is a lot of
> external function references anyway, so having something setup to
> automatically jump to a function definition in a different file is alread=
y
> required to quickly parse the code.

For library type APIs, one usually doesn't read those functions. I'm=20
talking about functions within the driver. For well-structured and=20
well-named code, jumping all over the place not a requirement at all=20
because the interfaces that cross file boundaries are well architected and=
=20
rest is self-contained and self-explanatory. I see you started to defend=20
the suboptimal split with everybody does that argument ;-).

Your references to "future" sound quite vague, if there are no immediate=20
plans for such drivers to exist, I'd just do such rearranging of code when=
=20
the supposed other drivers actually happens (which often is never).

--=20
 i.

--8323328-1481543863-1738929196=:938--

