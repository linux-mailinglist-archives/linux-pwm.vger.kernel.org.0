Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E565EEE20
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Sep 2022 08:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbiI2Gz4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Sep 2022 02:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbiI2Gzy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Sep 2022 02:55:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0C510B582
        for <linux-pwm@vger.kernel.org>; Wed, 28 Sep 2022 23:55:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1odnSN-0007ad-HW; Thu, 29 Sep 2022 08:55:39 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1odnSJ-003Yiv-PN; Thu, 29 Sep 2022 08:55:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1odnSH-004JPt-Gz; Thu, 29 Sep 2022 08:55:33 +0200
Date:   Thu, 29 Sep 2022 08:55:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        kernel@pengutronix.de, Neil Armstrong <narmstrong@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Douglas Anderson <dianders@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-gpio@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Robert Foss <robert.foss@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-leds@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/3] pwm: Change prototype of .get_state() callback to
 return an error
Message-ID: <20220929065532.n3kc44zimshufe4c@pengutronix.de>
References: <20220916151506.298488-1-u.kleine-koenig@pengutronix.de>
 <YzRCvGNpWXKyO/PE@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6w6u3nfxl4bcy3e3"
Content-Disposition: inline
In-Reply-To: <YzRCvGNpWXKyO/PE@orome>
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


--6w6u3nfxl4bcy3e3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 28, 2022 at 02:49:00PM +0200, Thierry Reding wrote:
> On Fri, Sep 16, 2022 at 05:15:04PM +0200, Uwe Kleine-K=F6nig wrote:
> [...]
> > diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
> > index 7b357d1cf642..811e6f424927 100644
> > --- a/drivers/pwm/pwm-crc.c
> > +++ b/drivers/pwm/pwm-crc.c
> > @@ -121,8 +121,8 @@ static int crc_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
> >  	return 0;
> >  }
> > =20
> > -static void crc_pwm_get_state(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> > -			      struct pwm_state *state)
> > +static int crc_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> > +			     struct pwm_state *state)
> >  {
> >  	struct crystalcove_pwm *crc_pwm =3D to_crc_pwm(chip);
> >  	struct device *dev =3D crc_pwm->chip.dev;
> > @@ -132,13 +132,13 @@ static void crc_pwm_get_state(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> >  	error =3D regmap_read(crc_pwm->regmap, PWM0_CLK_DIV, &clk_div_reg);
> >  	if (error) {
> >  		dev_err(dev, "Error reading PWM0_CLK_DIV %d\n", error);
> > -		return;
> > +		return -EIO;
> >  	}
> > =20
> >  	error =3D regmap_read(crc_pwm->regmap, PWM0_DUTY_CYCLE, &duty_cycle_r=
eg);
> >  	if (error) {
> >  		dev_err(dev, "Error reading PWM0_DUTY_CYCLE %d\n", error);
> > -		return;
> > +		return -EIO;
> >  	}
>=20
> In other drivers you propagate errors from regmap_read(), why not here?

Oh, this is indeed wrong and should be "return error".

>=20
> > diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> > index 7004f55bbf11..aa06b3ce81a6 100644
> > --- a/drivers/pwm/pwm-sprd.c
> > +++ b/drivers/pwm/pwm-sprd.c
> > @@ -65,8 +65,8 @@ static void sprd_pwm_write(struct sprd_pwm_chip *spc,=
 u32 hwid,
> >  	writel_relaxed(val, spc->base + offset);
> >  }
> > =20
> > -static void sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> > -			       struct pwm_state *state)
> > +static int sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> > +			      struct pwm_state *state)
> >  {
> >  	struct sprd_pwm_chip *spc =3D
> >  		container_of(chip, struct sprd_pwm_chip, chip);
> > @@ -80,11 +80,8 @@ static void sprd_pwm_get_state(struct pwm_chip *chip=
, struct pwm_device *pwm,
> >  	 * reading to the registers.
> >  	 */
> >  	ret =3D clk_bulk_prepare_enable(SPRD_PWM_CHN_CLKS_NUM, chn->clks);
> > -	if (ret) {
> > -		dev_err(spc->dev, "failed to enable pwm%u clocks\n",
> > -			pwm->hwpwm);
>=20
> This might be useful information, so perhaps leave it in?

Ok, I don't like .get_state emitting an error, but agreed, that's an
orthogonal issue that shouldn't be addressed en passant in this change.

> [...]
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index c8445b0a3339..ead909400e64 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -108,9 +108,9 @@ static inline void sun4i_pwm_writel(struct sun4i_pw=
m_chip *chip,
> >  	writel(val, chip->base + offset);
> >  }
> > =20
> > -static void sun4i_pwm_get_state(struct pwm_chip *chip,
> > -				struct pwm_device *pwm,
> > -				struct pwm_state *state)
> > +static int sun4i_pwm_get_state(struct pwm_chip *chip,
> > +			       struct pwm_device *pwm,
> > +			       struct pwm_state *state)
> >  {
> >  	struct sun4i_pwm_chip *sun4i_pwm =3D to_sun4i_pwm_chip(chip);
> >  	u64 clk_rate, tmp;
> > @@ -132,7 +132,7 @@ static void sun4i_pwm_get_state(struct pwm_chip *ch=
ip,
> >  		state->duty_cycle =3D DIV_ROUND_UP_ULL(state->period, 2);
> >  		state->polarity =3D PWM_POLARITY_NORMAL;
> >  		state->enabled =3D true;
> > -		return;
> > +		return 0;
> >  	}
> > =20
> >  	if ((PWM_REG_PRESCAL(val, pwm->hwpwm) =3D=3D PWM_PRESCAL_MASK) &&
> > @@ -142,7 +142,8 @@ static void sun4i_pwm_get_state(struct pwm_chip *ch=
ip,
> >  		prescaler =3D prescaler_table[PWM_REG_PRESCAL(val, pwm->hwpwm)];
> > =20
> >  	if (prescaler =3D=3D 0)
> > -		return;
> > +		/* huh? is this an error? */
> > +		return 0;
>=20
> Yeah, I think this would count as an error. The prescaler value returned
> from that table is 0 in what seems to be "invalid" configurations. If
> you look at how this is used in sun4i_pwm_calculate(), these entries are
> skipped for the computation of the duty cycle. So I would expect this to
> happen in either an invalidly configured or completely unconfigured PWM.
>=20
> That raises the question about what to do in these cases. If we return
> an error, that could potentially throw off consumers. So perhaps the
> closest would be to return a disabled PWM? Or perhaps it'd be up to the
> consumer to provide some fallback configuration for invalidly configured
> or unconfigured PWMs.

This is something I'd address on the framework level. i.e. don't care in
the lowlevel driver about setting .enabled =3D false (or whatever we
choose to do) but care for that in drivers/pwm/core.c.

Note that the status quo is that if that error happens the consumer sees
whatever state the lowlevel driver stored in pwm->state, without an
error indication.

Will send a v2.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6w6u3nfxl4bcy3e3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmM1QWEACgkQwfwUeK3K
7AnVsgf+Ldl2tUGY9LFOCK2ERWS85VthgpwLbNMQlzHq7y/5oI2/DogWTP3xDZ8y
Bbxo+AhFrbHTizo5c7SgHrWIAb1G2I+tHmJbBym+oZd6Tx33aS+8gHsha4WWRjm3
OVZuFQnivYrgRyIbihT8CpeEOH+vyfo7vQHQeYE/8+YtgODsiSdu2TRWSkzhaXCC
iTtNUPhvbn8iMRSciSYaUAMS4LwmACM+GVQ0+zAQUFMwbMKQiGgsq9We527pOFCT
RkxTVKHr7hWaB92iSuDcIC2FLOeQfTKKwXHWCjuqef+OPnLhpuXsSbVHvDlqdwTa
V/JINGn/9VpPyw25hZ/WAqlEr/10MA==
=CHS4
-----END PGP SIGNATURE-----

--6w6u3nfxl4bcy3e3--
