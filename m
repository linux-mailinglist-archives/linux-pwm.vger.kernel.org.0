Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A430338C957
	for <lists+linux-pwm@lfdr.de>; Fri, 21 May 2021 16:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhEUOlT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 May 2021 10:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhEUOlS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 May 2021 10:41:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A02C061763
        for <linux-pwm@vger.kernel.org>; Fri, 21 May 2021 07:39:54 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lk6JD-0002gN-CB; Fri, 21 May 2021 16:39:27 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lk6JB-00065t-VB; Fri, 21 May 2021 16:39:25 +0200
Date:   Fri, 21 May 2021 16:39:25 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Ian Abbott <abbotti@mev.co.uk>,
        linux-kernel@vger.kernel.org,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "David A. Schleef" <ds@schleef.org>,
        Mori Hess <fmhess@users.sourceforge.net>,
        Truxton Fulton <trux@linode1.truxton.com>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 5/6] comedi: drivers: ni_mio_common: Move
 'range_ni_E_ao_ext' to where it is used
Message-ID: <20210521143925.xjmwluaoyer322lg@pengutronix.de>
References: <20210520122538.3470259-1-lee.jones@linaro.org>
 <20210520122538.3470259-6-lee.jones@linaro.org>
 <c69d39a0-bf9e-857d-93ba-73e2884fa4ad@mev.co.uk>
 <20210521072635.GY2549456@dell>
 <20210521115431.GK1955@kadam>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xpc7qmyd6f62xnp5"
Content-Disposition: inline
In-Reply-To: <20210521115431.GK1955@kadam>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xpc7qmyd6f62xnp5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 21, 2021 at 02:54:31PM +0300, Dan Carpenter wrote:
> On Fri, May 21, 2021 at 08:26:35AM +0100, Lee Jones wrote:
> > On Thu, 20 May 2021, Ian Abbott wrote:
> >=20
> > > On 20/05/2021 13:25, Lee Jones wrote:
> > > > ... and mark it as __maybe_unused since not all users of the
> > > > header file reference it.
> > > >=20
> > > > Fixes the following W=3D1 kernel build warning(s):
> > > >=20
> > > >   drivers/staging/comedi/drivers/ni_mio_common.c:163:35: warning: =
=E2=80=98range_ni_E_ao_ext=E2=80=99 defined but not used [-Wunused-const-va=
riable=3D]
> > > >=20
> > > > Cc: Ian Abbott <abbotti@mev.co.uk>
> > > > Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > > Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> > > > Cc: Lee Jones <lee.jones@linaro.org>
> > > > Cc: "David A. Schleef" <ds@schleef.org>
> > > > Cc: Mori Hess <fmhess@users.sourceforge.net>
> > > > Cc: Truxton Fulton <trux@truxton.com>
> > > > Cc: linux-staging@lists.linux.dev
> > > > Cc: linux-pwm@vger.kernel.org
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >   drivers/comedi/drivers/ni_mio_common.c | 9 ---------
> > > >   drivers/comedi/drivers/ni_stc.h        | 9 ++++++++-
> > > >   2 files changed, 8 insertions(+), 10 deletions(-)
> > > >=20
> > > > diff --git a/drivers/comedi/drivers/ni_mio_common.c b/drivers/comed=
i/drivers/ni_mio_common.c
> > > > index 4f80a4991f953..37615b4e2c10d 100644
> > > > --- a/drivers/comedi/drivers/ni_mio_common.c
> > > > +++ b/drivers/comedi/drivers/ni_mio_common.c
> > > > @@ -160,15 +160,6 @@ static const struct comedi_lrange range_ni_M_a=
i_628x =3D {
> > > >   	}
> > > >   };
> > > > -static const struct comedi_lrange range_ni_E_ao_ext =3D {
> > > > -	4, {
> > > > -		BIP_RANGE(10),
> > > > -		UNI_RANGE(10),
> > > > -		RANGE_ext(-1, 1),
> > > > -		RANGE_ext(0, 1)
> > > > -	}
> > > > -};
> > > > -
> > > >   static const struct comedi_lrange *const ni_range_lkup[] =3D {
> > > >   	[ai_gain_16] =3D &range_ni_E_ai,
> > > >   	[ai_gain_8] =3D &range_ni_E_ai_limited,
> > > > diff --git a/drivers/comedi/drivers/ni_stc.h b/drivers/comedi/drive=
rs/ni_stc.h
> > > > index fbc0b753a0f59..0822e65f709dd 100644
> > > > --- a/drivers/comedi/drivers/ni_stc.h
> > > > +++ b/drivers/comedi/drivers/ni_stc.h
> > > > @@ -1137,6 +1137,13 @@ struct ni_private {
> > > >   	u8 rgout0_usage;
> > > >   };
> > > > -static const struct comedi_lrange range_ni_E_ao_ext;
> > > > +static const struct comedi_lrange __maybe_unused range_ni_E_ao_ext=
 =3D {
> > > > +	4, {
> > > > +		BIP_RANGE(10),
> > > > +		UNI_RANGE(10),
> > > > +		RANGE_ext(-1, 1),
> > > > +		RANGE_ext(0, 1)
> > > > +	}
> > > > +};
> > > >   #endif /* _COMEDI_NI_STC_H */
> > > >=20
> > >=20
> > > The "ni_stc.h" header is also included by "ni_mio_cs.c" which doesn't=
 need
> > > `range_ni_E_ao_ext` (admittedly, it was already pulling in a "tentati=
ve"
> > > definition of the variable).
> > >=20
> > > Thinking about it, I think it's probably better to move `range_ni_E_a=
o_ext`
> > > from "ni_mio_common.c" into *both* "ni_atmio.c" and "ni_pcimio.c" (I =
think
> > > we can live with the small amount of duplication), and to remove the
> > > tentative definition from "ni_stc.h".
> >=20
> > Happy to rework.
> >=20
> > Am I taking this or Uwe's suggestion?
>=20
> You should probably take Ian's suggestion because he is the maintainer
> and I really doubt Uwe's will build.  :P  But Uwe is right that
> including .c files is ugly.

I just tried

diff --git a/drivers/comedi/drivers/ni_mio_common.c b/drivers/comedi/driver=
s/ni_mio_common.c
index 4f80a4991f95..3b37c8b00ecd 100644
--- a/drivers/comedi/drivers/ni_mio_common.c
+++ b/drivers/comedi/drivers/ni_mio_common.c
@@ -160,7 +160,7 @@ static const struct comedi_lrange range_ni_M_ai_628x =
=3D {
 	}
 };
=20
-static const struct comedi_lrange range_ni_E_ao_ext =3D {
+const struct comedi_lrange range_ni_E_ao_ext =3D {
 	4, {
 		BIP_RANGE(10),
 		UNI_RANGE(10),
diff --git a/drivers/comedi/drivers/ni_stc.h b/drivers/comedi/drivers/ni_st=
c.h
index fbc0b753a0f5..026d215f2ef2 100644
--- a/drivers/comedi/drivers/ni_stc.h
+++ b/drivers/comedi/drivers/ni_stc.h
@@ -1137,6 +1137,6 @@ struct ni_private {
 	u8 rgout0_usage;
 };
=20
-static const struct comedi_lrange range_ni_E_ao_ext;
+extern const struct comedi_lrange range_ni_E_ao_ext;
=20
 #endif /* _COMEDI_NI_STC_H */

and it built for me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xpc7qmyd6f62xnp5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCnxhcACgkQwfwUeK3K
7AnDfQf/fVekK150Z5CIp+UhXg67VDGOnS4hkIdUtjNNkyOc/SAfLwCadzctN6fD
4n1iOfS8lkuvhK+iA/NAh3s16/HWS/Utrd2PRg6zbtzZg2tt1FyttlKiFuLeb26+
2KQwD/Y5xAMSeMpdRWJCaEApmBsaZ3aob8Kz6KfgSZvkC6lt/G19lag2i6xX0qlx
nHWZqDGtmnt3Iyt8UVuG0Djt/lC6WmhyIYlh88YRZcMC2+ejU7lqNNDbIyTLRmiL
Dur4aYv8+YGqvg/fTXDADG8/xOoQ21cxY5iocRprBWfPJF17mE7IOtiFOqk6K33c
J/eBKuDfJaLXylhUc31nYxvidR1YuA==
=VPgS
-----END PGP SIGNATURE-----

--xpc7qmyd6f62xnp5--
