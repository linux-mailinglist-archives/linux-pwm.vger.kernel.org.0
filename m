Return-Path: <linux-pwm+bounces-2326-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FC88D7947
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Jun 2024 02:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA511C21435
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Jun 2024 00:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC3519F;
	Mon,  3 Jun 2024 00:10:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC84391;
	Mon,  3 Jun 2024 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717373431; cv=none; b=rQcozB6oZroznXQZIsOnIAVv0orZNvbeNFFkm5fthfsUMJXwQoQkOw9wBEZlNtUp5fP5NvVZkf7QhkYl4deIhD2yFzmxUCx0zdr+jA5nS6AogdWuYlCAblosgoEuqTpAkq7zp7RAOvayM/rZEK7FssXtEzSXQz901/oH4r59zA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717373431; c=relaxed/simple;
	bh=07ynrVUW3Z/uc5Y7/yQ+UyVpLSvpRWi/UkrMoSVmo70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epet9HTnMaBsc6gG6h4C7llsx8nmwImhSyjXqIW4b1xfdfNu5NHUu8EiK19R3B7L9mLZVFy/JvzueULAlc7vF4gBwQWymNx0KD062XBz/b6LJgEss3BBGQChQ4YvUbxg+daESd8rfuTuKDR5mV9HVa6TRLEEJHaFzNHyUQdzNZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5284A113E;
	Sun,  2 Jun 2024 17:10:52 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E10BA3F792;
	Sun,  2 Jun 2024 17:10:25 -0700 (PDT)
Date: Mon, 3 Jun 2024 01:09:12 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Hironori KIKUCHI <kikuchan98@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Aleksandr
 Shubin <privatesub2@gmail.com>, Cheo Fusi <fusibrandon13@gmail.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 5/5] dt-bindings: pwm: sun20i: Add options to select a
 clock source and DIV_M
Message-ID: <20240603010912.44b99988@minigeek.lan>
In-Reply-To: <CAG40kxHKdC=uwyWzsBo1LTAXARDQGs0N4TBdD5nE1zhos48cbg@mail.gmail.com>
References: <20240531141152.327592-1-kikuchan98@gmail.com>
	<20240531141152.327592-6-kikuchan98@gmail.com>
	<851280ad-ac0e-47d1-99e2-4f3b5ea29f2f@kernel.org>
	<CAG40kxEbMQc-ni0HDVR7rtj48aFu-jz8sYUAO+fdmZSmXWrizw@mail.gmail.com>
	<da382d43-fa82-44c0-9630-086f59e6efa2@kernel.org>
	<CAG40kxHKdC=uwyWzsBo1LTAXARDQGs0N4TBdD5nE1zhos48cbg@mail.gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Jun 2024 15:15:13 +0900
Hironori KIKUCHI <kikuchan98@gmail.com> wrote:

Hi Kikuchan,

> Hi Krzysztof,
> 
> > On 31/05/2024 19:57, Hironori KIKUCHI wrote:  
> > > Hello,
> > >  
> > >>> This patch adds new options to select a clock source and DIV_M register
> > >>> value for each coupled PWM channels.  
> > >>
> > >> Please do not use "This commit/patch/change", but imperative mood. See
> > >> longer explanation here:
> > >> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> > >>
> > >> Bindings are before their users. This should not be last patch, because
> > >> this implies there is no user.  
> > >
> > > I'm sorry, I'll fix them.
> > >  
> > >> This applies to all variants? Or the one you add? Confused...  
> > >
> > > Apologies for confusing you. This applies to all variants.
> > >  
> > >>  
> > >>>
> > >>> Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
> > >>> ---
> > >>>  .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 19 +++++++++++++++++++
> > >>>  1 file changed, 19 insertions(+)
> > >>>
> > >>> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > >>> index b9b6d7e7c87..436a1d344ab 100644
> > >>> --- a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > >>> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > >>> @@ -45,6 +45,25 @@ properties:
> > >>>      description: The number of PWM channels configured for this instance
> > >>>      enum: [6, 9]
> > >>>
> > >>> +  allwinner,pwm-pair-clock-sources:
> > >>> +    description: The clock source names for each PWM pair
> > >>> +    items:
> > >>> +      enum: [hosc, apb]
> > >>> +    minItems: 1
> > >>> +    maxItems: 8  
> > >>
> > >> Missing type... and add 8 of such items to your example to make it complete.  
> > >
> > > Thank you. I'll fix it.
> > >  
> > >>  
> > >>> +
> > >>> +  allwinner,pwm-pair-clock-prescales:
> > >>> +    description: The prescale (DIV_M register) values for each PWM pair
> > >>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > >>> +    items:
> > >>> +      items:
> > >>> +        minimum: 0
> > >>> +        maximum: 8
> > >>> +      minItems: 1
> > >>> +      maxItems: 1
> > >>> +    minItems: 1
> > >>> +    maxItems: 8  
> > >>
> > >> This does not look like matrix but array.  
> > >
> > > I wanted to specify values like this:
> > >
> > >     allwinner,pwm-pair-clock-prescales = <0>, <1>, <3>;
> > >     allwinner,pwm-pair-clock-sources = "hosc", "apb", "hosc":
> > >
> > > These should correspond to each PWM pair.
> > > This way, I thought we might be able to visually understand the relationship
> > > between prescalers and sources, like clock-names and clocks.
> > >
> > > Is this notation uncommon, perhaps?  
> >
> > It's still an array.  
> 
> Oh I understood and clear. Thank you.
> 
> > >> Why clock DIV cannot be deduced from typical PWM attributes + clock
> > >> frequency?  
> > >
> > > This SoC's PWM system has one shared prescaler and clock source for each pair
> > > of PWM channels. I should have noted this earlier, sorry.
> > >
> > > Actually, the original v9 patch automatically deduced the DIV value
> > > from the frequency.
> > > However, because the two channels share a single prescaler, once one channel is
> > > enabled, it affects and restricts the DIV value for the other channel
> > > in the pair.
> > > This introduces a problem of determining which channel should set the shared DIV
> > > value. The original behavior was that the first channel enabled would win.  
> >
> > There's nothing bad in this.
> >  
> > >
> > > Instead, this patch try to resolve the issue by specifying these
> > > values for each PWM
> > > pairs deterministically.
> > > That's why it requires the new options.  
> >
> > This does not solve that wrong divider can be programmed for second
> > channel in each pair.
> >  
> 
> Let me illustrate the connection of a paired PWM channels to be sure.
> 
> .    +------+                   +--------------+  +------+
> .    + HOSC +--+             +--+ prescale_k 0 +--+ PWM0 |
> .    +------+  |  +-------+  |  +--------------+  +------+
> .              +--+ DIV_M +--+
> .    +------+  |  +-------+  |  +--------------+  +------+
> .    + APBx +--+             +--+ prescale_k 1 +--+ PWM1 |
> .    +------+                   +--------------+  +------+
> .          CLK_SRC
> 
> The PWM0 and PWM1 share DIV_M and CLK_SRC for them, and (not
> illustrated) PWM2 and PWM3 share another DIV_M and another CLK_SRC for
> them, and so on.
> The DIV_M ranges from 0 to 8 and is used as a 1 / 2^DIV_M prescaler,
> prescale_k ranges from 0 to 255 and is used as a 1 / (prescale_k + 1)
> prescaler.
> 
> In the original v9 patch, enabling PWM0 determines CLK_SRC and
> calculates DIV_M from the period that is going to be set.
> Once the CLK_SRC and DIV_M are fixed, they cannot be changed until
> both channels are disabled, unless PWM0 is the only enabled channel.
> 
> Looks good so far, but there is a pitfall.
> 
> Selecting CLK_SRC and DIV_M means it defines the PWM resolution of the
> period and duty cycle for the pair of the PWM channels.
> In other words, the resolution is determined by the (most likely the
> very first) period, which can be arbitrary.

So I understand the problem, but I don't think expressing this in the
devicetree is the right solution. It seems like a tempting pragmatical
approach, but it sounds like the wrong way: this is not a hardware
*description* of any kind, but rather a way to describe a certain user
intention or a configuration. So this looks like a rather embedded
approach to me, where you have a certain fixed register setup in mind,
and want to somehow force this to the hardware.
Another problem with this approach is that it doesn't really cover the
sysfs interface, which is very dynamic by nature.

I have some questions / ideas, and would love to hear some feedback on
them:
- If some PWM channels are "linked", I don't think there is much we can
  do about it: it's a hardware limitation. The details of that is
  already "encoded" in the compatible string, I'd say, so there is no
  need for further description in the devicetree. Any PWM user on those
  boards would probably need to know about the shortcomings, and either
  use different channels for wildly different PWM setups, or accept
  that there are actually only three freely programmable PWM channels.
- Does the PWM subsystem already have a way to model linked channels?
  Maybe that problem is solved already elsewhere?
- Previous Allwinner PWM IP was restricted to use the 24 MHz
  oscillator only, and people seem to have survived with that. Can we
  not just restrict ourselves to one clock source for those linked
  channels? I would assume that the PWM frequency is less important
  than the duty cycle? 
- Can't we just return an error if some conflicting setup requests are
  made? At the expense of this seeming somewhat random to the user,
  because it depends on the order of requests? But people could then
  react on the returned error value?

In general, I wonder what the real use cases are, maybe it's not a
problem in real life? Do you have a concrete issue at hand, or is this
just thinking about all potential use cases - which is honourable, but
maybe a bit over the top here?

Cheers,
Andre

> Consider an application that uses PWM channels to generate a square
> wave in stereo.
> The very first musical note played defines the entire resolution for
> the subsequent notes.
> The music quality depends on the first note.
> 
> The problem is, there is NO way to fixate the resolution to be used.
> 
> The proposed method provides a simple way to deterministically fixate
> the resolution.
> (ofcourse, prescale_k is still calculated by period to be set)
> 
> > Best regards,
> > Krzysztof  
> 
> Best regards,
> kikuchan.
> 


