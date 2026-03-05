Return-Path: <linux-pwm+bounces-8194-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP3wOv7YqWl5GAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8194-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 20:26:54 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3AD217822
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 20:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C635C3008312
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2026 19:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AFA38C2BB;
	Thu,  5 Mar 2026 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t808lmHO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA72037D11F;
	Thu,  5 Mar 2026 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738811; cv=none; b=Bndw+rD1U+gR85+j4q7sQmEcgTShXOZ3l8FBpWKPVTUaRMmmocpkjkbvzwyWgQUZllW/ppb2o2NvOIfF1HvgyZScPXacFZKFURpZQRs1HqkI8pzj3ahCphHG1uIM7N1x+cpR2mKpbWxtfBCUy02E+AKPyGdrP92kOoZ3NjnwpVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738811; c=relaxed/simple;
	bh=Fl+xG8f3V1m4AHOqnKP1lKLxgOPU2ocJ0lJuwUzAE00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dyx+8G1wKC7cljFk+0oqZ0fq5MYJAO9qlCRYIhyCbiS/KRraGAdJ4X/KwkD/ZRrE7tC3LyVQhKKrq1MjGWWEE99EyMUzi+c0pDg+RKjB1YswY0aVQUKeK8tGvXAEcQj1gYvg9zSe4CGxQ/8EzGLS6CyYi9FJwqprfD+kbQIvd5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t808lmHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FADC19425;
	Thu,  5 Mar 2026 19:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772738811;
	bh=Fl+xG8f3V1m4AHOqnKP1lKLxgOPU2ocJ0lJuwUzAE00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t808lmHOtJGp+XoEZMeQIZVg7/0o/3HSErU+RY/5F+5J0NqG1L34Jvj0iBBc/+DDE
	 r/7MIgLiyGYStNkVQBdbqZEoD5M4CaLlHQqoKGZyFu0nd51YpqzNkTRhCL/TasAH+G
	 7fpNxcQgiZVNXgdMt+0N7wyvqwwfGU6epofo3YLOaP64x8TyoZtUoDwLMbsmi5VXTP
	 8yWCdKrfSiNdn5/Jl2hhYxnqTNDqVrogglSvo0IJcBJn2B39nbudvyT3Ihfm5G+HUQ
	 Lw/I37tWB1s/cOI8nrxDwqppsyUoGECSHCrw4hkFCiq0UrNmgsgHWMM8Cj4fEbALBB
	 ixTfHC06jvDIg==
Date: Thu, 5 Mar 2026 19:26:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: adc: ad4691: add SPI offload support
Message-ID: <20260305192641.3c7c653f@jic23-huawei>
In-Reply-To: <20260305-ad4692-multichannel-sar-adc-driver-v1-4-336229a8dcc7@analog.com>
References: <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
	<20260305-ad4692-multichannel-sar-adc-driver-v1-4-336229a8dcc7@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AF3AD217822
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8194-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,analog.com:email]
X-Rspamd-Action: no action

On Thu, 05 Mar 2026 14:23:30 +0200
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add SPI offload support to the AD4691 family driver to enable
> DMA-based RX stream acquisition. When an SPI offload is available,
> the driver switches to a pre-built SPI message with 32-bit transfers
> (4-byte frames aligned to DMA width) and registers a periodic
> offload trigger for autonomous, CPU-independent sampling.
> 
> The offload path implements its own buffer setup ops
> (ad4691_offload_buffer_postenable/predisable) that enable the
> offload trigger and wire the DMAengine buffer, while the existing
> software triggered buffer path is retained as a fallback for
> non-offload configurations.
> 
> Offload channel specs use a 32-bit storage/repeat with a 16-bit
> shift to extract ADC data from the MSBytes of each DMA word,
> matching the wire format in Manual Mode where SDO outputs ADC data
> directly without a command echo.
> 
> Kconfig gains a dependency on IIO_BUFFER_DMAENGINE.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

Just a few really quick comments as I'm out of time for today.

J

> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> index ab48f336e46c..7ec0a2555a4b 100644
> --- a/drivers/iio/adc/ad4691.c
> +++ b/drivers/iio/adc/ad4691.c
> @@ -8,6 +8,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/dmaengine.h>
>  #include <linux/err.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/hrtimer.h>
> @@ -21,11 +22,15 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
> +#include <linux/spi/offload/consumer.h>
> +#include <linux/spi/offload/provider.h>

This is a provider and a consumer?

>  #include <linux/util_macros.h>
>  #include <linux/units.h>
>  #include <linux/unaligned.h>

> @@ -719,7 +871,9 @@ static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, unsigned int freq
>  		 * count. The exact period is refined at buffer enable time when
>  		 * the active channel count is known.
>  		 */
> -		period_ns = ad4691_cnv_burst_period_ns(st, st->chip->num_channels);
> +		period_ns = ad4691_cnv_burst_period_ns(st,
> +							st->chip->num_channels,
Check for reformatting like occurred for 1st two lines here and try and
tweak earlier patches to reduce the churn.
> +							false);

> +
> +static int ad4691_offload_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	struct spi_offload_trigger *trigger;
> +	int ret = 0, tmp;
> +
> +	trigger = (st->adc_mode == AD4691_MANUAL_MODE) ?
> +		  st->offload_trigger_periodic : st->offload_trigger;
> +
> +	spi_offload_trigger_disable(st->offload, trigger);
> +	spi_unoptimize_message(&st->offload_msg);
> +
> +	/* Stop conversions and reset sequencer state (not needed for MANUAL_MODE) */
> +	if (st->adc_mode != AD4691_MANUAL_MODE) {
> +		tmp = ad4691_sampling_enable(st, false);
> +		if (!ret)
> +			ret = tmp;
> +
> +		tmp = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +				   AD4691_SEQ_ALL_CHANNELS_OFF);
> +		if (!ret)

If that failed, all bets are off.  May be better to just return the error.

> +			ret = tmp;
> +
> +		tmp = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
> +				   AD4691_STATE_RESET_ALL);
> +		if (!ret)
> +			ret = tmp;
> +	}
> +
> +	return ret;
> +}

>  static irqreturn_t ad4691_irq(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
> @@ -1353,10 +1802,17 @@ static void ad4691_setup_channels(struct iio_dev *indio_dev,
>  				  struct ad4691_state *st)
>  {
>  	if (st->adc_mode == AD4691_MANUAL_MODE) {
> -		if (st->chip->num_channels == 8)
> -			indio_dev->channels = ad4693_manual_channels;
> -		else
> -			indio_dev->channels = ad4691_manual_channels;
> +		if (st->offload) {

Add more pointers to channel arrays to the chip_info structures and just look them
up from there.

> +			if (st->chip->num_channels == 8)
> +				indio_dev->channels = ad4693_manual_offload_channels;
> +			else
> +				indio_dev->channels = ad4691_manual_offload_channels;
> +		} else {
> +			if (st->chip->num_channels == 8)
> +				indio_dev->channels = ad4693_manual_channels;
> +			else
> +				indio_dev->channels = ad4691_manual_channels;
> +		}

