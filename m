Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F79550CD7
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Jun 2022 22:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiFSUD4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 19 Jun 2022 16:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiFSUD4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jun 2022 16:03:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2209CA18F
        for <linux-pwm@vger.kernel.org>; Sun, 19 Jun 2022 13:03:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o319D-00081q-4z; Sun, 19 Jun 2022 22:03:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3196-001Vnm-6i; Sun, 19 Jun 2022 22:03:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3196-00HRXK-L3; Sun, 19 Jun 2022 22:03:44 +0200
Date:   Sun, 19 Jun 2022 22:03:41 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 5/6] pwm: renesas-tpu: Improve maths to compute
 register settings
Message-ID: <20220619200341.7itehcpp6d62rmx7@pengutronix.de>
References: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de>
 <20220420121240.67781-6-u.kleine-koenig@pengutronix.de>
 <CAMuHMdWL=eLbd-U3hjgt9NkyDGQSxC4SfNxdf-odNFGskf1cUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wlsh2thwlccocyns"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWL=eLbd-U3hjgt9NkyDGQSxC4SfNxdf-odNFGskf1cUw@mail.gmail.com>
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


--wlsh2thwlccocyns
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 20, 2022 at 08:08:34PM +0200, Geert Uytterhoeven wrote:
> Hi Uwe,
>=20
> On Wed, Apr 20, 2022 at 2:12 PM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > The newly computed register values are intended to exactly match the
> > previously computed values. The main improvement is that the prescaler
> > is computed without a loop that involves two divisions in each step.
> > This uses the fact, that prescalers[i] =3D 1 << (2 * i).
> >
> > Assuming a moderately smart compiler, the needed number of divisions for
> > the case where the requested period is too big, is reduced from 5 to 2.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Thanks for your patch!
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
> > @@ -254,26 +253,47 @@ static int tpu_pwm_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >         u32 duty;
> >         int ret;
> >
> > +       clk_rate =3D clk_get_rate(tpu->clk);
> > +
> > +       period =3D clk_rate / (NSEC_PER_SEC / period_ns);
> > +
> >         /*
> > -        * Pick a prescaler to avoid overflowing the counter.
> > -        * TODO: Pick the highest acceptable prescaler.
> > +        * Find the minimal prescaler in [0..3] such that
> > +        *
> > +        *      period >> (2 * prescaler) < 0x10000
>=20
> scripts/checkpatch.pl:
> WARNING: please, no space before tabs
>=20
> > +        *
> > +        * This could be calculated using something like:
> > +        *
> > +        *      prescaler =3D max(ilog2(period) / 2, 7) - 7;
>=20
> WARNING: please, no space before tabs
>=20
> The rest LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

@Thierry: Assuming you agree to this patch, too: Should I resend for the
checkpack warning (I'd s/\t/   /), or do you want to fixup at apply
time?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wlsh2thwlccocyns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKvgRsACgkQwfwUeK3K
7AnhKgf/c6v0bpNhb1ql6D+9BuFhCLTm4sYQe6uOU2RYUJ3qj1wlIxCTdx/2O4Rn
9ld4EGdVwcN8NubuLR8l5hEjAiUFVW236mjgGky+n3sA6oU9AKvg7e0e4Bkq0qNi
ELGk6HLzuXJZTKegWlPk/ca+Cq1ob4cqcoPw6WhIxwhyDu+WYqvRsWqsfrIYT+wW
nrZFGLNxNCiMpaltofqD4rH5h5aQ7RZGX5fp1u2XILFtYVb25WEUGDvDEzzQudFr
0QXRnm/i8xacKZBhyAcEkJe30w/dJhLfAzQnFZXa+5YPe1TSpeLdlLIvNt/3IuEs
OOHfL7yIqTLF/xLeVg9edAPXYy4BNg==
=C/K3
-----END PGP SIGNATURE-----

--wlsh2thwlccocyns--
