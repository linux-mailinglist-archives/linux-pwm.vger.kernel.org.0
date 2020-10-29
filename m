Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EF429F3E8
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Oct 2020 19:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgJ2SOC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Oct 2020 14:14:02 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:36326 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgJ2SOB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Oct 2020 14:14:01 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D080F1C0B7A; Thu, 29 Oct 2020 19:13:57 +0100 (CET)
Date:   Thu, 29 Oct 2020 19:13:57 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 2/4] leds: Add driver for Qualcomm LPG
Message-ID: <20201029181357.GE26053@duo.ucw.cz>
References: <20201021201224.3430546-1-bjorn.andersson@linaro.org>
 <20201021201224.3430546-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TD8GDToEDw0WLGOL"
Content-Disposition: inline
In-Reply-To: <20201021201224.3430546-3-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> PMICs from Qualcomm. It can operate on fixed parameters or based on a
> lookup-table, altering the duty cycle over time - which provides the
> means for e.g. hardware assisted transitions of LED brightness.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>=20
> Changes since v5:
> - Make sure to not used the state of the last channel in a group to deter=
mine
>   if the current sink should be active for all channels in the group.
> - Replacement of unsigned -1 with UINT_MAX
> - Work around potential overflow by using larger data types, instead of s=
eparate code paths
> - Use cpu_to_l16() rather than hand rolling them
> - Minor style cleanups
>=20
>  drivers/leds/Kconfig         |    9 +
>  drivers/leds/Makefile        |    1 +
>  drivers/leds/leds-qcom-lpg.c | 1190 ++++++++++++++++++++++++++++++++++
>  3 files changed, 1200 insertions(+)
>  create mode 100644 drivers/leds/leds-qcom-lpg.c

Let's put this into drivers/leds/rgb/. You may need to create it.


> +static int lpg_lut_store(struct lpg *lpg, struct led_pattern *pattern,
> +			 size_t len, unsigned int *lo_idx, unsigned int *hi_idx)
> +{
> +	unsigned int idx;
> +	__le16 val;

No need for __XX variants outside of headers meant for userspace.

> +#define LPG_ENABLE_GLITCH_REMOVAL	BIT(5)
> +
> +static void lpg_enable_glitch(struct lpg_channel *chan)
> +{
> +	struct lpg *lpg =3D chan->lpg;
> +
> +	regmap_update_bits(lpg->map, chan->base + PWM_TYPE_CONFIG_REG,
> +			   LPG_ENABLE_GLITCH_REMOVAL, 0);
> +}
> +
> +static void lpg_disable_glitch(struct lpg_channel *chan)
> +{
> +	struct lpg *lpg =3D chan->lpg;
> +
> +	regmap_update_bits(lpg->map, chan->base + PWM_TYPE_CONFIG_REG,
> +			   LPG_ENABLE_GLITCH_REMOVAL,
> +			   LPG_ENABLE_GLITCH_REMOVAL);
> +}

Helper functions for single register write is kind of overkill...

> +static int lpg_blink_set(struct lpg_led *led,
> +			 unsigned long delay_on, unsigned long delay_off)
> +{
> +	struct lpg_channel *chan;
> +	unsigned int period_us;
> +	unsigned int duty_us;
> +	int i;
> +
> +	if (!delay_on && !delay_off) {
> +		delay_on =3D 500;
> +		delay_off =3D 500;
> +	}

Aren't you supposed to modify the values passed to you, so that
userspace knows what the default rate is?


> +	ret =3D lpg_lut_store(lpg, pattern, len, &lo_idx, &hi_idx);
> +	if (ret < 0)
> +		goto out;

Just do direct return.

> +out:
> +	return ret;
> +}

> +static const struct pwm_ops lpg_pwm_ops =3D {
> +	.request =3D lpg_pwm_request,
> +	.apply =3D lpg_pwm_apply,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int lpg_add_pwm(struct lpg *lpg)
> +{
> +	int ret;
> +
> +	lpg->pwm.base =3D -1;
> +	lpg->pwm.dev =3D lpg->dev;
> +	lpg->pwm.npwm =3D lpg->num_channels;
> +	lpg->pwm.ops =3D &lpg_pwm_ops;
> +
> +	ret =3D pwmchip_add(&lpg->pwm);
> +	if (ret)
> +		dev_err(lpg->dev, "failed to add PWM chip: ret %d\n", ret);
> +
> +	return ret;
> +}

Do we need to do this? I'd rather have LED driver, than LED+PWM
driver...

Best regards,
							Pavel
--=20
http://www.livejournal.com/~pavelmachek

--TD8GDToEDw0WLGOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX5sGZQAKCRAw5/Bqldv6
8jjrAJ4guFpAcsPC95xJrR4r3t4uMKbBGACgpj6Cfs0rkR02mKrJQpcllvY1vwU=
=QegQ
-----END PGP SIGNATURE-----

--TD8GDToEDw0WLGOL--
