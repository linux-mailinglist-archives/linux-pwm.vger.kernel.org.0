Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422115085DC
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Apr 2022 12:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbiDTKaU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Apr 2022 06:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiDTKaT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Apr 2022 06:30:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F493D1EF
        for <linux-pwm@vger.kernel.org>; Wed, 20 Apr 2022 03:27:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh7YY-0006Hd-5R; Wed, 20 Apr 2022 12:27:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh7YW-00493i-NM; Wed, 20 Apr 2022 12:27:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh7YU-004SgR-7b; Wed, 20 Apr 2022 12:27:26 +0200
Date:   Wed, 20 Apr 2022 12:27:26 +0200
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
Subject: Re: [PATCH 5/6] pwm: renesas-tpu: Improve maths to compute register
 settings
Message-ID: <20220420102726.hjj5eh5qjlyklzfw@pengutronix.de>
References: <20220413085050.61144-1-u.kleine-koenig@pengutronix.de>
 <20220413085050.61144-5-u.kleine-koenig@pengutronix.de>
 <CAMuHMdW6u3xrnZrxsx8h6-zfZ=6sH=ehnQ6KCthB5QNFU5rexQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rxxc7zsmbx3lfz5x"
Content-Disposition: inline
In-Reply-To: <CAMuHMdW6u3xrnZrxsx8h6-zfZ=6sH=ehnQ6KCthB5QNFU5rexQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--rxxc7zsmbx3lfz5x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Geert,

On Thu, Apr 14, 2022 at 12:10:02PM +0200, Geert Uytterhoeven wrote:
> On Wed, Apr 13, 2022 at 10:51 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > The newly computed register values are intended to exactly match the
> > previously computed values. The main improvement is that the prescaler
> > is computed directly instead of with a loop. This uses the fact, that
> > prescalers[i] =3D 1 << (2 * i).
> >
> > Assuming a moderately smart compiler, the needed number of divisions for
> > the case where the requested period is too big, is reduced from 5 to 2.
>=20
> I'm not worried about the divisions, but about the ilog2(), which
> uses fls().  The TPU block also exists on SuperH SoCs (although
> currently no SH Linux code has it enabled), and SH uses the fls()
> implementation from asm-generic.
>=20
> > --- a/drivers/pwm/pwm-renesas-tpu.c
> > +++ b/drivers/pwm/pwm-renesas-tpu.c
> > @@ -244,7 +244,6 @@ static void tpu_pwm_free(struct pwm_chip *chip, str=
uct pwm_device *pwm)
> >  static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> >                           int duty_ns, int period_ns, bool enabled)
> >  {
> > -       static const unsigned int prescalers[] =3D { 1, 4, 16, 64 };
> >         struct tpu_pwm_device *tpd =3D pwm_get_chip_data(pwm);
> >         struct tpu_device *tpu =3D to_tpu_device(chip);
> >         unsigned int prescaler;
> > @@ -254,26 +253,21 @@ static int tpu_pwm_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >         u32 duty;
> >         int ret;
> >
> > -       /*
> > -        * Pick a prescaler to avoid overflowing the counter.
> > -        * TODO: Pick the highest acceptable prescaler.
> > -        */
> >         clk_rate =3D clk_get_rate(tpu->clk);
> >
> > -       for (prescaler =3D 0; prescaler < ARRAY_SIZE(prescalers); ++pre=
scaler) {
> > -               period =3D clk_rate / prescalers[prescaler]
> > -                      / (NSEC_PER_SEC / period_ns);
> > -               if (period <=3D 0xffff)
> > -                       break;
> > -       }
> > +       period =3D clk_rate / (NSEC_PER_SEC / period_ns);
> > +       if (period >=3D 64 * 0x10000 || period =3D=3D 0)
> > +               return -EINVAL;
> >
> > -       if (prescaler =3D=3D ARRAY_SIZE(prescalers) || period =3D=3D 0)=
 {
> > -               dev_err(&tpu->pdev->dev, "clock rate mismatch\n");
> > -               return -ENOTSUPP;
> > -       }
> > +       if (period < 0x10000)
> > +               prescaler =3D 0;
> > +       else
> > +               prescaler =3D ilog2(period / 0x10000) / 2 + 1;
> > +
> > +       period >>=3D 2 * prescaler;
>=20
> Although the above is correct, I find it hard to read.
> Hence I'd keep a loop, like:
>=20
>     unsigned int prescaler =3D 0;
>     ...
>     while (period > 0x10000) {
>             period >>=3D 2;
>             prescalar++;
>     }
>=20
> This would even save 2 lines of code ;-)

The "hard to read" part is subjective, I understand it just fine. (But I
admit I wouldn't be surprised if I'm the exception here as I do much
math.) I suggest to judge this by looking at the generated code. I'm not
an expert here (no sh toolchain here, no sh asm foo), but my expectation
is that the compiler notices that 1 <=3D period / 0x10000 < 64 and then
the inlined fls code should be simplified such that

	ilog2(period / 0x10000) / 2 + 1

simplifies to something like:

	x =3D period >> 16
	prescaler =3D 4
	if (!(x & 0xf0u)) {
		x <<=3D 4;
		prescaler -=3D 2;
	}
	if (!(x & 0xc0u)) {
		x <<=3D 2;
		prescaler -=3D 1;
	}

which I expect to be more efficient than the loop you suggested.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rxxc7zsmbx3lfz5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJf4AoACgkQwfwUeK3K
7Akxegf9FVKpyeDvfLOgPQva52ItsksegQgHiavhXmb6HBGweFrusK6jNxJ8Ctbl
i1XkmQ23BWY9dqvOOyWNjkVKECOgr5WWJW+w8liw8d8+YZHBaMeVOqJcjvqL2f5K
fMtApPvpkz2dLJ8HAGwmR2HjmN5+2Ot04gTqu0ef2KCkOdUf1xTe6g8ppaljIzm2
DIs8xmsSgD3c7CwWx1G7d138oKdRuyr3/aazpJQ2fodqKYca4rn8JwnVeVfy7485
iOrGGzBxKjkQuATdEjgk3ug5jZ5kBl4aXUOhgUBCD5Cny9nk5VayFpzpY33qHgni
kzjAJqWiCUfpWmeRVAekMfBH34YScQ==
=g5L8
-----END PGP SIGNATURE-----

--rxxc7zsmbx3lfz5x--
