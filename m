Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DD228DC7F
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Oct 2020 11:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgJNJOg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Oct 2020 05:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbgJNJOg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Oct 2020 05:14:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC90EC051109
        for <linux-pwm@vger.kernel.org>; Tue, 13 Oct 2020 23:49:16 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSab2-0004WE-Ds; Wed, 14 Oct 2020 08:49:12 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSab0-00047U-Gx; Wed, 14 Oct 2020 08:49:10 +0200
Date:   Wed, 14 Oct 2020 08:49:10 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     vijayakannan.ayyathurai@intel.com
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v11 1/2] pwm: Add PWM driver for Intel Keem Bay
Message-ID: <20201014064910.jwb664re6frsqd5a@pengutronix.de>
References: <cover.1602612067.git.vijayakannan.ayyathurai@intel.com>
 <d5312c9bef22f4439deb27a00d0bf51d7a2b92c6.1602612067.git.vijayakannan.ayyathurai@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yx43rknoeurrq3mn"
Content-Disposition: inline
In-Reply-To: <d5312c9bef22f4439deb27a00d0bf51d7a2b92c6.1602612067.git.vijayakannan.ayyathurai@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yx43rknoeurrq3mn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

sorry, I still found a problem that I want to have addressed. I'll point
out a few minor things en passant.

But after that I really have a good feeling and like the driver now.

On Wed, Oct 14, 2020 at 02:14:12AM +0800, vijayakannan.ayyathurai@intel.com=
 wrote:
> +static void keembay_pwm_get_state(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> +				  struct pwm_state *state)
> +{
> +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> +	unsigned long long pwm_h_count, pwm_l_count;
> +	unsigned long clk_rate;
> +	u32 buff;
> +
> +	clk_rate =3D clk_get_rate(priv->clk);
> +
> +	/* Read channel enabled status */
> +	buff =3D readl(priv->base + KMB_PWM_LEADIN_OFFSET(pwm->hwpwm));
> +	if (buff & KMB_PWM_EN_BIT)
> +		state->enabled =3D true;
> +	else
> +		state->enabled =3D false;
> +
> +	/* Read period and duty cycle */
> +	buff =3D readl(priv->base + KMB_PWM_HIGHLOW_OFFSET(pwm->hwpwm));
> +	pwm_l_count =3D FIELD_GET(KMB_PWM_LOW_MASK, buff) * NSEC_PER_SEC;
> +	pwm_h_count =3D FIELD_GET(KMB_PWM_HIGH_MASK, buff) * NSEC_PER_SEC;

<minor nit>: The variable names are not optimal. I'd use "highlow"
instead of "buff". pwm_l_count would be appropriate for
FIELD_GET(KMB_PWM_LOW_MASK, buff); when multiplied with NSEC_PER_SEC
it's not really matching. Maybe just use "low"?! (and "high" instead of
pwm_h_count)

> +	state->duty_cycle =3D DIV_ROUND_UP_ULL(pwm_h_count, clk_rate);
> +	state->period =3D DIV_ROUND_UP_ULL(pwm_h_count + pwm_l_count, clk_rate);

state->polarity =3D PWM_POLARITY_NORMAL; (That's the important bit here.)

> +}
> +
> +static int keembay_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state)
> +{
> +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> +	struct pwm_state current_state;
> +	u16 pwm_h_count, pwm_l_count;
> +	unsigned long long div;
> +	unsigned long clk_rate;
> +	u32 pwm_count =3D 0;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -ENOSYS;
> +
> +	keembay_pwm_update_bits(priv, KMB_PWM_LEADIN_MASK, 0,
> +				KMB_PWM_LEADIN_OFFSET(pwm->hwpwm));

A comment describing the effect of this register would be great.

> +	keembay_pwm_get_state(chip, pwm, &current_state);
> +
> +	if (!state->enabled) {
> +		if (current_state.enabled)
> +			keembay_pwm_disable(priv, pwm->hwpwm);
> +		return 0;
> +	}
> +
> [...]

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yx43rknoeurrq3mn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+Gn2MACgkQwfwUeK3K
7Al7xgf/XG+s4p97S6RCv1PhTDpBnQxQnC4jQPqNrY33kMyI6UP8yqp/jGPHMvHU
1XZwZh+KFm1j29gxuGgHVJZhWPK/O53aRlQKOMINkMgPZrp0hP/OiTJDqURm2L5E
fOfB5+pGcYD1JLf2MSUKlA4ri0Bu0l4Zc4EG+cCLgfkezr1jqWDtXl4waYrRCmII
atFpiWbQJRvQmBh2yw7Oj8bfahAmKr+z/oMJ71L2fc3qD/dYaxcWh747cNo/95Bx
Q3OF2pqyGYVd+aW9EQT8iEx0J8TJxDbJT232LqMridF+r4h+5j9Y64QRxhXvkjTe
cJKFkQHJCfTOlLLjBXSwRiIVZO3mig==
=0nEz
-----END PGP SIGNATURE-----

--yx43rknoeurrq3mn--
