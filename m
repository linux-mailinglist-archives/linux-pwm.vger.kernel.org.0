Return-Path: <linux-pwm+bounces-4284-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4BD9E806E
	for <lists+linux-pwm@lfdr.de>; Sat,  7 Dec 2024 16:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79DA11884331
	for <lists+linux-pwm@lfdr.de>; Sat,  7 Dec 2024 15:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF052745C;
	Sat,  7 Dec 2024 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iQbGnn/x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FCA2E628
	for <linux-pwm@vger.kernel.org>; Sat,  7 Dec 2024 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733585399; cv=none; b=t+qkwkAokcncnSVM7RO/7ExYQRxQuyxKYC3iSrojje+kwjzh4pw+IkrhSnRfBZgOkyK9c5qQF9jKS781iNhBvh6YjERp6/Tr9NGcYjwOq1bYIHrQkoMYtDKfgA4ZhYJJv2DE/qhJwKj8Sk/+aJ1pX5CmVEYRfhFMvKxzuli3eag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733585399; c=relaxed/simple;
	bh=++qwKaLQJK0eYuZPezy9s9pCAqz4NQG7EHyBEh/bhPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1z9VpbF+eNApwWZA3GDllaML3wQ/h2lvVeRWZNg2zo2NPhE7a8xql3KoFgcXS5JdRqA6SafIotYqjcS/2IDd6PQ1hLiO5DUpYmMbw2QkW79EJABst4tpZkTiEa/VFSgoaIA1KZ/0JFttd85pEQw+D1+7rnz91Qfqctt2OcbA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iQbGnn/x; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso388545166b.1
        for <linux-pwm@vger.kernel.org>; Sat, 07 Dec 2024 07:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733585394; x=1734190194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N94u8ceJE9IihGissqr+ltow5uqSpjZz+SPLJ2SzdDc=;
        b=iQbGnn/xXpVDe2T9BJg0wVaFJ3xBRuKIfmhVzO8CvuAbIXO2rROhTWuraBGu1fB1Vc
         v4C0RAKOCMcTN7/p0Sj2ch7t/+4bjDSc2Q9udO5oHO+M5/yy/j5J1i1xJXSdlP/CZ0UW
         xnW8+p0R1eW6mHnWmmcb4+9eh5xmkF5lICDcsrcamwmyxRkFUqJPfJAw7zHR+nYHhFLb
         8C1IRY2TDqcHl6GhWUTgaIYqqFe+2Fv4FldanBcQermjFVQRGtny6gQvitIaCUsggt7O
         jCLkp2gDzLt4tJTVmoxn5GcpWiAvlGPFudjsi7edtmDB81sK9faegoXhWrmLPzKFus60
         MjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733585394; x=1734190194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N94u8ceJE9IihGissqr+ltow5uqSpjZz+SPLJ2SzdDc=;
        b=FYTXV1Nk3S9PRMxglZ3i06EXbOsVatUini6LkL+buV+4dazvTpb8YbLATdCbNnx8XO
         YEcX5x62Id1S1uK47dgddFiTRS/tO5ex/0pl56Kv8nuCCc9GdeNMNDHwZpqYTLNl3wpr
         RGs0+wxRCmAVS1PWmuf5j5MSIVzUpMCq8FjB1zCG3oN3hYcEVMwMMEPUnDkAItxXbg+B
         K/25EHHh62XuutVDjFkG8pChPkFskn7dEU0wo+nbdnBB2lKU6o82p1L5OQl0wbSFGllW
         5nx4Qa13R/N+THqXjFqEO0jCbRaMksFBKHInRHL1fHIh8h5wccWXq3yLKfKJatMZYFA1
         iJIg==
X-Forwarded-Encrypted: i=1; AJvYcCVL0OpKCiuZqE/mhnL2bNghxHcTmBGMcoUELljDv0R1PmLokPlz1/gHp9h9n7iLf3pPvhNtFnElHBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWuyLbJEJXPg//DSl2jdP1mUpuPMToYUqGYUaFhM5u4BWra3JS
	ZW5G/bZOkzOzGY2OOhPJGaJW+1YyZrmBsmpn43zj/MRQ41Uu0tCkeClBrjj3A54=
X-Gm-Gg: ASbGncuoqEdbhlLmNn2KT3BbO890C+S0hjKrAjYQRJV/ppFDhtBrhK/J+toM9ZCQEeC
	HnbB/ktCe2UGylvMhqXdN7tzbUkSLSX5s3sUViFEY6e3pGfKEiAJS5HnzFOaXUkUhADSRnV8fhh
	wG2rmLJfYNUHY6s4shmk2IY7Q9+pB/wl0EGVO91OPCnfyNGneYNhEXoQv+wLgv0ssUlHPo76b8z
	MQx45qg1rel9fd06QR3+O+L0OGqJcq/Q1AiKB/E1Hl1fyoVmFnF1w==
X-Google-Smtp-Source: AGHT+IF4LY5WB0e2F6DNpEuhnVjdXbVwXG9srfjzrNNUuYa2L9aD5xp0wQlYa8StPx5b3r+PKQuxAA==
X-Received: by 2002:a17:906:2189:b0:a9a:1f8:6c9b with SMTP id a640c23a62f3a-aa63a33c764mr406864066b.37.1733585394222;
        Sat, 07 Dec 2024 07:29:54 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:a8d:e1d8:6f77:cd7e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e5c660sm399012466b.19.2024.12.07.07.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 07:29:53 -0800 (PST)
Date: Sat, 7 Dec 2024 16:29:51 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v7 8/8] iio: adc: ad4851: add ad485x driver
Message-ID: <cpfpysi6zcr7n6qy642dmhsi2a4hom2p7l4rboj4jgakuzpa5p@5xaqd3oxxlrs>
References: <20241129153546.63584-1-antoniu.miclaus@analog.com>
 <20241129153546.63584-9-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ssuityvtqapol74n"
Content-Disposition: inline
In-Reply-To: <20241129153546.63584-9-antoniu.miclaus@analog.com>


--ssuityvtqapol74n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v7 8/8] iio: adc: ad4851: add ad485x driver
MIME-Version: 1.0

Hello Antoniu,

On Fri, Nov 29, 2024 at 05:35:46PM +0200, Antoniu Miclaus wrote:
> +static int ad4851_set_sampling_freq(struct ad4851_state *st, unsigned int freq)
> +{
> +	struct pwm_state cnv_state = {
> +		.duty_cycle = AD4851_T_CNVH_NS,
> +		.enabled = true,
> +	};
> +	int ret;
> +
> +	freq = clamp(freq, 1, st->info->max_sample_rate_hz);
> +
> +	cnv_state.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
> +
> +	ret = pwm_apply_might_sleep(st->cnv, &cnv_state);
> +	if (ret)
> +		return ret;

If you want to be sure that pwm_apply_might_sleep() doesn't round down
.period (and .duty_cycle?) too much, you might consider using
pwm_round_waveform_might_sleep(). But note that this function only works
for two hwpwm drivers currently.

> +
> +	st->sampling_freq = freq;
> +
> +	return 0;
> +}
> +
> +static const int ad4851_oversampling_ratios[] = {
> +	1, 2, 4, 8, 16,	32, 64, 128,
> +	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
> +	65536,
> +};
> +
> +static int ad4851_osr_to_regval(int ratio)

This function is called with an unsigned parameter only.

> +{
> +	int i;
> +
> +	for (i = 1; i < ARRAY_SIZE(ad4851_oversampling_ratios); i++)
> +		if (ratio == ad4851_oversampling_ratios[i])
> +			return i - 1;

Given that ad4851_oversampling_ratios[i] == 1 << i you could simplify
that. Something like:

	if (is_power_of_2(ratio) && ratio <= 65536 && ratio > 0)
		return ilog2(ratio);

> +
> +	return -EINVAL;
> +}
> +
> +static int ad4851_set_oversampling_ratio(struct ad4851_state *st,
> +					 const struct iio_chan_spec *chan,
> +					 unsigned int osr)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (osr == 1) {
> +		ret = regmap_clear_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +					AD4851_OS_EN_MSK);
> +		if (ret)
> +			return ret;
> +
> +		ret = iio_backend_oversampling_disable(st->back);
> +		if (ret)
> +			return ret;
> +	} else {
> +		val = ad4851_osr_to_regval(osr);
> +		if (val < 0)
> +			return -EINVAL;
> +
> +		ret = regmap_set_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +				      AD4851_OS_EN_MSK);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +					 AD4851_OS_RATIO_MSK, val);

You set this register twice in a row. Can this be done in a single
register access?

> +		if (ret)
> +			return ret;

Best regards
Uwe

--ssuityvtqapol74n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdUaewACgkQj4D7WH0S
/k55Vwf/dcyzLERHADJy0eA4I3kK1jSCddOaUpX9iL4wUcXFMi2IGBfN/aJ6hVJW
RahHHZ0hx4S6Y+RMdyIb40mDgDxEOIzxihi7D+5KI6CV3cDd4oZkUkQ3rNFXQ3Gk
hOuaDEasQKueh0lbjTT5eQ4t1xzfSlNjpTrbR3t+PRtXRF1Wgkg2E+IorJ8q7duR
+tsndFiWef/2ycvM/e/RZefB9kCX+3IEiaZIzgiXIbqtZp5hcN3WQJ9iJY95s0Gq
BN7yTVmNrknMfJopgF3JhHuwtCoEfLqS6ehITy3bd1SKWL00sg2Nvnh7IBKc/04d
9M+ZIy+6be+xTyAXZi0ESyB20GywDg==
=W1c1
-----END PGP SIGNATURE-----

--ssuityvtqapol74n--

