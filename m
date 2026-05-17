Return-Path: <linux-pwm+bounces-8928-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGrFGBqsCWookgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8928-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 13:52:58 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D11DE560D7C
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 13:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99410300331F
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 11:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16D0361DAB;
	Sun, 17 May 2026 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guB9BX1m"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB221336892;
	Sun, 17 May 2026 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779018775; cv=none; b=scGJm9V8LYcUQOjQyhAncU5eA+146jcisMFxFR4yhwE/DqBo/oXz7NT+6weDrKSZ8mF1MLEC4bKpqWeSEPXaxUXS0XNHaHzQMMFzirLflP0LU+WNVYrquKFLH/o+kyod0Kc4UAAjb1++oaWj6TBTQssFdy2enUm2phgadAfSjNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779018775; c=relaxed/simple;
	bh=AeFvKizQvGmW/aHGo5/kVhgV5UAz94LJEdekn7rilrE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qq9GRq4MFqaUnpVGPXt8fCPFrJqRL8vytsRSNRgbVUoqto0i81yYCUPG6f0/h3FpfKnnGB+oqPceEitVtIIhgdlHSqrt+IG3s6iUn9hrthamKtwiuU4PVmvMVjyzlo7K0X4y2vAZVwtdjEYgNsH3hWSTDfs1/Bvj6pdbPq+qkXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guB9BX1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2836C2BCB0;
	Sun, 17 May 2026 11:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779018775;
	bh=AeFvKizQvGmW/aHGo5/kVhgV5UAz94LJEdekn7rilrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=guB9BX1mFgWxscvcGORKUtSPLxcP7xPnwDgyds8tMlqmIwBdL8s7finopkNvXMAhm
	 GB4h61CbkR54Yqb/bTovr9c3fiIX8AKcaQQwwvRhr/dkj39rUrbut1pFPVPMga03kE
	 BGBRRz5sHbhITJvcj7kUR5xJ4Z9gq5kgm1tZqe7AyD1+i1OJjDrb/45/lpbgz9KYs9
	 kxDNoS8GBZFC+U4Z3OF/3CG6oBT8c0Cly5N3BrxoktjR0/GUPLCCem9YLcvoNwDJIG
	 J6rpTVROoLSgAIdqj03io+JvA4Jbr/tj6+uBZVzJSMGhF0okFX5HGUTiNx05R6XcvU
	 SLAqfGkdsmcVg==
Date: Sun, 17 May 2026 12:52:41 +0100
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
Subject: Re: [PATCH v11 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <20260517125241.7dbfb964@jic23-huawei>
In-Reply-To: <20260515-ad4692-multichannel-sar-adc-driver-v11-2-eab27d852ac2@analog.com>
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
	<20260515-ad4692-multichannel-sar-adc-driver-v11-2-eab27d852ac2@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D11DE560D7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8928-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email,baylibre.com:email,sashiko.dev:url]
X-Rspamd-Action: no action

On Fri, 15 May 2026 16:31:31 +0300
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
> REFBUF_EN is set accordingly). Hardware reset is performed via
> the reset controller framework; a software reset through SPI_CONFIG_A
> is used as fallback when no hardware reset is available.
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

Just to make sure it's not missed, one sashiko comment referenced below.
I agree with it that no sleep after coming out of reset is unusual. Not
impossible I suppose, but needs a comment.

> +static int ad4691_reset(struct ad4691_state *st)
> +{
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	struct reset_control *rst;
> +
> +	rst =3D devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset\n");
> +
> +	if (rst) {
> +		/*
> +		 * Assert the reset line before sleeping to guarantee a proper
> +		 * reset pulse on every probe, including driver reloads where
> +		 * the line may already be deasserted (reset_control_put() does
> +		 * not re-assert on release).
> +		 * devm_reset_control_get_optional_exclusive_deasserted() cannot
> +		 * be used because it deasserts immediately without delay; the
> +		 * datasheet (Table 5) requires a =E2=89=A5300 =C2=B5s reset pulse wid=
th
> +		 * before deassertion.
> +		 */
> +		reset_control_assert(rst);
> +		fsleep(300);
> +		return reset_control_deassert(rst);
Sashiko makes the reasonable point that we'd kind of expect some time betwe=
en
that pin dropping the device out of reset and it being able to respond.  If=
 it
really is that quick - then add a comment.

https://sashiko.dev/#/patchset/20260515-ad4692-multichannel-sar-adc-driver-=
v11-0-eab27d852ac2%40analog.com
> +	}
> +
> +	/* No hardware reset available, fall back to software reset. */
> +	return regmap_write(st->regmap, AD4691_SPI_CONFIG_A_REG,
> +			    AD4691_SW_RESET);
Same applies here.

> +}

