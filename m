Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536B32031E8
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jun 2020 10:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgFVIS1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Jun 2020 04:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgFVIS1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Jun 2020 04:18:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1875C061795
        for <linux-pwm@vger.kernel.org>; Mon, 22 Jun 2020 01:18:25 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jnHel-0004I1-8V; Mon, 22 Jun 2020 10:18:19 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jnHeU-0003pu-F0; Mon, 22 Jun 2020 10:18:02 +0200
Date:   Mon, 22 Jun 2020 10:18:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>, linux-rtc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        allen <allen.chen@ite.com.tw>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH 06/10] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Message-ID: <20200622081802.pv4xmb7vn4te5r5t@taurus.defre.kleine-koenig.org>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
 <20200620224222.1312520-5-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7tfyuhyp2zipmowo"
Content-Disposition: inline
In-Reply-To: <20200620224222.1312520-5-j.neuschaefer@gmx.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7tfyuhyp2zipmowo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Jun 21, 2020 at 12:42:17AM +0200, Jonathan Neusch=E4fer wrote:
> The Netronix EC provides a PWM output, which is used for the backlight

s/,//

> on ebook readers. This patches adds a driver for the PWM output.

on *some* ebook readers


> +#define NTXEC_UNK_A		0xa1
> +#define NTXEC_UNK_B		0xa2
> +#define NTXEC_ENABLE		0xa3
> +#define NTXEC_PERIOD_LOW	0xa4
> +#define NTXEC_PERIOD_HIGH	0xa5
> +#define NTXEC_DUTY_LOW		0xa6
> +#define NTXEC_DUTY_HIGH		0xa7
> +
> +/*
> + * The time base used in the EC is 8MHz, or 125ns. Period and duty cycle=
 are
> + * measured in this unit.
> + */
> +static int ntxec_pwm_config(struct pwm_chip *chip, struct pwm_device *pw=
m_dev,
> +				 int duty_ns, int period_ns)
> +{
> +	struct ntxec_pwm *pwm =3D pwmchip_to_pwm(chip);
> +	uint64_t duty =3D duty_ns;
> +	uint64_t period =3D period_ns;

As you cannot use values bigger than 8191999 anyhow, I wonder why you
use a 64 bit type here.

> +	int res =3D 0;
> +
> +	do_div(period, 125);

Please use a define instead of plain 125.

> +	if (period > 0xffff) {
> +		dev_warn(pwm->dev,
> +			 "Period is not representable in 16 bits: %llu\n", period);
> +		return -ERANGE;
> +	}
> +
> +	do_div(duty, 125);
> +	if (duty > 0xffff) {
> +		dev_warn(pwm->dev, "Duty cycle is not representable in 16 bits: %llu\n=
",
> +			duty);
> +		return -ERANGE;
> +	}

This check isn't necessary as the pwm core ensures that duty <=3D period.

> +	res |=3D ntxec_write8(pwm->ec, NTXEC_PERIOD_HIGH, period >> 8);
> +	res |=3D ntxec_write8(pwm->ec, NTXEC_PERIOD_LOW, period);
> +	res |=3D ntxec_write8(pwm->ec, NTXEC_DUTY_HIGH, duty >> 8);
> +	res |=3D ntxec_write8(pwm->ec, NTXEC_DUTY_LOW, duty);

Does this complete the currently running period? Can it happen that a
new period starts between the first and the last write and so a mixed
period can be seen at the output?

> +
> +	return (res < 0) ? -EIO : 0;
> +}
> +
> +static int ntxec_pwm_enable(struct pwm_chip *chip,
> +				 struct pwm_device *pwm_dev)
> +{
> +	struct ntxec_pwm *pwm =3D pwmchip_to_pwm(chip);
> +
> +	return ntxec_write8(pwm->ec, NTXEC_ENABLE, 1);
> +}
> +
> +static void ntxec_pwm_disable(struct pwm_chip *chip,
> +				   struct pwm_device *pwm_dev)
> +{
> +	struct ntxec_pwm *pwm =3D pwmchip_to_pwm(chip);
> +
> +	ntxec_write8(pwm->ec, NTXEC_ENABLE, 0);
> +}
> +
> +static struct pwm_ops ntxec_pwm_ops =3D {
> +	.config		=3D ntxec_pwm_config,
> +	.enable		=3D ntxec_pwm_enable,
> +	.disable	=3D ntxec_pwm_disable,
> +	.owner		=3D THIS_MODULE,

Please don't align the =3D, just a single space before them is fine.
More important: Please implement .apply() (and .get_state()) instead of
the old API. Also please enable PWM_DEBUG which might save us a review
iteration.

> +};
> +
> +static int ntxec_pwm_probe(struct platform_device *pdev)
> +{
> +	struct ntxec *ec =3D dev_get_drvdata(pdev->dev.parent);
> +	struct ntxec_pwm *pwm;
> +	struct pwm_chip *chip;
> +	int res;
> +
> +	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	pwm->ec =3D ec;
> +	pwm->dev =3D &pdev->dev;
> +
> +	chip =3D &pwm->chip;
> +	chip->dev =3D &pdev->dev;
> +	chip->ops =3D &ntxec_pwm_ops;
> +	chip->base =3D -1;
> +	chip->npwm =3D 1;
> +
> +	res =3D pwmchip_add(chip);
> +	if (res < 0)
> +		return res;
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	res |=3D ntxec_write8(pwm->ec, NTXEC_ENABLE, 0);
> +	res |=3D ntxec_write8(pwm->ec, NTXEC_UNK_A, 0xff);
> +	res |=3D ntxec_write8(pwm->ec, NTXEC_UNK_B, 0xff);
> +
> +	return (res < 0) ? -EIO : 0;

This is broken for several reasons:

 - You're not supposed to modify the output in .probe
 - if ntxec_write8 results in an error you keep the pwm registered.
 - From the moment on pwmchip_add returns the callbacks can be called.
   The calls to ntxec_write8 probably interfere here.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7tfyuhyp2zipmowo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7waTcACgkQwfwUeK3K
7Alz9gf8C+9A/FPfdyoWF4DcZ7zjNKarHze44XtL4sUIkJfLYl9xqKr+/YjB9EYr
6Z/sukeRDw5Gn0DZo0kgntYx5TcLztsQxB7TFVhO6cj25+uzwnJwumN4DQxJlOqY
u30aZH1IyFoG2PTDKyCnOrxrWGnK2VsUqV5t5g8RgIUIJysGaMtUgiwvyggtXvKv
jMLcjm5QBnrsU56rkZYJGiXtcz+L6lGF7rd1cXWPR3nfgXngWPEBe/NjnqChsfsy
VRF8nb6G46xF7c58IARrMRiH43wLcHLhtKvIStC17t5on0FbfuL3jFMT1wylV+E5
lZ9Y/VFroSxQX6EARBDDa2E/J38PSg==
=eoxM
-----END PGP SIGNATURE-----

--7tfyuhyp2zipmowo--
