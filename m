Return-Path: <linux-pwm+bounces-7433-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E14A8BCCBAB
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Oct 2025 13:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909B04212F0
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Oct 2025 11:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3381E280A5A;
	Fri, 10 Oct 2025 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dM1M3X4T"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490C513A265
	for <linux-pwm@vger.kernel.org>; Fri, 10 Oct 2025 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095165; cv=none; b=H/xIuc6R7kyh5yfGYUiZp2HhtMsH5OiLco/l50Ge2iBjmHEmGcd+dikyuDg0dNEAINQLMn7dZBMWWBdANc7Ev5tQjFMRukpgBse0CYkMYPhHfv9dhf0tviewb2Z32IXSypwWWQM6GPw5Tql3Y/eKmjbEs2y7KpJ4ASL+akNhM0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095165; c=relaxed/simple;
	bh=98nXmX0x/T/SB+0PPttIG7pzObEhxNkc8qTiAG78+Ug=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hz+zfKDVeuDTvvM2GN5An8NdfK1Rxv57BHKWo20H5U41GdkMzk72ti987zUgkKhtA6be7VKS8/uB5g7cKtNRmQ1NH0LBhyNJFMmoBS6EL/uUJlTXHLH2ed251bmGCRaZJ1yfR8Ue2NWkKOYR9rP+eWhzh90jqSkGJO6wX8FnDFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dM1M3X4T; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e52279279so13666875e9.3
        for <linux-pwm@vger.kernel.org>; Fri, 10 Oct 2025 04:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760095161; x=1760699961; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mQUthDybaqmde2khQPID91r0o4Z6OCsl2xip0QA47YU=;
        b=dM1M3X4TWL6Mdq59ri+jwRu4ca/aV/JjeA1+JjFDf8PrRWYn5lLb7F4UmOM21tsnus
         SuJc2xlflF3xe+uTR8V3WRvDOe93tQik+iTw/xUBICNtelBwtpBE5+c0tmh3/4kkRdWP
         CML3w2y61vVllmFHeQ3nByKK+A4i35rAB+i+nZXFq1xcES7Lr9tPHDpzxOee2P9HypyJ
         7nI209J4VxeMJIZu8Mk8SgyehSTDaZelvVRzcbHQbC4ZqMrXJ8zeVBkntvpepODdXHXS
         v9ClPJvpBjBHW+i0P81lnb/bRTinYOK8TEhMySdICIlzFLpFZxyS6bYpfMpEzXCwTPhh
         7TkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760095161; x=1760699961;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQUthDybaqmde2khQPID91r0o4Z6OCsl2xip0QA47YU=;
        b=muzR7fNeRTRUwbatcsUX/JnS8D/4Yib8SZ3iEPa150QrKDcIIrDl2QUDB9Ef+8MMZm
         rqUzQksDsIu3+/QnUD4AQIqMnik2J8ELK2q3v1RGtyC9hX99LRoi1K9ItCDTHaIKtqWB
         MYym0Ahl1XHY9si7qxlmyB+ENKe7x+guvI1O6pl6T5quICbxcQlKgDdSEzLCNMkoTV0q
         nyNxNZOOJTR7Y1updGklHivCndaScV16GsU5YIvQTUNbivfaEuGgd4UwjYu0aFn016H6
         +Z3K9T4oIpluC1zkpe7BJ1UdlPUVroyOMXSLwOONt+ADERwSxQBEe/L6YP+Q1YCwWqzC
         DYPg==
X-Forwarded-Encrypted: i=1; AJvYcCVMW6fZg1mcASs5D6TYAOF1FM1SH3nPs5pFFQkKimclj+P7yNTFWz7l1HdxLC0wEAlziAEL32L5vOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw8uzA3XFOQtYHh+v49G+XnYWbgL2mBqIq1egxLEr4M8vQlJjs
	6Bse3CbYMzGHHK7lzalnFI3H0yf7MJJ9RdkUN/eHD2VQFG+CIkGzt+kl
X-Gm-Gg: ASbGncu2cXlI9LlxfQmV+HlrkaW3lfh1USb9BE0hQ5/OmQyjty2I9cLZtTlL+ScH+H/
	RIjgZAnXAQTp1ag4R7ES/MnMNaKA3phSe6UVk1SVfaVy7Ls7MOrVy2MUW2Ai3tzJ5eGQZqaa6aI
	PYAFDe/nNXQc03ymodddfW+1ea1Vzu/kRRuY6xK3pj21gtO/YsmCvX9laSP2N7eyZpOkIHQsaSK
	PjQXlzwYfnKjy5MqsO9hgkm2PaO4xKhe7WBV1kfYicfjKTsQFmOCJg8o9GMzVzpcPbQxrt+0OjB
	cj9UyP6oMENRHUBu3rUY50QYB3B2O4zpRyPgHvHKfAgHV6wbaw1GfrfI8pk5PdYC1WUdbT7HpMQ
	TWiNbA5Zug5osGxkz0FlvdYKbwCShvVgtX07yXjsacDTnfpP+cw==
X-Google-Smtp-Source: AGHT+IEkS6AeBxxQLKIK3D1w+r7g91Ner9MOmo5++wjJE3I11bfvQ/Ya0TTeOl8ZHBi8TYpwszqnfw==
X-Received: by 2002:a05:600c:4e41:b0:45f:2cf9:c229 with SMTP id 5b1f17b1804b1-46fa9a220b1mr76696275e9.0.1760095160185;
        Fri, 10 Oct 2025 04:19:20 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482b99fsm43797445e9.3.2025.10.10.04.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 04:19:19 -0700 (PDT)
Message-ID: <a86007ab148f9556af032f5ba61991a74a5641c0.camel@gmail.com>
Subject: Re: [PATCH v4 6/8] iio: adc: ad4030: Add SPI offload support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pwm@vger.kernel.org, 	linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, ukleinek@kernel.org, michael.hennerich@analog.com, 
	nuno.sa@analog.com, eblanc@baylibre.com, dlechner@baylibre.com,
 andy@kernel.org, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 corbet@lwn.net, 	marcelo.schmitt1@gmail.com, Trevor Gamblin
 <tgamblin@baylibre.com>, Axel Haslam	 <ahaslam@baylibre.com>
Date: Fri, 10 Oct 2025 12:19:50 +0100
In-Reply-To: <2bde211f1bc730ee147c9540b88339a93b2983e6.1759929814.git.marcelo.schmitt@analog.com>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
	 <2bde211f1bc730ee147c9540b88339a93b2983e6.1759929814.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-08 at 10:51 -0300, Marcelo Schmitt wrote:
> AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> samples per second (MSPS). Not all SPI controllers are able to achieve su=
ch
> high throughputs and even when the controller is fast enough to run
> transfers at the required speed, it may be costly to the CPU to handle
> transfer data at such high sample rates. Add SPI offload support for AD40=
30
> and similar ADCs to enable data capture at maximum sample rates.
>=20
> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v3 -> v4
> - Applied code adjustments suggested to SPI offload patch.
> - Only select SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM).
>=20
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0drivers/iio/adc/ad4030.c | 504 +++++++++++++++++++++++++++++++++++-=
---
> =C2=A02 files changed, 465 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 58a14e6833f6..1ed091b6731a 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -62,7 +62,10 @@ config AD4030
> =C2=A0	depends on GPIOLIB
> =C2=A0	select REGMAP
> =C2=A0	select IIO_BUFFER
> +	select IIO_BUFFER_DMA
> +	select IIO_BUFFER_DMAENGINE
> =C2=A0	select IIO_TRIGGERED_BUFFER
> +	select SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM)

Two things as I mentioned in [1]:

1) Wouldn't 'imply SPI_OFFLOAD_TRIGGER_PWM' accomplish the same?
2) Don't we also need stubs for spi/offload/consumer.h?

[1]: https://lore.kernel.org/linux-pwm/2e82eaf275b5c8df768c8b842167c3562991=
e50c.camel@gmail.com/T/#t
- Nuno S=C3=A1
=20
> =C2=A0	help
> =C2=A0	=C2=A0 Say yes here to build support for Analog Devices AD4030 and=
 AD4630
> high speed
> =C2=A0	=C2=A0 SPI analog to digital converters (ADC).
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index b2847fd90271..bbadcda8df77 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -14,15 +14,25 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> =C2=A0#include <linux/clk.h>
> +#include <linux/dmaengine.h>
> +#include <linux/iio/buffer-dmaengine.h>
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/trigger_consumer.h>
> =C2=A0#include <linux/iio/triggered_buffer.h>
> +#include <linux/limits.h>
> +#include <linux/log2.h>
> +#include <linux/math64.h>
> +#include <linux/minmax.h>
> +#include <linux/pwm.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/regulator/consumer.h>
> +#include <linux/spi/offload/consumer.h>
> =C2=A0#include <linux/spi/spi.h>
> =C2=A0#include <linux/unaligned.h>
> =C2=A0#include <linux/units.h>
> +#include <linux/types.h>
> =C2=A0
> =C2=A0#define AD4030_REG_INTERFACE_CONFIG_A			0x00
> =C2=A0#define=C2=A0=C2=A0=C2=A0=C2=A0 AD4030_REG_INTERFACE_CONFIG_A_SW_RE=
SET	(BIT(0) | BIT(7))
> @@ -111,6 +121,8 @@
> =C2=A0#define AD4632_TCYC_NS			2000
> =C2=A0#define AD4632_TCYC_ADJUSTED_NS		(AD4632_TCYC_NS -
> AD4030_TCNVL_NS)
> =C2=A0#define AD4030_TRESET_COM_DELAY_MS	750
> +/* Datasheet says 9.8ns, so use the closest integer value */
> +#define AD4030_TQUIET_CNV_DELAY_NS	10
> =C2=A0
> =C2=A0enum ad4030_out_mode {
> =C2=A0	AD4030_OUT_DATA_MD_DIFF,
> @@ -136,11 +148,13 @@ struct ad4030_chip_info {
> =C2=A0	const char *name;
> =C2=A0	const unsigned long *available_masks;
> =C2=A0	const struct iio_chan_spec channels[AD4030_MAX_IIO_CHANNEL_NB];
> +	const struct iio_chan_spec
> offload_channels[AD4030_MAX_IIO_CHANNEL_NB];
> =C2=A0	u8 grade;
> =C2=A0	u8 precision_bits;
> =C2=A0	/* Number of hardware channels */
> =C2=A0	int num_voltage_inputs;
> =C2=A0	unsigned int tcyc_ns;
> +	unsigned int max_sample_rate_hz;
> =C2=A0};
> =C2=A0
> =C2=A0struct ad4030_state {
> @@ -153,6 +167,14 @@ struct ad4030_state {
> =C2=A0	int offset_avail[3];
> =C2=A0	unsigned int avg_log2;
> =C2=A0	enum ad4030_out_mode mode;
> +	/* Offload sampling */
> +	struct spi_transfer offload_xfer;
> +	struct spi_message offload_msg;
> +	struct spi_offload *offload;
> +	struct spi_offload_trigger *offload_trigger;
> +	struct spi_offload_trigger_config offload_trigger_config;
> +	struct pwm_device *cnv_trigger;
> +	struct pwm_waveform cnv_wf;
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * DMA (thus cache coherency maintenance) requires the transfer
> buffers
> @@ -209,8 +231,9 @@ struct ad4030_state {
> =C2=A0 * - voltage0-voltage1
> =C2=A0 * - voltage2-voltage3
> =C2=A0 */
> -#define AD4030_CHAN_DIFF(_idx, _scan_type) {				\
> +#define __AD4030_CHAN_DIFF(_idx, _scan_type, _offload) {		\
> =C2=A0	.info_mask_shared_by_all =3D					\
> +		(_offload ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0)
> |		\
> =C2=A0		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
> =C2=A0	.info_mask_shared_by_all_available =3D				\
> =C2=A0		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
> @@ -232,6 +255,12 @@ struct ad4030_state {
> =C2=A0	.num_ext_scan_type =3D ARRAY_SIZE(_scan_type),			\
> =C2=A0}
> =C2=A0
> +#define AD4030_CHAN_DIFF(_idx, _scan_type)				\
> +	__AD4030_CHAN_DIFF(_idx, _scan_type, 0)
> +
> +#define AD4030_OFFLOAD_CHAN_DIFF(_idx, _scan_type)			\
> +	__AD4030_CHAN_DIFF(_idx, _scan_type, 1)
> +
> =C2=A0static const int ad4030_average_modes[] =3D {
> =C2=A0	BIT(0),					/* No
> averaging/oversampling */
> =C2=A0	BIT(1), BIT(2), BIT(3), BIT(4),		/* 2 to 16 */
> @@ -240,6 +269,11 @@ static const int ad4030_average_modes[] =3D {
> =C2=A0	BIT(13), BIT(14), BIT(15), BIT(16),	/* 8192 to 65536 */
> =C2=A0};
> =C2=A0
> +static const struct spi_offload_config ad4030_offload_config =3D {
> +	.capability_flags =3D SPI_OFFLOAD_CAP_TRIGGER |
> +			=C2=A0=C2=A0=C2=A0 SPI_OFFLOAD_CAP_RX_STREAM_DMA,
> +};
> +
> =C2=A0static int ad4030_enter_config_mode(struct ad4030_state *st)
> =C2=A0{
> =C2=A0	st->tx_data[0] =3D AD4030_REG_ACCESS;
> @@ -453,6 +487,107 @@ static int ad4030_get_chan_calibbias(struct iio_dev
> *indio_dev,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static void ad4030_get_sampling_freq(struct ad4030_state *st, int *freq)
> +{
> +	struct spi_offload_trigger_config *config =3D &st-
> >offload_trigger_config;
> +
> +	/*
> +	 * Conversion data is fetched from the device when the offload
> transfer
> +	 * is triggered. Thus, provide the SPI offload trigger frequency as
> the
> +	 * sampling frequency.
> +	 */
> +	*freq =3D config->periodic.frequency_hz;
> +}
> +
> +static int ad4030_update_conversion_rate(struct ad4030_state *st,
> +					 unsigned int freq, unsigned int
> avg_log2)
> +{
> +	struct spi_offload_trigger_config *config =3D &st-
> >offload_trigger_config;
> +	struct pwm_waveform cnv_wf =3D { };
> +	u64 target =3D AD4030_TCNVH_NS;
> +	u64 offload_period_ns;
> +	u64 offload_offset_ns;
> +	int ret;
> +
> +	/*
> +	 * When averaging/oversampling over N samples, we fire the offload
> +	 * trigger once at every N pulses of the CNV signal. Conversely, the
> CNV
> +	 * signal needs to be N times faster than the offload trigger. Take
> that
> +	 * into account to correctly re-evaluate both the PWM waveform
> connected
> +	 * to CNV and the SPI offload trigger.
> +	 */
> +	freq <<=3D avg_log2;
> +
> +	cnv_wf.period_length_ns =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);
> +	/*
> +	 * The datasheet lists a minimum time of 9.8 ns, but no maximum. If
> the
> +	 * rounded PWM's value is less than 10, increase the target value by
> 10
> +	 * and attempt to round the waveform again, until the value is at
> least
> +	 * 10 ns. Use a separate variable to represent the target in case the
> +	 * rounding is severe enough to keep putting the first few results
> under
> +	 * the minimum 10ns condition checked by the while loop.
> +	 */
> +	do {
> +		cnv_wf.duty_length_ns =3D target;
> +		ret =3D pwm_round_waveform_might_sleep(st->cnv_trigger,
> &cnv_wf);
> +		if (ret)
> +			return ret;
> +		target +=3D AD4030_TCNVH_NS;
> +	} while (cnv_wf.duty_length_ns < AD4030_TCNVH_NS);
> +
> +	if (!in_range(cnv_wf.period_length_ns, AD4030_TCYC_NS, INT_MAX))
> +		return -EINVAL;
> +
> +	offload_period_ns =3D cnv_wf.period_length_ns;
> +	/*
> +	 * Make the offload trigger period be N times longer than the CNV PWM
> +	 * period when averaging over N samples.
> +	 */
> +	offload_period_ns <<=3D avg_log2;
> +
> +	config->periodic.frequency_hz =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC,
> +							 offload_period_ns);
> +
> +	/*
> +	 * The hardware does the capture on zone 2 (when SPI trigger PWM
> +	 * is used). This means that the SPI trigger signal should happen at
> +	 * tsync + tquiet_con_delay being tsync the conversion signal period
> +	 * and tquiet_con_delay 9.8ns. Hence set the PWM phase accordingly.
> +	 *
> +	 * The PWM waveform API only supports nanosecond resolution right
> now,
> +	 * so round this setting to the closest available value.
> +	 */
> +	offload_offset_ns =3D AD4030_TQUIET_CNV_DELAY_NS;
> +	do {
> +		config->periodic.offset_ns =3D offload_offset_ns;
> +		ret =3D spi_offload_trigger_validate(st->offload_trigger,
> config);
> +		if (ret)
> +			return ret;
> +		offload_offset_ns +=3D AD4030_TQUIET_CNV_DELAY_NS;
> +	} while (config->periodic.offset_ns < AD4030_TQUIET_CNV_DELAY_NS);
> +
> +	st->cnv_wf =3D cnv_wf;
> +
> +	return 0;
> +}
> +
> +static int ad4030_set_sampling_freq(struct iio_dev *indio_dev, int freq)
> +{
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +
> +	/*
> +	 * We have no control over the sampling frequency without SPI offload
> +	 * triggering.
> +	 */
> +	if (!st->offload_trigger)
> +		return -ENODEV;
> +
> +	if (!in_range(freq, 1, st->chip->max_sample_rate_hz))
> +		return -EINVAL;
> +
> +	return ad4030_update_conversion_rate(st, freq, st->avg_log2);
> +}
> +
> =C2=A0static int ad4030_set_chan_calibscale(struct iio_dev *indio_dev,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan=
,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int gain_int,
> @@ -507,27 +642,6 @@ static int ad4030_set_chan_calibbias(struct iio_dev
> *indio_dev,
> =C2=A0				 st->tx_data, AD4030_REG_OFFSET_BYTES_NB);
> =C2=A0}
> =C2=A0
> -static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
> -{
> -	struct ad4030_state *st =3D iio_priv(dev);
> -	unsigned int avg_log2 =3D ilog2(avg_val);
> -	unsigned int last_avg_idx =3D ARRAY_SIZE(ad4030_average_modes) - 1;
> -	int ret;
> -
> -	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
> -		return -EINVAL;
> -
> -	ret =3D regmap_write(st->regmap, AD4030_REG_AVG,
> -			=C2=A0=C2=A0 AD4030_REG_AVG_MASK_AVG_SYNC |
> -			=C2=A0=C2=A0 FIELD_PREP(AD4030_REG_AVG_MASK_AVG_VAL,
> avg_log2));
> -	if (ret)
> -		return ret;
> -
> -	st->avg_log2 =3D avg_log2;
> -
> -	return 0;
> -}
> -
> =C2=A0static bool ad4030_is_common_byte_asked(struct ad4030_state *st,
> =C2=A0					unsigned int mask)
> =C2=A0{
> @@ -536,11 +650,10 @@ static bool ad4030_is_common_byte_asked(struct
> ad4030_state *st,
> =C2=A0		AD4030_DUAL_COMMON_BYTE_CHANNELS_MASK);
> =C2=A0}
> =C2=A0
> -static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask=
)
> +static int ad4030_set_mode(struct ad4030_state *st, unsigned long mask,
> +			=C2=A0=C2=A0 unsigned int avg_log2)
> =C2=A0{
> -	struct ad4030_state *st =3D iio_priv(indio_dev);
> -
> -	if (st->avg_log2 > 0) {
> +	if (avg_log2 > 0) {
> =C2=A0		st->mode =3D AD4030_OUT_DATA_MD_30_AVERAGED_DIFF;
> =C2=A0	} else if (ad4030_is_common_byte_asked(st, mask)) {
> =C2=A0		switch (st->chip->precision_bits) {
> @@ -564,6 +677,49 @@ static int ad4030_set_mode(struct iio_dev *indio_dev=
,
> unsigned long mask)
> =C2=A0				=C2=A0 st->mode);
> =C2=A0}
> =C2=A0
> +static int ad4030_set_avg_frame_len(struct iio_dev *dev, unsigned long m=
ask,
> int avg_val)
> +{
> +	struct ad4030_state *st =3D iio_priv(dev);
> +	unsigned int avg_log2 =3D ilog2(avg_val);
> +	unsigned int last_avg_idx =3D ARRAY_SIZE(ad4030_average_modes) - 1;
> +	int freq;
> +	int ret;
> +
> +	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
> +		return -EINVAL;
> +
> +	ret =3D ad4030_set_mode(st, mask, avg_log2);
> +	if (ret)
> +		return ret;
> +
> +	if (st->offload_trigger) {
> +		/*
> +		 * The sample averaging and sampling frequency configurations
> +		 * are mutually dependent one from another. That's because
> the
> +		 * effective data sample rate is fCNV / 2^N, where N is the
> +		 * number of samples being averaged.
> +		 *
> +		 * When SPI offload is supported and we have control over the
> +		 * sample rate, the conversion start signal (CNV) and the SPI
> +		 * offload trigger frequencies must be re-evaluated so data
> is
> +		 * fetched only after 'avg_val' conversions.
> +		 */
> +		ad4030_get_sampling_freq(st, &freq);
> +		ret =3D ad4030_update_conversion_rate(st, freq, avg_log2);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D regmap_write(st->regmap, AD4030_REG_AVG,
> +			=C2=A0=C2=A0 AD4030_REG_AVG_MASK_AVG_SYNC |
> +			=C2=A0=C2=A0 FIELD_PREP(AD4030_REG_AVG_MASK_AVG_VAL,
> avg_log2));
> +	if (ret)
> +		return ret;
> +
> +	st->avg_log2 =3D avg_log2;
> +	return 0;
> +}
> +
> =C2=A0/*
> =C2=A0 * Descramble 2 32bits numbers out of a 64bits. The bits are interl=
eaved:
> =C2=A0 * 1 bit for first number, 1 bit for the second, and so on...
> @@ -672,7 +828,7 @@ static int ad4030_single_conversion(struct iio_dev
> *indio_dev,
> =C2=A0	struct ad4030_state *st =3D iio_priv(indio_dev);
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D ad4030_set_mode(indio_dev, BIT(chan->scan_index));
> +	ret =3D ad4030_set_mode(st, BIT(chan->scan_index), st->avg_log2);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -769,6 +925,13 @@ static int ad4030_read_raw_dispatch(struct iio_dev
> *indio_dev,
> =C2=A0		*val =3D BIT(st->avg_log2);
> =C2=A0		return IIO_VAL_INT;
> =C2=A0
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (!st->offload_trigger)
> +			return -ENODEV;
> +
> +		ad4030_get_sampling_freq(st, val);
> +		return IIO_VAL_INT;
> +
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> @@ -807,7 +970,10 @@ static int ad4030_write_raw_dispatch(struct iio_dev
> *indio_dev,
> =C2=A0		return ad4030_set_chan_calibbias(indio_dev, chan, val);
> =C2=A0
> =C2=A0	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		return ad4030_set_avg_frame_len(indio_dev, val);
> +		return ad4030_set_avg_frame_len(indio_dev, BIT(chan-
> >scan_index), val);
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad4030_set_sampling_freq(indio_dev, val);
> =C2=A0
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> @@ -869,7 +1035,11 @@ static int ad4030_get_current_scan_type(const struc=
t
> iio_dev *indio_dev,
> =C2=A0static int ad4030_update_scan_mode(struct iio_dev *indio_dev,
> =C2=A0				=C2=A0=C2=A0 const unsigned long *scan_mask)
> =C2=A0{
> -	return ad4030_set_mode(indio_dev, *scan_mask);
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +
> +	//return ad4030_set_mode(st, *scan_mask, st->avg_log2);
> +	//return ad4030_set_mode(iio_priv(indio_dev), &scan_mask, st-
> >avg_log2);
> +	return ad4030_set_mode(iio_priv(indio_dev), *scan_mask, st-
> >avg_log2);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct iio_info ad4030_iio_info =3D {
> @@ -898,6 +1068,108 @@ static const struct iio_buffer_setup_ops
> ad4030_buffer_setup_ops =3D {
> =C2=A0	.validate_scan_mask =3D ad4030_validate_scan_mask,
> =C2=A0};
> =C2=A0
> +static void ad4030_prepare_offload_msg(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +	u8 offload_bpw;
> +
> +	if (st->mode =3D=3D AD4030_OUT_DATA_MD_30_AVERAGED_DIFF) {
> +		offload_bpw =3D 32;
> +	} else {
> +		offload_bpw =3D st->chip->precision_bits;
> +		offload_bpw +=3D (st->mode =3D=3D AD4030_OUT_DATA_MD_24_DIFF_8_COM
> ||
> +				st->mode =3D=3D AD4030_OUT_DATA_MD_16_DIFF_8_COM)
> ? 8 : 0;
> +	}
> +
> +	st->offload_xfer.bits_per_word =3D offload_bpw;
> +	st->offload_xfer.len =3D spi_bpw_to_bytes(offload_bpw);
> +	st->offload_xfer.offload_flags =3D SPI_OFFLOAD_XFER_RX_STREAM;
> +	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer,
> 1);
> +}
> +
> +static int ad4030_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +	unsigned int reg_modes;
> +	int ret, ret2;
> +
> +	/*
> +	 * When data from 2 analog input channels is output through a single
> +	 * bus line (interleaved mode (LANE_MD =3D=3D 0b11)) and gets pushed
> through
> +	 * DMA, extra hardware is required to do the de-interleaving. While
> we
> +	 * don't support such hardware configurations, disallow interleaved
> mode
> +	 * when using SPI offload.
> +	 */
> +	ret =3D regmap_read(st->regmap, AD4030_REG_MODES, &reg_modes);
> +	if (ret)
> +		return ret;
> +
> +	if (st->chip->num_voltage_inputs > 1 &&
> +	=C2=A0=C2=A0=C2=A0 FIELD_GET(AD4030_REG_MODES_MASK_LANE_MODE, reg_modes=
) =3D=3D
> AD4030_LANE_MD_INTERLEAVED)
> +		return -EINVAL;
> +
> +	ret =3D regmap_write(st->regmap, AD4030_REG_EXIT_CFG_MODE, BIT(0));
> +	if (ret)
> +		return ret;
> +
> +	ad4030_prepare_offload_msg(indio_dev);
> +	st->offload_msg.offload =3D st->offload;
> +	ret =3D spi_optimize_message(st->spi, &st->offload_msg);
> +	if (ret)
> +		goto out_reset_mode;
> +
> +	ret =3D pwm_set_waveform_might_sleep(st->cnv_trigger, &st->cnv_wf,
> false);
> +	if (ret)
> +		goto out_unoptimize;
> +
> +	ret =3D spi_offload_trigger_enable(st->offload, st->offload_trigger,
> +					 &st->offload_trigger_config);
> +	if (ret)
> +		goto out_pwm_disable;
> +
> +	return 0;
> +
> +out_pwm_disable:
> +	pwm_disable(st->cnv_trigger);
> +out_unoptimize:
> +	spi_unoptimize_message(&st->offload_msg);
> +out_reset_mode:
> +	/* reenter register configuration mode */
> +	ret2 =3D ad4030_enter_config_mode(st);
> +	if (ret2)
> +		dev_err(&st->spi->dev,
> +			"couldn't reenter register configuration mode: %d\n",
> +			ret2);
> +
> +	return ret;
> +}
> +
> +static int ad4030_offload_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> +
> +	pwm_disable(st->cnv_trigger);
> +
> +	spi_unoptimize_message(&st->offload_msg);
> +
> +	/* reenter register configuration mode */
> +	ret =3D ad4030_enter_config_mode(st);
> +	if (ret)
> +		dev_err(&st->spi->dev,
> +			"couldn't reenter register configuration mode\n");
> +
> +	return ret;
> +}
> +
> +static const struct iio_buffer_setup_ops ad4030_offload_buffer_setup_ops=
 =3D {
> +	.postenable =3D &ad4030_offload_buffer_postenable,
> +	.predisable =3D &ad4030_offload_buffer_predisable,
> +	.validate_scan_mask =3D ad4030_validate_scan_mask,
> +};
> +
> =C2=A0static int ad4030_regulators_get(struct ad4030_state *st)
> =C2=A0{
> =C2=A0	struct device *dev =3D &st->spi->dev;
> @@ -967,6 +1239,24 @@ static int ad4030_detect_chip_info(const struct
> ad4030_state *st)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int ad4030_pwm_get(struct ad4030_state *st)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +
> +	st->cnv_trigger =3D devm_pwm_get(dev, NULL);
> +	if (IS_ERR(st->cnv_trigger))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv_trigger),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get CNV PWM\n");
> +
> +	/*
> +	 * Preemptively disable the PWM, since we only want to enable it with
> +	 * the buffer.
> +	 */
> +	pwm_disable(st->cnv_trigger);
> +
> +	return 0;
> +}
> +
> =C2=A0static int ad4030_config(struct ad4030_state *st)
> =C2=A0{
> =C2=A0	int ret;
> @@ -994,6 +1284,31 @@ static int ad4030_config(struct ad4030_state *st)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int ad4030_spi_offload_setup(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0 struct ad4030_state *st)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +	struct dma_chan *rx_dma;
> +
> +	indio_dev->setup_ops =3D &ad4030_offload_buffer_setup_ops;
> +
> +	st->offload_trigger =3D devm_spi_offload_trigger_get(dev, st->offload,
> +							=C2=A0=C2=A0
> SPI_OFFLOAD_TRIGGER_PERIODIC);
> +	if (IS_ERR(st->offload_trigger))
> +		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get offload trigger\n");
> +
> +	st->offload_trigger_config.type =3D SPI_OFFLOAD_TRIGGER_PERIODIC;
> +
> +	rx_dma =3D devm_spi_offload_rx_stream_request_dma_chan(dev, st-
> >offload);
> +	if (IS_ERR(rx_dma))
> +		return dev_err_probe(dev, PTR_ERR(rx_dma),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get offload RX DMA\n");
> +
> +	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,
> rx_dma,
> +							=C2=A0=C2=A0
> IIO_BUFFER_DIRECTION_IN);
> +}
> +
> =C2=A0static int ad4030_probe(struct spi_device *spi)
> =C2=A0{
> =C2=A0	struct device *dev =3D &spi->dev;
> @@ -1045,24 +1360,61 @@ static int ad4030_probe(struct spi_device *spi)
> =C2=A0		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get cnv gpio\n");
> =C2=A0
> -	/*
> -	 * One hardware channel is split in two software channels when using
> -	 * common byte mode. Add one more channel for the timestamp.
> -	 */
> -	indio_dev->num_channels =3D 2 * st->chip->num_voltage_inputs + 1;
> =C2=A0	indio_dev->name =3D st->chip->name;
> =C2=A0	indio_dev->modes =3D INDIO_DIRECT_MODE;
> =C2=A0	indio_dev->info =3D &ad4030_iio_info;
> -	indio_dev->channels =3D st->chip->channels;
> =C2=A0	indio_dev->available_scan_masks =3D st->chip->available_masks;
> =C2=A0
> -	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_pollfunc_store_time,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad4030_trigger_handler,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &ad4030_buffer_setup_ops);
> -	if (ret)
> -		return dev_err_probe(dev, ret,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to setup triggered buffer\n");
> +	st->offload =3D devm_spi_offload_get(dev, spi, &ad4030_offload_config);
> +	ret =3D PTR_ERR_OR_ZERO(st->offload);
> +	if (ret && ret !=3D -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to get offload\n");
> +
> +	/* Fall back to low speed usage when no SPI offload is available. */
> +	if (ret =3D=3D -ENODEV) {
> +		/*
> +		 * One hardware channel is split in two software channels
> when
> +		 * using common byte mode. Add one more channel for the
> timestamp.
> +		 */
> +		indio_dev->num_channels =3D 2 * st->chip->num_voltage_inputs +
> 1;
> +		indio_dev->channels =3D st->chip->channels;
> +
> +		ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> iio_pollfunc_store_time,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad4030_trigger_handler,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> &ad4030_buffer_setup_ops);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to setup triggered
> buffer\n");
> +	} else {
> +		/*
> +		 * One hardware channel is split in two software channels
> when
> +		 * using common byte mode. Offloaded SPI transfers can't
> support
> +		 * software timestamp so no additional timestamp channel is
> added.
> +		 */
> +		indio_dev->num_channels =3D 2 * st->chip->num_voltage_inputs;
> +		indio_dev->channels =3D st->chip->offload_channels;
> +		ret =3D ad4030_spi_offload_setup(indio_dev, st);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to setup SPI
> offload\n");
> +
> +		ret =3D ad4030_pwm_get(st);
> +		if (ret)
> +			return dev_err_probe(&spi->dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get PWM: %d\n", ret);
> +
> +		/*
> +		 * Start with a slower sampling rate so there is some room
> for
> +		 * adjusting the sample averaging and the sampling frequency
> +		 * without hitting the maximum conversion rate.
> +		 */
> +		ret =3D ad4030_update_conversion_rate(st, st->chip-
> >max_sample_rate_hz >> 4,
> +						=C2=A0=C2=A0=C2=A0 st->avg_log2);
> +		if (ret)
> +			return dev_err_probe(&spi->dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to set offload samp
> freq\n");
> +	}
> =C2=A0
> =C2=A0	return devm_iio_device_register(dev, indio_dev);
> =C2=A0}
> @@ -1100,6 +1452,23 @@ static const struct iio_scan_type
> ad4030_24_scan_types[] =3D {
> =C2=A0	},
> =C2=A0};
> =C2=A0
> +static const struct iio_scan_type ad4030_24_offload_scan_types[] =3D {
> +	[AD4030_SCAN_TYPE_NORMAL] =3D {
> +		.sign =3D 's',
> +		.storagebits =3D 32,
> +		.realbits =3D 24,
> +		.shift =3D 0,
> +		.endianness =3D IIO_CPU,
> +	},
> +	[AD4030_SCAN_TYPE_AVG] =3D {
> +		.sign =3D 's',
> +		.storagebits =3D 32,
> +		.realbits =3D 30,
> +		.shift =3D 2,
> +		.endianness =3D IIO_CPU,
> +	},
> +};
> +
> =C2=A0static const struct iio_scan_type ad4030_16_scan_types[] =3D {
> =C2=A0	[AD4030_SCAN_TYPE_NORMAL] =3D {
> =C2=A0		.sign =3D 's',
> @@ -1117,6 +1486,23 @@ static const struct iio_scan_type
> ad4030_16_scan_types[] =3D {
> =C2=A0	}
> =C2=A0};
> =C2=A0
> +static const struct iio_scan_type ad4030_16_offload_scan_types[] =3D {
> +	[AD4030_SCAN_TYPE_NORMAL] =3D {
> +		.sign =3D 's',
> +		.storagebits =3D 32,
> +		.realbits =3D 16,
> +		.shift =3D 0,
> +		.endianness =3D IIO_CPU,
> +	},
> +	[AD4030_SCAN_TYPE_AVG] =3D {
> +		.sign =3D 's',
> +		.storagebits =3D 32,
> +		.realbits =3D 30,
> +		.shift =3D 2,
> +		.endianness =3D IIO_CPU,
> +	},
> +};
> +
> =C2=A0static const struct ad4030_chip_info ad4030_24_chip_info =3D {
> =C2=A0	.name =3D "ad4030-24",
> =C2=A0	.available_masks =3D ad4030_channel_masks,
> @@ -1125,10 +1511,15 @@ static const struct ad4030_chip_info
> ad4030_24_chip_info =3D {
> =C2=A0		AD4030_CHAN_CMO(1, 0),
> =C2=A0		IIO_CHAN_SOFT_TIMESTAMP(2),
> =C2=A0	},
> +	.offload_channels =3D {
> +		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
> +		AD4030_CHAN_CMO(1, 0),
> +	},
> =C2=A0	.grade =3D AD4030_REG_CHIP_GRADE_AD4030_24_GRADE,
> =C2=A0	.precision_bits =3D 24,
> =C2=A0	.num_voltage_inputs =3D 1,
> =C2=A0	.tcyc_ns =3D AD4030_TCYC_ADJUSTED_NS,
> +	.max_sample_rate_hz =3D 2 * HZ_PER_MHZ,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct ad4030_chip_info ad4630_16_chip_info =3D {
> @@ -1141,10 +1532,17 @@ static const struct ad4030_chip_info
> ad4630_16_chip_info =3D {
> =C2=A0		AD4030_CHAN_CMO(3, 1),
> =C2=A0		IIO_CHAN_SOFT_TIMESTAMP(4),
> =C2=A0	},
> +	.offload_channels =3D {
> +		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
> +		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
> +		AD4030_CHAN_CMO(2, 0),
> +		AD4030_CHAN_CMO(3, 1),
> +	},
> =C2=A0	.grade =3D AD4030_REG_CHIP_GRADE_AD4630_16_GRADE,
> =C2=A0	.precision_bits =3D 16,
> =C2=A0	.num_voltage_inputs =3D 2,
> =C2=A0	.tcyc_ns =3D AD4030_TCYC_ADJUSTED_NS,
> +	.max_sample_rate_hz =3D 2 * HZ_PER_MHZ,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct ad4030_chip_info ad4630_24_chip_info =3D {
> @@ -1157,10 +1555,17 @@ static const struct ad4030_chip_info
> ad4630_24_chip_info =3D {
> =C2=A0		AD4030_CHAN_CMO(3, 1),
> =C2=A0		IIO_CHAN_SOFT_TIMESTAMP(4),
> =C2=A0	},
> +	.offload_channels =3D {
> +		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
> +		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
> +		AD4030_CHAN_CMO(2, 0),
> +		AD4030_CHAN_CMO(3, 1),
> +	},
> =C2=A0	.grade =3D AD4030_REG_CHIP_GRADE_AD4630_24_GRADE,
> =C2=A0	.precision_bits =3D 24,
> =C2=A0	.num_voltage_inputs =3D 2,
> =C2=A0	.tcyc_ns =3D AD4030_TCYC_ADJUSTED_NS,
> +	.max_sample_rate_hz =3D 2 * HZ_PER_MHZ,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct ad4030_chip_info ad4632_16_chip_info =3D {
> @@ -1173,10 +1578,17 @@ static const struct ad4030_chip_info
> ad4632_16_chip_info =3D {
> =C2=A0		AD4030_CHAN_CMO(3, 1),
> =C2=A0		IIO_CHAN_SOFT_TIMESTAMP(4),
> =C2=A0	},
> +	.offload_channels =3D {
> +		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
> +		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
> +		AD4030_CHAN_CMO(2, 0),
> +		AD4030_CHAN_CMO(3, 1),
> +	},
> =C2=A0	.grade =3D AD4030_REG_CHIP_GRADE_AD4632_16_GRADE,
> =C2=A0	.precision_bits =3D 16,
> =C2=A0	.num_voltage_inputs =3D 2,
> =C2=A0	.tcyc_ns =3D AD4632_TCYC_ADJUSTED_NS,
> +	.max_sample_rate_hz =3D 500 * HZ_PER_KHZ,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct ad4030_chip_info ad4632_24_chip_info =3D {
> @@ -1189,10 +1601,17 @@ static const struct ad4030_chip_info
> ad4632_24_chip_info =3D {
> =C2=A0		AD4030_CHAN_CMO(3, 1),
> =C2=A0		IIO_CHAN_SOFT_TIMESTAMP(4),
> =C2=A0	},
> +	.offload_channels =3D {
> +		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
> +		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
> +		AD4030_CHAN_CMO(2, 0),
> +		AD4030_CHAN_CMO(3, 1),
> +	},
> =C2=A0	.grade =3D AD4030_REG_CHIP_GRADE_AD4632_24_GRADE,
> =C2=A0	.precision_bits =3D 24,
> =C2=A0	.num_voltage_inputs =3D 2,
> =C2=A0	.tcyc_ns =3D AD4632_TCYC_ADJUSTED_NS,
> +	.max_sample_rate_hz =3D 500 * HZ_PER_KHZ,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct spi_device_id ad4030_id_table[] =3D {
> @@ -1228,3 +1647,4 @@ module_spi_driver(ad4030_driver);
> =C2=A0MODULE_AUTHOR("Esteban Blanc <eblanc@baylibre.com>");
> =C2=A0MODULE_DESCRIPTION("Analog Devices AD4630 ADC family driver");
> =C2=A0MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");

