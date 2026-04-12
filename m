Return-Path: <linux-pwm+bounces-8559-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MFXCJrb22lMHgkAu9opvQ
	(envelope-from <linux-pwm+bounces-8559-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Apr 2026 19:51:22 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9100A3E53AF
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Apr 2026 19:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D119301B4FA
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Apr 2026 17:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DB13624AB;
	Sun, 12 Apr 2026 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yz89q0bG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADF6359A94;
	Sun, 12 Apr 2026 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776016039; cv=none; b=Ey3w1m3Wv+MSIAnI0nEpDDo5ftMczUBxlcShfDI0XiHcn/2dCLHocUDTnrCZ7MTG9wgQcW560XGdEuXuDrEIN1UW1x4+K+yp8VVa8Y4aH08ai6BiR831b2vN70mKcM2uoNimkGuvd0CpgFyFcwJyqwuUoiXLzDGUploRDdFPo3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776016039; c=relaxed/simple;
	bh=A3XhfYlHe0vqa+yb2NK5CwvHW6blS53GYBNRCgeDFeA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUbOqfSe/YSAhNqRXTR04QBlhlEAjrGv71g6PhA92S45i9htwy65FeVvGKCIc7AiWK6NePLsdDzq/zj8hY4PY3jmJhx1JZYOVMenqgAbFPGk8g3OOwVK8rtQkszaQH6cWZd105zE7AOKPZIsHMbdekClWGG7lp3vWOG3SHNvPaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yz89q0bG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A9BC19424;
	Sun, 12 Apr 2026 17:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776016038;
	bh=A3XhfYlHe0vqa+yb2NK5CwvHW6blS53GYBNRCgeDFeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yz89q0bGmMbjikiXLGJuOqvuRFAqYA2VM+VJFs1Wl86fF8Hd5e1GNQiKaPnsd2nmh
	 Mb1ObnadA1e5JGTR4QwRBeDs0w6Pxfb/TA7rPUddCWM6CXAMsWXKDcG01jpmyNkd/n
	 38d6SyX4k+MPBSxE0ofoRWNW6gKyjFSw572+2dC4AR1OcBkhDgvAsSOoWGGSd/sQiG
	 5gnPQKHqTpfO2F0FqjfOquaynZJuTAHBiWoG9rAT9KbUKiQHgNzgFrZcNBgVhoYNzp
	 NzYITwnLn3+Vi3FMve0ureAStpy8rWEAPdu6/sS2qHaLg/7CMHdCpQCUFkmdz5tzAj
	 PJJB2h7aBi4ag==
Date: Sun, 12 Apr 2026 18:47:04 +0100
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
Subject: Re: [PATCH v7 3/6] iio: adc: ad4691: add triggered buffer support
Message-ID: <20260412184704.2f0678ad@jic23-huawei>
In-Reply-To: <20260409-ad4692-multichannel-sar-adc-driver-v7-3-be375d4df2c5@analog.com>
References: <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
	<20260409-ad4692-multichannel-sar-adc-driver-v7-3-be375d4df2c5@analog.com>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8559-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9100A3E53AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 09 Apr 2026 18:28:24 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

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
A couple of minor things inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> index 43bd408c3d11..3e5caa0972eb 100644
> --- a/drivers/iio/adc/ad4691.c
> +++ b/drivers/iio/adc/ad4691.c
> @@ -5,15 +5,19 @@
>   */
>  #include <linux/array_size.h>
>  #include <linux/bitfield.h>
> -#include <linux/bitops.h>
> +#include <linux/bitmap.h>
>  #include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/dev_printk.h>
>  #include <linux/device/devres.h>
> +#include <linux/dmaengine.h>
>  #include <linux/err.h>
> +#include <linux/interrupt.h>
>  #include <linux/math.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/pwm.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
> @@ -21,7 +25,14 @@
>  #include <linux/units.h>
>  #include <linux/unaligned.h>
> =20
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/buffer-dma.h>
> +#include <linux/iio/buffer-dmaengine.h>
Not yet...  Only bring these headers in when you need them.
So far this is just doing normal SPI stuff.

>  #include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>

> @@ -201,8 +245,45 @@ struct ad4691_state {
>  	 * atomicity of consecutive SPI operations.
>  	 */
>  	struct mutex lock;
> +	/*
> +	 * Per-buffer-enable lifetime resources:
> +	 * Manual Mode - a pre-built SPI message that clocks out N+1
> +	 *		 transfers in one go.
> +	 * CNV Burst Mode - a pre-built SPI message that clocks out 2*N
> +	 *		    transfers in one go.
> +	 */
> +	struct spi_message scan_msg;
> +	/* max 16 + 1 NOOP (manual) or 2*16 + 2 (CNV burst). */
> +	struct spi_transfer scan_xfers[34];
> +	/*
> +	 * CNV burst: 16 AVG_IN addresses + state-reset address + state-reset
> +	 * value =3D 18.  Manual: 16 channel cmds + 1 NOOP =3D 17.
> +	 */
> +	__be16 scan_tx[18];

David raised this. As these aren't going through the regmap and are using
spi_transfers directly they need to be using DMA safe buffers.

> +	/* Scan buffer: one BE16 slot per channel (rx'd directly), plus timesta=
mp */
> +	struct {
> +		__be16 vals[16];
> +		aligned_s64 ts;
> +	} scan;
>  };

> +static int ad4691_manual_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +	unsigned int n_active;
> +	unsigned int n_xfers;
> +	unsigned int prev_i, k, i;
> +	bool first;
> +	int ret;
> +
> +	n_active =3D bitmap_weight(indio_dev->active_scan_mask, iio_get_masklen=
gth(indio_dev));
> +	n_xfers =3D n_active + 1;
> +
> +	memset(st->scan_xfers, 0, n_xfers * sizeof(st->scan_xfers[0]));
> +	memset(st->scan_tx, 0, n_xfers * sizeof(st->scan_tx[0]));
> +
> +	spi_message_init(&st->scan_msg);
> +
> +	first =3D true;
> +	prev_i =3D 0;
> +	k =3D 0;
> +	iio_for_each_active_channel(indio_dev, i) {
> +		st->scan_tx[k] =3D cpu_to_be16(AD4691_ADC_CHAN(i));
> +		st->scan_xfers[k].tx_buf =3D &st->scan_tx[k];
> +		/*
> +		 * The pipeline means xfer[0] receives the residual from the
> +		 * previous sequence, not a valid sample for channel i. Point
> +		 * it at vals[i] anyway; xfer[1] (or the NOOP when only one
> +		 * channel is active) will overwrite that slot with the real
> +		 * result, so no separate dummy buffer is needed.
> +		 */
> +		if (first) {
> +			st->scan_xfers[k].rx_buf =3D &st->scan.vals[i];
> +			first =3D false;
> +		} else {
> +			st->scan_xfers[k].rx_buf =3D &st->scan.vals[prev_i];
> +		}
> +		st->scan_xfers[k].len =3D sizeof(__be16);
> +		st->scan_xfers[k].cs_change =3D 1;
> +		spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
> +		prev_i =3D i;
> +		k++;
> +	}
> +
> +	/* Final NOOP transfer retrieves the last channel's result. */
> +	st->scan_xfers[k].tx_buf =3D &st->scan_tx[k]; /* scan_tx[k] =3D=3D 0 =
=3D=3D NOOP */
> +	st->scan_xfers[k].rx_buf =3D &st->scan.vals[prev_i];
> +	st->scan_xfers[k].len =3D sizeof(__be16);
> +	spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
> +
> +	ret =3D spi_optimize_message(st->spi, &st->scan_msg);
> +	if (ret)

See below. This matches my expectations for what to do if spi_optimize_mess=
age()
fails.


> +		return ret;
> +
> +	ret =3D ad4691_enter_conversion_mode(st);
> +	if (ret) {
> +		spi_unoptimize_message(&st->scan_msg);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

> +static int ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +	unsigned int n_active;
> +	unsigned int k, i;
> +	int ret;
> +
> +	n_active =3D bitmap_weight(indio_dev->active_scan_mask, iio_get_masklen=
gth(indio_dev));
> +
> +	memset(st->scan_xfers, 0, (2 * n_active + 2) * sizeof(st->scan_xfers[0]=
));
> +	memset(st->scan_tx, 0, (n_active + 2) * sizeof(st->scan_tx[0]));
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
> +		st->scan_xfers[2 * k + 1].rx_buf =3D &st->scan.vals[i];
> +		st->scan_xfers[2 * k + 1].len =3D sizeof(__be16);
> +		st->scan_xfers[2 * k + 1].cs_change =3D 1;
> +		spi_message_add_tail(&st->scan_xfers[2 * k + 1], &st->scan_msg);
> +		k++;
> +	}
> +
> +	st->scan_tx[k] =3D cpu_to_be16(AD4691_STATE_RESET_REG);
> +	st->scan_xfers[2 * k].tx_buf =3D &st->scan_tx[k];
> +	st->scan_xfers[2 * k].len =3D sizeof(__be16);
> +	spi_message_add_tail(&st->scan_xfers[2 * k], &st->scan_msg);
> +	st->scan_tx[k + 1] =3D cpu_to_be16(AD4691_STATE_RESET_ALL << 8);
> +	st->scan_xfers[2 * k + 1].tx_buf =3D &st->scan_tx[k + 1];
> +	st->scan_xfers[2 * k + 1].len =3D sizeof(__be16);
> +	st->scan_xfers[2 * k + 1].cs_change =3D 1;
> +	spi_message_add_tail(&st->scan_xfers[2 * k + 1], &st->scan_msg);
> +
> +	ret =3D spi_optimize_message(st->spi, &st->scan_msg);
> +	if (ret)
> +		goto err_unoptimize;
I'd expect spi_optimize_message() to be side effect free if it fails.
I took a quick look at the implementation and it looks like it is..
So probably just return ret; here
That matches with the other similar flow above.


> +
> +	ret =3D regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +			   bitmap_read(indio_dev->active_scan_mask, 0,
> +				       iio_get_masklength(indio_dev)));
> +	if (ret)
> +		goto err_unoptimize;
> +
> +	ret =3D regmap_write(st->regmap, AD4691_ACC_MASK_REG,
> +			   ~bitmap_read(indio_dev->active_scan_mask, 0,
> +				iio_get_masklength(indio_dev)) & GENMASK(15, 0));
> +	if (ret)
> +		goto err_unoptimize;
> +
> +	ret =3D ad4691_enter_conversion_mode(st);
> +	if (ret)
> +		goto err_unoptimize;
> +
> +	ret =3D ad4691_sampling_enable(st, true);
> +	if (ret)
> +		goto err_exit_conv;
> +
> +	enable_irq(st->irq);
> +	return 0;
> +
> +err_exit_conv:
> +	ad4691_exit_conversion_mode(st);
> +err_unoptimize:
> +	spi_unoptimize_message(&st->scan_msg);
> +	return ret;
> +}




> +static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
> +					 struct ad4691_state *st)
> +{
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	struct iio_trigger *trig;
> +	unsigned int i;
> +	int irq, ret;
> +
> +	trig =3D devm_iio_trigger_alloc(dev, "%s-dev%d",
> +				      indio_dev->name,
> +				      iio_device_id(indio_dev));

Might as well wrap this less.

> +	if (!trig)
> +		return -ENOMEM;
> +



