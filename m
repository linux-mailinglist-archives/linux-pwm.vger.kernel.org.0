Return-Path: <linux-pwm+bounces-2699-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5DE927E8E
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jul 2024 23:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E8D284A40
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jul 2024 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE280143872;
	Thu,  4 Jul 2024 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S0JEVBhI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E7D7346E;
	Thu,  4 Jul 2024 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720128735; cv=none; b=DZGw/OcogMQof1U3M+hlIY6X5j6CVY1XLLiEmj75OJ4vNcH67GwiW1Q8fhQ15g8G+XXA0LR330OR5vyKarSVOeeg2a9p7t47Zdes1N8Kw5+CT0kprR4Kqnmi38L02p2yYojUV/pX6wjtUxiYvnbv5yLeeGt0ZrDb0+wz78d0MAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720128735; c=relaxed/simple;
	bh=jEOP4tmTJgNwT4VJJ/H4/e/Pm5Ggkrq6iv0SA5dQ8ws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEdY1vZXnp4q1ZgWKD8Vx0Yl1lmjGa63OpOWxBKnb1JMPmzahNymJaKTYM9dMXW3sfI3/I92OfBmhKNRocf2tGVCwclQLhO8sRY17opnqDGp/7nA+2sF6W46EPjS0rfT1qULVpw7otozRNkiTDVerLmxMvlGOfheEWGOHH9tEiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S0JEVBhI; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD86AFF802;
	Thu,  4 Jul 2024 21:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720128729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rey18xTlnMgOgIPL25ImB7B15sMWYzxAsvnHNthV5S0=;
	b=S0JEVBhI3tfc5ntPMObRrKKeyUXsGRrO+dmrSHHiA/CXiaTrDzUnuWN/8RLan/W8yEPBYy
	WTaC4P67s78ijbrvczP1KnuPtKQbrRcwlYEqUPZPpZW0nhX/siqNP/GhziUB79nYOQPi8r
	PhP0fpq9va52mSjevxSqg9gaf/S2Ukug9XtKh8mzSUYLpNZp80MAwL96mMkrYY7WNzzmay
	5AT/X7DCWHP8tVhsE6o3C1PHb0Q9g3z2DXN4uHMidHU5Rwoaz4Y/LepANuZA6Uuvs21L3L
	95mP/Ounvba0aITTStBPv4Esd+fhuzK/5YdBxhSIiG700JAP0NMtF9NGxcnshQ==
Date: Thu, 4 Jul 2024 23:31:55 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Bjorn Andersson <andersson@kernel.org>, Emilio
 =?UTF-8?Q?L=C3=B3pez?= <emilio@elopez.com.ar>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Krzysztof Kozlowski <krzk@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel
 review list <bcm-kernel-feedback-list@broadcom.com>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan
 Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Uwe
 =?UTF-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Richard
 Leitner <richard.leitner@linux.dev>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, Damien Le Moal <dlemoal@kernel.org>, "Peng
 Fan (OSS)" <peng.fan@oss.nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, llvm@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-samsung-soc@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH 00/20] Simplify of_property_for_each_u32()
Message-ID: <20240704233155.61b5323c@booty>
In-Reply-To: <20240703180742.GB1245093-robh@kernel.org>
References: <20240703-of_property_for_each_u32-v1-0-42c1fc0b82aa@bootlin.com>
	<20240703180742.GB1245093-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Rob,

On Wed, 3 Jul 2024 12:07:42 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Jul 03, 2024 at 12:36:44PM +0200, Luca Ceresoli wrote:
> > [Note: to reduce the noise I have trimmed the get_maintainers list
> > manually. Should you want to be removed, or someone else added, to future
> > versions, just tell me. Sorry for the noise.]
> > 
> > This series aims at simplifying of_property_for_each_u32() as well as
> > making it more difficult to misuse it in the future.
> > 
> > The long-term goal is changing this pattern:
> > 
> >   struct property *prop;
> >   const __be32 *p;
> >   u32 val;
> >  
> >   of_property_for_each_u32(np, "xyz", prop, p, val) { ... }
> > 
> > to this:
> > 
> >   u32 val;
> > 
> >   of_property_for_each_u32(np, "xyz", val) { ... }
> > 
> > So, removing the 3rd and 4th arguments which are typically meant to be
> > internal. Those two parameters used to be unavoidable until the kernel
> > moved to building with the C11 standard unconditionally. Since then, it is
> > now possible to get rid of them. However a few users of
> > of_property_for_each_u32() do actually use those arguments, which
> > complicates the transition. For this reason this series does the following:
> > 
> >  * Add of_property_for_each_u32_new(), which does not have those two
> >    arguments (patch 1)
> >  * Convert _almost_ every usage to of_property_for_each_u32_new()
> >  * Rename of_property_for_each_u32() to of_property_for_each_u32_old() and
> >    deprecate it, as a incentive to code not (yet) in mainline to upgrade
> >    to the *_new() version (last patch)  
> 
> I don't really see the point of introducing the _old variant. Let's get 
> this done in one step.
> 
> > 
> > The plan for the next series is to additionally:
> > 
> >  * Convert the few remaining of_property_for_each_u32_old() instantes to
> >    of_property_for_each_u32_new()
> >  * Remove of_property_for_each_u32_old()
> >  * Rename of_property_for_each_u32_new() to of_property_for_each_u32()  
> 
> Honestly, I think there's few enough users we could just convert the 
> whole thing in one patch. It's all got to go thru 1 tree anyways. If 
> there's new cases in -next, then I'd be happy to send it to Linus at the 
> end of the merge window.

Sure, make sense. I'll need to convert the few remaining users, then
I'm sending a squashed v2.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

