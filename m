Return-Path: <linux-pwm+bounces-8895-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eS6mGBKzCGoY1wMAu9opvQ
	(envelope-from <linux-pwm+bounces-8895-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 16 May 2026 20:10:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B18E255D057
	for <lists+linux-pwm@lfdr.de>; Sat, 16 May 2026 20:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A7A63011C6D
	for <lists+linux-pwm@lfdr.de>; Sat, 16 May 2026 18:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8D62DCF67;
	Sat, 16 May 2026 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="erKFMeQj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA8A2DB7B8
	for <linux-pwm@vger.kernel.org>; Sat, 16 May 2026 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778955023; cv=none; b=Yu4xGwQYzgNMdWTx7qrDbyO5WdS/eDu/8nBB3ou3s8rv13hjJNF9YMuoQKNKnsNjqjCVKXkC7g6D1LWAJSszNJHiG7rl0UrkraPKTuHRPOMpMMXNDMyITrzdxpBgQkjJXZxxz6+RMocK6UJ41sglKK/NnFJiPO+l0tiY+KpBrA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778955023; c=relaxed/simple;
	bh=qxAV1H4Gj+7C26k9rxFOXUqwm2BA7thWcEeDZX5+1iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvSnRMJMNf6hDtLgKX33QXRYNX56mrEkbcJc5/tZvFaw6aL6zKcaIPZ3/O3COueLUChEzCTGhlO0cYhM/yvvI+kifc9WhT7Nktmi6o9epQGqCtgHBEBH4OaU5J/MJ8slwz+VDx+D+pse+AMoZZPuAgKzKeyrSGH8H7nA8/27IJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=erKFMeQj; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6948da50eb5so350017eaf.1
        for <linux-pwm@vger.kernel.org>; Sat, 16 May 2026 11:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778955020; x=1779559820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gehK28nsSdghgiVpRyjqCle0+XjWKxiooIwQQ+z2r3w=;
        b=erKFMeQjl/yQGSGFeD4AuvGIrAC8OUgGrI2PohvHW41RyN0BYpXxkV5Ls9kYvi/NUr
         tkl+/twQ/tszscFO45WlxzVleoUm9HIjwnI81csd+R1eNb0Q3P+0QkTi/NEFZisxInoh
         HPzT7PFwA323I/gjHwfHNJQKtIhx4xYzOanJYD1/XJyFczIaYGQ4QoLsLUx683n1xH4L
         g5LHfXoOs9dt0ruupoZKlTzIHk7aNZFt2qfTPy9KAPwj6/huZNJ50tfwd5KKfjM6r63E
         +Ktm2GSbl1F3M+xEyzDoXjhuZKiiP/UOrGmKUFzpoEXpMVx5NXqyqn6S3HXTJ6HuVHOJ
         heeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778955020; x=1779559820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gehK28nsSdghgiVpRyjqCle0+XjWKxiooIwQQ+z2r3w=;
        b=brY6B2fJQuI7r42SUmNAjUROMUVhsVa5f6RPxl13mXRCrbTrW5xldP3mMFLMaosPru
         OQ0gIag9JOhwcJ2woTBjawup0hzyj57oxHMhC6XMi2Tu3+jEQW/7lLrtJKMrRZUrQjII
         Oks9KT0QiCkVedKPuxLH57/taIuD36LvhXJPPo+s8JW8QEruDEtQc1u3CmHcR/ZybUmm
         Re5CZxmLmGz+cK94UmZoKDHu5cvV1EFvHXQcv01szQTlfgZNptWeoxEE1z7MVTS+rPuV
         y+RX9eoWabdhKLQ5OIj7LrPFULKlrTnZx/zWNoRrZtrcMw3FZnfpMuTyA05/iULzFkDD
         L6wg==
X-Forwarded-Encrypted: i=1; AFNElJ/YizmBBkO3x04+6ch7tc5DRDWGTkOBmRhCYVjBqFL7VtCmsZICvxFkN1FN70X835gxcv91EAkVKkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmYEExeebKt8TXZ6Vv+5wourWPcEr3tiCav2bI4EYfDQn8YmMF
	IMYLqP3FpcvA6mvbQQY2kJFzzEZQuoJ0lYTc/gUZd252lYKzJBf/kxm6TyCR7CJLojU=
X-Gm-Gg: Acq92OEMDJZAT084OcCSuR3kF6Kgw3lmblLH6vIuZNCdXkDBRtm0fG50GAPnOBasx9O
	ZbB08Wp2QCR6ilx+A6Rsi3mLi3liEgokGkj9sFARVLTI18oB2ybyN+9yxtalnmJN3gaU/8/s+/Y
	P9Mf7z/iJYZfXxdqN+20CPJcGjUT85n8qFDSO+6he0NZ/cMNhNDC9JwFxBpqIZ1j6hdFy5yyEfZ
	KB5EgGupi3/m0cXxZmVDspxID7pLXAZyqvuqU1OHEfhgNvUddG97UMxUK6Uo0q7FALB+Vcoo8W0
	+IA1mzTfAt35BxwVo6Czn64jve+sQ5n1oQV4q3f4ZS2mcaXTBiRqVV7MkOi2lgCUxd3hWWu/zgb
	W18yQeiPd83MkWWkEBDbDA1Qr2987TwRGy3P3jk/RpGmhoe6DDyOgyhboch2Wk14We+S5Q4MGQv
	fc6oGAkuMtNw6fN+3ROPCieF46xQ+PKq8luqqXgx04ySFhtVKDqzwwD91cPKdzIzzpyLAKbmMvk
	Q==
X-Received: by 2002:a05:6820:190b:b0:696:177b:42b6 with SMTP id 006d021491bc7-69c77b1d871mr4625082eaf.30.1778955019829;
        Sat, 16 May 2026 11:10:19 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b36d:bd18:7c02:29e2? ([2600:8803:e7e4:500:b36d:bd18:7c02:29e2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc4dcb89sm7067820fac.12.2026.05.16.11.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 11:10:19 -0700 (PDT)
Message-ID: <59ca0624-227a-4b0e-a411-008f3fe33461@baylibre.com>
Date: Sat, 16 May 2026 13:10:17 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/6] iio: adc: ad4691: add oversampling support
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
 <20260515-ad4692-multichannel-sar-adc-driver-v11-5-eab27d852ac2@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260515-ad4692-multichannel-sar-adc-driver-v11-5-eab27d852ac2@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B18E255D057
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8895-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:8803:e7e4:500:b36d:bd18:7c02:29e2:received,100.90.174.1:received,209.85.161.53:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,baylibre-com.20251104.gappssmtp.com:dkim,baylibre.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/15/26 8:31 AM, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add per-channel oversampling ratio (OSR) support for CNV burst mode.
> The accumulator depth register (ACC_DEPTH_IN) is programmed with the
> selected OSR at buffer enable time and before each single-shot read.
> 
> Supported OSR values: 1, 2, 4, 8, 16, 32.
> 
> Introduce AD4691_MANUAL_CHANNEL() for manual mode channels, which do
> not expose the oversampling_ratio attribute since OSR is not applicable
> in that mode. A separate manual_channels array is added to
> struct ad4691_channel_info and selected at probe time.
> 
> in_voltageN_sampling_frequency represents the effective output rate for
> channel N, defined as osc_freq / osr[N]. The chip has one internal
> oscillator shared by all channels; each channel independently
> accumulates osr[N] oscillator cycles before producing a result.
> 
> Writing sampling_frequency computes needed_osc = freq * osr[N] and
> snaps down to the largest oscillator table entry that satisfies both
> osc <= needed_osc and osc % osr[N] == 0, guaranteeing an exact integer
> read-back. The result is stored in target_osc_freq_Hz and written to
> OSC_FREQ_REG at buffer enable and single-shot time, so sampling_frequency
> and oversampling_ratio can be set in any order.
> 
> in_voltageN_sampling_frequency_available is computed dynamically from
> the channel's current OSR, listing only oscillator table entries that
> divide evenly by osr[N], expressed as effective rates. The list becomes
> sparser as OSR increases, capping at max_rate / osr[N].
> 
> Writing oversampling_ratio stores the new OSR for that channel and snaps
> target_osc_freq_Hz to the largest oscillator table entry that is both
> <= old_effective_rate * new_osr and evenly divisible by new_osr. This
> preserves an integer read-back of in_voltageN_sampling_frequency after
> the OSR change while keeping the oscillator as close as possible to the
> previous effective rate.
> 
> OSR defaults to 1 (no accumulation) for all channels.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  drivers/iio/adc/ad4691.c | 381 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 343 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> index 25f7a6939b0f..39244e0e4a2d 100644
> --- a/drivers/iio/adc/ad4691.c
> +++ b/drivers/iio/adc/ad4691.c
> @@ -25,6 +25,7 @@
>  #include <linux/reset.h>
>  #include <linux/string.h>
>  #include <linux/spi/spi.h>
> +#include <linux/types.h>

Out of order. Also probably belongs in earlier patch.

>  #include <linux/spi/offload/consumer.h>
>  #include <linux/spi/offload/provider.h>
>  #include <linux/units.h>
> @@ -117,6 +118,7 @@ enum ad4691_ref_ctrl {
>  
>  struct ad4691_channel_info {
>  	const struct iio_chan_spec *channels __counted_by_ptr(num_channels);
> +	const struct iio_chan_spec *manual_channels __counted_by_ptr(num_channels);
>  	unsigned int num_channels;
>  };
>  
> @@ -127,12 +129,39 @@ struct ad4691_chip_info {
>  	const struct ad4691_channel_info *offload_info;
>  };
>  
> +/* CNV burst mode channel — exposes oversampling ratio. */
>  #define AD4691_CHANNEL(ch)						\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
>  		.indexed = 1,						\
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
> -				    | BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) | \
> +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +		.info_mask_separate_available =				\
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) | \
> +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.channel = ch,						\
> +		.scan_index = ch,					\
> +		.scan_type = {						\
> +			.sign = 'u',					\

This field has new name: .format.

> +			.realbits = 16,					\
> +			.storagebits = 16,				\
> +			.endianness = IIO_BE,				\
> +		},							\
> +	}
> +
> +/*
> + * Manual mode channel — no oversampling ratio attribute. OSR is not
> + * supported in manual mode; ACC_DEPTH_IN is not configured during manual
> + * buffer enable.
> + */
> +#define AD4691_MANUAL_CHANNEL(ch)					\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
>  		.info_mask_separate_available =				\
>  				      BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
> @@ -151,8 +180,33 @@ struct ad4691_chip_info {
>   * bits into native 16-bit words before DMA, so samples are in
>   * CPU-native byte order (IIO_CPU). storagebits=16 matches the 16-bit
>   * DMA word size.
> + *
> + * CNV burst offload configures ACC_DEPTH_IN per channel, so the
> + * oversampling_ratio attribute is exposed. Manual offload does not;
> + * use AD4691_OFFLOAD_MANUAL_CHANNEL for that path.
>   */
>  #define AD4691_OFFLOAD_CHANNEL(ch)					\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
> +				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) \
> +				    | BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +		.info_mask_separate_available =				\
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) \
> +				    | BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.channel = ch,						\
> +		.scan_index = ch,					\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = 16,					\
> +			.storagebits = 16,				\
> +		},							\
> +	}
> +
> +/* Manual offload — same IIO_CPU layout but no oversampling_ratio attribute. */
> +#define AD4691_OFFLOAD_MANUAL_CHANNEL(ch)				\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
>  		.indexed = 1,						\
> @@ -236,23 +290,91 @@ static const struct iio_chan_spec ad4693_offload_channels[] = {
>  	AD4691_OFFLOAD_CHANNEL(7),
>  };
>  
> +static const struct iio_chan_spec ad4691_manual_channels[] = {
> +	AD4691_MANUAL_CHANNEL(0),
> +	AD4691_MANUAL_CHANNEL(1),
> +	AD4691_MANUAL_CHANNEL(2),
> +	AD4691_MANUAL_CHANNEL(3),
> +	AD4691_MANUAL_CHANNEL(4),
> +	AD4691_MANUAL_CHANNEL(5),
> +	AD4691_MANUAL_CHANNEL(6),
> +	AD4691_MANUAL_CHANNEL(7),
> +	AD4691_MANUAL_CHANNEL(8),
> +	AD4691_MANUAL_CHANNEL(9),
> +	AD4691_MANUAL_CHANNEL(10),
> +	AD4691_MANUAL_CHANNEL(11),
> +	AD4691_MANUAL_CHANNEL(12),
> +	AD4691_MANUAL_CHANNEL(13),
> +	AD4691_MANUAL_CHANNEL(14),
> +	AD4691_MANUAL_CHANNEL(15),
> +	IIO_CHAN_SOFT_TIMESTAMP(16),
> +};
> +
> +static const struct iio_chan_spec ad4693_manual_channels[] = {
> +	AD4691_MANUAL_CHANNEL(0),
> +	AD4691_MANUAL_CHANNEL(1),
> +	AD4691_MANUAL_CHANNEL(2),
> +	AD4691_MANUAL_CHANNEL(3),
> +	AD4691_MANUAL_CHANNEL(4),
> +	AD4691_MANUAL_CHANNEL(5),
> +	AD4691_MANUAL_CHANNEL(6),
> +	AD4691_MANUAL_CHANNEL(7),
> +	IIO_CHAN_SOFT_TIMESTAMP(8),
> +};
> +
> +static const struct iio_chan_spec ad4691_offload_manual_channels[] = {
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(0),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(1),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(2),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(3),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(4),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(5),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(6),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(7),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(8),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(9),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(10),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(11),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(12),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(13),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(14),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(15),
> +};
> +
> +static const struct iio_chan_spec ad4693_offload_manual_channels[] = {
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(0),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(1),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(2),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(3),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(4),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(5),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(6),
> +	AD4691_OFFLOAD_MANUAL_CHANNEL(7),
> +};
> +
> +static const int ad4691_oversampling_ratios[] = { 1, 2, 4, 8, 16, 32 };
> +
>  static const struct ad4691_channel_info ad4691_sw_info = {
>  	.channels = ad4691_channels,
> +	.manual_channels = ad4691_manual_channels,
>  	.num_channels = ARRAY_SIZE(ad4691_channels),
>  };
>  
>  static const struct ad4691_channel_info ad4693_sw_info = {
>  	.channels = ad4693_channels,
> +	.manual_channels = ad4693_manual_channels,
>  	.num_channels = ARRAY_SIZE(ad4693_channels),
>  };
>  
>  static const struct ad4691_channel_info ad4691_offload_info = {
>  	.channels = ad4691_offload_channels,
> +	.manual_channels = ad4691_offload_manual_channels,
>  	.num_channels = ARRAY_SIZE(ad4691_offload_channels),
>  };
>  
>  static const struct ad4691_channel_info ad4693_offload_info = {
>  	.channels = ad4693_offload_channels,
> +	.manual_channels = ad4693_offload_manual_channels,
>  	.num_channels = ARRAY_SIZE(ad4693_offload_channels),
>  };
>  
> @@ -325,6 +447,19 @@ struct ad4691_state {
>  	int irq;
>  	int vref_uV;
>  	u32 cnv_period_ns;
> +	/*
> +	 * Snapped oscillator frequency (Hz) shared by all channels. Set when
> +	 * sampling_frequency or oversampling_ratio is written; written to
> +	 * OSC_FREQ_REG at buffer enable and single-shot time so both attributes
> +	 * can be set in any order. Reading in_voltageN_sampling_frequency
> +	 * returns target_osc_freq_Hz / osr[N] — the effective rate for that
> +	 * channel given its oversampling ratio.
> +	 */
> +	u32 target_osc_freq_Hz;
> +	/* Per-channel oversampling ratio; always 1 in manual mode. */
> +	u8 osr[16];
> +	/* Scratch buffer for read_avail SAMP_FREQ; content is OSR-dependent. */

> +	int samp_freq_avail[16][ARRAY_SIZE(ad4691_osc_freqs_Hz)];

Is there a *_MAX_CHANNELS macro to tell us what 16 is?

>  
>  	bool manual_mode;
>  	bool refbuf_en;
> @@ -398,8 +533,7 @@ static bool ad4691_offload_trigger_match(struct spi_offload_trigger *trigger,
>  					 enum spi_offload_trigger_type type,
>  					 u64 *args, u32 nargs)
>  {
> -	return type == SPI_OFFLOAD_TRIGGER_DATA_READY &&
> -	       nargs == 1 && args[0] <= 3;
> +	return type == SPI_OFFLOAD_TRIGGER_DATA_READY && nargs == 1 && args[0] <= 3;

unrelated change?

>  }
>  
>  static int ad4691_offload_trigger_request(struct spi_offload_trigger *trigger,
> @@ -578,6 +712,16 @@ static const struct regmap_config ad4691_regmap_config = {
>  	.cache_type = REGCACHE_MAPLE,
>  };
>  
> +/* Write target_osc_freq_Hz to OSC_FREQ_REG. Called at use time. */
> +static int ad4691_write_osc_freq(struct ad4691_state *st)
> +{
> +	for (unsigned int i = 0; i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {
> +		if (ad4691_osc_freqs_Hz[i] == st->target_osc_freq_Hz)
> +			return regmap_write(st->regmap, AD4691_OSC_FREQ_REG, i);
> +	}
> +	return -EINVAL;
> +}
> +
>  /*
>   * Index 0 in ad4691_osc_freqs_Hz is 1 MHz — valid only for AD4692/AD4694
>   * (max_rate == 1 MHz). AD4691/AD4693 cap at 500 kHz so their valid range
> @@ -588,41 +732,65 @@ static unsigned int ad4691_samp_freq_start(const struct ad4691_chip_info *info)
>  	return (info->max_rate == 1 * HZ_PER_MHZ) ? 0 : 1;
>  }
>  
> -static int ad4691_get_sampling_freq(struct ad4691_state *st, int *val)
> +/*
> + * Find the largest oscillator table entry that is both <= needed_osc and
> + * evenly divisible by osr (guaranteeing an integer effective rate on
> + * read-back). Returns 0 if no such entry exists in the chip's valid range.
> + */
> +static unsigned int ad4691_find_osc_freq(struct ad4691_state *st,
> +					 unsigned int needed_osc,
> +					 unsigned int osr)
>  {
> -	unsigned int reg_val;
> -	int ret;
> +	unsigned int start = ad4691_samp_freq_start(st->info);
>  
> -	/*
> -	 * AD4691_OSC_FREQ_REG is non-volatile and written during
> -	 * ad4691_config(), so regmap returns the cached value here without
> -	 * touching the SPI bus. No lock is needed.
> -	 */
> -	ret = regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &reg_val);
> -	if (ret)
> -		return ret;
> +	for (unsigned int i = start; i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {
> +		if ((unsigned int)ad4691_osc_freqs_Hz[i] > needed_osc)
> +			continue;
> +		if (ad4691_osc_freqs_Hz[i] % osr)
> +			continue;
> +		return ad4691_osc_freqs_Hz[i];
> +	}
> +	return 0;
> +}
>  
> -	*val = ad4691_osc_freqs_Hz[FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val)];
> +static int ad4691_get_sampling_freq(struct ad4691_state *st, u8 osr, int *val)
> +{
> +	*val = st->target_osc_freq_Hz / osr;
>  	return IIO_VAL_INT;
>  }
>  
> -static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, int freq)
> +static int ad4691_set_sampling_freq(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec const *chan, int freq)
>  {
>  	struct ad4691_state *st = iio_priv(indio_dev);
> -	unsigned int start = ad4691_samp_freq_start(st->info);
> +	unsigned int osr, found;
>  
>  	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
>  	if (IIO_DEV_ACQUIRE_FAILED(claim))
>  		return -EBUSY;
>  
> -	for (unsigned int i = start; i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {
> -		if (ad4691_osc_freqs_Hz[i] != freq)
> -			continue;
> -		return regmap_update_bits(st->regmap, AD4691_OSC_FREQ_REG,
> -					  AD4691_OSC_FREQ_MASK, i);
> -	}
> +	/*
> +	 * Read osr under st->lock: osr[chan] and target_osc_freq_Hz are
> +	 * modified together under the lock; reading after acquiring it ensures
> +	 * we see a consistent snapshot with no concurrent write racing us.
> +	 */
> +	guard(mutex)(&st->lock);
> +	osr = st->osr[chan->channel];
>  
> -	return -EINVAL;
> +	if (freq <= 0 || (unsigned int)freq > st->info->max_rate / osr)
> +		return -EINVAL;
> +
> +	found = ad4691_find_osc_freq(st, (unsigned int)freq * osr, osr);
> +	if (!found)
> +		return -EINVAL;
> +
> +	/*
> +	 * Store the snapped oscillator frequency; OSC_FREQ_REG is written at
> +	 * buffer enable and single-shot time so that sampling_frequency and
> +	 * oversampling_ratio can be set in any order.
> +	 */
> +	st->target_osc_freq_Hz = found;
> +	return 0;
>  }
>  
>  static int ad4691_read_avail(struct iio_dev *indio_dev,
> @@ -634,10 +802,46 @@ static int ad4691_read_avail(struct iio_dev *indio_dev,
>  	unsigned int start = ad4691_samp_freq_start(st->info);
>  
>  	switch (mask) {
> -	case IIO_CHAN_INFO_SAMP_FREQ:
> -		*vals = &ad4691_osc_freqs_Hz[start];
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		unsigned int osr;
> +		int n = 0;
> +
> +		/*
> +		 * Hold the lock while reading osr[chan] and populating the
> +		 * scratch buffer: a concurrent oversampling_ratio write modifies
> +		 * both target_osc_freq_Hz and osr[] under the lock, so we must
> +		 * read osr atomically with respect to that write. The scratch
> +		 * buffer is per-channel, so concurrent reads on different
> +		 * channels do not race; concurrent reads on the same channel
> +		 * would compute identical values, but holding the lock avoids
> +		 * the formal data race.
> +		 */
> +		scoped_guard(mutex, &st->lock) {

I'm not a fan of scposed_guard() in case statements because break would
break out of scoped_guard(), not case.

I would write it as:

		{
			guard(mutex)(&st->lock);


instead or put the critical section in a new function.

Or don't restrict the scope since the few assignments after the
critical section are not going to take a significant amount of
time. It won't hurt if they are done with the mutex held.

> +			osr = st->osr[chan->channel];
> +
> +			/*
> +			 * Only oscillator frequencies evenly divisible by the
> +			 * channel's OSR yield an integer effective rate; expose
> +			 * those as effective rates (osc / osr) so the user works
> +			 * entirely in output-sample space.
> +			 */
> +			for (unsigned int i = start;
> +			     i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {
> +				if (ad4691_osc_freqs_Hz[i] % osr)
> +					continue;
> +				st->samp_freq_avail[chan->channel][n++] =
> +					ad4691_osc_freqs_Hz[i] / osr;
> +			}
> +		}
> +		*vals = st->samp_freq_avail[chan->channel];
>  		*type = IIO_VAL_INT;
> -		*length = ARRAY_SIZE(ad4691_osc_freqs_Hz) - start;
> +		*length = n;
> +		return IIO_AVAIL_LIST;
> +	}
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals = ad4691_oversampling_ratios;
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(ad4691_oversampling_ratios);
>  		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;
> @@ -648,7 +852,7 @@ static int ad4691_single_shot_read(struct iio_dev *indio_dev,
>  				   struct iio_chan_spec const *chan, int *val)
>  {
>  	struct ad4691_state *st = iio_priv(indio_dev);
> -	unsigned int reg_val, osc_idx, period_us;
> +	unsigned int reg_val, period_us;
>  	int ret;
>  
>  	guard(mutex)(&st->lock);
> @@ -669,7 +873,12 @@ static int ad4691_single_shot_read(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> -	ret = regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &reg_val);
> +	ret = regmap_write(st->regmap, AD4691_ACC_DEPTH_IN(chan->channel),
> +			   st->osr[chan->channel]);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4691_write_osc_freq(st);
>  	if (ret)
>  		return ret;
>  
> @@ -677,9 +886,12 @@ static int ad4691_single_shot_read(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> -	osc_idx = FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val);
> -	/* Wait 2 oscillator periods for the conversion to complete. */
> -	period_us = DIV_ROUND_UP(2UL * USEC_PER_SEC, ad4691_osc_freqs_Hz[osc_idx]);
> +	/*
> +	 * Wait osr + 1 oscillator periods: osr for accumulation, +1 for the
> +	 * pipeline margin (one extra period ensures the final result is ready).
> +	 */
> +	period_us = DIV_ROUND_UP((st->osr[chan->channel] + 1) * USEC_PER_SEC,
> +				 st->target_osc_freq_Hz);
>  	fsleep(period_us);
>  
>  	ret = regmap_write(st->regmap, AD4691_OSC_EN_REG, 0);
> @@ -713,8 +925,21 @@ static int ad4691_read_raw(struct iio_dev *indio_dev,
>  
>  		return ad4691_single_shot_read(indio_dev, chan, val);
>  	}
> -	case IIO_CHAN_INFO_SAMP_FREQ:
> -		return ad4691_get_sampling_freq(st, val);
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		/*
> +		 * Read target_osc_freq_Hz and osr[chan] under st->lock to get a
> +		 * consistent snapshot: write_raw for SAMP_FREQ or OSR modifies
> +		 * both fields under the lock, so a concurrent read without the
> +		 * lock could observe a new oscillator frequency with the old OSR.
> +		 */
> +		guard(mutex)(&st->lock);
> +		return ad4691_get_sampling_freq(st, st->osr[chan->channel], val);
> +	}
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
> +		guard(mutex)(&st->lock);
> +		*val = st->osr[chan->channel];
> +		return IIO_VAL_INT;
> +	}
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = st->vref_uV / (MICRO / MILLI);
>  		*val2 = chan->scan_type.realbits;
> @@ -728,9 +953,48 @@ static int ad4691_write_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int val, int val2, long mask)
>  {
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		return ad4691_set_sampling_freq(indio_dev, val);
> +		return ad4691_set_sampling_freq(indio_dev, chan, val);
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
> +		unsigned int old_effective, found;
> +		bool valid = false;
> +
> +		for (unsigned int i = 0; i < ARRAY_SIZE(ad4691_oversampling_ratios); i++) {
> +			if (ad4691_oversampling_ratios[i] == val) {
> +				valid = true;
> +				break;
> +			}
> +		}
> +		if (!valid)
> +			return -EINVAL;
> +
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		/*
> +		 * Hold st->lock while computing the new oscillator frequency
> +		 * and updating both target_osc_freq_Hz and osr[chan] atomically:
> +		 * read_raw for SAMP_FREQ reads both fields under the lock and
> +		 * must see a consistent pair (new osc ↔ new osr).
> +		 *
> +		 * Snap target_osc_freq_Hz to the largest table entry that is
> +		 * both <= old_effective * new_osr and evenly divisible by
> +		 * new_osr, preserving an integer read-back of
> +		 * in_voltageN_sampling_frequency after the OSR change.
> +		 */
> +		guard(mutex)(&st->lock);
> +		old_effective = st->target_osc_freq_Hz / st->osr[chan->channel];
> +		found = ad4691_find_osc_freq(st, old_effective * (unsigned int)val, val);
> +		if (!found)
> +			return -EINVAL;
> +		st->target_osc_freq_Hz = found;
> +		st->osr[chan->channel] = val;
> +		return 0;
> +	}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -785,6 +1049,10 @@ static int ad4691_enter_conversion_mode(struct ad4691_state *st)
>  		return regmap_update_bits(st->regmap, AD4691_DEVICE_SETUP,
>  					  AD4691_MANUAL_MODE, AD4691_MANUAL_MODE);
>  
> +	ret = ad4691_write_osc_freq(st);
> +	if (ret)
> +		return ret;
> +
>  	ret = regmap_update_bits(st->regmap, AD4691_ADC_SETUP,
>  				 AD4691_ADC_MODE_MASK, AD4691_CNV_BURST_MODE);
>  	if (ret)
> @@ -948,6 +1216,14 @@ static int ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)
>  	if (ret)
>  		goto err_unoptimize;
>  
> +	iio_for_each_active_channel(indio_dev, i) {
> +		if (i >= indio_dev->num_channels - 1)
> +			break; /* skip soft timestamp */

timestamp channel should be handled separately already.

> +		ret = regmap_write(st->regmap, AD4691_ACC_DEPTH_IN(i), st->osr[i]);
> +		if (ret)
> +			goto err_unoptimize;
> +	}
> +
>  	ret = ad4691_enter_conversion_mode(st);
>  	if (ret)
>  		goto err_unoptimize;
> @@ -1126,6 +1402,14 @@ static int ad4691_cnv_burst_offload_buffer_postenable(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> +	iio_for_each_active_channel(indio_dev, bit) {
> +		if (bit >= indio_dev->num_channels)
> +			break; /* defensive guard; offload channels have no soft timestamp */

really don't need it in this case.

> +		ret = regmap_write(st->regmap, AD4691_ACC_DEPTH_IN(bit), st->osr[bit]);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = ad4691_enter_conversion_mode(st);
>  	if (ret)
>  		return ret;
> @@ -1524,6 +1808,8 @@ static int ad4691_config(struct ad4691_state *st)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to write OSC_FREQ\n");
>  
> +	st->target_osc_freq_Hz = ad4691_osc_freqs_Hz[ad4691_samp_freq_start(st->info)];
> +
>  	ret = regmap_update_bits(st->regmap, AD4691_ADC_SETUP,
>  				 AD4691_ADC_MODE_MASK, AD4691_AUTONOMOUS_MODE);
>  	if (ret)
> @@ -1540,7 +1826,14 @@ static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
>  	unsigned int i;
>  	int irq, ret;
>  
> -	indio_dev->channels = st->info->sw_info->channels;
> +	/*
> +	 * Manual mode exposes channels without the oversampling_ratio attribute
> +	 * because ACC_DEPTH_IN is not configured in manual mode.
> +	 */
> +	if (st->manual_mode)
> +		indio_dev->channels = st->info->sw_info->manual_channels;
> +	else
> +		indio_dev->channels = st->info->sw_info->channels;
>  	indio_dev->num_channels = st->info->sw_info->num_channels;
>  	indio_dev->info = st->manual_mode ? &ad4691_manual_info : &ad4691_cnv_burst_info;
>  
> @@ -1621,7 +1914,18 @@ static int ad4691_setup_offload(struct iio_dev *indio_dev,
>  	offload->offload = spi_offload;
>  	st->offload = offload;
>  
> -	indio_dev->channels = st->info->offload_info->channels;
> +	/*
> +	 * CNV burst offload exposes oversampling_ratio (ACC_DEPTH_IN is
> +	 * configured per channel at buffer enable). Manual offload does not
> +	 * configure ACC_DEPTH_IN, so it uses a separate channel array
> +	 * without the oversampling_ratio attribute. Both paths use IIO_CPU
> +	 * (no .endianness annotation) because bits_per_word=16 causes the
> +	 * SPI Engine to produce native 16-bit DMA words.
> +	 */
> +	if (st->manual_mode)
> +		indio_dev->channels = st->info->offload_info->manual_channels;
> +	else
> +		indio_dev->channels = st->info->offload_info->channels;
>  	indio_dev->num_channels = st->info->offload_info->num_channels;
>  	/*
>  	 * Offload path uses DMA directly; no IIO trigger is involved, so
> @@ -1695,6 +1999,7 @@ static int ad4691_probe(struct spi_device *spi)
>  	st->info = spi_get_device_match_data(spi);
>  	if (!st->info)
>  		return -ENODEV;
> +	memset(st->osr, 1, sizeof(st->osr));
>  
>  	ret = devm_mutex_init(dev, &st->lock);
>  	if (ret)
> 


