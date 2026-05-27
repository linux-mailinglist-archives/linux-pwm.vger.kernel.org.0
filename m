Return-Path: <linux-pwm+bounces-9184-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAnuHGo0F2rd7wcAu9opvQ
	(envelope-from <linux-pwm+bounces-9184-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 20:14:02 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A07F95E8CAA
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 20:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E82C301F5EA
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 18:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72964611E8;
	Wed, 27 May 2026 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFnJL65Q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7DB45106F;
	Wed, 27 May 2026 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905247; cv=none; b=LmBEqxtx98NwNZEctG1WYgFuci/bRnc9uWoBQgyQbuvsRg/QWgYE7K4DFRKCbc3OYrvf/vwVKdXamdbRGMGDS3sTJAf6aUvPYjuI95kZei3H3Eqf+hAsE+EBPLg2WagZF24rl9ljp8yUYRIoXEjLkArW/oACBi3kvpSzEuS9BE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905247; c=relaxed/simple;
	bh=51XUH+sK+SN+nlFz1dl2LW9JG/fpI4iMqLjIsM4rzis=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddL4MyCOKuMXadpqvssRDfsTJ+JO5kJbkFKTFEWHWF9rpPU0Toiz5glMgjb9gXP/TLexQH0lmA9MWYWMz29UvLuySl1mFFMeXss3u8rv2FQclO9Q4yNjqGqZY4BTW6fEB9BVVIb7tRpw5RVpoj75ktHk1GXSKyOo8RZBv5wwLGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFnJL65Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D0B1F000E9;
	Wed, 27 May 2026 18:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905246;
	bh=uDOrhsrRdh6+Yf4xP8K2rk2l3PA3yjLH3cn4K7gp9PA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FFnJL65QyL7vCdq1lNbCKXeys4pP8qgnwtz2ENCtMKNGFAnWbgQefBIPzTalqB4p9
	 69ef482ntqIYaFaBTjK8Ri/DpQoH9Fy7+RSfCzMoem1CEcqeIZ8lrec/lXxHHusrOo
	 bmv/CH8JwbO/dzbCPqXgnmDpE43UelMOdfmwaow5EKUrispJz7NJ9HAQU1RM2K/Kqo
	 ufxgqiINv2CBItOHypvEG/7YLhhyz3tda9+w6zG/PMM7RYqVozGf6HLP+glFuRYdv5
	 Dk8Fe+Y753hMil5u/TeSa6iaVKy/mmkh6yD1qfHzd2kfiTp5ABjUWxiKUAkJw7iOoy
	 2yT/TIG/xAscw==
Date: Wed, 27 May 2026 19:07:13 +0100
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
Subject: Re: [PATCH v13 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <20260527190713.1cba1e89@jic23-huawei>
In-Reply-To: <20260525-ad4692-multichannel-sar-adc-driver-v13-2-1b7626d3b35c@analog.com>
References: <20260525-ad4692-multichannel-sar-adc-driver-v13-0-1b7626d3b35c@analog.com>
	<20260525-ad4692-multichannel-sar-adc-driver-v13-2-1b7626d3b35c@analog.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9184-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,analog.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A07F95E8CAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 13:10:11 +0300
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

As Sashiko notes this doesn't quite correspond to the code which deasserts
then sleeps.  The comments in the code make it obvious that was intended
so this commit description probably just needs an update.

I guess you probably already saw and fixed this.

> a software reset via SPI_CONFIG_A is used as fallback when no reset
> GPIO is provided.
>=20
> Accumulator channel masking for single-shot reads uses ACC_MASK_REG via
> an ADDR_DESCENDING SPI write, which covers both mask bytes in a single
> 16-bit transfer.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

Otherwise, just one question inline.

> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> new file mode 100644
> index 000000000000..cc1e2ef6bfd8
> --- /dev/null
> +++ b/drivers/iio/adc/ad4691.c


> +
> +static bool ad4691_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case AD4691_STATUS_REG:
> +	case AD4691_CLAMP_STATUS1_REG:
> +	case AD4691_CLAMP_STATUS2_REG:
> +	case AD4691_GPIO_READ:
> +	case AD4691_ACC_STATUS_FULL1_REG ... AD4691_ACC_STATUS_SAT2_REG:
> +	case AD4691_ACC_SAT_OVR_REG(0) ... AD4691_ACC_SAT_OVR_REG(15):
> +		return true;
> +	default:
> +		break;
> +	}
> +
> +	/*
> +	 * Multi-byte registers have non-unit strides; only accept base
> +	 * addresses to prevent debugfs from triggering reads that cross
> +	 * register boundaries.
What does this have to do with preventing debugfs from doing anything.
It should allow reading of volatile registers. Why is it not enough to
make the non base aligned registers neither readable nor writeable?

> +	 */
> +	if (reg >=3D AD4691_AVG_IN(0) && reg <=3D AD4691_AVG_IN(15))
> +		return (reg - AD4691_AVG_IN(0)) % 2 =3D=3D 0;
> +	if (reg >=3D AD4691_AVG_STS_IN(0) && reg <=3D AD4691_AVG_STS_IN(15))
> +		return (reg - AD4691_AVG_STS_IN(0)) % 3 =3D=3D 0;
> +	if (reg >=3D AD4691_ACC_IN(0) && reg <=3D AD4691_ACC_IN(15))
> +		return (reg - AD4691_ACC_IN(0)) % 3 =3D=3D 0;
> +	if (reg >=3D AD4691_ACC_STS_DATA(0) && reg <=3D AD4691_ACC_STS_DATA(15))
> +		return (reg - AD4691_ACC_STS_DATA(0)) % 4 =3D=3D 0;
> +
> +	return false;
> +}
> +
> +static bool ad4691_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_SAT_OVR_REG(15):
> +	case AD4691_STD_SEQ_CONFIG:
> +		return true;
> +	default:
> +		break;
> +	}
> +
> +	/* Multi-byte registers: only accept base addresses (see volatile_reg).=
 */
> +	if (reg >=3D AD4691_AVG_IN(0) && reg <=3D AD4691_AVG_IN(15))
> +		return (reg - AD4691_AVG_IN(0)) % 2 =3D=3D 0;
> +	if (reg >=3D AD4691_AVG_STS_IN(0) && reg <=3D AD4691_AVG_STS_IN(15))
> +		return (reg - AD4691_AVG_STS_IN(0)) % 3 =3D=3D 0;
> +	if (reg >=3D AD4691_ACC_IN(0) && reg <=3D AD4691_ACC_IN(15))
> +		return (reg - AD4691_ACC_IN(0)) % 3 =3D=3D 0;
> +	if (reg >=3D AD4691_ACC_STS_DATA(0) && reg <=3D AD4691_ACC_STS_DATA(15))
> +		return (reg - AD4691_ACC_STS_DATA(0)) % 4 =3D=3D 0;
> +
> +	return false;
> +}

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
> +	} else {
> +		/* No hardware reset available, fall back to software reset. */
> +		ret =3D regmap_write(st->regmap, AD4691_SPI_CONFIG_A_REG,
> +				   AD4691_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Wait 300 =C2=B5s (Table 5) for the device to complete its internal r=
eset
> +	 * sequence before accepting SPI commands.
> +	 */
> +	fsleep(300);
This is what sashiko was moaning about.

> +	return 0;
> +}



