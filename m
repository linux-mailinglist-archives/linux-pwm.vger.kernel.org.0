Return-Path: <linux-pwm+bounces-8349-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECvIJB2CwmlneQQAu9opvQ
	(envelope-from <linux-pwm+bounces-8349-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Mar 2026 13:22:53 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA0A308201
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Mar 2026 13:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B10C3035A51
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Mar 2026 12:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D09C3F65EC;
	Tue, 24 Mar 2026 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu+iy2MX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3BA3F0A98
	for <linux-pwm@vger.kernel.org>; Tue, 24 Mar 2026 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354928; cv=none; b=lrhaG0ojUYBwj/nTPei/+5cpxloubUb6uvjva2T4zWIEHMhde8jIEoiGNtqA7kXTFviIlF9BOLlxvvdw3nbsdPkAPWoMYrVbw/1rLTAZyMb0v2CUKHvIBnFeuWdOlR5GJ5PE0AvKv/DV9LRponsHOq8fRbMdNduFRzT5ZltIiGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354928; c=relaxed/simple;
	bh=r1GJsCW8OLWD6HbAwhJRnQ4Q6N5LSNo7LvQtNAUbDmw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TaPHEU+3MiqYoPiwAN+C2yCh/mnJSX3qC6mdZrWkGtfxkBU+9OC0Fh3LB+Of2p2io5JGnfQblnyUFoEq7sGPyKQfRaZHb9oKpLZ7jzpW6hcsnnlRcZuh9cY3jpX6r7mQbIGhLHXThTH6grVeGyK290t6CxjnX3W4mYT7LeG9Jbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hu+iy2MX; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439fe4985efso3432980f8f.3
        for <linux-pwm@vger.kernel.org>; Tue, 24 Mar 2026 05:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774354925; x=1774959725; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q5dvk7Zm80VcMEttb3GAfdno1MkIso7lnn9GAMceQ6w=;
        b=hu+iy2MXoQ27dPUT/Emhf66o/sCS7kRpgWAzzUgtKuBuaa2xT/LofKdvNvRjNzI/n5
         lAAj2lzgI/q/3QLLohY17ZHgjGSOZehWnuDmIlEww0S1OpeYx0WzzDTw21i2z7Cx44A6
         1C/KWGI26/d9ZwTtHldBoCOVuRr4KvrhGtspgqUQ8yn0GQTq5lsHUh32KKBLIewGqc1r
         /Rw4lr4uMn3zJkF9rTX7YEyjKSAcKdKHEkKfTe7hVa6k1Y0aczqmvwzRdRoimhfrq4d7
         VoJRvIdsvn5WHVOHLtCutxOZTdd2U25LI4kEx8QWjKT/2UIUvy/c1tuw817DVVvaJgrr
         rwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774354925; x=1774959725;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5dvk7Zm80VcMEttb3GAfdno1MkIso7lnn9GAMceQ6w=;
        b=OXutEPpffxHRa8nCleZNzvQ5eh5eORqRREDqAuq27G11/ccuuO+jvcWYHX3IHatt5/
         Hfo1+n2AZwr8dMHW3vJCMTiyFeWmynp4OBXYCLOzlMe/Bl+EJxQVAySK6dR3sQ3mQJIk
         XgWZiNbZ98LezqUcgD1FkvQ9MIEPmofVS3VqDmwMmz0GwMAZTJDCXbWY7VHi6LOuj7zo
         pFrkhtwFg0ronbWxI0AwqpKOxGIzYp0xLYG5MtkOtESOdVnW+uSwKx7xizNRzTRo5dYg
         IOZF7YjHy6Cx8+CJYcVqakXozFY/35KgzBHiaSYO7ejV/1OKzuNajcKTka1gXwcVIHlV
         c8rw==
X-Forwarded-Encrypted: i=1; AJvYcCWFkiX57g+KpoK0VsV5ByZPA0SzKGizSKDbAyIglHFUgNzI+cjiONHzjPeQmh5DW+C+ysFP8Z0WHTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmRjEZiIxcYeIpDEXpBn9TFTicsg1IMs3IwMWGmAd70VU0Kx2B
	BlYF36KHHlGVQf4F6cjqvCPMl/i5Q1RuEptaCGBED8g9sVw0UDTJ4yOz
X-Gm-Gg: ATEYQzyx7hnstQt6aDSKx3pJNczJwp4rxLPMPeblJAnCz+WhhoLRqVJ8goUDMjYerht
	0J/zhYlPES189gk7GmgATOFD111V5622EoCCfCQrc3aBDdR6DLjtyWqQ2tcudVIrD6r2V7ggb9G
	I0WzAYS0Ad9BeLFcOQmJoNLxVWiadAze34e4o9pszXBe/dCJQ/cQs3od3cLWp4BRt9SC/hunX6v
	gVGdb4jOcLuI85fF1/2XQjUaI06/LsOLlya1FiZqubIovM8jIMTPNdZC2g9DZ3tkm6F4nbogToT
	W40b2L9ke8EcIoPpJpV+kMNiIZYp9ddLtFAc7a3lLnnc1GDvbS0rutyOcYISOmGiUKWm3wJkrk8
	b5Bb7MmtXjILLmQVWXxB/YsZru0rI6A0AnO8xqEFcDGvbf7ovbYZP0skkqFlLEWcvO6smTCSh02
	154IOVM+/NCZUTpch2jxBH2Jre6retQq+r1BO21eFx/w==
X-Received: by 2002:a05:6000:2010:b0:43b:4ec7:f924 with SMTP id ffacd0b85a97d-43b64264073mr24532596f8f.34.1774354924370;
        Tue, 24 Mar 2026 05:22:04 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470c239sm37754549f8f.27.2026.03.24.05.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:22:03 -0700 (PDT)
Message-ID: <83d87ff35002e5c7b9448a5ee7f2791a63c38c38.camel@gmail.com>
Subject: Re: [PATCH v4 3/4] iio: adc: ad4691: add triggered buffer support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner	 <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,  Andy Shevchenko	
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown	 <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski	 <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Date: Tue, 24 Mar 2026 12:22:50 +0000
In-Reply-To: <20260320-ad4692-multichannel-sar-adc-driver-v4-3-052c1050507a@analog.com>
References: 
	<20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com>
	 <20260320-ad4692-multichannel-sar-adc-driver-v4-3-052c1050507a@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8349-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,baylibre.com,gmail.com,pengutronix.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Queue-Id: 3EA0A308201
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Radu,

Some comments from me.

On Fri, 2026-03-20 at 13:03 +0200, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
>=20
> Add buffered capture support using the IIO triggered buffer framework.
>=20
> CNV Burst Mode: the GP pin identified by interrupt-names in the device
> tree is configured as DATA_READY output. The IRQ handler stops
> conversions and fires the IIO trigger; the trigger handler executes a
> pre-built SPI message that reads all active channels from the AVG_IN
> accumulator registers and then resets accumulator state and restarts
> conversions for the next cycle.
>=20
> Manual Mode: CNV is tied to SPI CS so each transfer simultaneously
> reads the previous result and starts the next conversion (pipelined
> N+1 scheme). At preenable time a pre-built, optimised SPI message of
> N+1 transfers is constructed (N channel reads plus one NOOP to drain
> the pipeline). The trigger handler executes the message in a single
> spi_sync() call and collects the results. An external trigger (e.g.
> iio-trig-hrtimer) is required to drive the trigger at the desired
> sample rate.
>=20
> Both modes share the same trigger handler and push a complete scan =E2=80=
=94
> one u16 slot per channel at its scan_index position, followed by a
> timestamp =E2=80=94 to the IIO buffer via iio_push_to_buffers_with_ts().
>=20
> The CNV Burst Mode sampling frequency (PWM period) is exposed as a
> buffer-level attribute via IIO_DEVICE_ATTR.
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0drivers/iio/adc/ad4691.c | 584 ++++++++++++++++++++++++++++++++++++=
+++++++++--
> =C2=A02 files changed, 571 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 3685a03aa8dc..d498f16c0816 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -142,6 +142,8 @@ config AD4170_4
> =C2=A0config AD4691
> =C2=A0	tristate "Analog Devices AD4691 Family ADC Driver"
> =C2=A0	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> =C2=A0	select REGMAP
> =C2=A0	help
> =C2=A0	=C2=A0 Say yes here to build support for Analog Devices AD4691 Fam=
ily MuxSAR
> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> index 5e02eb44ca44..db776de32846 100644
> --- a/drivers/iio/adc/ad4691.c
> +++ b/drivers/iio/adc/ad4691.c
> @@ -9,9 +9,12 @@
> =C2=A0#include <linux/delay.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/err.h>
> +#include <linux/interrupt.h>
> =C2=A0#include <linux/math.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/pwm.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/regulator/consumer.h>
> =C2=A0#include <linux/reset.h>
> @@ -19,7 +22,12 @@
> =C2=A0#include <linux/units.h>
> =C2=A0#include <linux/unaligned.h>
> =C2=A0
> +#include <linux/iio/buffer.h>
> =C2=A0#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> =C2=A0
> =C2=A0#define AD4691_VREF_uV_MIN			2400000
> =C2=A0#define AD4691_VREF_uV_MAX			5250000
> @@ -28,6 +36,8 @@
> =C2=A0#define AD4691_VREF_3P3_uV_MAX			3750000
> =C2=A0#define AD4691_VREF_4P096_uV_MAX		4500000
> =C2=A0
> +#define AD4691_CNV_DUTY_CYCLE_NS		380
> +
> =C2=A0#define AD4691_SPI_CONFIG_A_REG			0x000
> =C2=A0#define AD4691_SW_RESET				(BIT(7) | BIT(0))
> =C2=A0

...

>=20
> +static int ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	struct spi_device *spi =3D to_spi_device(dev);
> +	unsigned int n_active =3D hweight_long(*indio_dev->active_scan_mask);
> +	unsigned int bit, k, i;
> +	int ret;
> +
> +	st->scan_devm_group =3D devres_open_group(dev, NULL, GFP_KERNEL);
> +	if (!st->scan_devm_group)
> +		return -ENOMEM;

Agree with Jonathan. Not seeing a valid reason for the above.

> +
> +	st->scan_xfers =3D devm_kcalloc(dev, 2 * n_active, sizeof(*st->scan_xfe=
rs),
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> +	st->scan_tx =3D devm_kcalloc(dev, n_active, sizeof(*st->scan_tx),
> +				=C2=A0=C2=A0 GFP_KERNEL);
> +	st->scan_rx =3D devm_kcalloc(dev, n_active, sizeof(*st->scan_rx),
> +				=C2=A0=C2=A0 GFP_KERNEL);
> +	if (!st->scan_xfers || !st->scan_tx || !st->scan_rx) {
> +		devres_release_group(dev, st->scan_devm_group);
> +		return -ENOMEM;
> +	}
> +
> +	spi_message_init(&st->scan_msg);
> +
> +	/*
> +	 * Each AVG_IN read needs two transfers: a 2-byte address write phase
> +	 * followed by a 2-byte data read phase. CS toggles between channels
> +	 * (cs_change=3D1 on the read phase of all but the last channel).
> +	 */
> +	k =3D 0;
> +	iio_for_each_active_channel(indio_dev, i) {
> +		st->scan_tx[k] =3D cpu_to_be16(0x8000 | AD4691_AVG_IN(i));
> +		st->scan_xfers[2 * k].tx_buf =3D &st->scan_tx[k];
> +		st->scan_xfers[2 * k].len =3D sizeof(__be16);
> +		spi_message_add_tail(&st->scan_xfers[2 * k], &st->scan_msg);
> +		st->scan_xfers[2 * k + 1].rx_buf =3D &st->scan_rx[k];
> +		st->scan_xfers[2 * k + 1].len =3D sizeof(__be16);
> +		if (k < n_active - 1)
> +			st->scan_xfers[2 * k + 1].cs_change =3D 1;
> +		spi_message_add_tail(&st->scan_xfers[2 * k + 1], &st->scan_msg);
> +		k++;
> +	}
> +
> +	devres_close_group(dev, st->scan_devm_group);
> +
> +	st->scan_msg.spi =3D spi;
> +
> +	ret =3D spi_optimize_message(spi, &st->scan_msg);
> +	if (ret) {
> +		devres_release_group(dev, st->scan_devm_group);
> +		return ret;
> +	}
> +
> +	ret =3D regmap_write(st->regmap, AD4691_ACC_MASK_REG,
> +			=C2=A0=C2=A0 (u16)~(*indio_dev->active_scan_mask));
> +	if (ret)
> +		goto err;
> +
> +	ret =3D regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +			=C2=A0=C2=A0 *indio_dev->active_scan_mask);
> +	if (ret)
> +		goto err;
> +
> +	iio_for_each_active_channel(indio_dev, bit) {
> +		ret =3D regmap_write(st->regmap, AD4691_ACC_COUNT_LIMIT(bit),
> +				=C2=A0=C2=A0 AD4691_ACC_COUNT_VAL);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	ret =3D ad4691_enter_conversion_mode(st);
> +	if (ret)
> +		goto err;
> +
> +	ret =3D ad4691_sampling_enable(st, true);
> +	if (ret)
> +		goto err;
> +
> +	enable_irq(st->irq);
> +	return 0;
> +err:
> +	spi_unoptimize_message(&st->scan_msg);
> +	devres_release_group(dev, st->scan_devm_group);
> +	return ret;
> +}
> +
> +static int ad4691_cnv_burst_buffer_postdisable(struct iio_dev *indio_dev=
)
> +{
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	int ret;
> +
> +	disable_irq(st->irq);

Should we use disable_irq_sync()?
> +
> +	ret =3D ad4691_sampling_enable(st, false);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +			=C2=A0=C2=A0 AD4691_SEQ_ALL_CHANNELS_OFF);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad4691_exit_conversion_mode(st);
> +	spi_unoptimize_message(&st->scan_msg);
> +	devres_release_group(dev, st->scan_devm_group);
> +	return ret;
> +}
> +
> +static const struct iio_buffer_setup_ops ad4691_cnv_burst_buffer_setup_o=
ps =3D {
> +	.preenable =3D &ad4691_cnv_burst_buffer_preenable,
> +	.postdisable =3D &ad4691_cnv_burst_buffer_postdisable,
> +};
> +
> +static ssize_t sampling_frequency_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +
> +	if (st->manual_mode)
> +		return -ENODEV;

Can the above happen at all? I think you're making sure (at probe) this int=
erface
never get's exposed in manual mode.

> +
> +	return sysfs_emit(buf, "%u\n", (u32)(NSEC_PER_SEC / st->cnv_period_ns))=
;
> +}
> +
> +static ssize_t sampling_frequency_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +	int freq, ret;
> +
> +	if (st->manual_mode)
> +		return -ENODEV;
> +
> +	ret =3D kstrtoint(buf, 10, &freq);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret =3D ad4691_set_pwm_freq(st, freq);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(sampling_frequency, 0644,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sampling_frequency_show,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sampling_frequency_store, 0);
> +
> +static const struct iio_dev_attr *ad4691_buffer_attrs[] =3D {
> +	&iio_dev_attr_sampling_frequency,
> +	NULL,
> +};
> +
> +static irqreturn_t ad4691_irq(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev =3D private;
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +
> +	/*
> +	 * GPx has asserted: stop conversions before reading so the
> +	 * accumulator does not continue sampling while the trigger handler
> +	 * processes the data. Then fire the IIO trigger to push the sample
> +	 * to the buffer.
> +	 */
> +	ad4691_sampling_enable(st, false);
> +	iio_trigger_poll(st->trig);

Not sure you need to save trig in your struct. We already have it in indio_=
dev->trig. Sure,
it is a private member but still fairly common to see (this patch included)=
:

indio_dev->trig =3D iio_trigger_get(trig);

So I would say we either assume it's public or start to not allow the above
pattern.

Alternatively, I don't think you're using indio_dev driverdata right? Could=
 save it
in there.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_trigger_ops ad4691_trigger_ops =3D {
> +	.validate_device =3D iio_trigger_validate_own_device,
> +};
> +
> +static irqreturn_t ad4691_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +	unsigned int i, k =3D 0;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret =3D spi_sync(st->scan_msg.spi, &st->scan_msg);
> +	if (ret)
> +		goto done;
> +
> +	if (st->manual_mode) {
> +		iio_for_each_active_channel(indio_dev, i) {
> +			st->scan.vals[i] =3D be16_to_cpu(st->scan_rx[k + 1]);
> +			k++;
> +		}
> +	} else {
> +		iio_for_each_active_channel(indio_dev, i) {
> +			st->scan.vals[i] =3D be16_to_cpu(st->scan_rx[k]);
> +			k++;
> +		}
> +
> +		ret =3D regmap_write(st->regmap, AD4691_STATE_RESET_REG,
> +				=C2=A0=C2=A0 AD4691_STATE_RESET_ALL);
> +		if (ret)
> +			goto done;
> +
> +		ret =3D ad4691_sampling_enable(st, true);
> +		if (ret)
> +			goto done;
> +	}
> +
> +	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
> +				=C2=A0=C2=A0=C2=A0 pf->timestamp);
> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> =C2=A0static const struct iio_info ad4691_info =3D {
> =C2=A0	.read_raw =3D &ad4691_read_raw,
> =C2=A0	.write_raw =3D &ad4691_write_raw,
> @@ -495,6 +934,25 @@ static const struct iio_info ad4691_info =3D {
> =C2=A0	.debugfs_reg_access =3D &ad4691_reg_access,
> =C2=A0};
> =C2=A0
> +static int ad4691_pwm_setup(struct ad4691_state *st)
> +{
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	int ret;
> +
> +	st->conv_trigger =3D devm_pwm_get(dev, "cnv");
> +	if (IS_ERR(st->conv_trigger))
> +		return dev_err_probe(dev, PTR_ERR(st->conv_trigger),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get cnv pwm\n");
> +
> +	ret =3D devm_add_action_or_reset(dev, ad4691_disable_pwm,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->conv_trigger);

This is a suspicious pattern. But I do see it's used like this in more plac=
es and it's a no-op
if PWM is already disabled. Still, not sure if agree with this kind "unbala=
nced" handling.

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to register PWM disable action\n");
> +
> +	return ad4691_set_pwm_freq(st, st->info->max_rate);
> +}
> +
> =C2=A0static int ad4691_regulator_setup(struct ad4691_state *st)
> =C2=A0{
> =C2=A0	struct device *dev =3D regmap_get_device(st->regmap);
> @@ -555,12 +1013,30 @@ static int ad4691_reset(struct ad4691_state *st)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static int ad4691_config(struct ad4691_state *st)
> +static int ad4691_config(struct ad4691_state *st, u32 max_speed_hz)

My eyes might be failing me but where is 'max_speed_hz' used?


> =C2=A0{
> =C2=A0	struct device *dev =3D regmap_get_device(st->regmap);
> =C2=A0	enum ad4691_ref_ctrl ref_val;
> +	const char *irq_name;
> +	unsigned int gp_num;
> =C2=A0	int ret;
> =C2=A0
> +	/*
> +	 * Determine buffer conversion mode from DT: if a PWM is provided it
> +	 * drives the CNV pin (CNV_BURST_MODE); otherwise CNV is tied to CS
> +	 * and each SPI transfer triggers a conversion (MANUAL_MODE).
> +	 * Both modes idle in AUTONOMOUS mode so that read_raw can use the
> +	 * internal oscillator without disturbing the hardware configuration.
> +	 */
> +	if (device_property_present(dev, "pwms")) {
> +		st->manual_mode =3D false;
> +		ret =3D ad4691_pwm_setup(st);
> +		if (ret)
> +			return ret;
> +	} else {
> +		st->manual_mode =3D true;
> +	}
> +
> =C2=A0	switch (st->vref_uV) {
> =C2=A0	case AD4691_VREF_uV_MIN ... AD4691_VREF_2P5_uV_MAX:
> =C2=A0		ref_val =3D AD4691_VREF_2P5;
> @@ -595,17 +1071,91 @@ static int ad4691_config(struct ad4691_state *st)
> =C2=A0		return dev_err_probe(dev, ret, "Failed to write DEVICE_SETUP\n");
> =C2=A0
> =C2=A0	/*
> -	 * Set the internal oscillator to the highest valid rate for this chip.
> -	 * Index 0 (1 MHz) is valid only for AD4692/AD4694; AD4691/AD4693 start
> -	 * at index 1 (500 kHz).
> +	 * Set the internal oscillator to the highest rate this chip supports.
> +	 * Index 0 (1 MHz) exceeds the 500 kHz max of AD4691/AD4693, so those
> +	 * chips start at index 1 (500 kHz).
> =C2=A0	 */
> =C2=A0	ret =3D regmap_write(st->regmap, AD4691_OSC_FREQ_REG,
> -			=C2=A0=C2=A0 (st->info->max_rate =3D=3D HZ_PER_MHZ) ? 0 : 1);
> +			=C2=A0=C2=A0 (ad4691_osc_freqs[0] > st->info->max_rate) ? 1 : 0);

Does this belong to this commit?

> =C2=A0	if (ret)
> =C2=A0		return dev_err_probe(dev, ret, "Failed to write OSC_FREQ\n");
> =C2=A0
> =C2=A0	/* Device always operates in AUTONOMOUS mode. */
> -	return regmap_write(st->regmap, AD4691_ADC_SETUP, AD4691_AUTONOMOUS_MOD=
E_VAL);
> +	ret =3D regmap_write(st->regmap, AD4691_ADC_SETUP, AD4691_AUTONOMOUS_MO=
DE);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write ADC_SETUp\n");
> +
> +	if (st->manual_mode)
> +		return 0;
> +
> +	ret =3D device_property_read_string_array(dev, "interrupt-names",
> +						&irq_name, 1);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to read interrupt-names\n");
> +
> +	if (strncmp(irq_name, "gp", 2) !=3D 0 ||
> +	=C2=A0=C2=A0=C2=A0 kstrtouint(irq_name + 2, 10, &gp_num) || gp_num > 3)
> +		return dev_err_probe(dev, -EINVAL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid interrupt name '%s'\n", irq_name);
> +

I would likely prefer something like [1] rather than the string parsing.

[1]: https://elixir.bootlin.com/linux/v7.0-rc5/source/drivers/iio/imu/adis1=
6480.c#L1582

- Nuno S=C3=A1


