Return-Path: <linux-pwm+bounces-3182-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1879729F4
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 09:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C3C1C240CB
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 07:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F1E17BB12;
	Tue, 10 Sep 2024 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XYJKxpmn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6647335A7
	for <linux-pwm@vger.kernel.org>; Tue, 10 Sep 2024 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951652; cv=none; b=WOfBYC6rb9ibogThavAVZbMwAklRvWvbNqXCrwrjNpsp+oXMsmrUdZavmsutRiOgu1Ek1ATaCZHjz5sNLbmyYe3FuSys2hvdKaQI3Vj7Y+bQ4eEWfUADPYiupOeZIg9ZuBEYRpFHSpz6P6oSenwZ/N95UPsPzb5V+1vTm+ypXYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951652; c=relaxed/simple;
	bh=fKFDtJX6H4J4ft9KA8cVnAC7FeDdliRD0lLCvf/mcpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExCiaUpsGOh3yyXOf4rilL4COnDQEnS+bqKrFvcQrM5ygwysvh/uBfE45S+X8wGGlPNEQy1/nn2daXlaOmKLw9r0Sa2IHXQugTOou/+4Vj9BmK7aoSWFsNrEnLwDv4NeoB3LFm9hgBTGFDGikCtA/qgUuJOKRNxuZYzkwMwqA5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XYJKxpmn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374c1e5fe79so3376971f8f.1
        for <linux-pwm@vger.kernel.org>; Tue, 10 Sep 2024 00:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725951649; x=1726556449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MLdy1HqCe/P/wfI/U0dXpj5UGtLrwYaUul2f80rYcsE=;
        b=XYJKxpmnnOlzpt59dijL2fSvScQP+PIffRUVNjurB+e/veLl86ujt5D17ZuIgvZuF5
         xutAbiGSFgSDd3b9oIbhSbswIrXh6CMgP9+FscydkTpsOp7qpGGIHNHMbflVHllK/sT/
         VwxmcUJ6VjdPQs2qnh2r2Jlrabl1Xi13EFsc6XnIKk5VDSNc2XcQNSG+7WUCP5qebxIm
         65fpFo1xeS58zuI55FM/RtnDJNxA7oJJZrHUNYKcp8+iIwi6dQhBL4wY8TclDuRbBu7a
         DslcjL17qRaG/Fe+baQDF8PGHBpO96rA9mPL6R3RRZk2+X4Us4ntsdVSV+PDmrSIqZLG
         FkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725951649; x=1726556449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLdy1HqCe/P/wfI/U0dXpj5UGtLrwYaUul2f80rYcsE=;
        b=clQnLzUKocisYYwi3fRyiwnFSXpHOiPdBDOlePzEcnE3vZMUsK8sXigHkG7lOks4Nf
         BQEcy2BFPJXQKpeDH5sS0mjoXilZKtJysoGWaaLosBGJfmiOw2bD7zZ5+LQuG5+uTSo9
         137ut5PWdfUvNB8YM0QfxplhZzDsxNJ6QBdPq059PBP6D8V+ue/WPH8MkT5wsRSCjMcg
         rY+i5rjSEN3ozCZtXSjxuxHjgrVMBm0rRlaMCDSJgUQGnXfaBH1XoyM8yVnlq8rSBjZz
         D1brhnVeJlKlKvSfJv6kSQ5OB0Y0K5Nht/06iVNvylARGaB/ewzJmFoBrFOFF4W3RnTJ
         9epA==
X-Forwarded-Encrypted: i=1; AJvYcCUfjRXS/j5vz4/EfQpXUDRAIyaYGebLv43E1Me9Hw1Wh2dGJlb7lJSiKG2ui1rXUxFvalg3zXr0pnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7wcxAn6maNZ+LS+U67D8YJNZlTnKmgWQOtlZQR3zyHBQdZYdo
	tsOlVjNnchuJ78vnJc0FeJLm4j4RbozSx6+6W0xo4EhPvEJ87FH7FVTy2eDw8uc=
X-Google-Smtp-Source: AGHT+IGSpgZGxNJQq/Qo4D8JhGcF7UkYtWKkqi99YliN+/1ihfgtjS4RGuaumEGAlmzP201Le1guqQ==
X-Received: by 2002:a5d:4386:0:b0:374:bb2b:e7c4 with SMTP id ffacd0b85a97d-378896b1c82mr8978817f8f.57.1725951648885;
        Tue, 10 Sep 2024 00:00:48 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8b2f4sm100972925e9.45.2024.09.10.00.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:00:48 -0700 (PDT)
Date: Tue, 10 Sep 2024 09:00:46 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH v5 2/2] pwm: Add Loongson PWM controller support
Message-ID: <awru62rcjkkb6n4sa2abmilzmu5ddxiv5s52tnkm2jcwi4isnt@djpzrj6asxok>
References: <cover.1720516327.git.zhoubinbin@loongson.cn>
 <63a540e93147eff5e7c942133c462530689f707c.1720516327.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w4t66meuz2x6g6x5"
Content-Disposition: inline
In-Reply-To: <63a540e93147eff5e7c942133c462530689f707c.1720516327.git.zhoubinbin@loongson.cn>


--w4t66meuz2x6g6x5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On Wed, Jul 10, 2024 at 10:04:07AM +0800, Binbin Zhou wrote:
> diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> new file mode 100644
> index 000000000000..17ab2a2f48ad
> --- /dev/null
> +++ b/drivers/pwm/pwm-loongson.c
> @@ -0,0 +1,285 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Loongson PWM driver
> + *
> + * Author: Juxin Gao <gaojuxin@loongson.cn>
> + * Further cleanup and restructuring by:
> + *         Binbin Zhou <zhoubinbin@loongson.cn>
> + *
> + * Copyright (C) 2017-2024 Loongson Technology Corporation Limited.
> + *
> + * Limitations:
> + * - The buffer register value should be written before the CTRL register.
> + * - When disabled the output is driven to 0 independent of the configured
> + *   polarity.

An info about possible glitches and if a period is completed on
reconfiguration or when the PWM is disabled would be great.

Also if there is a publically available manual, please add a link here.

> + */
> +
> [...]
> +static int pwm_loongson_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			      const struct pwm_state *state)
> +{
> +	int ret;
> +	u64 period, duty_cycle;
> +	bool enabled = pwm->state.enabled;
> +
> +	if (enabled && !state->enabled) {
> +		pwm_loongson_disable(chip, pwm);
> +		return 0;
> +	}

You can also shortcut if !pwm->state.enabled. Something like:

	if (!state->enabled) {
		if (enabled)
			pwm_loongson_disable(chip, pwm);
		return 0;
	}

> +	if (state->polarity != pwm->state.polarity) {
> +		ret = pwm_loongson_set_polarity(chip, pwm, state->polarity);
> +		if (ret)
> +			return ret;
> +	}

Together with the shortcut above this is buggy. Consider:

	pwm_apply_might_sleep(mypwm, &(struct pwm_state){
			.period = A,
			.duty_cycle = B,
			.polarity = PWM_POLARITY_NORMAL,
			.enabled = true});
	pwm_apply_might_sleep(mypwm, &(struct pwm_state){
			.period = A,
			.duty_cycle = B,
			.polarity = PWM_POLARITY_INVERSED,
			.enabled = false});
	pwm_apply_might_sleep(mypwm, &(struct pwm_state){
			.period = A,
			.duty_cycle = B,
			.polarity = PWM_POLARITY_INVERSED,
			.enabled = true});

After the 2nd call you left pwm_loongson_apply() early without writing
the inversed polarity to the register space. In the 3rd call you have
state->polarity == pwm->state.polarity and so skip configuring the
polarity again.

I suggest to just do pwm_loongson_set_polarity() unconditionally if
state->enabled = true.

> +	period = min(state->period, NANOHZ_PER_HZ);
> +	duty_cycle = min(state->duty_cycle, NANOHZ_PER_HZ);
> +
> +	ret = pwm_loongson_config(chip, pwm, duty_cycle, period);
> +	if (ret)
> +		return ret;
> +
> +	if (!enabled && state->enabled)
> +		ret = pwm_loongson_enable(chip, pwm);
> +
> +	return ret;
> +}

Best regards
Uwe

--w4t66meuz2x6g6x5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbf7pMACgkQj4D7WH0S
/k5t/QgAofx2pNsRH3IuK4/XzJXnm6mE1nKFc6tbO+Z+q4IJ6d74I4YvT2+XoYBp
efq6UR+1TTL2e0kkaoKhqIEfhA2ol371vVbsK9GXbFcnb4hfJFF4K9XD62oynakN
FgdMByd4DxiLTY2m5HJiLFNgUHHWQ23o6QPJ3GrLfA4nHXTpNHiBRSPiXHfMSqSH
TtqZELnnIadnGXE8DZbmxKims3D/Lg/nJoPggcYRtjXpJ0cY5PVaB2JULjb9Ul87
fGC7GdAEYYnRMly5inlY/1UqPUw9aWirjsp1/7vaxorgoe+Rc9l4z1V0BdT/q1tp
bOJo74ocmKhmUdMIJx5XraMrtFYcKw==
=rDRR
-----END PGP SIGNATURE-----

--w4t66meuz2x6g6x5--

