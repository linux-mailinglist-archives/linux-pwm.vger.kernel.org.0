Return-Path: <linux-pwm+bounces-2311-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C72958D6899
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2024 19:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA90C1C2138C
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2024 17:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4D017C7DF;
	Fri, 31 May 2024 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7yULbTB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC6317C7D4;
	Fri, 31 May 2024 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717178250; cv=none; b=B1WfU0Ml538vqnEQvuWD5W9/O8fL6nhxEuUlQS4fh6742r8NZ8pV1RD2gZ+LOTLxB9d/B2KoPIKagvW94dcJHDknEr1V8ygw+AFg/ilwHCTOMcwJC0NCjv4NjU0v7eUF3PfbrNzLuOVdIJptevE1wyE456i/D1xsyMDx+u1pShc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717178250; c=relaxed/simple;
	bh=14nUOvlXzx9FwcFZnYhljHX2vE6nY1fLFbUL/vgkrwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcpyvsrtoVFwAXo8y0VC6/CkA/vrCZcSdmSx8GcAIRMl3JvkmY5t0qyH6HlBs+EvEE927ED3+pC0S8h1eTJAOhsFtGBdrIKmUxwK7nWopGnYnxnZh+w4wd1V/UlSN77cg1uvWih2dwlHR2bGakAXxrnRY8Xkj4EozReGckZ6LdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7yULbTB; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dfa6e0add60so1416567276.3;
        Fri, 31 May 2024 10:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717178247; x=1717783047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iLsU9SrFk8jsYiYkwRmxAIdMWmUIfrvdUknMyWYRiWE=;
        b=e7yULbTBi8fPsnGj+5gxmyqps7WiyVq6V/8R9T96B7aFSlgcwk720JnVR1w98xqh3L
         dAf8EiGQKLDAs9r2QH1JoQcSsXB2hG3MdN3+bzmFoTMr/B4/LMQFuRbSYHDtRhTGD+ym
         hK/GrGbfAbyuXaIjRVu6F5aABJMPPACA4A0VFgZms9DhNRBZ7swN9mQ7mwM06Zcvpojn
         N23O57Thr3dUWr8XXJiacD3iRo9omsFUzeEgzWuCzuc1Z81oTAdjs6VcxO0ZjTyp6mOb
         SoTP9eXGqZSN/X/KW6YWXZXPdg/W67KKfh1VSiPSLE0daUhnOSkgf02crm7eiRgr0wWu
         yf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717178247; x=1717783047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLsU9SrFk8jsYiYkwRmxAIdMWmUIfrvdUknMyWYRiWE=;
        b=LZr2dvtb1WWoBNl2VnTc/62mokMvGtAi8qBg89aXN1wCpPenhr62yvaRkS3QdcD9x9
         QDObzlnY/gdAKhK9GKjAFTsbEDUqC2o0c8c5fUDCU2dWDHLGEH5U7u5N045/kzkP1qkP
         UMhtKBQidmDkvJ1SRnOkOeonilS8GxQ/p0YHazXeItWmyjtL3Y+k2uFrf6qiwcsMrf+y
         HcvK55iNrtCBRsQcEjWGYNjwM1ktej2/Klv8BinfadOCqa46aujRIciDgMAq6FIrM2Ol
         u+dGeMpAFctY0yrtlsBhiD3K31JfwUM8nDunCrpKVfsr4D/+KHND8byXZx10+I7oEzFD
         QDFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbxy6eGRV5tP3ypRDfAc3dpD6mvGUQKBupKzFnDoEzPPz0tTIAvhqdry0tIVsj3JwUC1Q8VNZhREbtUrDNqH1m8wQYGSqxZMCq02Dx5Q+tU1R5jcb/Sf6udth4fUwXo1uhZutH/Q==
X-Gm-Message-State: AOJu0YxtgQuGM0Bky0bIT5Wppyt9Qkr57YySlk8mrdIea9XxOMNwCuz0
	gxFygfNErEKYj1CqHq1kgMuM/6DUW6ukCAXZUFCg306K7xYPoYQXdy41l9ojff6zGiGJZmeEHH2
	wqWS34XhtAXaDWcvPd1bmlUBGuz8=
X-Google-Smtp-Source: AGHT+IGJfAakWRlaze69hr1itb5DcopAVyEyNrYk8qoHbmtcEU0nuInXs6ghX0YrxFqZ+c4wgNhMQt18gfTY2R95X1Y=
X-Received: by 2002:a5b:b86:0:b0:de5:4ab8:317f with SMTP id
 3f1490d57ef6-dfa73c087fcmr2687449276.20.1717178247282; Fri, 31 May 2024
 10:57:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531141152.327592-1-kikuchan98@gmail.com> <20240531141152.327592-6-kikuchan98@gmail.com>
 <851280ad-ac0e-47d1-99e2-4f3b5ea29f2f@kernel.org>
In-Reply-To: <851280ad-ac0e-47d1-99e2-4f3b5ea29f2f@kernel.org>
From: Hironori KIKUCHI <kikuchan98@gmail.com>
Date: Sat, 1 Jun 2024 02:57:15 +0900
Message-ID: <CAG40kxEbMQc-ni0HDVR7rtj48aFu-jz8sYUAO+fdmZSmXWrizw@mail.gmail.com>
Subject: Re: [PATCH 5/5] dt-bindings: pwm: sun20i: Add options to select a
 clock source and DIV_M
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Aleksandr Shubin <privatesub2@gmail.com>, 
	Cheo Fusi <fusibrandon13@gmail.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

> > This patch adds new options to select a clock source and DIV_M register
> > value for each coupled PWM channels.
>
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
>
> Bindings are before their users. This should not be last patch, because
> this implies there is no user.

I'm sorry, I'll fix them.

> This applies to all variants? Or the one you add? Confused...

Apologies for confusing you. This applies to all variants.

>
> >
> > Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
> > ---
> >  .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > index b9b6d7e7c87..436a1d344ab 100644
> > --- a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > @@ -45,6 +45,25 @@ properties:
> >      description: The number of PWM channels configured for this instance
> >      enum: [6, 9]
> >
> > +  allwinner,pwm-pair-clock-sources:
> > +    description: The clock source names for each PWM pair
> > +    items:
> > +      enum: [hosc, apb]
> > +    minItems: 1
> > +    maxItems: 8
>
> Missing type... and add 8 of such items to your example to make it complete.

Thank you. I'll fix it.

>
> > +
> > +  allwinner,pwm-pair-clock-prescales:
> > +    description: The prescale (DIV_M register) values for each PWM pair
> > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +    items:
> > +      items:
> > +        minimum: 0
> > +        maximum: 8
> > +      minItems: 1
> > +      maxItems: 1
> > +    minItems: 1
> > +    maxItems: 8
>
> This does not look like matrix but array.

I wanted to specify values like this:

    allwinner,pwm-pair-clock-prescales = <0>, <1>, <3>;
    allwinner,pwm-pair-clock-sources = "hosc", "apb", "hosc":

These should correspond to each PWM pair.
This way, I thought we might be able to visually understand the relationship
between prescalers and sources, like clock-names and clocks.

Is this notation uncommon, perhaps?

>
> Why clock DIV cannot be deduced from typical PWM attributes + clock
> frequency?

This SoC's PWM system has one shared prescaler and clock source for each pair
of PWM channels. I should have noted this earlier, sorry.

Actually, the original v9 patch automatically deduced the DIV value
from the frequency.
However, because the two channels share a single prescaler, once one channel is
enabled, it affects and restricts the DIV value for the other channel
in the pair.
This introduces a problem of determining which channel should set the shared DIV
value. The original behavior was that the first channel enabled would win.

Instead, this patch try to resolve the issue by specifying these
values for each PWM
pairs deterministically.
That's why it requires the new options.

>
> Best regards,
> Krzysztof

Best regards,
kikuchan.

