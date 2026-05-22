Return-Path: <linux-pwm+bounces-9080-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJumObU/EGrzVAYAu9opvQ
	(envelope-from <linux-pwm+bounces-9080-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 13:36:21 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC175B3177
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 13:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21917300CE97
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 11:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2663E8688;
	Fri, 22 May 2026 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd/nszY9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A947636B07B;
	Fri, 22 May 2026 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449752; cv=none; b=nZ0amjM93PyMsWVgI9EAwnpv0uzgSF8uCLpkMjt1ccVx6MWhg+yhiYhL1JVhakKW2MSwkH4pBo/8zSmJMoq7Q4UlWjR9rIffC4RoCd4HEXebJB7bZiJnu9vi3M/EjzgCSMHwMnFdgrm8iHR1vKLQjaHU/VIVdRbMf4Jx2xYnisA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449752; c=relaxed/simple;
	bh=dhK9LwkTVSg5ClC7s36E3nT62pjq9DRrRLj8t34gf1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmh8cpyxOh9vzweli6xzn96BXEXxKrfGbQ3HUc9zW6iGAiGKCG9XPMvOhv7sO3hPabEsqMO6Mlai3acx+rPpvTHl13tsTnh0tJD64jAgnGCpTSbxodqKhtgJkQJHLsHn+di1NwgenYJD7wPTKNTrpdOxhClemjijy0bZate0gjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd/nszY9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7520C1F00A3D;
	Fri, 22 May 2026 11:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779449751;
	bh=uQ24BeckYia2HpQtla0uiDaMZ5DsfBUVq5bUePbJKtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Vd/nszY9OghrxXxo67VGf9mX4htr93FLvnBaxgptt4KpSnh+1f7Z0eWigVIQVXucj
	 tVI4bVOKunBhg2tUthXTMDUW6luepsZiwFRLWU/AU2AaGrSAfmjo3iYJJLbzkN2Yxy
	 jJsxUkhXchDCRUpPbr1eYxBHn5C0uGB//K0BRK6W33nGlydNHyvrzBekW7FfTEZSEZ
	 ghzO8ZeDFqEd/XxUYsvQL9lv/2scpt0CogkBPN32B+Mvkp9DJy2NBQSn34tnEi30se
	 PXBsmto29z8cK7zuMdBVGEAyiXdXx9kY8nOZqxdRiXUngCuKOhhgaXuOnqkgvrw/3c
	 WE2vrZzaZuXxQ==
Date: Fri, 22 May 2026 12:35:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v12 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <20260522123542.0425f2b1@jic23-huawei>
In-Reply-To: <20260519-ad4692-multichannel-sar-adc-driver-v12-2-5b335162aa51@analog.com>
References: <20260519-ad4692-multichannel-sar-adc-driver-v12-0-5b335162aa51@analog.com>
	<20260519-ad4692-multichannel-sar-adc-driver-v12-2-5b335162aa51@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9080-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,baylibre.com:email]
X-Rspamd-Queue-Id: BBC175B3177
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 15:20:23 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
>=20
> Add support for the Analog Devices AD4691 family of high-speed,
> low-power multichannel SAR ADCs: AD4691 (16-ch, 500 kSPS),
> AD4692 (16-ch, 1 MSPS), AD4693 (8-ch, 500 kSPS) and
> AD4694 (8-ch, 1 MSPS).
>=20
> The driver implements a custom regmap layer over raw SPI to handle the
> device's mixed 1/2/3/4-byte register widths and uses the standard IIO
> read_raw/write_raw interface for single-channel reads.
>=20
> The chip idles in Autonomous Mode so that single-shot read_raw can use
> the internal oscillator without disturbing the hardware configuration.
>=20
> Three voltage supply domains are managed: avdd (required), vio, and a
> reference supply on either the REF pin (ref-supply, external buffer)
> or the REFIN pin (refin-supply, uses the on-chip reference buffer;
> REFBUF_EN is set accordingly). Hardware reset is performed by asserting
> the reset-gpios GPIO line for at least 300 =C2=B5s then deasserting it;
> a software reset via SPI_CONFIG_A is used as fallback when no reset
> GPIO is provided.
>=20
> Accumulator channel masking for single-shot reads uses ACC_MASK_REG via
> an ADDR_DESCENDING SPI write, which covers both mask bytes in a single
> 16-bit transfer.
>=20
> IIO_CHAN_INFO_SAMP_FREQ is exposed as info_mask_separate. The oscillator
> is shared hardware =E2=80=94 writing any channel's sampling_frequency att=
ribute
> sets it for all others =E2=80=94 but per-channel attributes are used thro=
ughout
> the series to avoid an ABI change when per-channel oversampling ratios
> are introduced in a later commit, at which point the effective output
> rate (osc_freq / osr[N]) becomes genuinely per-channel.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

One really small thing given you mention you'll be doing a v13.

> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> new file mode 100644
> index 000000000000..2d58df862142
> --- /dev/null
> +++ b/drivers/iio/adc/ad4691.c



> +static int ad4691_reset(struct ad4691_state *st)
> +{
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	struct reset_control *rst;
> +	int ret;
> +
> +	rst =3D devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset\n");
> +
> +	if (rst) {
> +		/*
> +		 * Assert the reset line to guarantee a clean reset pulse on
> +		 * every probe, including driver reloads where the line may
> +		 * already be deasserted (reset_control_put() does not
> +		 * re-assert on release). tRESETL (minimum pulse width) =3D 10 ns
> +		 * (Table 5); kernel function-call overhead alone exceeds this,
> +		 * so no explicit delay is needed between assert and deassert.
> +		 */
> +		reset_control_assert(rst);
> +		ret =3D reset_control_deassert(rst);
> +		if (ret)
> +			return ret;

Really trivial but seems like this could be refactored to share the sleep=20
code + perhaps more usefully the comment.



	} else {
		/* No hardware reset available, fall back to software reset. */
		ret =3D regmap_write(st->regmap, AD4691_SPI_CONFIG_A_REG, AD4691_SW_RESET=
);
		if (ret)
			return ret;
	}
	/*
	 * Wait tHWR =3D 300 =C2=B5s (Table 5) for the device to complete its
	 * internal reset sequence before accepting SPI commands.
	 */
	fsleep(300);

	return 0;
}
> +		/*
> +		 * Wait tHWR =3D 300 =C2=B5s (Table 5) for the device to complete its
> +		 * internal reset sequence before accepting SPI commands.
> +		 */
> +		fsleep(300);
> +		return 0;
> +	}
> +
> +	/* No hardware reset available, fall back to software reset. */
> +	ret =3D regmap_write(st->regmap, AD4691_SPI_CONFIG_A_REG, AD4691_SW_RES=
ET);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Wait tSWR =3D 300 =C2=B5s (Table 5) for the device to complete its
> +	 * internal reset sequence before accepting SPI commands.
> +	 */
> +	fsleep(300);
> +	return 0;
> +}


