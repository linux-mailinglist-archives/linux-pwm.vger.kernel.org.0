Return-Path: <linux-pwm+bounces-2033-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C43E8AA0AF
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Apr 2024 19:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F341C20F65
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Apr 2024 17:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4224211CA0;
	Thu, 18 Apr 2024 17:04:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7A0171085
	for <linux-pwm@vger.kernel.org>; Thu, 18 Apr 2024 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459841; cv=none; b=LypBmtuTi10+Hnb2XZtS2CnMysJw5JpndKilBd/VW+Zk9JwaB/oc8AirRBYDg4CDp5EJ8NGRnHe+0gjWJjJhz0/GlPolNxQHpgx9m97ocjUbjkoUwkIxmL8tY1vg1BILpyJE2XytTbSl/iUUz+cBCNlLuDUD9MCzno9sGgRVb2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459841; c=relaxed/simple;
	bh=tA59HgmDi75BVQlxUyyOR016EoNBqveQpHmqG6lx9+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ag0YVOMw/97NQW3e43dAf2O1EICWn5b74ZqBe8kcDHHN3e8N5gr9tt1mXYyxB01v0g7E0IG2qeyl0uD+oguW9Dj4SntQy5uBk8JrHw3OetcDWmcc1pHpkuR0EbnHFItsT7360OR9DXyGrsuuhMdD0UthZ75258kQtAVWp5GvWOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rxVAu-0000X0-Ib; Thu, 18 Apr 2024 19:03:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rxVAt-00D0rU-3L; Thu, 18 Apr 2024 19:03:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rxVAt-003aAG-03;
	Thu, 18 Apr 2024 19:03:51 +0200
Date: Thu, 18 Apr 2024 19:03:50 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v19 3/4] pwm: Add support for RZ/G2L GPT
Message-ID: <xy7qcimczmqyzk2zvysr3mdkzl3m54cjvh2pxx4d42dc7atyvs@itbq2jr4ghmo>
References: <20240315143558.221340-1-biju.das.jz@bp.renesas.com>
 <20240315143558.221340-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ko23r2bd7do3ltuy"
Content-Disposition: inline
In-Reply-To: <20240315143558.221340-4-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--ko23r2bd7do3ltuy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Biju,

thanks for your patience. I'm quite behind on my review tasks.

On Fri, Mar 15, 2024 at 02:35:57PM +0000, Biju Das wrote:
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> new file mode 100644
> index 000000000000..8c88f5d536fc
> --- /dev/null
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -0,0 +1,542 @@
> [...]
> +static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *rzg2l_gpt,
> +			    struct pwm_device *pwm)
> +{
> +	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> +	u32 val =3D RZG2L_GTIOR_GTIOx(sub_ch) | RZG2L_GTIOR_OxE(sub_ch);
> +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +
> +	/* Enable pin output */
> +	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR, val,
> +			 RZG2L_GTIOR_GTIOx_OUT_HI_END_TOGGLE_CMP_MATCH(sub_ch));

That doesn't need protection by the lock?

> +	mutex_lock(&rzg2l_gpt->lock);
> +	if (!rzg2l_gpt->enable_count[ch])
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, 0, RZG2L_GTCR_CST);
> +
> +	rzg2l_gpt->enable_count[ch]++;
> +	mutex_unlock(&rzg2l_gpt->lock);
> +
> +	return 0;
> +}
> +
> +static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
> +			      struct pwm_device *pwm)
> +{
> +	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +
> +	/* Disable pin output */
> +	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR, RZG2L_GTIOR_OxE(sub_ch)=
, 0);
> +
> +	/* Stop count, Output low on GTIOCx pin when counting stops */
> +	mutex_lock(&rzg2l_gpt->lock);
> +	/* Don't decrement, if ch_en_bits is set by the probe */
> +	if (!test_bit(pwm->hwpwm, rzg2l_gpt->ch_en_bits))
> +		rzg2l_gpt->enable_count[ch]--;

I don't get the reason why this is skipped if ch_en_bits is set.

> +	if (!rzg2l_gpt->enable_count[ch])
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_CST, 0);
> +
> +	mutex_unlock(&rzg2l_gpt->lock);
> +
> +	/*
> +	 * Probe() set these bits, if pwm is enabled by bootloader. In such
> +	 * case, clearing the bits will avoid errors during unbind.
> +	 */
> +	if (test_bit(pwm->hwpwm, rzg2l_gpt->ch_en_bits))
> +		clear_bit(pwm->hwpwm, rzg2l_gpt->ch_en_bits);
> +}
> +
> +static u64 calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt, u3=
2 val, u8 prescale)
> +{
> +	u64 tmp;
> +

	/* This cannot overflow because ... */

> +	tmp =3D (u64)val << (2 * prescale);
> +	tmp *=3D USEC_PER_SEC;
> +
> +	return DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate_khz);
> +}
> +
> [...]
> +static int rzg2l_gpt_probe(struct platform_device *pdev)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt;
> +	struct device *dev =3D &pdev->dev;
> +	struct pwm_chip *chip;
> +	unsigned long rate;
> +	struct clk *clk;
> +	int ret;
> +	u32 i;
> +
> +	chip =3D devm_pwmchip_alloc(dev, RZG2L_MAX_PWM_CHANNELS, sizeof(*rzg2l_=
gpt));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +
> +	rzg2l_gpt->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rzg2l_gpt->mmio))
> +		return PTR_ERR(rzg2l_gpt->mmio);
> +
> +	rzg2l_gpt->rstc =3D devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(rzg2l_gpt->rstc))
> +		return dev_err_probe(dev, PTR_ERR(rzg2l_gpt->rstc),
> +				     "get reset failed\n");
> +
> +	clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "cannot get clock\n");
> +
> +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot deassert reset control\n");
> +
> +	pm_runtime_enable(dev);
> +	ret =3D pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		goto err_reset;
> +
> +	ret =3D devm_clk_rate_exclusive_get(dev, clk);
> +	if (ret)
> +		goto err_pm_put;
> +
> +	rate =3D clk_get_rate(clk);
> +	if (!rate) {
> +		ret =3D dev_err_probe(dev, -EINVAL, "gpt clk rate is 0");
> +		goto err_pm_put;
> +	}
> +
> +	/*
> +	 * Refuse clk rates > 1 GHz to prevent overflow later for computing
> +	 * period and duty cycle.
> +	 */
> +	if (rate > NSEC_PER_SEC) {
> +		ret =3D dev_err_probe(dev, -EINVAL, "gpt clk rate is > 1GHz");
> +		goto err_pm_put;
> +	}
> +
> +	/*
> +	 * Rate is in MHz and is always integer for peripheral clk
> +	 * 2^32 * 2^10 (prescalar) * 10^6 (rate_khz) < 2^64
> +	 * So make sure rate is multiple of 1000.
> +	 */
> +	rzg2l_gpt->rate_khz =3D rate / KILO;
> +	if (rzg2l_gpt->rate_khz * KILO !=3D rate) {
> +		ret =3D dev_err_probe(dev, -EINVAL, "rate is not multiple of 1000");
> +		goto err_pm_put;
> +	}
> +
> +	rzg2l_gpt->max_val =3D div64_u64((u64)U32_MAX * USEC_PER_SEC,
> +				       rzg2l_gpt->rate_khz) * RZG2L_MAX_SCALE_FACTOR;
> +
> +	/*
> +	 *  We need to keep the clock on, in case the bootloader has enabled the
> +	 *  PWM and is running during probe().
> +	 */
> +	for (i =3D 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
> +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, i)) {
> +			set_bit(i, rzg2l_gpt->ch_en_bits);

The tracking of which channels were enabled by the bootloader is more
extensive than that of other drivers. (That's good from a correctness
point of view.) I consider doing something like:

	for (i =3D 0; i < npwm; ++i) {
		pwm =3D &chip->pwm[i];

		pwm->state =3D { 0, };

		ret =3D chip->ops->get_state(chip, pwm, &state);
		if (!ret && state->enabled)
			chip->ops->apply(chip, pwm, &state);
	}

(with some more error checking) in pwmchip_register(). That should get
the usage count's right, but would (maybe?) conflict with your handling
here. Anyhow, that's orthogonal to this patch for now (and needs some
more thoughs. For example it might not be a good idea to call
=2Eget_state() and .apply() without request before. Also it might
not work for chips that cannot be disabled in hardware).

Back to your patch: Maybe call .ch_en_bits .bootloader_enabled_channels
instead? Also I think this could be simplified (but not entirely sure I
grabbed all the details, so take this with a grain of salt):

 - In .probe() set .bootloader_enabled_channels[i] if pwm#i is enabled and
   ensure it stays on.

 - In .apply() replace the code that is supposed to enable the HW by:

	if (...->bootloader_enabled_channels[i]) {
		/*
		 * it's already be on. Instead of reenabling in hardware
		 * just take over from the bootloader
		 */
		...->bootloader_enabled_channels[i] =3D 0;
	} else {
		enable_hw();
		... get pm_runtime reference etc.
	}

 - in .remove():

 	for (i =3D 0; i < npwm; ++i) {
		if (...->bootloader_enabled_channels[i]) {

			... drop pm_runtime reference, but don't disable HW

		}
	}

Does that make sense? Did I miss anything?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ko23r2bd7do3ltuy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYhUnUACgkQj4D7WH0S
/k7T/gf9Gzz1XkVw/rllZVQfN6hWapj+4FT/y7YNgAkr0Zo5kh51DrlXtZgG6xGB
Q5r0P+aQ9E9NZfpcCT/at17pmNvxQVlW7l9ulNsHViD/K/hDiKalQIFB7womjCN5
XtuDqe8dR8I9AzfNrPURsRn4Lvbf2McoaQuUfT6mCzjw9BMNMgqrpeGbvZ/yQBf9
2vTj66S6lB2ypw3Qx6P72At8NiUsalGXGTLzOJ/U4gs+jcfQpvsx1Ku3Sstes0cg
pmfYCQ9edmcjMjPo9hnEOjXPjw2r8UupV/q8WaJ/IpShyzQyEvldH3TUB9UZOYQu
Lp4J/UYfE2HA0ozebScY2V8ZOIm6Ng==
=2ixr
-----END PGP SIGNATURE-----

--ko23r2bd7do3ltuy--

