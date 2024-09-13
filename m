Return-Path: <linux-pwm+bounces-3232-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DF597834A
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB06E28ABAF
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDB52EB02;
	Fri, 13 Sep 2024 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhHyyols"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDAC4776E;
	Fri, 13 Sep 2024 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240010; cv=none; b=Epdl1p2d7lYKLo5Tgf3Y30I9W+4gMgL7PTtSZEDwg0X6IMqmFJP4MjO6Yikj6rhjmxrXB9GIgkjAXm+dj8z3bephUjNH2ouepIGGlKPfNGJW+LFxjC16nQXpKgXbriYdYNuBEz7VGdKz0CsXn/I1RTBZfF4lMFgkgHJfSw8iGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240010; c=relaxed/simple;
	bh=wz+c8oAd6WLW7uFv0JHSMpd9jMorPWZVWklbkOfGZzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ju58lvn7YIHrVyduBsH2z/5dySXl2eIirn9WoNcQF8PQUOyPYs+qxzb3ur/r+bGhV5GpZtaH0IM53PzWWjHiRWll1yl95npTCVsEZ9afja/AVMvxOnF5vaBEjFm8uJEMpp57tdq7KCap946ie1uHRKHInxXzIk1HwP4wpdqBSZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhHyyols; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e037b80140so900606b6e.3;
        Fri, 13 Sep 2024 08:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240007; x=1726844807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5xW7wFZXBPvsr8C7DrncpqkE2kHm1pCShCK0/i9/lc=;
        b=mhHyyolss7hpb0ZSWogWNSNtwbNjPY6ufBUVPmmBMwaUpSzzWCHOO/UJEcZBLqw+8z
         wI18IGq7b9e3lIeOfbPhehKiejs7W35gYdm170CiwgpPU4fpP5KOcxNTzrziFri/Y6Z8
         lbqWkKM3mhNJLCy2gYtcXs4JSJZwIHhwB8MASVoG4BuBs9NZBry0e+di8NwrUrcqlskD
         3keiaf3ogKG56B3hY0CnAttfYqE/460UzEhfJX985Vx8mF/B5Tgebmv/rk/nmyclhFoC
         TWH6qWBc/rKxu6Uc1amqZ7k3aYisNKcy/ueRv4LzJzMqYm2ics6frIhXNw1kr+lDpxkj
         SJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240007; x=1726844807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5xW7wFZXBPvsr8C7DrncpqkE2kHm1pCShCK0/i9/lc=;
        b=qk7MkEiepCWw7kPnHggqoOc/ck4EfpxzGQufGirnsDaSdi3fVUMrEbETbu/Ld2RpNl
         Owjwmoze9VbzjwpI0/yYg0dJqOyqKTlA0xl3r7lFb105BYeLXgITt/cBvH8hYfHw4NBc
         7WtjBpFQbNo4VQ2u5mk3vLijzpacwCnQewLHhfBEQJ+/h1rRVWO58NN8Rt5Ck4uVaxT5
         OkS5WQH3UvKMbImu6j2B0tgo0G2vErEwLmTXBoEOGsSgMx6nLnfqKObXYCQ+iERteZnB
         skCitnhR0cY3WA4qr2CzQnITxojf1Cug7tpJEjZytKUAzJf3qdy3XzNlHyWno56SowH8
         L6Gg==
X-Forwarded-Encrypted: i=1; AJvYcCU9il6q7gzf7DJ4vYA+l55I2ZXcprEaQ9rRiB5gOTPH1E82xN+MqsB6/vU86eA8b6vaxdk9C4Bb4eQkXQ==@vger.kernel.org, AJvYcCUAyW0LSzRSV24Qb7os/9WMFvS6ARJa40H+WMaToU6twBx20KLjLqyiea6YUjhR1oQcwfURtBnhB85pLrxAQPkrYjg=@vger.kernel.org, AJvYcCUTBS+HX+k3K3RdQa4IJMxJnDP/n09N6Je1+RkaMN2IdMjhuLcSsWVmzcsaeV/DLAxOauw1pSGL8RU=@vger.kernel.org, AJvYcCVePBL1qrrXLctZizepDh2yPM8zTmyk5ogDb+mjnCzSxQDxFxblro6zXzztnMP2sPE9/XxKpfHVRyJV56tlJA==@vger.kernel.org, AJvYcCWDU5dh8qC+vyVJEzxVqqKzf1sdgxUmuKb3ImODaLHJH8HYuaAHVTa80tt/itW8uKSS5f6da0ZRb5zzxR4=@vger.kernel.org, AJvYcCWEnFUbv9JFSez1ot4NZKyANTRwY2LRlMyj4mUUZ7MRGD+KFuXEHLA6xrYB6Y5wtiD8HzW7lucnYW9C@vger.kernel.org, AJvYcCWHVQLQ3j7fMWnHiaoRYdhQbfNqJVxZUyISIOFImd+dRBUSZ03Yy8hgMY3bL6rZHukOJ9MsKWfibMCeyTlq@vger.kernel.org, AJvYcCWJ8/YG5dQqwvyEi65coNdxK0b1ukTNAuAE5gKSX14l0dKLkvTr6wBRoUZW0RYPQcYFes4ttWdR9heI@vger.kernel.org, AJvYcCX8khivKX9Xhq+E/A9HsMuQv39ywUMbLKMR4UMqTWquyjlyhTjxZjDKOtb7x6QptiMKEJ8GHz7gC+zR@vger.kernel.org
X-Gm-Message-State: AOJu0YxCm/OLAD8E4Xo2kZRuXCjwQCshJW/BoyRE3L/WD5ApyLtgQ6j5
	dHVu/ZuOe4o6oZqUtcl4DKJM4E3+jk+IfbQgQ9LjP0poZdhaRneZniSuubznee0PbgFEcZXIzIx
	ufnYzlnRfTxK+o9btch7QTqKtatk=
X-Google-Smtp-Source: AGHT+IHpQNpk1RPbqhgaZak33vQVpNCMrUXMzkQcxSmZLbxJpQEgL7VG8czofXsUN5d9oYR08U0ZzgsDFVqScsKOzcg=
X-Received: by 2002:a05:6808:220b:b0:3d9:245c:4225 with SMTP id
 5614622812f47-3e071a93899mr4047532b6e.6.1726240007552; Fri, 13 Sep 2024
 08:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719-starqltechn_integration_upstream-v4-0-a7f644821941@gmail.com>
 <20240719-starqltechn_integration_upstream-v4-27-a7f644821941@gmail.com> <uevafpb6r7rfutiqrm5asfvv7zfxcb3acrlxqpispele5er52x@eegonpzqlm7j>
In-Reply-To: <uevafpb6r7rfutiqrm5asfvv7zfxcb3acrlxqpispele5er52x@eegonpzqlm7j>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:06:36 +0300
Message-ID: <CABTCjFA+4+37+gF2FcvGVMLmzwM01MVvSjBDinVJyRaw007jTg@mail.gmail.com>
Subject: Re: [PATCH v4 27/28] gcc-sdm845: Add general purpose clock ops
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: dmitry.baryshkov@linaro.org, Sebastian Reichel <sre@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 10 =D1=81=D0=B5=D0=BD=D1=82. 2024=E2=80=AF=D0=B3. =D0=B2 12:5=
9, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>:
>
> Hello,
>
> On Fri, Jul 19, 2024 at 03:55:04PM +0300, Dzmitry Sankouski wrote:
> > SDM845 has "General Purpose" clocks that can be muxed to
> > SoC pins to clock various external devices.
> > Those clocks may be used as e.g. PWM sources for external peripherals.
> >
> > GPCLK can in theory have arbitrary value depending on the use case, so
> > the concept of frequency tables, used in rcg2 clock driver, is not
> > efficient, because it allows only defined frequencies.
> >
> > Introduce clk_rcg2_gp_ops, which automatically calculate clock
> > mnd values for arbitrary clock rate.
> >
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > ---
> >  drivers/clk/qcom/clk-rcg.h    |   1 +
> >  drivers/clk/qcom/clk-rcg2.c   | 162 ++++++++++++++++++++++++++++++++++=
++++++--
> >  drivers/clk/qcom/gcc-sdm845.c |  19 ++---
> >  drivers/pwm/pwm-clk.c         |   5 ++
>
> I don't understand why a change to some qcom clk implementation detail
> needs a change to drivers/pwm/pwm-clk.c in the same commit. I guess if
> the change to drivers/pwm/pwm-clk.c is needed it should better go into a
> separate patch with an appropriate commit log?!
>
You're right, I'll fix that. Also I heavily rewrote this patch, and
included it in
starqltechn patch series. Since this patch has the wrong version (sorry for=
 my
mistake) and order numbering, please consider the next patch a successor of=
 it.

--=20

Best regards,
Dzmitry

