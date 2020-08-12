Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4E62427C7
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Aug 2020 11:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgHLJko (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Aug 2020 05:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgHLJko (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Aug 2020 05:40:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E1BC06174A
        for <linux-pwm@vger.kernel.org>; Wed, 12 Aug 2020 02:40:44 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k5nFT-00014t-2s; Wed, 12 Aug 2020 11:40:43 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k5nFS-00067Z-AH; Wed, 12 Aug 2020 11:40:42 +0200
Date:   Wed, 12 Aug 2020 11:40:42 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: atmel: Make use of dev_err_probe()
Message-ID: <20200812094042.oqgrkc3laeis6gxa@pengutronix.de>
References: <20200812080259.4431-1-u.kleine-koenig@pengutronix.de>
 <20200812082002.GD4354@dell>
 <20200812083204.kktnid63j6vefsky@pengutronix.de>
 <20200812084751.GE4354@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sgj6g623yav3oqlo"
Content-Disposition: inline
In-Reply-To: <20200812084751.GE4354@dell>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--sgj6g623yav3oqlo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lee,

On Wed, Aug 12, 2020 at 09:47:51AM +0100, Lee Jones wrote:
> On Wed, 12 Aug 2020, Uwe Kleine-K=F6nig wrote:
> > On Wed, Aug 12, 2020 at 09:20:02AM +0100, Lee Jones wrote:
> > > On Wed, 12 Aug 2020, Uwe Kleine-K=F6nig wrote:
> > >=20
> > > > Add an error message for failure points that currently lack a messa=
ge
> > > > and convert dev_err to dev_err_probe() which does the right thing f=
or
> > > > -EPROBE_DEFER. Also slightly simplify the error handling.
> > > >=20
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > >  drivers/pwm/pwm-atmel.c | 24 +++++++++++-------------
> > > >  1 file changed, 11 insertions(+), 13 deletions(-)
> > > >=20
> > > > diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> > > > index 6161e7e3e9ac..aa0b36695dc7 100644
> > > > --- a/drivers/pwm/pwm-atmel.c
> > > > +++ b/drivers/pwm/pwm-atmel.c
> > > > @@ -415,17 +415,18 @@ static int atmel_pwm_probe(struct platform_de=
vice *pdev)
> > > >  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > >  	atmel_pwm->base =3D devm_ioremap_resource(&pdev->dev, res);
> > > >  	if (IS_ERR(atmel_pwm->base))
> > > > -		return PTR_ERR(atmel_pwm->base);
> > > > +		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->base),
> > > > +				     "Failed to remap register space\n");
> > >=20
> > > This is a regression.
> > >=20
> > > devm_ioremap_resource() already emits and error message for !-ENOMEM.
> > >=20
> > > -ENOMEM cases should fail silently.
> >=20
> > ah right. Maybe dev_err_probe() should do this right, too?
>=20
> Maybe, but you're still adding an unnecessary string to the kernel's
> binary.  There was a bit push a little while back to cut down on
> these.

Note I agreed to dropping the error message here. Letting
dev_err_probe() ignore -ENOMEM is an orthogonal thing.
=20
> > > >  	atmel_pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> > > >  	if (IS_ERR(atmel_pwm->clk))
> > > > -		return PTR_ERR(atmel_pwm->clk);
> > > > +		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->clk),
> > > > +				     "Failed to get clock\n");
> > >=20
> > > Isn't dev_err_probe() only useful for drivers handling -EPROBE_DEFER?
> >=20
> > devm_clk_get() might return -EPROBE_DEFER.
>=20
> Perhaps, but the author has chosen not to handle it specifically.

Perhaps, in my book having a probe call fail without an error message is
always annoying. So the main advantage of this commit is not the use of
dev_err_probe(), but that error paths yield some output with an
indication about the reason.

> It's my understanding that dev_err_probe() was designed to simplify
> error handling in .probe() whereas this patch seems to do the polar
> opposite.

Yes, it doesn't get simpler, but it gains a feature and for that uses
dev_err_probe() because open coding it would be still more complex.

> > > >  	ret =3D clk_prepare(atmel_pwm->clk);
> > > > -	if (ret) {
> > > > -		dev_err(&pdev->dev, "failed to prepare PWM clock\n");
> > > > -		return ret;
> > > > -	}
> > > > +	if (ret)
> > > > +		return dev_err_probe(&pdev->dev, ret,
> > > > +				     "Failed to prepare PWM clock\n");
> > >=20
> > > As above.
> >=20
> > I only checked quickly and didn't find an instance where clk_prepare can
> > return -EPROBE_DEFER, but even if it doesn't it works fine.
>=20
> It's still misleading IMHO.  dev_err_probe()'s header details its
> reason for existence.  This seems to be a square peg in a round hole
> scenario.

clk_prepare might not benefit from the EPROBE_DEFER logic in
dev_err_probe(), that's true. But it replaces two statements by a single
one and adds the error code to the error message. So the driver benefits
only for two reasons from the conversion to dev_err_probe() while others
might have three. IMHO still good enough to justify the patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sgj6g623yav3oqlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8zuRcACgkQwfwUeK3K
7An30gf/Q5jN9xchl2GCx7qdoDwyNvmg7Tw4oSpyZbZ7W962uQp0yZhJxvk8sUbm
/jjvL6m/SJ672CNmGyfWcMBMzRGIfnMBWYKdN9sVxAGSUk4RVnkzkmDF3KumB2el
ZWrHla8qaDEQgT/Zp3l0YhuLvCdpGL2axJg+RVPQeZvRWA3vM3zHFj86Z8PBUmB/
WYwEaXQNhaw5DgobZ56UYVzxcFOc3oAY7igkgBAJ3O6R0N8bJIY9f/ukNRXMTzhB
E/uoSLGE+/ueqOafOvCDAC7hRuECj9xEhGk8X0b9/QUEHeNfU4jgU0DaINv0rNDV
kMWf1tyJwNIfiJRGdwtQTZ0tnHZigA==
=yR0J
-----END PGP SIGNATURE-----

--sgj6g623yav3oqlo--
