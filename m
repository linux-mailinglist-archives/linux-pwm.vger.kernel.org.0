Return-Path: <linux-pwm+bounces-8929-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qi04Jx6xCWrglQQAu9opvQ
	(envelope-from <linux-pwm+bounces-8929-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 14:14:22 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F15B560E55
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 14:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24A9C300767E
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 12:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C54B362142;
	Sun, 17 May 2026 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjVoQvKz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92BA10F1;
	Sun, 17 May 2026 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779020055; cv=none; b=hgB0WM0N4orH+rmtVy8KsGHfDVtyUC1UwqhRs5/uH7phvsQM4wW+vIbncke2SAuN3DzZzLCGFE8bD9r7E4mOzAguJFpsTS3Ls8D6FnCMQU0gxkBxdIbzSBZci4ErwB+e2gUEYBSRten6/OpBjFxt5d7A/GTQk5vShkFcNbt2K2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779020055; c=relaxed/simple;
	bh=bFcGiGJfu9Ac5rl1wi1J5n2/JD7kyJwnntbvyDfKYpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0B094BRSiDh98qxQCJp6O7QB8JYYjfE5eVY3pmATou5029OHpdbr+slBa3dh+2bHLGTfBEDWKMkF1GZ2x24HYbZrYI97/YtdiOZ9TpJ7vhvko1e1BKhWZpQeWcPfC/Fc0SxqhrR9wSgJuWQC9e4QqkiNCMKX/rH4S0Jk6SZSmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjVoQvKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED72C2BCB0;
	Sun, 17 May 2026 12:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779020054;
	bh=bFcGiGJfu9Ac5rl1wi1J5n2/JD7kyJwnntbvyDfKYpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EjVoQvKzHIEG2gPB3ClUsCxLPGrics1u2frI9totgFxSZmbHtPMyJgP7T2ly1h38s
	 /f9H6uHDliTgPx5BURcLPYVM5Jxl5ha1ki6UOSCpzUFVRzwnBRT257Ke+Iq6V/zx8O
	 RYAI/lF3qWpRTu9mlElAslwSWb5sYAftrzN1XRc7tFvgL3sFOBGuo3hrXzt0bFz2bw
	 ylJFyoB6WroMcdLQG5Cqf1psjwFzu4H2MQ13aN/4l+qUbWn1DcJfJj6QVfKdiqrW3I
	 s5AchMDeVOzPiV2MxYInItIxAktpOQjXiKNXvBJ58VNP5ErYhHE/kdjwc4W0kniRKh
	 bGcKnhf/ZL8Tg==
Date: Sun, 17 May 2026 13:14:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v11 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <20260517131401.32118f4c@jic23-huawei>
In-Reply-To: <0696b662-f478-4d1a-95e0-0338bbdb719e@baylibre.com>
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
	<20260515-ad4692-multichannel-sar-adc-driver-v11-2-eab27d852ac2@analog.com>
	<0696b662-f478-4d1a-95e0-0338bbdb719e@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3F15B560E55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8929-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Action: no action

On Sat, 16 May 2026 12:11:16 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/15/26 8:31 AM, Radu Sabau via B4 Relay wrote:
> > From: Radu Sabau <radu.sabau@analog.com>
> >=20
> > Add support for the Analog Devices AD4691 family of high-speed,
> > low-power multichannel SAR ADCs: AD4691 (16-ch, 500 kSPS),
> > AD4692 (16-ch, 1 MSPS), AD4693 (8-ch, 500 kSPS) and
> > AD4694 (8-ch, 1 MSPS).
> >=20
> > The driver implements a custom regmap layer over raw SPI to handle the
> > device's mixed 1/2/3/4-byte register widths and uses the standard IIO
> > read_raw/write_raw interface for single-channel reads.
> >=20
> > The chip idles in Autonomous Mode so that single-shot read_raw can use
> > the internal oscillator without disturbing the hardware configuration.
> >=20
> > Three voltage supply domains are managed: avdd (required), vio, and a
> > reference supply on either the REF pin (ref-supply, external buffer)
> > or the REFIN pin (refin-supply, uses the on-chip reference buffer;
> > REFBUF_EN is set accordingly). Hardware reset is performed via
> > the reset controller framework; a software reset through SPI_CONFIG_A
> > is used as fallback when no hardware reset is available.
> >=20
> > Accumulator channel masking for single-shot reads uses ACC_MASK_REG via
> > an ADDR_DESCENDING SPI write, which covers both mask bytes in a single
> > 16-bit transfer.
> >=20
> > IIO_CHAN_INFO_SAMP_FREQ is exposed as info_mask_separate. The oscillator
> > is shared hardware =E2=80=94 writing any channel's sampling_frequency a=
ttribute
> > sets it for all others =E2=80=94 but per-channel attributes are used th=
roughout
> > the series to avoid an ABI change when per-channel oversampling ratios
> > are introduced in a later commit, at which point the effective output
> > rate (osc_freq / osr[N]) becomes genuinely per-channel.
> >=20
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > Signed-off-by: Radu Sabau <radu.sabau@analog.com>
One follow up as I was commenting on same code...

> > diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> > new file mode 100644
> > index 000000000000..ba77e1bfef16
> > --- /dev/null
> > +++ b/drivers/iio/adc/ad4691.c

> > +static int ad4691_get_sampling_freq(struct ad4691_state *st, int *val)
> > +{
> > +	unsigned int reg_val;
> > +	int ret;
> > + =20
>=20
> No mutex lock here? Maybe without OK since it is a read.

Agreed. It's not a bug, but also not a fast path and it will save reasoning
and need for comment to just take the lock.

>=20
> > +	/*
> > +	 * AD4691_OSC_FREQ_REG is non-volatile and written during
> > +	 * ad4691_config(), so regmap returns the cached value here without
> > +	 * touching the SPI bus. No lock is needed.
> > +	 */
> > +	ret =3D regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &reg_val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*val =3D ad4691_osc_freqs_Hz[FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val)=
];
> > +	return IIO_VAL_INT;
> > +}
> > +
> > +static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, int fre=
q)
> > +{
> > +	struct ad4691_state *st =3D iio_priv(indio_dev);
> > +	unsigned int start =3D ad4691_samp_freq_start(st->info);
> > +
> > +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> > +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> > +		return -EBUSY;
> > +
> > +	for (unsigned int i =3D start; i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i=
++) {
> > +		if (ad4691_osc_freqs_Hz[i] !=3D freq)
> > +			continue; =20
>=20
> mutex lock?
Agreed. Whilst the direct mode acquire will serialize that's an internal im=
plementation
detail.  Where a driver needs to ensure some sequences are not interrupted
(like I think for the single short read?) then it should take the local
lock.


>=20
> > +		return regmap_update_bits(st->regmap, AD4691_OSC_FREQ_REG,
> > +					  AD4691_OSC_FREQ_MASK, i);
> > +	}
> > +
> > +	return -EINVAL;
> > +}

