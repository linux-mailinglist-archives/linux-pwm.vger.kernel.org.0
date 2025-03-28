Return-Path: <linux-pwm+bounces-5300-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D85A7467D
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Mar 2025 10:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B1F7A6009
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Mar 2025 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521EC214A8D;
	Fri, 28 Mar 2025 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Nren2MQn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515782153CC
	for <linux-pwm@vger.kernel.org>; Fri, 28 Mar 2025 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743154914; cv=none; b=AD7TZH0mdn0msP8tMtMsn9v38jjBwNT3iNilqHe3hQyLSF+V8e/bNaVWuuKPJ10MOR9vWTpPLlp2nYCAv9myq5UVmTto/ELCniZmr1nDWzQEV53Pgp5Bkdq9t7uW6DOTS/0E/baB5TSNilAIh0KSHrkPwStnTnENpUl/miq4AVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743154914; c=relaxed/simple;
	bh=Zun5s4aXGl/09PaE0IgNxFi9M4KhwUChifZd44o3m8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lB8NFDTA8MJ136vOY0vgji1l8ZTHXC0a0fHNQ+OKKGdTnH4VpwnYjSxjnbnyGylfv+t0ctQAxH3gWelajn0V+UwUcACxC8ZHXvEGzd0++RufP9LPNqelWa27XVaokYFvkBcyYK3wKOmzy4/d0fznJnA6VJCfPtU+5817ff8tm64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Nren2MQn; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86dc3482b3dso3078029241.0
        for <linux-pwm@vger.kernel.org>; Fri, 28 Mar 2025 02:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1743154909; x=1743759709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1b0hX/zsu3e/MFK5kXhrakxPDVZLxz0+s0CCuIkG+I=;
        b=Nren2MQntzUBLwhRf0HZGBWJKRUerlocQmOPALoBnJebxRqRjkKTlKT4cTNWivvsM2
         XEiRQCjr9k/FhMk8HIuQ9zXjhnfcUPsUzECR3ucE6i2ZWXZA/s+r84ZK0QQqFfyDKNDf
         Dgsk9b5wMLIDvP9yg8qGXmyrAcRzRYL6os9rlZOufdzW4P9tVFhACxAqnpMrp8c8vF6+
         gNMjJAyPcD3gXwsvMsYaDkhafxHDCp4TSe6BsaPFcvv6SHwX2vpIjfV/0kwIqwI11h76
         IjErwa1+GaTi1x3b+iqct7N3RUU46v1zUCoV1UPbdJLFRxK5G+TVJCZ/jei9KvhVeSDO
         cung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743154909; x=1743759709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1b0hX/zsu3e/MFK5kXhrakxPDVZLxz0+s0CCuIkG+I=;
        b=rXAkN5lXJvIRfjPcr/1LkVfU3sQVwufk4+NxvlHyJPFW8etbxzSBiN0OZkB54m76kI
         JZL8tK1dkN/zV/RysfGWGiMUAo+YXX7ymGFB+0tdPsUPTFspmECpQ6mBOzmDjCYDFien
         D3apM8gc/BDHsRODUM43aCLninrNdCyGgFK1z5lZ1nVYNxNGYb3/bM/dSie7u5VKAPqx
         qWCC9ZRhR5af/HGCxV9rP34Hws42zC2AywmhSQBnbXlKwenPFhCeFv+bTbq9gYxhfHZi
         QJTNRHlS7d+AP4qC+j+UV2VmeWDg4n4usEyvnUEhHCJt9v1AMT/gbP0IiPwz5EyQRA2b
         FgJw==
X-Forwarded-Encrypted: i=1; AJvYcCUcU2jxup6x5OiM7aiFbUNi07N/RUoK5eHbgTYiMJ+HDCK7P68NER6kSjqQtFv2QDwJtZxUoanKZVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjZhlm+WHnU1QhZOCFIfqupCt8CODH/gbDfy+qhcZeCG/0XLPQ
	E0CAwm0DHsFW8CVNv6aamgJnFbdp1tmEFSyn4NcDgfqkbXT4qmmU/V/mkepPVyzorSwiKb4+NXD
	cInpHl1WgKRUt90ExyCBgfzmqyD3XjQkRvSdkJA==
X-Gm-Gg: ASbGncuayQ4bjOhAZMNlFC34WI3Zb+s+3vjuRBQy4I2XdQ0N/FXvriQ4OFMx42OgLN/
	EhpsR7VYnhlX7kThhUcaAWNCVtw6g1bOfMSe2b8RsAyK3BAdLw8yAeWOE7O3iwjlwzN3SB3n/PZ
	kZ0Qr+9IyarYmTduAh8le1sDLDCD6y
X-Google-Smtp-Source: AGHT+IHAfA7U5ABlgiwkdwG5YFKYhP7zz3TIEVTOcbnJ0BCTQpH0ybwGPzt5hi7ByZc+Ofz77emzNeHplbMnGuIyChc=
X-Received: by 2002:a05:6102:a90:b0:4c3:878:6a62 with SMTP id
 ada2fe7eead31-4c6c2816727mr954406137.8.1743154908552; Fri, 28 Mar 2025
 02:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224093902.1632627-1-nylon.chen@sifive.com> <zqkx7cx5nalslfmxeoxdnsjbvrvzajrjybsmsyeyc65a64sntr@gpc5qp6aoyp7>
In-Reply-To: <zqkx7cx5nalslfmxeoxdnsjbvrvzajrjybsmsyeyc65a64sntr@gpc5qp6aoyp7>
From: Nylon Chen <nylon.chen@sifive.com>
Date: Fri, 28 Mar 2025 17:41:37 +0800
X-Gm-Features: AQ5f1JrdaQFUJm63vOfH9GWXIi95vV8JEVeEsIoDHq3ca33AIZRvXLmLu0ehrcM
Message-ID: <CAHh=Yk_j1ZnJ+=XQ_geN1sXMaye=P4jk-vduwj0-1soM7d+wQw@mail.gmail.com>
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
Hi Uwe, I've contacted the spec's author, and he is willing to correct
the spec-related error.

Based on your suggestions, I think we have two approaches
1. First add comments explaining where the spec and implementation
don't match, then after the spec is corrected, submit another patch to
remove the comments
2. No need to add this error explanation part, because the spec will
be corrected later.

I don't have a preference, so I wanted to check with you - do you lean
more toward option 1 or option 2
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
>
> Best regards
> Uwe

