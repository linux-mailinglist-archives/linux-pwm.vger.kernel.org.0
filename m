Return-Path: <linux-pwm+bounces-6420-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35652ADD1CB
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 17:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896AC1896B3A
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 15:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353922ECD1B;
	Tue, 17 Jun 2025 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je3VwXQw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72125221F1F;
	Tue, 17 Jun 2025 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174504; cv=none; b=ehlnV9wQRs8o8Fww7GiS1fKRuHVu/z4RlsLjYsK4bmln5pu4G5oRkbK6F6Jd1AxehE9eVdb7vlxDS2FocL8jR7aaB9Dz+r1izPB8lHfilyo3z30AhENGfEI4zaFiLlyXbJVXAYpb5ifZTqxEnP6o3YQ5kXbT5Lt6HlsDM/Xtyx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174504; c=relaxed/simple;
	bh=CPRfJWrde/3/SeuvcgoE8XZLSXfJKM2tDw/cNUxij6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWDh0jFnSZUZxbwGTvkJ49e18Wf3BbJD91kDCRwfPHNz8dx7V6gtWx+RWrKCtrMEbvSC/5zjqxs+IkMysZjmCjpsVO7ieGSEm5mZDrQOWonqbBbpwqHXxrePeIt/M+xfbl/f28Gf9sSHEyv52x+y1NSkYCq3LamHZC4k8eSPFaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je3VwXQw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so44169115e9.0;
        Tue, 17 Jun 2025 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750174501; x=1750779301; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MeUMhKUUGmcp9qUgtKmUDGAht+h0f117nU5fk45ORA8=;
        b=Je3VwXQwmtcB/PPaOgIT+SfH781dLGkPHfaz7fLEJOxW8yPsyQKQ6gHKeB6S8TxFEt
         WbVp2VzkgMWZj87cgveusv8mn2YO4R+PKgPiwjE3bEknR2klLsPN0n7+nJphHrjUtSmF
         q5GDYH38AiuXCOOVHiJJBqY4kqSEi/J4dPZLcpfrM8L8HNoWS8fQUx1QK1BJOCIDAxwz
         3QmGJGSbWa7wANp4FjR3FiYBkExHTVr+rwhfESnoGXVxbpS4x7hmjCJgfuUhDc5HKdf8
         wiYmzdqx2RWYAz7KIKCwexdSJxeAyl0WQULVEilJhpd60XhlbzYTuTSiJD4RTz8gvfGo
         jgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750174501; x=1750779301;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MeUMhKUUGmcp9qUgtKmUDGAht+h0f117nU5fk45ORA8=;
        b=YMneWsuDmTBwESR1Jk2rmW5zRBGllgvphoCLqrAtST2zy9O857+Etq1Ls1t1X2Oir+
         JSjHWIBNW0uRTCCvYat/p5EM5k4yNl47FHXUuvCgT/xoWo+jTPZ+5GGptMUbbsgq5XMA
         iTqR3aS5jekkZo1J/g7gHsMZjRJ0e7fUDN91TWq15xuVWHcMXvZDl5ipemGH7cdpaZKt
         aYFJgEc8IJEGBO9TU65Dv+ZIilvQ3b65MHPvS+DvAKCg+UcMv6hBYgFFHveu2X0uyLnZ
         Yh9HzCjNwk0nK+vYGrC53dOjfyiRlPSSgnaoAD9sMPDd4GlAzMoP75uskL+qwiUtN1/L
         Pgmg==
X-Forwarded-Encrypted: i=1; AJvYcCUFsFUrVsNz5n3UmOkqUzxvCLZL8Gf+cHKTl7Ktn6H6RUZ4y/Vf7nVoIFG9nyE0gsqobBhYb7PKiVtV@vger.kernel.org, AJvYcCUSnpYb64RoMRsCqA2y68DsDlEJ2BFI5l698LDFCIn9jkG0buaeYEg+fimBfKu2WmgOPX/zszJQRd0R@vger.kernel.org, AJvYcCUZhNDRcZxpoNa8FwS3uvmMnUErP0fxz/TZ8I8yd/DNsp/smD5eowVV1CDJhWakxTnhTRSgJSd3EgSd@vger.kernel.org, AJvYcCW+IoeaGjRAs1+zlwwSEYCFvxOcR+YSk43MXSu/5oWqb0nZDswn8SGZ4MWPAfDLwBT3qhs+2yuuHDCN@vger.kernel.org, AJvYcCWbp0RWwUSIbxFgkq9XZojVdAzMFxrNdhWEpSsN73hUwJuxAHLU47l97C0Bf56o9NQITv2liFexe/9LlrmX@vger.kernel.org
X-Gm-Message-State: AOJu0YzMw0Ixzkdh/Yrf03Jk/xQ2Yk5y8M/PEJNJkrbHRrvjMf2KE0+p
	IENKpIhnHNHtFAMWnI8fZBFMhFzY/LiYuA8+M/On8vIjVhYGdaKsvvQV
X-Gm-Gg: ASbGncuh6Pkjnc6aEqafLkiMV+kxRO1Q3b7dtFeX1v55fd0HwkB0SQNKtPwHJ2yzNxv
	kJ6YvhsjSwtKWNEHFlODLhF8ErFHpE9jrE8VcQnBX2qSW9sRKNZlRwAY7EbplsSoDblaQo47jaB
	SIRCvgw/I4VQwTf4y5MzG3NweeHA1h6QiAqKYxzIHL+R1qGCEq7926q4u00ds0l95rQMZk6mthh
	4s7+NUxMN0muk5mthxLY7VrN8fx+Ib60ON/wYHYAjHxDyGoRskSLEinVeVf/Lje30f4qgn4Xj+l
	Fb9234ZvniZxqgDZyKdWOTkXqtfZ5v8q7bJNpI4MseObjl6+nTB6wLALUF8bIALJREYqya6r0OU
	mF0N8l70=
X-Google-Smtp-Source: AGHT+IEcSofaIoMWRLHHOm6SNzbPQq+A9aFchPMIuRecoiBLLWlnkmk5gbcFgeFTvXVj0u/dPRX0kg==
X-Received: by 2002:a05:6000:2289:b0:3a4:f723:3e73 with SMTP id ffacd0b85a97d-3a5723a3627mr11983013f8f.16.1750174500651;
        Tue, 17 Jun 2025 08:35:00 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224600sm180824845e9.8.2025.06.17.08.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 08:35:00 -0700 (PDT)
Date: Tue, 17 Jun 2025 17:34:56 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 4/8] iio: adc: Add support for ad4052
Message-ID: <oqibdd7spdxvlimrwcabqo2xryfplk4q6lnwav5grtl5juud5x@vqfego523x7a>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
 <20250610-iio-driver-ad4052-v3-4-cf1e44c516d4@analog.com>
 <yw3n2csu4x4mfed33dtvl75zc5scgkjvkzruqilpw64n7esmdn@3fj77ufzm3c2>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw3n2csu4x4mfed33dtvl75zc5scgkjvkzruqilpw64n7esmdn@3fj77ufzm3c2>

On Tue, Jun 17, 2025 at 04:59:48PM +0200, Uwe Kleine-König wrote:
> On Tue, Jun 10, 2025 at 09:34:37AM +0200, Jorge Marques wrote:
> > +static int ad4052_get_samp_freq(struct iio_dev *indio_dev,
> > +				struct iio_chan_spec const *chan,
> > +				int *val,
> > +				int *val2)
> > +{
> > +	struct ad4052_state *st = iio_priv(indio_dev);
> > +
> > +	*val = DIV_ROUND_UP_ULL(NSEC_PER_SEC, st->pwm_st.period);
> > +	return IIO_VAL_INT;
> 
> st->pwm_st.period is the period that was requested before. If you want
> the real period that is currently emitted, check pwm_get_state_hw().
> 
Hi Uwe,

I believe only ad4695.c uses this method and the reason for that is if
the pwm is disabled we still want to obtain the requested value.

Reverting slightly to v2, the semantic to allow fetching from hw when
enabled, and using the managed state when disabled, would be:

	struct pwm_state pwm_st;
	int ret

	ret = pwm_get_state_hw(st->cnv_pwm, &pwm_st);
	if (ret)
		goto out_release;

	if (!pwm_st.enabled)
		pwm_st = st->pwm_st;

	*val = DIV_ROUND_UP_ULL(NSEC_PER_SEC, pwm_st.period);

Is this ok?

Best regards,
Jorge
> > +}
> 
> Best regards
> Uwe



