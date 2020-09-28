Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DEF27B4FD
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Sep 2020 21:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgI1TGj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Sep 2020 15:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgI1TGj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Sep 2020 15:06:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBB7C061755
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2020 12:06:39 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kMyTt-0006hA-Hp; Mon, 28 Sep 2020 21:06:37 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kMyTs-00058T-BI; Mon, 28 Sep 2020 21:06:36 +0200
Date:   Mon, 28 Sep 2020 21:06:36 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, michal.vokac@ysoft.com,
        kernel@pengutronix.de, Anson.Huang@nxp.com, lee.jones@linaro.org,
        s.hauer@pengutronix.de, thierry.reding@gmail.com,
        linux-imx@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        l.majewski@majess.pl, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/5] pwm: imx27: fix disable state for inverted PWMs
Message-ID: <20200928190636.dcqpy5ghvcurv6i6@pengutronix.de>
References: <20200925155330.32301-1-m.felsch@pengutronix.de>
 <20200925155330.32301-5-m.felsch@pengutronix.de>
 <20200928074736.l63eecosjbyrcewe@pengutronix.de>
 <20200928095230.GU29466@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="urrnhkxsxgrvm6kh"
Content-Disposition: inline
In-Reply-To: <20200928095230.GU29466@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--urrnhkxsxgrvm6kh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2020 at 11:52:30AM +0200, Marco Felsch wrote:
> On 20-09-28 09:47, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Fri, Sep 25, 2020 at 05:53:29PM +0200, Marco Felsch wrote:
> > > Up to now disabling the PWM is done using the PWMCR.EN register bit.
> > > Setting this bit to zero results in the output pin driving a low value
> > > independent of the polarity setting (PWMCR.POUTC).
> > >=20
> > > There is only little documentation about expectations and requirements
> > > in the PWM framework but the usual expectation seems to be that
> > > disabling a PWM together with setting .duty_cycle =3D 0 results in the
> > > output driving the inactive level. The pwm-bl driver for example uses
> > > this setting to disable the backlight and with the pwm-imx27 driver
> > > this results in an enabled backlight if the pwm signal is inverted.
> >=20
> > This sounds as if the pwm-imx27 behaviour is a reason to believe that
> > .duty_cycle =3D 0 + .enabled =3D false should drive the inactive level.
>=20
> That was what you suggested in v1.
>=20
> > I'd write:
> > 	The pwm-bl driver for example uses this setting to disable the
> > 	backlight. Up to now however, this request makes the pwm-imx27
> > 	enable the backlight if the PWM signal is inverted.
>=20
> I don't wanna but a specific user (pwm-bl driver) into the commit
> message since this assumes that this fix is only needed because
> of the pwm-bl driver.

I think this is fine because for lack of definitive documentation
looking at the expectations of consumers is the only source we have to
somewhat justify what the lowlevel driver is expected to do. And if I
understood you correctly the pwm-bl driver is the one that the problems
surfaced with, isn't it?

> > > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > > index 3b6bcd8d58b7..07c6a263a39c 100644
> > > --- a/drivers/pwm/pwm-imx27.c
> > > +++ b/drivers/pwm/pwm-imx27.c
> > > @@ -141,12 +141,9 @@ static void pwm_imx27_get_state(struct pwm_chip =
*chip,
> > >  	if (ret < 0)
> > >  		return;
> > > =20
> > > -	val =3D readl(imx->mmio_base + MX3_PWMCR);
> > > +	state->enabled =3D imx->enabled;
> > > =20
> > > -	if (val & MX3_PWMCR_EN)
> > > -		state->enabled =3D true;
> > > -	else
> > > -		state->enabled =3D false;
> > > +	val =3D readl(imx->mmio_base + MX3_PWMCR);
> >=20
> > I'm not a big fan. IMHO the driver should report about reality and the
> > framework (and maybe the consumers) should be able to handle that
> > .get_state() reports
> >=20
> > 	.enabled =3D true
> > 	.duty_cycle =3D 0
> >=20
> > after
> >=20
> > 	.enabled =3D false
> >=20
> > was requested.
>=20
> So your suggestions will spam the pwm user with the ugly details?
> IMHO the framework should abstract this since it is a nasty HW detail
> the pwm user should not take care off.

So we're on one line here.

> > >  	switch (FIELD_GET(MX3_PWMCR_POUTC, val)) {
> > >  	case MX3_PWMCR_POUTC_NORMAL:
> > > @@ -169,8 +166,8 @@ static void pwm_imx27_get_state(struct pwm_chip *=
chip,
> > >  	state->period =3D DIV_ROUND_UP_ULL(tmp, pwm_clk);
> > > =20
> > >  	/*
> > > -	 * PWMSAR can be read only if PWM is enabled. If the PWM is disable=
d,
> > > -	 * use the cached value.
> > > +	 * Use the cached value if the PWM is disabled since we are using t=
he
> > > +	 * PWMSAR to disable the PWM (see the notes in pwm_imx27_apply())
> > >  	 */
> > >  	if (state->enabled)
> > >  		val =3D readl(imx->mmio_base + MX3_PWMSAR);
> > > @@ -199,8 +196,8 @@ static void pwm_imx27_sw_reset(struct pwm_imx27_c=
hip *imx, struct device *dev)
> > >  		dev_warn(dev, "software reset timeout\n");
> > >  }
> > > =20
> > > -static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
> > > -				     struct pwm_device *pwm)
> > > +static int pwm_imx27_get_fifo_slot(struct pwm_chip *chip,
> > > +				   struct pwm_device *pwm)
> > >  {
> > >  	struct pwm_imx27_chip *imx =3D to_pwm_imx27_chip(chip);
> > >  	struct device *dev =3D chip->dev;
> > > @@ -216,9 +213,13 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_=
chip *chip,
> > >  		msleep(period_ms);
> > > =20
> > >  		sr =3D readl(imx->mmio_base + MX3_PWMSR);
> > > -		if (fifoav =3D=3D FIELD_GET(MX3_PWMSR_FIFOAV, sr))
> > > +		if (fifoav =3D=3D FIELD_GET(MX3_PWMSR_FIFOAV, sr)) {
> > >  			dev_warn(dev, "there is no free FIFO slot\n");
> > > +			return -EBUSY;
> > > +		}
> > >  	}
> > > +
> > > +	return fifoav;
> > >  }
> > > =20
> > >  static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device =
*pwm,
> > > @@ -257,16 +258,25 @@ static int pwm_imx27_apply(struct pwm_chip *chi=
p, struct pwm_device *pwm,
> > >  	else
> > >  		period_cycles =3D 0;
> > > =20
> > > +	/* Wait for a free FIFO slot */
> > > +	ret =3D pwm_imx27_get_fifo_slot(chip, pwm);
> > > +	if (ret < 0)
> > > +		goto out;
> > > +
> > >  	/*
> > > -	 * Wait for a free FIFO slot if the PWM is already enabled, and flu=
sh
> > > -	 * the FIFO if the PWM was disabled and is about to be enabled.
> > > +	 * We can't use the enable bit to control the en-/disable squence
> > > +	 * correctly because the output pin is pulled low if setting this b=
it
> > > +	 * to '0' regardless of the poutc value. Instead we have to use the
> > > +	 * sample register. According the RM:
> >=20
> > According to the reference manual:
>=20
> K.
>=20
> > > +	 * A value of zero in the sample register will result in the PWMO o=
utput
> > > +	 * signal always being low/high (POUTC =3D 00 it will be low and
> > > +	 * POUTC =3D 01 it will be high), and no output waveform will be pr=
oduced.
> > > +	 * If the value in this register is higher than the PERIOD
> >=20
> > Did you forget to insert the end of this sentence here?
>=20
> Ups, thanks for covering that.
>=20
> >=20
> > >  	 */
> > > -	if (imx->enabled)
> > > -		pwm_imx27_wait_fifo_slot(chip, pwm);
> > > +	if (state->enabled)
> > > +		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > >  	else
> > > -		pwm_imx27_sw_reset(imx, chip->dev);
> > > -
> > > -	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > > +		writel(0, imx->mmio_base + MX3_PWMSAR);
> > >  	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> >=20
> > I think you can simplify the code a bit using the following idiom:
> >=20
> > 	/*=20
> > 	 * comment as above
> > 	 */
> > =09
> > 	if (!state->enabled)
> > 		duty_cycle =3D 0;
> >=20
> > 	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>=20
> I don't think so because this will throw aways the duty_cycle. What
> should happen if the user disable the pwm by: state->enable =3D false and
> enable it later again e.g. if you configure the pwm from the sysfs?

sysfs caches the value anyhow and so do most consumers. Also duty_cycle
is a local variable here only. (That's at least what I assumed writing
the above snippet.)

> My assumption is that the previouse set duty-cycle should be applied
> which isn't possible with your solution.
>=20
> > With the change from the next patch I could also imagine to write a
> > smaller period in the !enabled case. The upside would be that the second
> > call in:
> >=20
> > 	pwm_apply(mypwm, { .enabled =3D false, .period =3D 3s });
> > 	pwm_apply(mypwm, { .enabled =3D true, ... });
> >=20
> > wouldn't take longer than a second in the average case.
>=20
> Sorry I don't get this.

The first call configures the PWM with .duty_cycle =3D 3s and the second
call then waits until a period is completed (doesn't it?) So completing
the 2nd command takes up to 3 seconds and 1.5 seconds on average. Before
your patch the second command was done instantanious.

> > @Thierry, we really need to agree on the expected behaviour in these
> > cases and document them.
>=20
> +1
>=20
> > >  	/*
> > > @@ -276,15 +286,10 @@ static int pwm_imx27_apply(struct pwm_chip *chi=
p, struct pwm_device *pwm,
> > >  	imx->duty_cycle =3D duty_cycles;
> > > =20
> > >  	cr =3D MX3_PWMCR_PRESCALER_SET(prescale);
> > > -
> > >  	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> > > -		cr |=3D FIELD_PREP(MX3_PWMCR_POUTC,
> > > -				MX3_PWMCR_POUTC_INVERTED);
> > > -
> > > -	if (state->enabled)
> > > -		cr |=3D MX3_PWMCR_EN;
> > > +		cr |=3D FIELD_PREP(MX3_PWMCR_POUTC, MX3_PWMCR_POUTC_INVERTED);
> > > =20
> > > -	mask =3D MX3_PWMCR_PRESCALER | MX3_PWMCR_POUTC | MX3_PWMCR_EN;
> > > +	mask =3D MX3_PWMCR_PRESCALER | MX3_PWMCR_POUTC;
> > > =20
> > >  	pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, cr);
> > > =20
> > > @@ -373,10 +378,13 @@ static int pwm_imx27_probe(struct platform_devi=
ce *pdev)
> > >  	if (!(pwmcr & MX3_PWMCR_EN)) {
> > >  		pwm_imx27_sw_reset(imx, &pdev->dev);
> > >  		mask =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> > > -		       MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC;
> > > +		       MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC | MX3_PWMCR_POUTC |
> > > +		       MX3_PWMCR_EN;
> > >  		pwmcr =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> > >  			MX3_PWMCR_DBGEN |
> > > -			FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH);
> > > +			FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
> > > +			FIELD_PREP(MX3_PWMCR_POUTC, MX3_PWMCR_POUTC_OFF) |
> > > +			MX3_PWMCR_EN;
> > >  		pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
> > >  		pwm_imx27_clk_disable_unprepare(imx);
> > >  	} else {
> > > @@ -385,6 +393,7 @@ static int pwm_imx27_probe(struct platform_device=
 *pdev)
> > >  		pwmcr =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> > >  			MX3_PWMCR_DBGEN;
> > >  		pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
> > > +		imx->enabled =3D true;
> > >  	}
> > > =20
> > >  	return pwmchip_add(&imx->chip);
> > > @@ -392,11 +401,22 @@ static int pwm_imx27_probe(struct platform_devi=
ce *pdev)
> > > =20
> > >  static int pwm_imx27_remove(struct platform_device *pdev)
> > >  {
> > > -	struct pwm_imx27_chip *imx;
> > > +	struct pwm_imx27_chip *imx =3D platform_get_drvdata(pdev);
> > > +	int ret;
> > > =20
> > > -	imx =3D platform_get_drvdata(pdev);
> > > +	ret =3D pwm_imx27_clk_prepare_enable(imx);
> > > +	if (ret)
> > > +		return ret;
> > > =20
> > > -	return pwmchip_remove(&imx->chip);
> > > +	ret =3D pwmchip_remove(&imx->chip);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Ensure module is disabled after remove */
> > > +	pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, MX3_PWMCR_EN, 0);
> > > +	pwm_imx27_clk_disable_unprepare(imx);
> >=20
> > This is wrong. You are supposed to assume the PWM is already off in
> > .remove and don't touch it.
>=20
> Nope it isn't. The hardware is still running after the remove call since
> we don't enable/disable the HW anymore by toggling the PWMCR.EN bit. So
> we need to do it here.

Ah ok, there are now two different "off"s. Anyhow, I oppose to modify
the hardware state in .remove(). There are (I think) corner cases like
the backlight should remain on during reboot to show logs (or a splash
screen).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--urrnhkxsxgrvm6kh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9yNDkACgkQwfwUeK3K
7Al1lwgAkAizHk2jLJjZotTY+GzT1CuWpCGd7Vt8VrDctHH5PpQaE8CPlql+Dq9V
Pn1cUGeFQyTpNTVQUl9Y/iz/8tpTbfw6+KZIVeyvGoqUGZ+0h3v/IlfVY5iJl+Vs
Lw1FhRFZsBuqoNlJU1ZJnfTBAClv4/YWdyrq+V5dXmNKRaMt02yAmiJYCiHTsoKy
x4yyDW2P6VJBiHGRq8A1u1WT+Qu/UMIHYLam4G2F3yciuiljKQ5U2ufC+KoR4rfQ
Y7lV1Q3QMJXcv2+mDbF6TtUty4VKdHJUPbJMguNqjB0VHnFcB3f1j9W5grdm7BN9
9vDD7usCNhxEnoUnCrHB0WpEZ0OuIg==
=bvIx
-----END PGP SIGNATURE-----

--urrnhkxsxgrvm6kh--
