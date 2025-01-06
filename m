Return-Path: <linux-pwm+bounces-4539-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC055A0217C
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jan 2025 10:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D963A32A7
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jan 2025 09:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD581D7E45;
	Mon,  6 Jan 2025 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cGO49mid"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FF71D63F9
	for <linux-pwm@vger.kernel.org>; Mon,  6 Jan 2025 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736154559; cv=none; b=AvuHOFjtFXZ7smv5x0haBOkRCqBagN2mi6c7i880UdSiecY5rmbqYC7Tw4QNyYO56G1YIA7yl1cSK8gWrzG4+PP/gcV/uee2J3+BvABW2TZa5rYYvHZE/9K14rAJp9NhU07ltjMXQQEhL8N0EFW1yuYDVHRCiRbF6hNSsBtR2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736154559; c=relaxed/simple;
	bh=9zle5LgRMggSof2J6kpvNtie/hfml5DDqijUc5tcllg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSRwez6xDyajUkOjnjNVRRExduafX/qtOV28OKJVwGC7Y9JRpD7eXBqSypzvPZkbxvM23zA76hJKRRyYoPUP5MMD+COyakMRi3F+6IgIo8jhMRWcfkMEWGw9IfcfpLpV8Gd0ZUL2AKmfyO1RyxeStxnXgOvxBBejbW5ig0PVVzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=cGO49mid; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4afe99e5229so3989771137.3
        for <linux-pwm@vger.kernel.org>; Mon, 06 Jan 2025 01:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1736154556; x=1736759356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKuvKlk8OSfYx6PIrDfpXD1FNugUFoICZw9fVqCNqnA=;
        b=cGO49midQe+frxpyft64fTcSyGWyhgC6Ce4EABhwokHEHur6LSvCETL+qiyH+OdbpZ
         hd/Jh9giS/OSzFpq89pvwY810Co2ygqfywbyjGKey79sM3jh5TytIzddGOApn0KYoWKz
         Wj2Y1MFQpv7ErcpTuSlAr5uYhmgh4QVgmjQ82tUjCk9zFOUSDIB0kB7hPU0IN2CedAbz
         PfpFZ+x9DWdbQydF2lpAkxkZQo/3cVG2BRhRY+eeLVVmiAVY7WmRavjzI6/OdleQ7olV
         uOUmGKl1TlreB51uIzg+o6VYXXOtD9OTmnMLkAFgaV4gXR1GoScli/OLEL2AVFD5iy6N
         w8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736154556; x=1736759356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKuvKlk8OSfYx6PIrDfpXD1FNugUFoICZw9fVqCNqnA=;
        b=tV1HXxXjVbiG9iztBXzUVx2V+hdefFDWTWm1svbnEKzAn/8Nt1nMCmt051jLho4hiK
         x5oQfQlXCI/PQUlnCcIXHU4HGS2QzNqmxPGCkxf1VMeUnRl+wD5PHjisz4IZB80hmKz/
         OxhPqvwKovJ6/E3T/ZacnE6go7PbhG9vmNQWGqYDZyME9R1wdWFUsPjErLa3Q+bI+yBR
         mL8VHqOuLZAO6NhN5qm8lvLragQrZybCPmgIyUOEKBKnXu4svybshXfYFiCqllDWU1NP
         Apy8brmXWpfgiccFh1Y1H0C9X9uBvNCY9HZRApsvEmMdT45jrewqmggoOxMZvvZFL3zD
         nq1A==
X-Forwarded-Encrypted: i=1; AJvYcCXRb05er/rJXt9BcWHaTfkNYo5WqiTG4D2pTHotIlZYB545d41bKRfB2WZCSrCKTmxQKG7V2gZBOG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZRF36bS/YQg6Wa9rrRW2phvmskWFFxc0f4Ew1yUZC/gL8NI54
	TTB3xfZDO9VJ7faKVtAo+IILXYg28jSzZ4JXjSwDuR49/cXRmw6hNFvP+wAaCkWk6B0ZoHMKd8z
	Xufa3SuHrH/8ALRDoHYFqyyRB75/nWgMkReVWZw==
X-Gm-Gg: ASbGncsjIdqaHH3Laxl62dWZmTaej0zxxobbuj4FqSrenmQk0BOfs5bd+CT1Xb/r7eM
	E1Uzvjk2+WDVIPkUJPrFIlrFSoswW4kHxKbGLTYvC
X-Google-Smtp-Source: AGHT+IFjbXqhxALayXJfbH7eJGXsx4rjHHBouqVImmLYzT00NqHZwy4UszqEFmcWPxvwftlDyKoiqkwKnSXVY5m94Dw=
X-Received: by 2002:a05:6102:32cc:b0:4af:4974:a489 with SMTP id
 ada2fe7eead31-4b2cc46245cmr44531344137.20.1736154556388; Mon, 06 Jan 2025
 01:09:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224093902.1632627-1-nylon.chen@sifive.com> <zqkx7cx5nalslfmxeoxdnsjbvrvzajrjybsmsyeyc65a64sntr@gpc5qp6aoyp7>
In-Reply-To: <zqkx7cx5nalslfmxeoxdnsjbvrvzajrjybsmsyeyc65a64sntr@gpc5qp6aoyp7>
From: Nylon Chen <nylon.chen@sifive.com>
Date: Mon, 6 Jan 2025 17:09:05 +0800
Message-ID: <CAHh=Yk-_0rKB=FG6Voif2MDjtRxzUA5vXDP2J-o5=8ru1ewt0w@mail.gmail.com>
Subject: Re: [PATCH v10 0/3] Change PWM-controlled LED pin active mode and algorithm
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> =E6=96=BC 2024=E5=B9=
=B412=E6=9C=8827=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:20=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> Hello Nylon,
>
> On Tue, Dec 24, 2024 at 05:38:58PM +0800, Nylon Chen wrote:
> > According to the circuit diagram of User LEDs - RGB described in the
> > manual hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.p=
df[1].
> >
> > The behavior of PWM is acitve-high.
> >
> > According to the descriptionof PWM for pwmcmp in SiFive FU740-C000 Manu=
al[2].
> >
> > The pwm algorithm is (PW) pulse active time  =3D (D) duty * (T) period.
> > The `frac` variable is pulse "inactive" time so we need to invert it.
>
> I'm trying to understand that. You're saying that the PWMCMP register
> holds the inactive time. Looking at the logic diagram (Figure 29) of
> "SiFive FU740-C000 Manual v1p6" that is because pwms is feed into the
> comparator after going through that XNOR where the lower input is always
> 0 (as pwmcmpXcenter is always 0) and so effectively counts backwards,
> right?
> In that case the sentence "The output of each comparator is high
> whenever the value of pwms is greater than or equal to the corresponding
> pwmcmpX." from the description of the Compare Registers is wrong.
>
Hi Uwe,

Please give us some time to clarify these questions, thank you.
> With that assumption there are a few issues with the second patch:
>
>  - The Limitations paragraph still says "The hardware cannot generate a
>    100% duty cycle."
>  - If pwm_sifive_apply() is called with state->duty_cycle =3D 0 the PWMCM=
P
>    register becomes (1U << PWM_SIFIVE_CMPWIDTH) - 1 which results in a
>    wave form that is active for 1 clock tick each period. That's bogus.
>    If duty_cycle =3D 0 is requested, either make sure the output is
>    inactive the whole time, or return an error.
>  - With the above error in the official documentation, I'd like to have
>    a code comment that explains the mismatch such that a future reader
>    of the code has a chance to understand the situation without in
>    detail review of the manual and the driver.
>
> Orthogonal to your patches, I wonder about
>
>         frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
>
> . Round-closest is usually wrong in an .apply() callback. I didn't do
> the detailed math, but I think you need to round up here.
I will conduct relevant experiments to clarify this issue.

Thanks again.
>
> Best regards
> Uwe

