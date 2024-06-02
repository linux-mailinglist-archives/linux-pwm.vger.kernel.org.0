Return-Path: <linux-pwm+bounces-2315-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 514F48D73F7
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Jun 2024 08:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E23AB2111E
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Jun 2024 06:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BDB171AB;
	Sun,  2 Jun 2024 06:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q62ItOIv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B55417C7C;
	Sun,  2 Jun 2024 06:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717308929; cv=none; b=g/9jkpGTp1/nyrVbgrbxDfLGMzRO8uanxUP6QgZ0dYUPsxqyFjBt3YEgVMwdLjys64TmA+5A1Z2oeke+Mc8Hy3Z2LLECj4UytrMLvZ1wG9HFj4FGOfxfhA07zExp/SlmDzr7lChA7qAslaBlydQT2ROrOX8lWP+6UpvoBsuRPNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717308929; c=relaxed/simple;
	bh=Los8Ov7EyXlum763kU/ev3jxiQBgLzB/oqck/a0gAhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7LQkTqNCKarIe+e+BfeiyJEUU0wvfgZZWqOTde6aw5UcZrSpmoTuWykFRPzCl2RB5qn8E7ZDb2lhZG29CAKY7NKYPrRdyo79AX9052NzcPLOsiV8gmRcVPSx+c4Pl3uwkif6kRo89xX1CTPE6ZYE/Ld7LYDRLXBy3APtse7LZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q62ItOIv; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfa48f505a3so3399554276.1;
        Sat, 01 Jun 2024 23:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717308925; x=1717913725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KVjiwXFBtE1oOqyRTamGWqLptn8iyCLDvsbblHzrRdE=;
        b=Q62ItOIv21DWd2rE5PhV23KL1wCmJNUr+G8gsjaCBOhyVImDHdT70TCFsbtY8KEgBo
         g6dfWpAvOdAgy2T6sWkLop5J706id1NhEESSyGrEKL9h5+mfUYF5xCnnZqtihdHo4RmA
         FCoQgCNsgc97kw2/J5Mlxu4iqA3xCXv3duz54bfTszdm1iyVdffBXhBTOeW7mEkTO2pz
         vuMsxPv8nqryHSHcfvjQ/nMUJRZ/BIjAeDpQYI1c7UExymlWfH93pzDoX4K+V2aGOOT8
         Cb6UGo9tfZNR+kCSZcSy18wQ6+FszpFhegnExMEoFOPTmaZpg22Y2KV2o2mLmPN9bZpz
         8MYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717308925; x=1717913725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVjiwXFBtE1oOqyRTamGWqLptn8iyCLDvsbblHzrRdE=;
        b=tqs54Y1dlmrS9BmDPlF2R9Uy7fHvFbzjvk5McA/VqdLhmWbi5Yy3VZALe+uNfkRpE6
         ZjF+hK02N1/CKGP8vwWPM5zOtCEUEvCGRScWgnUanWhMrBvAd/ReC7DdF/nQay2d2oMd
         mLvhnqEGWq0dOeCqo4Tle7tb33N3KY7/6dO7Dqi4p/rUY6po6FMkU2d0RbOnfiAvPFYN
         56lEOZQL9789oilstj4axN5CjoP6Kvj3PK+D+KqdiF/+/W+8DA3r7b7TlbLeqVl0tyyG
         ZdurknJWs+goqDMVR7kB4tEawvkg9DlncqwZsomjsDDCN1b0xvM5BMStLX4WMEzVqiwn
         mJYA==
X-Forwarded-Encrypted: i=1; AJvYcCUtQxi0v+YbHzwAGyPkYCbOgMegLD7UB39VDs4gKkVUUB2yDqCC4sDfD/RUnLg24hu+U1HwrIOQneLafh+W0sRokE8hHsCaxhUnr2qi0433D72Dv7aah8nWWgIwTUML4iza2PW4AA==
X-Gm-Message-State: AOJu0YwLjVj/dVcLyAan1EIMZNxmhSA5kqXw7VrbaW8ZYVL8B0U+ZmG5
	3jvWq6HCcnU1PEKkEMGmVHkkqBoUbY5TXrUqDAywuq2ozrys/iOo4GZnxn2gkhCj8G4dAUXh8+1
	KPRw9gcW/asjoyg2gxrwgzoo/rvE=
X-Google-Smtp-Source: AGHT+IHzU7d27sCCp4NQBaatf3nzUotkZSiFvnl3BH+2PWIZ4QiHI8EK8bWQy/db4hkLKA2ay/UPCETfj9lFOCrUA80=
X-Received: by 2002:a25:ce92:0:b0:dfa:5710:d8c5 with SMTP id
 3f1490d57ef6-dfa73c49b40mr5947856276.31.1717308925325; Sat, 01 Jun 2024
 23:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531141152.327592-1-kikuchan98@gmail.com> <20240531141152.327592-6-kikuchan98@gmail.com>
 <851280ad-ac0e-47d1-99e2-4f3b5ea29f2f@kernel.org> <CAG40kxEbMQc-ni0HDVR7rtj48aFu-jz8sYUAO+fdmZSmXWrizw@mail.gmail.com>
 <da382d43-fa82-44c0-9630-086f59e6efa2@kernel.org>
In-Reply-To: <da382d43-fa82-44c0-9630-086f59e6efa2@kernel.org>
From: Hironori KIKUCHI <kikuchan98@gmail.com>
Date: Sun, 2 Jun 2024 15:15:13 +0900
Message-ID: <CAG40kxHKdC=uwyWzsBo1LTAXARDQGs0N4TBdD5nE1zhos48cbg@mail.gmail.com>
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

Hi Krzysztof,

> On 31/05/2024 19:57, Hironori KIKUCHI wrote:
> > Hello,
> >
> >>> This patch adds new options to select a clock source and DIV_M register
> >>> value for each coupled PWM channels.
> >>
> >> Please do not use "This commit/patch/change", but imperative mood. See
> >> longer explanation here:
> >> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> >>
> >> Bindings are before their users. This should not be last patch, because
> >> this implies there is no user.
> >
> > I'm sorry, I'll fix them.
> >
> >> This applies to all variants? Or the one you add? Confused...
> >
> > Apologies for confusing you. This applies to all variants.
> >
> >>
> >>>
> >>> Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
> >>> ---
> >>>  .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 19 +++++++++++++++++++
> >>>  1 file changed, 19 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> >>> index b9b6d7e7c87..436a1d344ab 100644
> >>> --- a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> >>> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> >>> @@ -45,6 +45,25 @@ properties:
> >>>      description: The number of PWM channels configured for this instance
> >>>      enum: [6, 9]
> >>>
> >>> +  allwinner,pwm-pair-clock-sources:
> >>> +    description: The clock source names for each PWM pair
> >>> +    items:
> >>> +      enum: [hosc, apb]
> >>> +    minItems: 1
> >>> +    maxItems: 8
> >>
> >> Missing type... and add 8 of such items to your example to make it complete.
> >
> > Thank you. I'll fix it.
> >
> >>
> >>> +
> >>> +  allwinner,pwm-pair-clock-prescales:
> >>> +    description: The prescale (DIV_M register) values for each PWM pair
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> >>> +    items:
> >>> +      items:
> >>> +        minimum: 0
> >>> +        maximum: 8
> >>> +      minItems: 1
> >>> +      maxItems: 1
> >>> +    minItems: 1
> >>> +    maxItems: 8
> >>
> >> This does not look like matrix but array.
> >
> > I wanted to specify values like this:
> >
> >     allwinner,pwm-pair-clock-prescales = <0>, <1>, <3>;
> >     allwinner,pwm-pair-clock-sources = "hosc", "apb", "hosc":
> >
> > These should correspond to each PWM pair.
> > This way, I thought we might be able to visually understand the relationship
> > between prescalers and sources, like clock-names and clocks.
> >
> > Is this notation uncommon, perhaps?
>
> It's still an array.

Oh I understood and clear. Thank you.

> >> Why clock DIV cannot be deduced from typical PWM attributes + clock
> >> frequency?
> >
> > This SoC's PWM system has one shared prescaler and clock source for each pair
> > of PWM channels. I should have noted this earlier, sorry.
> >
> > Actually, the original v9 patch automatically deduced the DIV value
> > from the frequency.
> > However, because the two channels share a single prescaler, once one channel is
> > enabled, it affects and restricts the DIV value for the other channel
> > in the pair.
> > This introduces a problem of determining which channel should set the shared DIV
> > value. The original behavior was that the first channel enabled would win.
>
> There's nothing bad in this.
>
> >
> > Instead, this patch try to resolve the issue by specifying these
> > values for each PWM
> > pairs deterministically.
> > That's why it requires the new options.
>
> This does not solve that wrong divider can be programmed for second
> channel in each pair.
>

Let me illustrate the connection of a paired PWM channels to be sure.

.    +------+                   +--------------+  +------+
.    + HOSC +--+             +--+ prescale_k 0 +--+ PWM0 |
.    +------+  |  +-------+  |  +--------------+  +------+
.              +--+ DIV_M +--+
.    +------+  |  +-------+  |  +--------------+  +------+
.    + APBx +--+             +--+ prescale_k 1 +--+ PWM1 |
.    +------+                   +--------------+  +------+
.          CLK_SRC

The PWM0 and PWM1 share DIV_M and CLK_SRC for them, and (not
illustrated) PWM2 and PWM3 share another DIV_M and another CLK_SRC for
them, and so on.
The DIV_M ranges from 0 to 8 and is used as a 1 / 2^DIV_M prescaler,
prescale_k ranges from 0 to 255 and is used as a 1 / (prescale_k + 1)
prescaler.

In the original v9 patch, enabling PWM0 determines CLK_SRC and
calculates DIV_M from the period that is going to be set.
Once the CLK_SRC and DIV_M are fixed, they cannot be changed until
both channels are disabled, unless PWM0 is the only enabled channel.

Looks good so far, but there is a pitfall.

Selecting CLK_SRC and DIV_M means it defines the PWM resolution of the
period and duty cycle for the pair of the PWM channels.
In other words, the resolution is determined by the (most likely the
very first) period, which can be arbitrary.

Consider an application that uses PWM channels to generate a square
wave in stereo.
The very first musical note played defines the entire resolution for
the subsequent notes.
The music quality depends on the first note.

The problem is, there is NO way to fixate the resolution to be used.

The proposed method provides a simple way to deterministically fixate
the resolution.
(ofcourse, prescale_k is still calculated by period to be set)

> Best regards,
> Krzysztof

Best regards,
kikuchan.

