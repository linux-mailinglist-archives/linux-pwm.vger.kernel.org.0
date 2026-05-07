Return-Path: <linux-pwm+bounces-8838-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEKfFvGe/GkMSAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8838-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 16:17:21 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE974E9F70
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 16:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB1EC301EB67
	for <lists+linux-pwm@lfdr.de>; Thu,  7 May 2026 14:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CFB3F9F41;
	Thu,  7 May 2026 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT6JeDT0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C5A3FCB30;
	Thu,  7 May 2026 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163364; cv=none; b=DmYRTeldiHl+/tjKy6F/P/h8hXlqqjwtodGUA6ayjOnNNwUc70qUdZh8Cs3FFSUaQvIWwT3pfzTU4A7mARnvlm43tQEuIKYJlY1YcRrmn76YFOM4IhW7mfwyZVwYRLtP4nB6DUVWQVybJyaZYtNFdLNPFlCi58I9VHbMHuG72RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163364; c=relaxed/simple;
	bh=bbrbEtkbVlAVQ/692G80E3CKsqbcxeQRCAsWArl4QmA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4ElsZs8X4ORUJ6Pi62srIctbdOI3VAjqpPWQC3HLraW4lV1d5o0we40NMdBsTJNgG7sJhrVDtDOlYNXo3+oBCJLEjIGVYdYBZ6qHQ48LuYPu7uRnnfJArY5ZvRC4DkQHZVS7RJRgM0If1Vt0WW4pCsHHZqTdtEjXyvoVAQQVIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT6JeDT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD29C2BCB2;
	Thu,  7 May 2026 14:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778163362;
	bh=bbrbEtkbVlAVQ/692G80E3CKsqbcxeQRCAsWArl4QmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XT6JeDT0CcdgJNhOX+Z3Ocj7OeJKn7+o1VZRuNFWOwvyE1lrQW/eIxFqod2yyyXKe
	 Cw1DPm5Hjdiodz/9grKfl9OB8p8NYK8my1IefT5GD9flNaD538X2Z5Sii7JNzXiXBc
	 FHKGpFm9wnYkZX0jOrtrm1ObC8II8SQqFk/oBXMF9nXcrKvDFnVCafyrStH7nBug6X
	 HhT9TcYnLOEHho/RNNwZxQw2+ueza2kXKCMStzj9rn5P9awQg3fpDGq1Sci1C7ojgn
	 aggw2gJ8dlt3QpThaGiQ8v1v1/SvGjLzuw/rGVFnTT/PlaXCd5ywykJP+QhRwWPrel
	 gzV8tQnrOFBDg==
Date: Thu, 7 May 2026 15:15:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v9 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <20260507151549.61e4e8fb@jic23-huawei>
In-Reply-To: <LV9PR03MB841460307B0CF4C6F267A631F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
	<20260430-ad4692-multichannel-sar-adc-driver-v9-2-33e439e4fb87@analog.com>
	<LV9PR03MB841460307B0CF4C6F267A631F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DBE974E9F70
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8838-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Action: no action

On Thu, 7 May 2026 09:26:00 +0000
"Sabau, Radu bogdan" <Radu.Sabau@analog.com> wrote:

> Addressing Sashiko's review for initial driver's patch.
>=20
> > -----Original Message-----
> > From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
> > Sent: Thursday, April 30, 2026 1:17 PM =20
>=20
> ...
>=20
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 60038ae8dfc4..3685a03aa8dc 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -139,6 +139,17 @@ config AD4170_4
> >  	  To compile this driver as a module, choose M here: the module will =
be
> >  	  called ad4170-4.
> >=20
> > +config AD4691
> > +	tristate "Analog Devices AD4691 Family ADC Driver"
> > +	depends on SPI =20
>=20
> "Should this driver also depend on REGULATOR? In ad4691_regulator_setup(),
> it relies on devm_regulator_get_enable_read_voltage() to obtain its refer=
ence
> voltage. If the kernel is compiled without CONFIG_REGULATOR, this function
> is stubbed to return -ENODEV, causing probe to fail unconditionally."
>=20
> Will add "depends on REGULATOR". Without it,
> devm_regulator_get_enable_read_voltage() can be stubbed and
> return -ENODEV, making the driver unusable regardless of hardware.

If you really want to also add || COMPILE_TEST because
I want maximum build coverage and for that I don't mind if the driver
can actually probe or not.

>=20
> > +	select REGMAP
> > +	help
> > +	  Say yes here to build support for Analog Devices AD4691 Family =20
>=20
> ...
>=20
> > +};
> > +
> > +#define AD4691_CHANNEL(ch)
> > 	\
> > +	{								\
> > +		.type =3D IIO_VOLTAGE,					\
> > +		.indexed =3D 1,						\
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW)
> > 	\
> > +				    | BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> > +		.info_mask_separate_available =3D
> > 	\
> > +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> > +		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SCALE),
> > 	\ =20
>=20
> "Since ad4691_set_sampling_freq() modifies the AD4691_OSC_FREQ_REG regist=
er
> which controls the global internal oscillator frequency for the entire AD=
C,
> should IIO_CHAN_INFO_SAMP_FREQ be exposed as info_mask_shared_by_all
> instead of info_mask_separate? Changing the frequency for one channel
> currently seems to silently alter it for all channels."
>=20
> Agreed for this commit. With no per-channel OSR in the base driver
> all channels share a single oscillator register, so info_mask_shared_by_a=
ll
> is the correct annotation. Changing accordingly. The OSR commit switches =
it
> back to info_mask_separate because at that point the effective rate is
> genuinely per-channel (osc_freq / osr[N]).

Don't.  That would mean an ABI change mid way through the series which we
don't want. Just add a note to the patch description.

...


>=20
> > +
> > +static int ad4691_reset(struct ad4691_state *st)
> > +{
> > +	struct device *dev =3D regmap_get_device(st->regmap);
> > +	struct reset_control *rst;
> > +
> > +	rst =3D devm_reset_control_get_optional_exclusive(dev, NULL);
> > +	if (IS_ERR(rst))
> > +		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get
> > reset\n");
> > +
> > +	if (rst) {
> > +		/*
> > +		 * reset_gpio_probe() already drives the pin asserted, so the
> > +		 * device is held in reset before we get here.
> > +		 * devm_reset_control_get_optional_exclusive_deasserted()
> > cannot
> > +		 * be used because it deasserts immediately without delay; the
> > +		 * datasheet (Table 5) requires a =E2=89=A5300 =C2=B5s reset pulse w=
idth
> > +		 * before deassertion.
> > +		 */
> > +		fsleep(300);
> > +		return reset_control_deassert(rst); =20
>=20
> "Could this sequence break on driver reload?
> When the driver is unloaded, the reset line remains in its deasserted sta=
te
> because there is no cleanup action to re-assert it. Upon reloading, the 3=
00
> microsecond sleep will occur while the pin is already deasserted, meaning
> the hardware might not receive the required reset pulse.
> Should reset_control_assert() be called explicitly prior to the delay?"
>=20
> Valid. reset_control_put() does not re-assert the line at unload, so
> on reload the pin is already deasserted when we enter the 300 =C2=B5s sle=
ep.
> Adding reset_control_assert(rst) before fsleep(300) to guarantee a proper
> reset pulse on every probe including reloads.

I'm not that fussed about driver reload bugs like this one but why
not fix it I guess.  Lots of cases of this in upstream code though.

>=20
> > +	}
> > + =20
>=20
> ...
>=20
> > +
> > +	st =3D iio_priv(indio_dev);
> > +	st->info =3D spi_get_device_match_data(spi); =20
>=20
> "Is it possible for st->info to be NULL here?
> If the driver is manually bound to a device with a non-matching name using
> the sysfs bind interface in combination with driver_override,
> spi_get_device_match_data() could return NULL, which would cause a NULL
> pointer dereference later in the probe sequence."
>=20
> Agreed, will add the NULL check with -ENODEV immediately after
> spi_get_device_match_data().

Andy, you seeing this one?  Looks like we are putting these checks back in =
again.
Whilst anyone forcing a bind like this is onto a looser anyway we shouldn't
crash due to a null dereference.

>=20
> > +
> > +	ret =3D devm_mutex_init(dev, &st->lock);
> > +	if (ret)
> > +		return ret; =20
>=20


