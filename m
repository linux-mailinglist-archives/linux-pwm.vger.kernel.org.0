Return-Path: <linux-pwm+bounces-2328-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 348138D7D9E
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Jun 2024 10:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE611F235AD
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Jun 2024 08:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096F36EB4A;
	Mon,  3 Jun 2024 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez92Ixgi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAEA22F03;
	Mon,  3 Jun 2024 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717404143; cv=none; b=S0Syq/9GppcaBgqMRq4+bCO5RPiWEB5fUmEOl/vMyC1ngtlpxD77UMYjJsFfkuWs2kOMfwUwNU62HzxlgXB5FGWhfBY6EGM7wa7La0ULA/BF1cLt8Hw/NWCe1j70LlCdr7C9LrLYUN8JW0MDr/zHEfovf6eGxzGM9smauHBlmkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717404143; c=relaxed/simple;
	bh=Ga1qPOK4XK5ED5tC7i/66nQWWWuMj1jMkhyfHaAisiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6wdru/sTfUqtpaoHDLe2j6HAkDxt+EGvoTGjds7n4k7ha+HwklsYSl/ceGDCWcqsWgOFqNkgdOln98DbbV30UM7M/G622gljoRMx/OwQmdDGLd4NALPHcjq//9OhRvmQdfASeDmgnuiKgisAw2F27++oesc1QfUccENuyZeHKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ez92Ixgi; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dfa5b9274feso4441916276.2;
        Mon, 03 Jun 2024 01:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717404141; x=1718008941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7vvsfENyFuJIy30+AvvNrIT8eWRYZztx7JrOWmsBgU=;
        b=ez92Ixgi6EUhwrNwXTMlmxHILSe80PdEMZO/oiTRvLj26X4mSLtEjGpvnHM5T7Bd1F
         wRxaxUvEHChFzq3JhbYyntgRnPyb6EKH6C9lcVOxzR2Gxv/bgl+Wvx8yjz61h/WzZqtN
         IgP4QilsvDVysJM45nUfHzA44l/OMxP6R9XQptOSK7fkIhwYdlhPufnadQZwKmjz3NSX
         uAN4gZ3HU0+sksZ+3EjlkNUVjXivaTKZEZaaafryRyR7IEP5wNErbMh6Mu9YRzFcLJ3I
         kpyO9aF6rRijcoaxTQxt42aHyCWd70IJdn+Ov7EtLfzX/L1c8S76Qv54/FZWDeXXLm+/
         uQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717404141; x=1718008941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7vvsfENyFuJIy30+AvvNrIT8eWRYZztx7JrOWmsBgU=;
        b=ULjsaGN+tqQwtHeUU4Gnr+nGnh7k3vSujifwcPEppxubxGZEP7yKBIR0xV6Dm4BfXT
         D0LH8O+Yo2LurOqb9bLBVdtMaS34zEwBGL08g5AvRCbep5VaJ+h9SOEpjtO8Vm1LHqlF
         hmF1SVMYuNrfbbwigxuih4WvsY0LeDxuxv0rfSEOGtU3c8WCrAfy9llUHkTA1KEB6Cjd
         djRn4CYm3zq9MspRmBDxCyo8NyEsxdnTI0SXp0Wjm0Sl+qmYn6Vn1zkreFYfu98PeIYO
         PHAOfq10VLtrnOxuixmcD48elO16IsM40hqy3neI7DWifnUQsl0BYymYYJ4RG/3Ogh0Z
         jeZw==
X-Forwarded-Encrypted: i=1; AJvYcCUuIBA94ptekalYsEFmQOPwdkbmhdryQ7bPnA/LLLjchpya00ecFZ7MyWiyh/GoUOuMhiXiaX4FI7LghD/Twm37vSlWdPCUR6dByT5CDjms1SLkdksQzA5yrqLLlMTnvaGGu/7cLvsQRSonZtAm8vGKqiGujXyNlCBJJc14b+7UXQ0Tew==
X-Gm-Message-State: AOJu0YySZGQL7hCslHuJJi3L3jzrM/XHb+3rLdmXFJzTZmb2ja30J/aB
	KvZ/QpyCPNik5Q9TRyKE0lJcknMf56CoeeZi2U8Snk5sdLxCvOcswtUBt9gziPBg6A/uVEVTcrc
	qgb6I5u5hR9nJtgHCK5i3CuRO7UE=
X-Google-Smtp-Source: AGHT+IE2NE00DLfbf9E7tMUKMhhqox6KKStGzL+ciKOii1Jqjmh/2PBCTsNr5nPdj5rNbNmoKJUzXe0RJ7IwC0BitgM=
X-Received: by 2002:a25:ad26:0:b0:dfa:52bc:4981 with SMTP id
 3f1490d57ef6-dfa73bf16cdmr8843125276.8.1717404141051; Mon, 03 Jun 2024
 01:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531141152.327592-1-kikuchan98@gmail.com> <20240531141152.327592-6-kikuchan98@gmail.com>
 <851280ad-ac0e-47d1-99e2-4f3b5ea29f2f@kernel.org> <CAG40kxEbMQc-ni0HDVR7rtj48aFu-jz8sYUAO+fdmZSmXWrizw@mail.gmail.com>
 <da382d43-fa82-44c0-9630-086f59e6efa2@kernel.org> <CAG40kxHKdC=uwyWzsBo1LTAXARDQGs0N4TBdD5nE1zhos48cbg@mail.gmail.com>
 <20240603010912.44b99988@minigeek.lan>
In-Reply-To: <20240603010912.44b99988@minigeek.lan>
From: Hironori KIKUCHI <kikuchan98@gmail.com>
Date: Mon, 3 Jun 2024 17:42:08 +0900
Message-ID: <CAG40kxETZBO1-UBr=rqEu0uWrfOe74k-M12qW7Rg_kX8U32UPg@mail.gmail.com>
Subject: Re: [PATCH 5/5] dt-bindings: pwm: sun20i: Add options to select a
 clock source and DIV_M
To: Andre Przywara <andre.przywara@arm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Aleksandr Shubin <privatesub2@gmail.com>, 
	Cheo Fusi <fusibrandon13@gmail.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andre,

Thank you for your reply.

2024=E5=B9=B46=E6=9C=883=E6=97=A5(=E6=9C=88) 9:10 Andre Przywara <andre.prz=
ywara@arm.com>:
>
> On Sun, 2 Jun 2024 15:15:13 +0900
> Hironori KIKUCHI <kikuchan98@gmail.com> wrote:
>
> Hi Kikuchan,
>
> > Hi Krzysztof,
> >
> > > On 31/05/2024 19:57, Hironori KIKUCHI wrote:
> > > > Hello,
> > > >
> > > >>> This patch adds new options to select a clock source and DIV_M re=
gister
> > > >>> value for each coupled PWM channels.
> > > >>
> > > >> Please do not use "This commit/patch/change", but imperative mood.=
 See
> > > >> longer explanation here:
> > > >> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/proc=
ess/submitting-patches.rst#L95
> > > >>
> > > >> Bindings are before their users. This should not be last patch, be=
cause
> > > >> this implies there is no user.
> > > >
> > > > I'm sorry, I'll fix them.
> > > >
> > > >> This applies to all variants? Or the one you add? Confused...
> > > >
> > > > Apologies for confusing you. This applies to all variants.
> > > >
> > > >>
> > > >>>
> > > >>> Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
> > > >>> ---
> > > >>>  .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 19 +++++++++++++=
++++++
> > > >>>  1 file changed, 19 insertions(+)
> > > >>>
> > > >>> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun2=
0i-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.ya=
ml
> > > >>> index b9b6d7e7c87..436a1d344ab 100644
> > > >>> --- a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.=
yaml
> > > >>> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.=
yaml
> > > >>> @@ -45,6 +45,25 @@ properties:
> > > >>>      description: The number of PWM channels configured for this =
instance
> > > >>>      enum: [6, 9]
> > > >>>
> > > >>> +  allwinner,pwm-pair-clock-sources:
> > > >>> +    description: The clock source names for each PWM pair
> > > >>> +    items:
> > > >>> +      enum: [hosc, apb]
> > > >>> +    minItems: 1
> > > >>> +    maxItems: 8
> > > >>
> > > >> Missing type... and add 8 of such items to your example to make it=
 complete.
> > > >
> > > > Thank you. I'll fix it.
> > > >
> > > >>
> > > >>> +
> > > >>> +  allwinner,pwm-pair-clock-prescales:
> > > >>> +    description: The prescale (DIV_M register) values for each P=
WM pair
> > > >>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > >>> +    items:
> > > >>> +      items:
> > > >>> +        minimum: 0
> > > >>> +        maximum: 8
> > > >>> +      minItems: 1
> > > >>> +      maxItems: 1
> > > >>> +    minItems: 1
> > > >>> +    maxItems: 8
> > > >>
> > > >> This does not look like matrix but array.
> > > >
> > > > I wanted to specify values like this:
> > > >
> > > >     allwinner,pwm-pair-clock-prescales =3D <0>, <1>, <3>;
> > > >     allwinner,pwm-pair-clock-sources =3D "hosc", "apb", "hosc":
> > > >
> > > > These should correspond to each PWM pair.
> > > > This way, I thought we might be able to visually understand the rel=
ationship
> > > > between prescalers and sources, like clock-names and clocks.
> > > >
> > > > Is this notation uncommon, perhaps?
> > >
> > > It's still an array.
> >
> > Oh I understood and clear. Thank you.
> >
> > > >> Why clock DIV cannot be deduced from typical PWM attributes + cloc=
k
> > > >> frequency?
> > > >
> > > > This SoC's PWM system has one shared prescaler and clock source for=
 each pair
> > > > of PWM channels. I should have noted this earlier, sorry.
> > > >
> > > > Actually, the original v9 patch automatically deduced the DIV value
> > > > from the frequency.
> > > > However, because the two channels share a single prescaler, once on=
e channel is
> > > > enabled, it affects and restricts the DIV value for the other chann=
el
> > > > in the pair.
> > > > This introduces a problem of determining which channel should set t=
he shared DIV
> > > > value. The original behavior was that the first channel enabled wou=
ld win.
> > >
> > > There's nothing bad in this.
> > >
> > > >
> > > > Instead, this patch try to resolve the issue by specifying these
> > > > values for each PWM
> > > > pairs deterministically.
> > > > That's why it requires the new options.
> > >
> > > This does not solve that wrong divider can be programmed for second
> > > channel in each pair.
> > >
> >
> > Let me illustrate the connection of a paired PWM channels to be sure.
> >
> > .    +------+                   +--------------+  +------+
> > .    + HOSC +--+             +--+ prescale_k 0 +--+ PWM0 |
> > .    +------+  |  +-------+  |  +--------------+  +------+
> > .              +--+ DIV_M +--+
> > .    +------+  |  +-------+  |  +--------------+  +------+
> > .    + APBx +--+             +--+ prescale_k 1 +--+ PWM1 |
> > .    +------+                   +--------------+  +------+
> > .          CLK_SRC
> >
> > The PWM0 and PWM1 share DIV_M and CLK_SRC for them, and (not
> > illustrated) PWM2 and PWM3 share another DIV_M and another CLK_SRC for
> > them, and so on.
> > The DIV_M ranges from 0 to 8 and is used as a 1 / 2^DIV_M prescaler,
> > prescale_k ranges from 0 to 255 and is used as a 1 / (prescale_k + 1)
> > prescaler.
> >
> > In the original v9 patch, enabling PWM0 determines CLK_SRC and
> > calculates DIV_M from the period that is going to be set.
> > Once the CLK_SRC and DIV_M are fixed, they cannot be changed until
> > both channels are disabled, unless PWM0 is the only enabled channel.
> >
> > Looks good so far, but there is a pitfall.
> >
> > Selecting CLK_SRC and DIV_M means it defines the PWM resolution of the
> > period and duty cycle for the pair of the PWM channels.
> > In other words, the resolution is determined by the (most likely the
> > very first) period, which can be arbitrary.
>
> So I understand the problem, but I don't think expressing this in the
> devicetree is the right solution. It seems like a tempting pragmatical
> approach, but it sounds like the wrong way: this is not a hardware
> *description* of any kind, but rather a way to describe a certain user
> intention or a configuration. So this looks like a rather embedded
> approach to me, where you have a certain fixed register setup in mind,
> and want to somehow force this to the hardware.
> Another problem with this approach is that it doesn't really cover the
> sysfs interface, which is very dynamic by nature.

... Indeed. You're right.
Now I've realized it was a bad idea.
It should be done in sysfs or sysctl perhaps.

>
> I have some questions / ideas, and would love to hear some feedback on
> them:
> - If some PWM channels are "linked", I don't think there is much we can
>   do about it: it's a hardware limitation. The details of that is
>   already "encoded" in the compatible string, I'd say, so there is no
>   need for further description in the devicetree. Any PWM user on those
>   boards would probably need to know about the shortcomings, and either
>   use different channels for wildly different PWM setups, or accept
>   that there are actually only three freely programmable PWM channels.
> - Does the PWM subsystem already have a way to model linked channels?
>   Maybe that problem is solved already elsewhere?
> - Previous Allwinner PWM IP was restricted to use the 24 MHz
>   oscillator only, and people seem to have survived with that. Can we
>   not just restrict ourselves to one clock source for those linked
>   channels? I would assume that the PWM frequency is less important
>   than the duty cycle?
> - Can't we just return an error if some conflicting setup requests are
>   made? At the expense of this seeming somewhat random to the user,
>   because it depends on the order of requests? But people could then
>   react on the returned error value?
>
> In general, I wonder what the real use cases are, maybe it's not a
> problem in real life? Do you have a concrete issue at hand, or is this
> just thinking about all potential use cases - which is honourable, but
> maybe a bit over the top here?

IMHO, it is sufficient to use fixed CLK_SRC and DIV_M values for this
driver, since the default values (CLK_SRC =3D=3D hosc and DIV_M =3D=3D 0)
already provide enough range in real life.

What I really care about is minimizing complexity and avoiding surprises.
Although the original method enables an incredibly wide range of the
period, it introduces unpredictability in resolution and inequity in a
pair due to a race in the order of enabling, as a drawback.

If the primary concern is achieving such a wide range, then I think
the original method is the most suitable option.

>
> Cheers,
> Andre
>

Best regards,
kikuchan.

