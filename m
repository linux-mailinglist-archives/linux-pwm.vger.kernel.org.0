Return-Path: <linux-pwm+bounces-8898-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOESGq69CGql3QMAu9opvQ
	(envelope-from <linux-pwm+bounces-8898-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 16 May 2026 20:55:42 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE6E55D650
	for <lists+linux-pwm@lfdr.de>; Sat, 16 May 2026 20:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB40E300BDA4
	for <lists+linux-pwm@lfdr.de>; Sat, 16 May 2026 18:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0E2342539;
	Sat, 16 May 2026 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhK1sizi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7563B28686;
	Sat, 16 May 2026 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778957736; cv=none; b=VbUO0bxtX7u+CPfpoSS5Wk6he/e7nZnru3vdnavr2MO7DyfKtkW8NqyU1oF9WfUPdjU55T7BRaiF1/XAkqBshmpLP6RooIiZGto4dGhCSSjuwSwD4+bxTtyexwhU38bmYRGgBBLUCnpA8FJOu1jgeR8SbzG4R6jJ5MTrp54UUrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778957736; c=relaxed/simple;
	bh=q/IpILmr0azoC+t0Lf2g+yybKTzBbhfe+OMXbr5vnMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbo1J/U1puZ/DF9hsIJjmjoGN4XEBBd4AiHXppHBZU3bfixcD/Wp3s4k4HaObYxVY2eoJvsQ/oAjyAO1zxxR/nDEsG/AKgUpWKwhDGg6uwwxmxnB89zUa99Ud9unZ35DhpGOi9NcsQFfKz/8x7TSJcvYzd1H2v/PL8jUfwnb6ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhK1sizi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDB1C19425;
	Sat, 16 May 2026 18:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778957736;
	bh=q/IpILmr0azoC+t0Lf2g+yybKTzBbhfe+OMXbr5vnMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZhK1siziz+X7X/gaHEAf46XLp/wpndFW29ONEQhistZJ8LZL9NdVhquDzcCgPzRA7
	 bYeyYR8bf5oaBqHnG4MFF7J/vDaW1WRDMr726TXGzMop61gPwHVD6HKwttfehaoLoA
	 h7vseBAgDOF2R1upFMaCUfj+o0ws1/A5FYJEw9mg1eHlPYjnYCltvTi0BhptUvduT2
	 9ZQ1zmnNifahl03+VVA7SFJfAiqMlxHu0iCqsxEmROOF0FY2eStn6JT/JHOpG/VQq5
	 deKDcavTSAoCLRc5oCU4z03rHl+rmDgUp+Sn0RdZQMBSdjAowxOxCHcvXl1dC/Zb7q
	 iT6k3kn+oWE+Q==
Date: Sat, 16 May 2026 19:55:22 +0100
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
Subject: Re: [PATCH v11 5/6] iio: adc: ad4691: add oversampling support
Message-ID: <20260516195522.6792f89e@jic23-huawei>
In-Reply-To: <20260515-ad4692-multichannel-sar-adc-driver-v11-5-eab27d852ac2@analog.com>
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
	<20260515-ad4692-multichannel-sar-adc-driver-v11-5-eab27d852ac2@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0FE6E55D650
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8898-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 15 May 2026 16:31:34 +0300
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

Mostly to avoid others looking into it. We do indeed have some issues
in the IIO core with races around read_avail().
They've been there a long time and attempts to fix them haven't yet
made it upstream.  Where possible it is better to precompute all the options
and pick a pointer rather than copying on the fly.

I think we can do that here but maybe I'm missing something.

I'm running out of energy tonight and feel like some Eurovision silliness
so I'm not going to do another full review today at least

> ---
>  drivers/iio/adc/ad4691.c | 381 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 343 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> index 25f7a6939b0f..39244e0e4a2d 100644
> --- a/drivers/iio/adc/ad4691.c
> +++ b/drivers/iio/adc/ad4691.c

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

The further issue that sashiko points out is we might rip whilst the
core is formatting this. It's actually worse than a small race as the
consumer interface might hold the pointer indefinitely.  There are only
a few osr values, can we precompute the lot and make this a pick?


> +		 */
> +		scoped_guard(mutex, &st->lock) {
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

