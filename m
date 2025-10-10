Return-Path: <linux-pwm+bounces-7438-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C344BCE1B3
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Oct 2025 19:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C2034E1503
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Oct 2025 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FAA221F39;
	Fri, 10 Oct 2025 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jpLHSzkj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B08221578
	for <linux-pwm@vger.kernel.org>; Fri, 10 Oct 2025 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117971; cv=none; b=WevlN+UKc714VGQL8lOpIIYO627ADqmyqNuy0/6w2GbYvHVimy0GRNsfEL2wQybyjjEQ5d/RY5lhczFO0XKOOEsVlNs8G2CyBCwo3H5mQpL4UEaB74QsQzr4F/e1BX0IVAMt1kz2ACtBd6TQm/soCmX+zKQXi9LsaNy7CLRzcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117971; c=relaxed/simple;
	bh=p8y/s+CYhyKDayoBztOHI0AHLWMRrYFOjG75hEUhgYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2NsfzleWg7afO4TYAWV1RO6/DG7Sc/DogUt3+nGAg3wPtMhD7VvCdXpNhkhr2SRgQS4dGyxoBXDUzvJxLyvaIbTkmZ7HCe3VipiY+9RMX/gcqSjmmHS/nS4HDFvAWNNE+AbsYCJ4ONw0QRHaISaotkupLwFlGS0SfSYdU9982c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jpLHSzkj; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-43fac2df7d4so1113074b6e.3
        for <linux-pwm@vger.kernel.org>; Fri, 10 Oct 2025 10:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760117968; x=1760722768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZ+Dy49i07NMHWC9th7IGBEaPJ8wyTfsNg8yJ9Fy9+c=;
        b=jpLHSzkjzBTfhvqzjF+1UoFXwfHroKWEBjQmLedwpn/L1F4K1yErjcpEDYwELsh9dO
         Vg5j0/p3qDmiiiT/HpgdHR9XHrn3ppPhB+rIFIs+yL82nhMbPcceU81iMvcTt4S4Ix/a
         dDzczYVBhGcY/p4E2AJ1NLMV1yX2g4bJh65z4v0JQHfGEbFj8w99EnsYgByCMQlCzX8k
         ZO/Biz0z+iked0T7lpsw8wIkzUmyxqSM/T6OqkSr2O9bU+clsKHLfR0dabz0uM7goFU1
         QXlCYmjeo42cB9/wHrOkSlvsXzIHXx6aBUovAFRwIiq07bXv4rf+Oip4+nCue/iFWz9i
         VAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760117968; x=1760722768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ+Dy49i07NMHWC9th7IGBEaPJ8wyTfsNg8yJ9Fy9+c=;
        b=EgJ4jyXTY6t4Ot5oj3rk1VtHlrMj683x/Y0ACKxiit7JtOpNpd56fNovRSr8NnDGvN
         OQEYdYuQ6YORqVOKsHZHqUcysNHjtn80/Mcar9LRS5MYvWcU2MYNUsKYLgx2Jgz5BMmB
         PvmfZs2KQEQDSGq4a0U9LCtiIWJuhka6wjahsXHBsiNcPPegmjzq5Bu+mx8Rgyet4kju
         jIhvUGYCBktYeLglEj+Lc2WTL0MR/3avKaKMzZr7V0OuiMMwEF+D6DqhJNDVp17HikH2
         ZiVFKj0sxBKBOc5j4MqnfWjIBGrhQLIeUatKKlWTnf98SFzxJiGaeHnXrWTbv5eO6L2f
         KCiw==
X-Forwarded-Encrypted: i=1; AJvYcCVe0LC/jP76YDiX//yAM4pq3+Hfww/MnMxto04Z+jusiG5WJj52XlN4r95HFtmaUpkpoMkN+xfQAHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKA10cMRs7szJJNNl6wlNsTLy281dTYA5zcLVOt+WQQMF9PBUX
	TdlQL5X28LDT3NKDgz6ayrLib09Zv68V//5MSoPTaBtzSHyxTw4RBDHksD+SP0mBmow=
X-Gm-Gg: ASbGncuA9jM/cn0mtsRpPaam/h/ddkrfp70B+g8+GRidfBnZlEBkz9PKRQnHa/k7X+V
	OSjNYR3LINjp+5bEJ1DBNkUrQwWX3kLHQy6APPLy5ZLELibLadVrgOu1xBR62G1DvrXm53R/TRl
	0rz+uP513TDTfOlz6UMkW1omC6NOXyWIoMyOCOhPnWrQP3aDssg0vJt4A7L40+eYtsbINwgdgHp
	kEi6krtZRbsq3kuY+pnjLxefDxH8oyEgtlmvkYwkjLhT7Tjau28MoN16ZgzggDFiBdBS1gDwEXW
	BefziC/DSvPHVyPXZ0beN1R++sKnsiJ4cPXQmvH1adfFIYZ5TqfeocDgy/bvioIsbp1PsrW19wM
	cBR8bqN/PObXv6GfhS/Mw9gNe7i5/7c0xurUvXUT4/zFP0KpvyPBQYyGne/N0ioOXegvB21WPOq
	m6hyftAnWe6ddQvdE=
X-Google-Smtp-Source: AGHT+IEYhPYvlDBLZaZqlLGB+iUT5R4ASjXBM6uBeyLBN/sayw6DH2MjRiDQ+SBu7/siJhgOZPrD1g==
X-Received: by 2002:a05:6808:2223:b0:43f:55f2:4c44 with SMTP id 5614622812f47-4417b2d22c4mr5138879b6e.3.1760117968269;
        Fri, 10 Oct 2025 10:39:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6d3b:e3bd:4210:32e2? ([2600:8803:e7e4:500:6d3b:e3bd:4210:32e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f915efddsm1009636a34.34.2025.10.10.10.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 10:39:27 -0700 (PDT)
Message-ID: <56f63486-20e7-4c9b-8a39-da904b4600ad@baylibre.com>
Date: Fri, 10 Oct 2025 12:39:25 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] iio: adc: ad4030: Add SPI offload support
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, ukleinek@kernel.org, michael.hennerich@analog.com,
 nuno.sa@analog.com, eblanc@baylibre.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
 marcelo.schmitt1@gmail.com, Trevor Gamblin <tgamblin@baylibre.com>,
 Axel Haslam <ahaslam@baylibre.com>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
 <2bde211f1bc730ee147c9540b88339a93b2983e6.1759929814.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2bde211f1bc730ee147c9540b88339a93b2983e6.1759929814.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/25 8:51 AM, Marcelo Schmitt wrote:

...

> +static int ad4030_update_conversion_rate(struct ad4030_state *st,
> +					 unsigned int freq, unsigned int avg_log2)

Always nice to have the units, e.g. freq_hz.

> +{
> +	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
> +	struct pwm_waveform cnv_wf = { };
> +	u64 target = AD4030_TCNVH_NS;
> +	u64 offload_period_ns;
> +	u64 offload_offset_ns;
> +	int ret;
> +
> +	/*
> +	 * When averaging/oversampling over N samples, we fire the offload
> +	 * trigger once at every N pulses of the CNV signal. Conversely, the CNV
> +	 * signal needs to be N times faster than the offload trigger. Take that
> +	 * into account to correctly re-evaluate both the PWM waveform connected
> +	 * to CNV and the SPI offload trigger.
> +	 */
> +	freq <<= avg_log2;

nit: modifying function arguments throws me off when reading the code. Would prefer
an additional local variable for this, e.g. cnv_rate_hz = freq << avg_log2.

> +
> +	cnv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);
> +	/*
> +	 * The datasheet lists a minimum time of 9.8 ns, but no maximum. If the
> +	 * rounded PWM's value is less than 10, increase the target value by 10
> +	 * and attempt to round the waveform again, until the value is at least
> +	 * 10 ns. Use a separate variable to represent the target in case the
> +	 * rounding is severe enough to keep putting the first few results under
> +	 * the minimum 10ns condition checked by the while loop.
> +	 */
> +	do {
> +		cnv_wf.duty_length_ns = target;
> +		ret = pwm_round_waveform_might_sleep(st->cnv_trigger, &cnv_wf);
> +		if (ret)
> +			return ret;
> +		target += AD4030_TCNVH_NS;
> +	} while (cnv_wf.duty_length_ns < AD4030_TCNVH_NS);
> +
> +	if (!in_range(cnv_wf.period_length_ns, AD4030_TCYC_NS, INT_MAX))
> +		return -EINVAL;
> +
> +	offload_period_ns = cnv_wf.period_length_ns;
> +	/*
> +	 * Make the offload trigger period be N times longer than the CNV PWM
> +	 * period when averaging over N samples.
> +	 */
> +	offload_period_ns <<= avg_log2;

Then this could be:

	offload_period_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);

Which might avoid some rounding issues.

period_length_ns can have up to 0.5 ns differnce from the exact value, so when
multiplying that by a large oversampling rate (up to 64k), that rounding error
would really add up.

> +
> +	config->periodic.frequency_hz = DIV_ROUND_UP_ULL(NSEC_PER_SEC,
> +							 offload_period_ns);
> +
> +	/*
> +	 * The hardware does the capture on zone 2 (when SPI trigger PWM
> +	 * is used). This means that the SPI trigger signal should happen at
> +	 * tsync + tquiet_con_delay being tsync the conversion signal period
> +	 * and tquiet_con_delay 9.8ns. Hence set the PWM phase accordingly.
> +	 *
> +	 * The PWM waveform API only supports nanosecond resolution right now,
> +	 * so round this setting to the closest available value.
> +	 */
> +	offload_offset_ns = AD4030_TQUIET_CNV_DELAY_NS;
> +	do {
> +		config->periodic.offset_ns = offload_offset_ns;
> +		ret = spi_offload_trigger_validate(st->offload_trigger, config);
> +		if (ret)
> +			return ret;
> +		offload_offset_ns += AD4030_TQUIET_CNV_DELAY_NS;
> +	} while (config->periodic.offset_ns < AD4030_TQUIET_CNV_DELAY_NS);
> +
> +	st->cnv_wf = cnv_wf;
> +
> +	return 0;
> +}

...

> +static int ad4030_set_avg_frame_len(struct iio_dev *dev, unsigned long mask, int avg_val)
> +{
> +	struct ad4030_state *st = iio_priv(dev);
> +	unsigned int avg_log2 = ilog2(avg_val);
> +	unsigned int last_avg_idx = ARRAY_SIZE(ad4030_average_modes) - 1;
> +	int freq;
> +	int ret;
> +
> +	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
> +		return -EINVAL;
> +
> +	ret = ad4030_set_mode(st, mask, avg_log2);

I still think setting the mode here is wrong for the reasons given in a previous review.
There is no "correct" mode until we have a request to read a sample.

And if we drop this, then we can return ad4030_set_avg_frame_len() to it's original
location and reduce the diff.

> +	if (ret)
> +		return ret;
> +
> +	if (st->offload_trigger) {
> +		/*
> +		 * The sample averaging and sampling frequency configurations
> +		 * are mutually dependent one from another. That's because the
> +		 * effective data sample rate is fCNV / 2^N, where N is the
> +		 * number of samples being averaged.
> +		 *
> +		 * When SPI offload is supported and we have control over the
> +		 * sample rate, the conversion start signal (CNV) and the SPI
> +		 * offload trigger frequencies must be re-evaluated so data is
> +		 * fetched only after 'avg_val' conversions.
> +		 */
> +		ad4030_get_sampling_freq(st, &freq);
> +		ret = ad4030_update_conversion_rate(st, freq, avg_log2);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_write(st->regmap, AD4030_REG_AVG,
> +			   AD4030_REG_AVG_MASK_AVG_SYNC |
> +			   FIELD_PREP(AD4030_REG_AVG_MASK_AVG_VAL, avg_log2));
> +	if (ret)
> +		return ret;
> +
> +	st->avg_log2 = avg_log2;
> +	return 0;
> +}
> +

...

> @@ -869,7 +1035,11 @@ static int ad4030_get_current_scan_type(const struct iio_dev *indio_dev,
>  static int ad4030_update_scan_mode(struct iio_dev *indio_dev,
>  				   const unsigned long *scan_mask)
>  {
> -	return ad4030_set_mode(indio_dev, *scan_mask);
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +

> +	//return ad4030_set_mode(st, *scan_mask, st->avg_log2);
> +	//return ad4030_set_mode(iio_priv(indio_dev), &scan_mask, st->avg_log2);

Oops. :-)

> +	return ad4030_set_mode(iio_priv(indio_dev), *scan_mask, st->avg_log2);
>  }
>  
>  static const struct iio_info ad4030_iio_info = {
> @@ -898,6 +1068,108 @@ static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
>  	.validate_scan_mask = ad4030_validate_scan_mask,
>  };
>  
> +static void ad4030_prepare_offload_msg(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	u8 offload_bpw;
> +
> +	if (st->mode == AD4030_OUT_DATA_MD_30_AVERAGED_DIFF) {
> +		offload_bpw = 32;
> +	} else {
> +		offload_bpw = st->chip->precision_bits;
> +		offload_bpw += (st->mode == AD4030_OUT_DATA_MD_24_DIFF_8_COM ||
> +				st->mode == AD4030_OUT_DATA_MD_16_DIFF_8_COM) ? 8 : 0;

The 8-bit common-mode voltage value needs to be in a separate SPI transfer
so that is gets placed in a separate word in the DMA buffer. Otherwise userspace
won't be able to interpret it correctly.

> +	}
> +
> +	st->offload_xfer.bits_per_word = offload_bpw;
> +	st->offload_xfer.len = spi_bpw_to_bytes(offload_bpw);
> +	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
> +}
> +
> +static int ad4030_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	unsigned int reg_modes;
> +	int ret, ret2;
> +
> +	/*
> +	 * When data from 2 analog input channels is output through a single
> +	 * bus line (interleaved mode (LANE_MD == 0b11)) and gets pushed through
> +	 * DMA, extra hardware is required to do the de-interleaving. While we
> +	 * don't support such hardware configurations, disallow interleaved mode
> +	 * when using SPI offload.
> +	 */
> +	ret = regmap_read(st->regmap, AD4030_REG_MODES, &reg_modes);
> +	if (ret)
> +		return ret;
> +
> +	if (st->chip->num_voltage_inputs > 1 &&
> +	    FIELD_GET(AD4030_REG_MODES_MASK_LANE_MODE, reg_modes) == AD4030_LANE_MD_INTERLEAVED)
> +		return -EINVAL;
> +
> +	ret = regmap_write(st->regmap, AD4030_REG_EXIT_CFG_MODE, BIT(0));

There is already AD4030_REG_EXIT_CFG_MODE_EXIT_MSK for BIT(0).

Also there is ad4030_exit_config_mode() that could be called instead. Not sure
why we have that though since there aren't any comments to explain it.

> +	if (ret)
> +		return ret;
> +
> +	ad4030_prepare_offload_msg(indio_dev);
> +	st->offload_msg.offload = st->offload;
> +	ret = spi_optimize_message(st->spi, &st->offload_msg);
> +	if (ret)
> +		goto out_reset_mode;
> +
> +	ret = pwm_set_waveform_might_sleep(st->cnv_trigger, &st->cnv_wf, false);
> +	if (ret)
> +		goto out_unoptimize;
> +
> +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
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
> +	ret2 = ad4030_enter_config_mode(st);
> +	if (ret2)
> +		dev_err(&st->spi->dev,
> +			"couldn't reenter register configuration mode: %d\n",
> +			ret2);
> +
> +	return ret;
> +}
> +

...

>  static const struct ad4030_chip_info ad4030_24_chip_info = {
>  	.name = "ad4030-24",
>  	.available_masks = ad4030_channel_masks,
> @@ -1125,10 +1511,15 @@ static const struct ad4030_chip_info ad4030_24_chip_info = {
>  		AD4030_CHAN_CMO(1, 0),
>  		IIO_CHAN_SOFT_TIMESTAMP(2),
>  	},
> +	.offload_channels = {
> +		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
> +		AD4030_CHAN_CMO(1, 0),

We will need a new AD4030_OFFLOAD_CHAN_CMO() that has storagebits = 32.

Also applies to similar items below.

> +	},
>  	.grade = AD4030_REG_CHIP_GRADE_AD4030_24_GRADE,
>  	.precision_bits = 24,
>  	.num_voltage_inputs = 1,
>  	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
> +	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
>  };
>  
>  static const struct ad4030_chip_info ad4630_16_chip_info = {
> @@ -1141,10 +1532,17 @@ static const struct ad4030_chip_info ad4630_16_chip_info = {
>  		AD4030_CHAN_CMO(3, 1),
>  		IIO_CHAN_SOFT_TIMESTAMP(4),
>  	},
> +	.offload_channels = {
> +		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
> +		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
> +		AD4030_CHAN_CMO(2, 0),
> +		AD4030_CHAN_CMO(3, 1),
> +	},
>  	.grade = AD4030_REG_CHIP_GRADE_AD4630_16_GRADE,
>  	.precision_bits = 16,
>  	.num_voltage_inputs = 2,
>  	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
> +	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
>  };
>  
>  static const struct ad4030_chip_info ad4630_24_chip_info = {
> @@ -1157,10 +1555,17 @@ static const struct ad4030_chip_info ad4630_24_chip_info = {
>  		AD4030_CHAN_CMO(3, 1),
>  		IIO_CHAN_SOFT_TIMESTAMP(4),
>  	},
> +	.offload_channels = {
> +		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
> +		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
> +		AD4030_CHAN_CMO(2, 0),
> +		AD4030_CHAN_CMO(3, 1),
> +	},
>  	.grade = AD4030_REG_CHIP_GRADE_AD4630_24_GRADE,
>  	.precision_bits = 24,
>  	.num_voltage_inputs = 2,
>  	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
> +	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
>  };
>  
>  static const struct ad4030_chip_info ad4632_16_chip_info = {
> @@ -1173,10 +1578,17 @@ static const struct ad4030_chip_info ad4632_16_chip_info = {
>  		AD4030_CHAN_CMO(3, 1),
>  		IIO_CHAN_SOFT_TIMESTAMP(4),
>  	},
> +	.offload_channels = {
> +		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
> +		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
> +		AD4030_CHAN_CMO(2, 0),
> +		AD4030_CHAN_CMO(3, 1),
> +	},
>  	.grade = AD4030_REG_CHIP_GRADE_AD4632_16_GRADE,
>  	.precision_bits = 16,
>  	.num_voltage_inputs = 2,
>  	.tcyc_ns = AD4632_TCYC_ADJUSTED_NS,
> +	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
>  };
>  
>  static const struct ad4030_chip_info ad4632_24_chip_info = {
> @@ -1189,10 +1601,17 @@ static const struct ad4030_chip_info ad4632_24_chip_info = {
>  		AD4030_CHAN_CMO(3, 1),
>  		IIO_CHAN_SOFT_TIMESTAMP(4),
>  	},
> +	.offload_channels = {
> +		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
> +		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
> +		AD4030_CHAN_CMO(2, 0),
> +		AD4030_CHAN_CMO(3, 1),
> +	},
>  	.grade = AD4030_REG_CHIP_GRADE_AD4632_24_GRADE,
>  	.precision_bits = 24,
>  	.num_voltage_inputs = 2,
>  	.tcyc_ns = AD4632_TCYC_ADJUSTED_NS,
> +	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
>  };
>  
>  static const struct spi_device_id ad4030_id_table[] = {
> @@ -1228,3 +1647,4 @@ module_spi_driver(ad4030_driver);
>  MODULE_AUTHOR("Esteban Blanc <eblanc@baylibre.com>");
>  MODULE_DESCRIPTION("Analog Devices AD4630 ADC family driver");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");


