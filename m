Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B79341EEA
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Mar 2021 15:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCSOAx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 19 Mar 2021 10:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhCSOAq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 19 Mar 2021 10:00:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC40FC06174A
        for <linux-pwm@vger.kernel.org>; Fri, 19 Mar 2021 07:00:46 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lNFgD-0003jB-6k; Fri, 19 Mar 2021 15:00:45 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lNFgC-0005oP-DW; Fri, 19 Mar 2021 15:00:44 +0100
Date:   Fri, 19 Mar 2021 15:00:44 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH 1/4] pwm: Make of_pwm_xlate_with_flags() work with
 #pwm-cells = <2>
Message-ID: <20210319140044.zoxr3gbykgjp73jx@pengutronix.de>
References: <20210315111124.2475274-1-u.kleine-koenig@pengutronix.de>
 <20210315111124.2475274-2-u.kleine-koenig@pengutronix.de>
 <20210319125858.b2roeeeinowhxkxy@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fzgjswcwy3ghggpo"
Content-Disposition: inline
In-Reply-To: <20210319125858.b2roeeeinowhxkxy@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fzgjswcwy3ghggpo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Marco,

On Fri, Mar 19, 2021 at 01:58:58PM +0100, Marco Felsch wrote:
> On 21-03-15 12:11, Uwe Kleine-K=F6nig wrote:
> > The two functions of_pwm_simple_xlate() and of_pwm_xlate_with_flags() a=
re
> > quite similar. of_pwm_simple_xlate() only supports two pwm-cells while
> > of_pwm_xlate_with_flags() only support >=3D 3 pwm-cells. The latter can
> > easily be modified to behave identically to of_pwm_simple_xlate for two
> > pwm-cells. This is implemented here and allows to drop
> > of_pwm_simple_xlate() in the next commit.
> >=20
> > There is a small detail that is different now between of_pwm_simple_xla=
te()
> > and of_pwm_xlate_with_flags() with pwm-cells =3D <2>: pwm->args.polarit=
y is
> > unconditionally initialized to PWM_POLARITY_NORMAL in the latter. I did=
n't
> > find a case where this matters and doing that explicitly is the more
> > robust approach.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/core.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index b1adf3bb8508..39b0ad506bdd 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -126,8 +126,7 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const =
struct of_phandle_args *args)
> >  {
> >  	struct pwm_device *pwm;
> > =20
> > -	/* check, whether the driver supports a third cell for flags */
> > -	if (pc->of_pwm_n_cells < 3)
> > +	if (pc->of_pwm_n_cells < 2)
> >  		return ERR_PTR(-EINVAL);
>=20
> Wouldn't this introduce regressions with old dtb's?

Can you be more specific here? I don't see a possible regression here.

Take into account:

 - Today no driver uses of_pwm_xlate_with_flags with pc->of_pwm_n_cells =3D=
=3D 2; and
 - the callback is only called after of_parse_phandle_with_args() with
   cells_name =3D #pwm-cells returned this chip.

So in the end the change is only that drivers that today only support 2
cells also support 3 iff the PWM node has #pwm-cells =3D <3>.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fzgjswcwy3ghggpo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBUrokACgkQwfwUeK3K
7AlPggf8DPViQEa36uwxztGscwEVXLuYpvN/JWbcS27QbgT/y8eLnEMBEfw4idtY
FZcKAshGqxzyBuaQm5T6+FpmLo3mitb1NKeC8g06SPXjjYUDxniTtuYwcpdmWTVn
8DR9SpxCUPSkHgBl8GYXs6jc+B3V2yr/J/wbfHBtD62ssF9vYvvYCsBHEbAR8QKz
OsDSXnJEHu/eFhdoxtokZFhSEB1pEV9DK+bnvrIXeqtt2alW8TPJL8kUIWve3hA0
5kjpXE/ted69kcFtf3zugqmOJXEbeMpPdWAyIA9ghIFaTZ0Vee66+dQp75vJBw4E
UAzbSPaRPiVUXkWxj6IRBjr3gcmqvQ==
=QeKV
-----END PGP SIGNATURE-----

--fzgjswcwy3ghggpo--
