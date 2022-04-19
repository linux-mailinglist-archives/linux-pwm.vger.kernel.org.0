Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FC9506643
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Apr 2022 09:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242782AbiDSHvd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 19 Apr 2022 03:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243344AbiDSHvb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Apr 2022 03:51:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161312E6BD
        for <linux-pwm@vger.kernel.org>; Tue, 19 Apr 2022 00:48:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ngibP-0008KA-Eg; Tue, 19 Apr 2022 09:48:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ngibO-003vZG-GD; Tue, 19 Apr 2022 09:48:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ngibL-004Dn6-Vu; Tue, 19 Apr 2022 09:48:43 +0200
Date:   Tue, 19 Apr 2022 09:48:40 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 6/6] pwm: renesas-tpu: Improve precision of period and
 duty_cycle calculation
Message-ID: <20220419074840.yrvuxz3bgh6zc3oc@pengutronix.de>
References: <20220413085050.61144-1-u.kleine-koenig@pengutronix.de>
 <20220413085050.61144-6-u.kleine-koenig@pengutronix.de>
 <CAMuHMdX7Kic2WG+f6hAdjz7SGSjWfi-UTdOrxtmV6D4zE3zh1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4776lsr6oeb2v4wm"
Content-Disposition: inline
In-Reply-To: <CAMuHMdX7Kic2WG+f6hAdjz7SGSjWfi-UTdOrxtmV6D4zE3zh1Q@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--4776lsr6oeb2v4wm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Geert,

first of all thanks for your review and testing. It's great to get some
feedback (even though it means some work for me :-)

On Thu, Apr 14, 2022 at 12:27:28PM +0200, Geert Uytterhoeven wrote:
> On Wed, Apr 13, 2022 at 10:51 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > Fixes: 99b82abb0a35 ("pwm: Add Renesas TPU PWM driver")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-renesas-tpu.c | 34 ++++++++++++++++++++++------------
> >  1 file changed, 22 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tp=
u.c
> > index fce7df418d62..c8c7a896fc55 100644
> > --- a/drivers/pwm/pwm-renesas-tpu.c
> > +++ b/drivers/pwm/pwm-renesas-tpu.c
> > @@ -242,42 +242,52 @@ static void tpu_pwm_free(struct pwm_chip *chip, s=
truct pwm_device *pwm)
> >  }
> >
> >  static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> > -                         int duty_ns, int period_ns, bool enabled)
> > +                         u64 duty_ns, u64 period_ns, bool enabled)
> >  {
> >         struct tpu_pwm_device *tpd =3D pwm_get_chip_data(pwm);
> >         struct tpu_device *tpu =3D to_tpu_device(chip);
> >         unsigned int prescaler;
> >         bool duty_only =3D false;
> >         u32 clk_rate;
> > -       u32 period;
> > +       u64 period;
> >         u32 duty;
> >         int ret;
> >
> >         clk_rate =3D clk_get_rate(tpu->clk);
>=20
> As clk_get_rate() returns unsigned long, I think you should change
> clk_rate from u32 to unsigned long, too.

Yeah, could do that. I guess I didn't because in my bubble a long is 32
bits wide :-) IMHO fixing that is worth a separate patch.

> > +       if (unlikely(clk_rate > 1000000000UL)) {
>=20
> s/1000000000UL/NSEC_PER_SEC/

ok

> > +               /*
> > +                * This won't happen in the nearer future, so this is o=
nly a
> > +                * safeguard to prevent the following calculation from
> > +                * overflowing. With this clk_rate * period_ns / NSEC_P=
ER_SEC is
> > +                * not greater than period_ns and so fits into an u64.
> > +                */
> > +               return -EINVAL;
> > +       }
> >
> > -       period =3D clk_rate / (NSEC_PER_SEC / period_ns);
> > +       period =3D mul_u64_u64_div_u64(clk_rate, period_ns, NSEC_PER_SE=
C);
> >         if (period >=3D 64 * 0x10000 || period =3D=3D 0)
> >                 return -EINVAL;
>=20
> Perhaps use "u64 period64" above, and
>=20
>     /* We know period to fit into an u32 */
>     period =3D (u32)period64;
>=20
> to avoid introducing all casts below.

I first had it that way, but didn't like it. Yeah, it makes the patch a
bit smaller, but IMHO it adds some burden to understand the code flow
because for a reader having two variables for the same (semantic) value
is harder to understand.

>=20
> >
> >         if (period < 0x10000)
> >                 prescaler =3D 0;
> >         else
> > -               prescaler =3D ilog2(period / 0x10000) / 2 + 1;
> > +               /*
> > +                * We know period to fit into an u32, so cast according=
ly to
> > +                * make the division a bit cheaper
> > +                */
> > +               prescaler =3D ilog2((u32)period / 0x10000) / 2 + 1;
>=20
> Using a loop would avoid the need for a division...

I would "fix" this differently, there isn't really a division; at least
I would expect (but didn't check) that the compiler uses a cheap shift
to implement "/ 0x10000" and "/ 2". ilog2 might become a bit cheaper for
a 32 bit value. So I would replace that by:

	/*
	 * ilog2 might be a bit cheaper for u32 than u64 and we know
	 * period to fit into a u32, so cast accordingly.
	 */

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4776lsr6oeb2v4wm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJeaVUACgkQwfwUeK3K
7AmdmQf9H9UJMFkbh+vYi+U2FWekO0vPXwr1EpJ0oAN6CObDt7E4cEX/L3TbzheN
OMi6zkN8jtP6p324/HG3xJzeknSHfCRwQ7SWCMQQVGCkpDUcyz5YXxiexYy6eraq
1KAzETomcBxkjVQVcNyuhQzdle49Yi/kqAvXMxbuBL6a39BQu0/A4gHTu4lfpVad
FV4MdUrog3x41P3EziUQnfs5trdgCL5Mx3MC0XSKq4r1khulqFVj0Xujsi4tujh9
vutB+tAogqNPOb4i8WLYxsM1dCxB4KpC1/8SqU8g52wdCponjGUWUnBByhZjuKej
dqDGnp+Xj9NS/7XC29K1FhVW3iExAw==
=jH8k
-----END PGP SIGNATURE-----

--4776lsr6oeb2v4wm--
