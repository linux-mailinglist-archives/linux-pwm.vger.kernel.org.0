Return-Path: <linux-pwm+bounces-3371-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F6B986E4C
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Sep 2024 09:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E6F1F275A4
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Sep 2024 07:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FADC19004E;
	Thu, 26 Sep 2024 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2XUpsEIB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A68B1A071A
	for <linux-pwm@vger.kernel.org>; Thu, 26 Sep 2024 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337322; cv=none; b=EkFMzrxwfrtNFMPtwbHDjHPoL02R0f2ZKHA/t+Dv7VXWZjZOBUqVYn4KCA9zIIt0I5SutWpC/L2i5xyx762fJU2UCBixB2rNv11H2W8aw3uguqN6c60s0J9fM3z6b+YzcArApfM1p+s8a3hJTMX+OYhk4DNgDbwZ9NArZAEp+Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337322; c=relaxed/simple;
	bh=ip6kFeuvP6zg6//1VVPPjLyEJoVFNToUC5FDa8jZ710=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bd+e7wDJxH4+fmWTuPXgDPvUMJgl0S8x9gsTKSVW9avI1ksxiiOR82ZarfpFF+pJZSIIxdjt48tEMws/dL1ZtcrotdvP2LeDkA6jZphUM+sC6L49kmIFNQjni7yKJVsOj4mJAMXO4mfVw7qTbWg+C8KiZkdyWhwCNPwRhPqyeps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2XUpsEIB; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f752d9ab62so7302341fa.3
        for <linux-pwm@vger.kernel.org>; Thu, 26 Sep 2024 00:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727337317; x=1727942117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PE2NoDBuLhPj2OiJOlSASTnt5gQkLgZG8T1NyKbDljU=;
        b=2XUpsEIBkkbl4A1w4Rv6uvhVLhGMgg7NXovJ0gorrbJiIHFr+t8ClOfksnpPvAElsO
         DgTOaBQ9uWvWtUPL3q9gWvS6Hrf8A1X+qt8CTdII5daJuqsK5CCi+6Yz6KruXv5nmgTf
         djuzH52HjVD+X+o4QODdaO/XNvFOgo07Ip54zK3ordULyKx/hNRIUexB/0oxSWdUAlzs
         6kVQWfBpdYfB1rpTuRMpBfZZQe6mgysVAtLuSpjaEqRcj4cc0VwlWTLqA0MHXZ1tHw2n
         9pT7rjPLu7fuI8hIlUQmaLSbGZVXZNgP1uAjSkuaWm7WUk7FunUvuYrZicN1zcTAo3ce
         3P7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727337317; x=1727942117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PE2NoDBuLhPj2OiJOlSASTnt5gQkLgZG8T1NyKbDljU=;
        b=JzTGIE9z8Tn6ituX0cR/xm9PkJ0LYFpx6nVK6ntSgbZ9KFYA4o30ovazW+h5mqMCg6
         rf1CUqLMBs2xK3wqajB5G/nNdno94W6z1wxBrEd81sBrEUJm6nL/CjBG+UUH9FX+bFAB
         V1tIWPpB4GafQAdY8XdzouZnwkE3TCDModnRe8SAmcmJg48kysS0IALkB9I5iOXmdzaV
         8/ALxUZ8mqmsmEqnrRK9C6zfc6qpR7zzwH6LD6e/eDFcnhLW309m4cBsMw50jM7912x8
         i7yqw4jDlbSM148Y/jOdCghirbTo67238Tyl/amzU2+NOTPJG7rX1GXjmBRpRdj+D/y7
         s2Sg==
X-Gm-Message-State: AOJu0Yw/DzvGb2qLnXZZTNqE1W8D2Sec/rUN8Q11qRSQXVzjVoL2XdH5
	3kG9NtUafC9Yis9z2Ikh+1baKvMY+iqIZqFxyV9QqaD1N/eGjtvpkr0dH6jmVrfrIaKUaK+EVVO
	4xbjpwjkIVNBX+MEqjK9sqM9VydvqNwhIHrdW9wmrOxsAq4EjhkM=
X-Google-Smtp-Source: AGHT+IEPQV/YMSoCZp+sw/VebldMUffwc78N+lxZPF0MgSV68uXjtYH/fUmGb4E3mbYN3ckpgvd5v/6u0mUUkXmiVxE=
X-Received: by 2002:a05:651c:513:b0:2ef:1b1f:4b4f with SMTP id
 38308e7fff4ca-2f91ca406c8mr36881751fa.34.1727337316592; Thu, 26 Sep 2024
 00:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726819463.git.u.kleine-koenig@baylibre.com> <6c97d27682853f603e18e9196043886dd671845d.1726819463.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <6c97d27682853f603e18e9196043886dd671845d.1726819463.git.u.kleine-koenig@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 26 Sep 2024 09:55:05 +0200
Message-ID: <CAMknhBFXwv+5ALzDQyMPjZ_Y9_DxDtSX9YWzy2QNjdHz8hkwmQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] pwm: Provide new consumer API functions for waveforms
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Kent Gibson <warthog618@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 10:58=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Provide API functions for consumers to work with waveforms.
>
> Note that one relevant difference between pwm_get_state() and
> pwm_get_waveform*() is that the latter yields the actually configured
> hardware state, while the former yields the last state passed to
> pwm_apply*() and so doesn't account for hardware specific rounding.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

...

> +/**
> + * pwm_set_waveform_might_sleep - Apply a new waveform
> + * Cannot be used in atomic context.
> + * @pwm: PWM device
> + * @wf: The waveform to apply
> + * @exact: If true no rounding is allowed
> + *
> + * Typically a requested waveform cannot be implemented exactly, e.g. be=
cause
> + * you requested .period_length_ns =3D 100 ns, but the hardware can only=
 set
> + * periods that are a multiple of 8.5 ns. With that hardware passing exa=
ct =3D
> + * true results in pwm_set_waveform_might_sleep() failing and returning =
1. If

I liked the previous suggestion to return -ERANGE instead of 1 here on fail=
ure.


> + * exact =3D false you get a period of 93.5 ns (i.e. the biggest period =
not bigger
> + * than the requested value).
> + * Note that even with exact =3D true, some rounding by less than 1 is
> + * possible/needed. In the above example requesting .period_length_ns =
=3D 94 and
> + * exact =3D true, you get the hardware configured with period =3D 93.5 =
ns.
> + */
> +int pwm_set_waveform_might_sleep(struct pwm_device *pwm,
> +                                const struct pwm_waveform *wf, bool exac=
t)

