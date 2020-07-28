Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0157E23037F
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 09:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgG1HIP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 03:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgG1HIO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2020 03:08:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA47AC0619D2
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 00:08:14 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k0JiV-0003di-9B; Tue, 28 Jul 2020 09:08:03 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k0JiT-0004YI-RR; Tue, 28 Jul 2020 09:08:01 +0200
Date:   Tue, 28 Jul 2020 09:08:01 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Martin Botka <martin.botka1@gmail.com>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH RFC 3/6] pwm: pwm-qti-lpg: Add PWM driver for QTI LPG
 module
Message-ID: <20200728070801.evcfnq25a2f5d55r@pengutronix.de>
References: <20200724213659.273599-1-martin.botka1@gmail.com>
 <20200724213659.273599-4-martin.botka1@gmail.com>
 <20200727200954.pzw6swdboa65474i@pengutronix.de>
 <CADQ2G_EMUdf2BEwjDOCyz_ccMTsjMBM3GmpRe+n6V9-DJGr-Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="65wsexfumroshxqm"
Content-Disposition: inline
In-Reply-To: <CADQ2G_EMUdf2BEwjDOCyz_ccMTsjMBM3GmpRe+n6V9-DJGr-Kg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--65wsexfumroshxqm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Martin,

On Mon, Jul 27, 2020 at 11:16:57PM +0200, Martin Botka wrote:
> Mo 27. 7. 2020 at 22:10 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.d=
e> wrote:
> >
> > On Fri, Jul 24, 2020 at 11:36:53PM +0200, Martin Botka wrote:
> > > From: Fenglin Wu <fenglinw@codeaurora.org>
> > >
> > > Add pwm_chip to support QTI LPG module and export LPG channels as
> > > PWM devices for consumer drivers' usage.
> > >
> > > Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
> > > [martin.botka1@gmail.com: Fast-forward the driver from kernel 4.14 to=
 5.8]
> > > Signed-off-by: Martin Botka <martin.botka1@gmail.com>
> > > ---
> > >  drivers/pwm/Kconfig       |   10 +
> > >  drivers/pwm/Makefile      |    1 +
> > >  drivers/pwm/pwm-qti-lpg.c | 1284 +++++++++++++++++++++++++++++++++++=
++
> > >  3 files changed, 1295 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-qti-lpg.c
> > >
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index cb8d739067d2..8a52d6884a9a 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -399,6 +399,16 @@ config PWM_RCAR
> > >         To compile this driver as a module, choose M here: the module
> > >         will be called pwm-rcar.
> > >
> > > +config PWM_QTI_LPG
> > > +     tristate "Qualcomm Technologies, Inc. LPG driver"
> > > +     depends on  MFD_SPMI_PMIC && OF
> > > +     help
> > > +       This driver supports the LPG (Light Pulse Generator) module f=
ound in
> > > +       Qualcomm Technologies, Inc. PMIC chips. Each LPG channel can =
be
> > > +       configured to operate in PWM mode to output a fixed amplitude=
 with
> > > +       variable duty cycle or in LUT (Look up table) mode to output =
PWM
> > > +       signal with a modulated amplitude.
> > > +
> > >  config PWM_RENESAS_TPU
> > >       tristate "Renesas TPU PWM support"
> > >       depends on ARCH_RENESAS || COMPILE_TEST
> > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > index a59c710e98c7..3555a6aa3f33 100644
> > > --- a/drivers/pwm/Makefile
> > > +++ b/drivers/pwm/Makefile
> > > @@ -37,6 +37,7 @@ obj-$(CONFIG_PWM_PCA9685)   +=3D pwm-pca9685.o
> > >  obj-$(CONFIG_PWM_PUV3)               +=3D pwm-puv3.o
> > >  obj-$(CONFIG_PWM_PXA)                +=3D pwm-pxa.o
> > >  obj-$(CONFIG_PWM_RCAR)               +=3D pwm-rcar.o
> > > +obj-$(CONFIG_PWM_QTI_LPG)    +=3D pwm-qti-lpg.o
> >
> > Please keep this list alphabetically sorted.
>=20
> OK
>=20
> >
> > >  obj-$(CONFIG_PWM_RENESAS_TPU)        +=3D pwm-renesas-tpu.o
> > >  obj-$(CONFIG_PWM_ROCKCHIP)   +=3D pwm-rockchip.o
> > >  obj-$(CONFIG_PWM_SAMSUNG)    +=3D pwm-samsung.o
> > > diff --git a/drivers/pwm/pwm-qti-lpg.c b/drivers/pwm/pwm-qti-lpg.c
> > > new file mode 100644
> > > index 000000000000..d24c3b3a3d8c
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-qti-lpg.c
> > > @@ -0,0 +1,1284 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> > > + */
> > > +
> > > +#define pr_fmt(fmt) "%s: " fmt, __func__
> >
> > This smells like debug stuff. Please drop this.
>=20
> What do you mean ?
> The #define pr_fmt(fmt) or the tons of REG definitions ?

Either drop pr_fmt or at least don't have __func__ in it. This doesn't
belong into the kernel log (in the non-debug case at least).
(For debugging I like:

	#define pr_fmt(fmt) "%s:%d: " fmt, __func__, __LINE__

which helps finding the right printk line in the code from a given
output in functions with many printks.)

I don't mind the REG definitions, though aligning the values vertically
is common.

> > > +static const struct pwm_ops qpnp_lpg_pwm_ops =3D {
> > > +     .config =3D qpnp_lpg_pwm_config,
> > > +     .config_extend =3D qpnp_lpg_pwm_config_extend,
> > > +     .get_output_type_supported =3D qpnp_lpg_pwm_output_types_suppor=
ted,
> > > +     .set_output_type =3D qpnp_lpg_pwm_set_output_type,
> > > +     .set_output_pattern =3D qpnp_lpg_pwm_set_output_pattern,
> > > +     .enable =3D qpnp_lpg_pwm_enable,
> > > +     .disable =3D qpnp_lpg_pwm_disable,
> >
> > As already noted in the former patch: Please implement .apply() and
> > .get_state().
>=20
> So drop:
>     .get_output_type_supported =3D qpnp_lpg_pwm_output_types_supported,
>     .set_output_type =3D qpnp_lpg_pwm_set_output_type,
>     .set_output_pattern =3D qpnp_lpg_pwm_set_output_pattern,
>=20
> Ad implement implement .apply and .get_state if i understood you correctl=
y.
> Right ?

ack

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--65wsexfumroshxqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8fzs4ACgkQwfwUeK3K
7Ak/YAf9FSlak+4n7XI61g7I4xuJ3J9+gwsKT9NvQ5nPGRpTWMcpgRBLUtTN7hQe
bsJTuOqQwYX7F2tIZOUXHfED/EB5maLbAlMEVvsukBc9Igmt1SZktjnL/XZWiVKK
auVqqp1q30K1Sq+rbZPkrhRjzY0PZkE9/UqE0TDEuwAg8FjZfbsg4MummLiQfWuk
FH7Z94j5Q/CcoGq/pDaK8/fur2Z0s1ea2UDh+GIGjoLHnMz5i5CcqYg5MrdfzTKn
3u/42Jy60r2SWDGkF7F1ghfoxsTlKPc2Auv40DFo+D448mNm//j0nQ6/ilF+wGFf
jcUQdplt8Pdx+VfXcAMAd6IJ95p3QQ==
=WSc0
-----END PGP SIGNATURE-----

--65wsexfumroshxqm--
