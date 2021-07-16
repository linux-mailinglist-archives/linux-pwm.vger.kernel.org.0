Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766203CB340
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Jul 2021 09:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbhGPHdc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Jul 2021 03:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbhGPHdb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Jul 2021 03:33:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B96CC061760
        for <linux-pwm@vger.kernel.org>; Fri, 16 Jul 2021 00:30:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m4IIs-0007em-PY; Fri, 16 Jul 2021 09:30:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m4IIr-0000BU-Ge; Fri, 16 Jul 2021 09:30:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m4IIr-0000F8-Fc; Fri, 16 Jul 2021 09:30:33 +0200
Date:   Fri, 16 Jul 2021 09:30:30 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-tegra@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v1 5/6] pwm: tegra: Implement .apply callback
Message-ID: <20210716073030.dzhs5j5rrnrdke4u@pengutronix.de>
References: <20210617095145.163694-1-u.kleine-koenig@pengutronix.de>
 <20210617095145.163694-6-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wqhoozubkymm3btz"
Content-Disposition: inline
In-Reply-To: <20210617095145.163694-6-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wqhoozubkymm3btz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jun 17, 2021 at 11:51:44AM +0200, Uwe Kleine-K=F6nig wrote:
> To ease review this reuses the formerly implemented callbacks.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-tegra.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 11a10b575ace..1161c6323e60 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -227,10 +227,36 @@ static void tegra_pwm_disable(struct pwm_chip *chip=
, struct pwm_device *pwm)
>  	clk_disable_unprepare(pc->clk);
>  }
> =20
> +static int tegra_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> +{
> +	int err;
> +
> +	if (state->polarity !=3D PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		if (pwm->state.enabled)
> +			tegra_pwm_disable(chip, pwm);
> +		return 0;
> +	}
> +
> +	if (state->period !=3D pwm->state.period ||
> +	    state->duty_cycle !=3D pwm->state.duty_cycle) {
> +		err =3D tegra_pwm_config(pwm->chip, pwm, (int)state->duty_cycle,
> +				       (int)state->period);

This patch has the same problem as my other apply conversions. I'll have
to rework that before it is safe to take this.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wqhoozubkymm3btz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDxNZQACgkQwfwUeK3K
7AmPWwgAlG6AdvlG6Y0jsvJJVeS4w3eT+Gb/mQf33rgcc38vAlRwX7nUSQnqlV05
WEbQjd6DIfL0lcG1ESu2uXTmS0HbGd4AgojhO8kpYlyzz3RnQyCpOzh+gQOprBpS
KVl+zUFtZgk0X9kIeO1uld8DVhz4wyKEuQ3CYREO1ra0IibmXvv9EweacPTG43Gc
/hde+0gmB9UuDiqK2ah6y8HsTzr5eJL9FHloJHKgZxESZUV48+yfFLVzaj6HF6vF
DChIGzMSAjud+L54C0IBlco0rhCS1muRyKeO4Q1mozNhBFgtSP71fEOvj1sfdLtr
V5ShDEGZsB+XIcYBeabOexzplszQOw==
=RYJO
-----END PGP SIGNATURE-----

--wqhoozubkymm3btz--
