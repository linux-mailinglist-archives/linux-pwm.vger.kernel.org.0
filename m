Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C393AABD1
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Jun 2021 08:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhFQG1K (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Jun 2021 02:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhFQG1J (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Jun 2021 02:27:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265DEC061574
        for <linux-pwm@vger.kernel.org>; Wed, 16 Jun 2021 23:25:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ltlSO-00076O-Nv; Thu, 17 Jun 2021 08:24:52 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ltlSL-00006j-Qc; Thu, 17 Jun 2021 08:24:49 +0200
Date:   Thu, 17 Jun 2021 08:24:49 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/bridge: ti-sn65dsi86: Implement the pwm_chip
Message-ID: <20210617062449.qwsjcpkyiwzdyfi3@pengutronix.de>
References: <20210615231828.835164-1-bjorn.andersson@linaro.org>
 <20210615231828.835164-2-bjorn.andersson@linaro.org>
 <20210616075637.jtoa25uyhnqkctlu@pengutronix.de>
 <YMq/6VhXrYJoTVnj@yoga>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rypnjiyukthypn2v"
Content-Disposition: inline
In-Reply-To: <YMq/6VhXrYJoTVnj@yoga>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--rypnjiyukthypn2v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bjorn,

On Wed, Jun 16, 2021 at 10:22:17PM -0500, Bjorn Andersson wrote:
> > > +static int ti_sn_pwm_apply(struct pwm_chip *chip, struct pwm_device =
*pwm,
> > > +			   const struct pwm_state *state)
> > > +{
> > > +	struct ti_sn65dsi86 *pdata =3D pwm_chip_to_ti_sn_bridge(chip);
> > > +	unsigned int pwm_en_inv;
> > > +	unsigned int backlight;
> > > +	unsigned int pre_div;
> > > +	unsigned int scale;
> > > +	int ret;
> > > +
> > > +	if (!pdata->pwm_enabled) {
> > > +		ret =3D pm_runtime_get_sync(pdata->dev);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +
> > > +		ret =3D regmap_update_bits(pdata->regmap, SN_GPIO_CTRL_REG,
> > > +				SN_GPIO_MUX_MASK << (2 * SN_PWM_GPIO_IDX),
> > > +				SN_GPIO_MUX_SPECIAL << (2 * SN_PWM_GPIO_IDX));
> > > +		if (ret) {
> > > +			dev_err(pdata->dev, "failed to mux in PWM function\n");
> > > +			goto out;
> > > +		}
> >=20
> > Do you need to do this even if state->enabled is false?
>=20
> I presume I should be able to explicitly mux in the GPIO function and
> configure that to output low. But I am not able to find anything in the
> data sheet that would indicate this to be preferred.

My question targetted a different case. If the PWM is off
(!pdata->pwm_enabled) and should remain off (state->enabled is false)
you can shortcut here, can you not?

> > Does this already modify the output pin?
>=20
> Yes, coming out of reset this pin is configured as input, so switching
> the mux here will effectively start driving the pin.

So please document this in the format the recently added drivers do,
too. See e.g. drivers/pwm/pwm-sifive.c. (The idea is to start that with
" * Limitations:" to make it easy to grep it.)

> > Lets continue the above example with the fixed calculation. So we have:
> >=20
> > 	pdata->pwm_refclk_freq =3D 3333334
> > 	state->period =3D 100000 [ns]
> > 	state->duty_cycle =3D 600
> > 	scale =3D 332
> >=20
> > so the actually emitted period =3D 99899.98002000399 ns
> >=20
> > Now you calculate:
> >=20
> > 	backlight =3D 1
> >=20
> > which yields an actual duty_cycle of 299.99994 ns, with backlight =3D 2
> > you would get an actual duty_cycle of 599.99988 ns, which is better. The
> > culprit here is that you divide by state->period but instead should
> > divide by the actual period.
>=20
> What do I do about the case where the actual period is lower than the
> requested one and thereby the duty cycle becomes larger than the period?

The general principle is: Pick the biggest possible duty_cycle available
for the just picked period. So in your example you have to clamp it to
period (assuming you can, otherwise pick the next lower possible value).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rypnjiyukthypn2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDK6q4ACgkQwfwUeK3K
7AmDTgf/UlzZ2Xa/kAdIRPNpMBYWUe1Lthwd6eoy2Phb9QLF9+d/GZxP/VCAa7om
1pKtQDCcd9Aj6JmwNT0Hj9cSva1cNOrWopMMhKsqln6wMDdR5JUJX0fA4r5W3G1T
FYNRtaFhYoIBo5uOpi2pS+9hsb4tgolYOej/MHOoN/+5O4ZRdRPYDiHrQF2RGqGo
FaYFQf3gUot7KvoNdibtcreIpdDPzewvC5r3TzNEb/oT7nCUSviz1g/DmNybiEOn
vjU0kyVCpKU+wQOEBm9LNE5MFmSA1hK2QP6B8DDcUh0Jzc+p5XhIbyD2FnZR7+Id
1IGFura69aq9zInspYRFL+NY/LuI0g==
=cOkb
-----END PGP SIGNATURE-----

--rypnjiyukthypn2v--
