Return-Path: <linux-pwm+bounces-8785-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O5rLNr/+WljHAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8785-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 16:34:02 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0D74CF7E7
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 16:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 337A3301A08A
	for <lists+linux-pwm@lfdr.de>; Tue,  5 May 2026 14:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F813876BF;
	Tue,  5 May 2026 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+Qt48zq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48B137C112;
	Tue,  5 May 2026 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991591; cv=none; b=i+OsXTTAT61sBUbsihHr8qtTkUnP9r8dLyi9K/MIQxR7ZSm3StbncSHaQ9KVK1JMWWAt1RIXtEM0UrAfmHwAqjbpytg9rg/gBchs0DslWPVyzIhGSd6beUD3R8KMWA1/frUSddu6AiyqW59BgE4l5EXbsJdpE1LLz/gJYIiiELw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991591; c=relaxed/simple;
	bh=OL4OUdNJ128vud94TMxhaGSNWLDUn9uwi9hY24ST15s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDr2LJKZgHp8sAPmg7HsTBQkLpC8zsBbqWtat3wobpEoEPmOD8AClPghU9knXRi9SCcmHdXZpBlHVgHKORtFHCzeKPUoCWx57THMwWPZtTpojbQYoAidLiwgxcYIvSV2fRJS0kUtM6fsEyihIHbl1Y/ss7DkUhcWmpiyMIJWwv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+Qt48zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF292C2BCF4;
	Tue,  5 May 2026 14:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777991590;
	bh=OL4OUdNJ128vud94TMxhaGSNWLDUn9uwi9hY24ST15s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o+Qt48zq92G+WnqzemHsR2BKpewJRmonklViFg1sBAkRUALN3AvmfcitxKt4xg5Z/
	 CoJuKl97HCswn0REmsFYFsgLMDc0YyyLp+teW63owZV2gQryLwWBsJ7SAZ49Pe1TGk
	 35H3Po5CrcSoLryxbSDRukkGZpxLrje4kCfzSUS+akmnuslxGiyA3GVZzoVrsRBdvc
	 Y8JHk1MExWTBN0OLGFk+X20U1IeTro+XQMvaR3Rcol1gjjaFDI1YNL5W67yp4YR+iw
	 jzabor0U3bv/uRo17qNACQC44TXta9ctUV6EmmJexGNep9+65P5F8qkYDgBXYR50Q+
	 guwEf1WVpNeZA==
Date: Tue, 5 May 2026 15:32:56 +0100
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
Subject: Re: [PATCH v9 5/6] iio: adc: ad4691: add oversampling support
Message-ID: <20260505153256.7779e7f8@jic23-huawei>
In-Reply-To: <20260430-ad4692-multichannel-sar-adc-driver-v9-5-33e439e4fb87@analog.com>
References: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
	<20260430-ad4692-multichannel-sar-adc-driver-v9-5-33e439e4fb87@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0E0D74CF7E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8785-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,analog.com:email]

On Thu, 30 Apr 2026 13:16:47 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add per-channel oversampling ratio (OSR) support for CNV burst mode.
> The accumulator depth register (ACC_DEPTH_IN) is programmed with the
> selected OSR at buffer enable time and before each single-shot read.
> 
> Supported OSR values: 1, 2, 4, 8, 16, 32.
> 
> Introduce AD4691_MANUAL_CHANNEL() for manual mode channels, which do
> not expose the oversampling ratio attribute since OSR is not applicable
> in that mode. A separate manual_channels array is added to
> struct ad4691_channel_info and selected at probe time; offload paths
> reuse the same arrays with num_channels capping access before the soft
> timestamp entry.
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
> Writing oversampling_ratio stores the new OSR for that channel;
> target_osc_freq_Hz is left unchanged. The effective rate read back via
> in_voltageN_sampling_frequency becomes target_osc_freq_Hz / new_osr
> automatically. The two attributes are orthogonal: sampling_frequency
> controls the oscillator, oversampling_ratio controls the averaging depth.
> 
> OSR defaults to 1 (no accumulation) for all channels.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
Just one thing - from Sashiko again.

J
>  
>  static int ad4691_read_avail(struct iio_dev *indio_dev,
> @@ -540,10 +655,30 @@ static int ad4691_read_avail(struct iio_dev *indio_dev,
>  	unsigned int start = ad4691_samp_freq_start(st->info);
>  
>  	switch (mask) {
> -	case IIO_CHAN_INFO_SAMP_FREQ:
> -		*vals = &ad4691_osc_freqs_Hz[start];
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		unsigned int osr = st->osr[chan->channel];
> +		int n = 0;
> +
Sashiko shouts about possibly getting a torn set in here if osr were to be changed
whilst you were computing the array.  That's probably worth using locks to protect against.
> +		/*
> +		 * Only oscillator frequencies evenly divisible by the channel's
> +		 * OSR yield an integer effective rate; expose those as effective
> +		 * rates (osc / osr) so the user works entirely in output-sample
> +		 * space.
> +		 */
> +		for (unsigned int i = start; i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {
> +			if (ad4691_osc_freqs_Hz[i] % osr != 0)
> +				continue;
> +			st->samp_freq_avail[n++] = ad4691_osc_freqs_Hz[i] / osr;
> +		}
> +		*vals = st->samp_freq_avail;
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



