Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0BE38C102
	for <lists+linux-pwm@lfdr.de>; Fri, 21 May 2021 09:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbhEUHxN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 May 2021 03:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhEUHxM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 May 2021 03:53:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD3AC061574
        for <linux-pwm@vger.kernel.org>; Fri, 21 May 2021 00:51:50 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ljzwW-0001Yn-6x; Fri, 21 May 2021 09:51:36 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ljzwU-0005dO-4c; Fri, 21 May 2021 09:51:34 +0200
Date:   Fri, 21 May 2021 09:51:33 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "David A. Schleef" <ds@schleef.org>,
        Mori Hess <fmhess@users.sourceforge.net>,
        Truxton Fulton <trux@truxton.com>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 5/6] comedi: drivers: ni_mio_common: Move
 'range_ni_E_ao_ext' to where it is used
Message-ID: <20210521075133.rditsyeiz3qah7qo@pengutronix.de>
References: <20210520122538.3470259-1-lee.jones@linaro.org>
 <20210520122538.3470259-6-lee.jones@linaro.org>
 <c69d39a0-bf9e-857d-93ba-73e2884fa4ad@mev.co.uk>
 <20210521072635.GY2549456@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xe2uc75uffgpbfp5"
Content-Disposition: inline
In-Reply-To: <20210521072635.GY2549456@dell>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xe2uc75uffgpbfp5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 21, 2021 at 08:26:35AM +0100, Lee Jones wrote:
> On Thu, 20 May 2021, Ian Abbott wrote:
>=20
> > On 20/05/2021 13:25, Lee Jones wrote:
> > > ... and mark it as __maybe_unused since not all users of the
> > > header file reference it.
> > >=20
> > > Fixes the following W=3D1 kernel build warning(s):
> > >=20
> > >   drivers/staging/comedi/drivers/ni_mio_common.c:163:35: warning: =E2=
=80=98range_ni_E_ao_ext=E2=80=99 defined but not used [-Wunused-const-varia=
ble=3D]
> > >=20
> > > Cc: Ian Abbott <abbotti@mev.co.uk>
> > > Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: "David A. Schleef" <ds@schleef.org>
> > > Cc: Mori Hess <fmhess@users.sourceforge.net>
> > > Cc: Truxton Fulton <trux@truxton.com>
> > > Cc: linux-staging@lists.linux.dev
> > > Cc: linux-pwm@vger.kernel.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >   drivers/comedi/drivers/ni_mio_common.c | 9 ---------
> > >   drivers/comedi/drivers/ni_stc.h        | 9 ++++++++-
> > >   2 files changed, 8 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/drivers/comedi/drivers/ni_mio_common.c b/drivers/comedi/=
drivers/ni_mio_common.c
> > > index 4f80a4991f953..37615b4e2c10d 100644
> > > --- a/drivers/comedi/drivers/ni_mio_common.c
> > > +++ b/drivers/comedi/drivers/ni_mio_common.c
> > > @@ -160,15 +160,6 @@ static const struct comedi_lrange range_ni_M_ai_=
628x =3D {
> > >   	}
> > >   };
> > > -static const struct comedi_lrange range_ni_E_ao_ext =3D {
> > > -	4, {
> > > -		BIP_RANGE(10),
> > > -		UNI_RANGE(10),
> > > -		RANGE_ext(-1, 1),
> > > -		RANGE_ext(0, 1)
> > > -	}
> > > -};
> > > -
> > >   static const struct comedi_lrange *const ni_range_lkup[] =3D {
> > >   	[ai_gain_16] =3D &range_ni_E_ai,
> > >   	[ai_gain_8] =3D &range_ni_E_ai_limited,
> > > diff --git a/drivers/comedi/drivers/ni_stc.h b/drivers/comedi/drivers=
/ni_stc.h
> > > index fbc0b753a0f59..0822e65f709dd 100644
> > > --- a/drivers/comedi/drivers/ni_stc.h
> > > +++ b/drivers/comedi/drivers/ni_stc.h
> > > @@ -1137,6 +1137,13 @@ struct ni_private {
> > >   	u8 rgout0_usage;
> > >   };
> > > -static const struct comedi_lrange range_ni_E_ao_ext;
> > > +static const struct comedi_lrange __maybe_unused range_ni_E_ao_ext =
=3D {
> > > +	4, {
> > > +		BIP_RANGE(10),
> > > +		UNI_RANGE(10),
> > > +		RANGE_ext(-1, 1),
> > > +		RANGE_ext(0, 1)
> > > +	}
> > > +};
> > >   #endif /* _COMEDI_NI_STC_H */
> > >=20
> >=20
> > The "ni_stc.h" header is also included by "ni_mio_cs.c" which doesn't n=
eed
> > `range_ni_E_ao_ext` (admittedly, it was already pulling in a "tentative"
> > definition of the variable).
> >=20
> > Thinking about it, I think it's probably better to move `range_ni_E_ao_=
ext`
> > from "ni_mio_common.c" into *both* "ni_atmio.c" and "ni_pcimio.c" (I th=
ink
> > we can live with the small amount of duplication), and to remove the
> > tentative definition from "ni_stc.h".
>=20
> Happy to rework.
>=20
> Am I taking this or Uwe's suggestion?

uah, maybe the first step is to not include ni_mio_common.c from other c
files. That should save some more duplicated bytes than only
range_ni_E_ao_ext ...

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xe2uc75uffgpbfp5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCnZoIACgkQwfwUeK3K
7Akt3wf/UQkqF+Z1NzTkWV1La+5hsrlsnfedxkr28C5qEPzHXA2+RzaktPosNohG
O2VpJZQWOVR9lXD49va5HuQgb2v175P9SHzFEEM0SgEcYgvyKkZkLzaqtcmiM9Q9
YhItZm62gughgfOIVmHJd1ogTVQx5e8ZwcJ7b71dXz4E/vypbJZF0UO1GL1xtPbw
POoHwKi19RmCTP/YCxTbABqTGHuP7PBXTnleb8Yn9rUTOWHvxQ8KGxw+JR+BqjtF
OHaDS5GbBujIYK9FbDFFsGs8tLJMKqTXijcDj8DTwlbVUxVqWmba/ww4uSmgQttj
59ZoOgMo8oo1puc7diIO04jL+NJ2pw==
=gvNE
-----END PGP SIGNATURE-----

--xe2uc75uffgpbfp5--
