Return-Path: <linux-pwm+bounces-2696-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DB99267BE
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 20:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A69D1C24DB0
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 18:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AA31862A4;
	Wed,  3 Jul 2024 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3bpvJgx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D201CF9D4;
	Wed,  3 Jul 2024 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030064; cv=none; b=i9XdwKQC4XV3xSPFlK/JYqpMJIbcTREXhPXjgN0PglgwgMJJxS/+FIgelBReg3LS8Wzr9omICAep/mLO8s/VRcYZWAgXPeH3ibLmzwNTHG0n6qRVW0wTQiJm72dFqXlMnCR8jdlYTenorftNIGnZvhQN6COL5MjlO98R8wLz1qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030064; c=relaxed/simple;
	bh=7VkdfXXbnQAAagurnl0t1uowHfXXxqv6JWqV5yzvHyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiMPUxASSVAdQ8N1jrJ4jlLETUK7VWDp3bpK1DeOHc+gim4rshy99CIXb9XQjsp7n9GbL6+VnGBgMdVXmLlMVfo34rFFswixa9gasJlyUYqZ0OkyMARPECxh1EncSIm+fCuZJJ8KcUj3zfgBnQWwkNnfSOHqyyF1gRKjH2P3384=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3bpvJgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2346AC2BD10;
	Wed,  3 Jul 2024 18:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720030063;
	bh=7VkdfXXbnQAAagurnl0t1uowHfXXxqv6JWqV5yzvHyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X3bpvJgxZPWMXNOzcyielDafYLsorlGeMfGsYxZsE3DcfgNG38u+IpqkFauqV7JBb
	 5vrbm1WYc3A6PpB/BYRkykAD7OTF0Cj7mNGz1MOi0sa5ZMS/EgfduMIqZfBT2ojOEE
	 bFo2aTY3NN6jY868V+Ef+HPG5nwsrIILcL4gaARoEmQ/3VJxlw8KNvls5K1NJbvrcL
	 liQUqmGsYZrzJg5w0kk4/LvcK6Tdp62Zk7+kzOZ/GnWL+VAWuwzwfMk9DNJ/Cy73bN
	 +KSVQC/fntqBgC8EoMj80EdF4hoVvz6Kgpa3QHWVeUvUPp8LsLtGUtLPC5Ip21htEj
	 aLChwBO4AdEcA==
Date: Wed, 3 Jul 2024 12:07:42 -0600
From: Rob Herring <robh@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Richard Leitner <richard.leitner@linux.dev>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	llvm@lists.linux.dev, linux-clk@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 00/20] Simplify of_property_for_each_u32()
Message-ID: <20240703180742.GB1245093-robh@kernel.org>
References: <20240703-of_property_for_each_u32-v1-0-42c1fc0b82aa@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703-of_property_for_each_u32-v1-0-42c1fc0b82aa@bootlin.com>

On Wed, Jul 03, 2024 at 12:36:44PM +0200, Luca Ceresoli wrote:
> [Note: to reduce the noise I have trimmed the get_maintainers list
> manually. Should you want to be removed, or someone else added, to future
> versions, just tell me. Sorry for the noise.]
> 
> This series aims at simplifying of_property_for_each_u32() as well as
> making it more difficult to misuse it in the future.
> 
> The long-term goal is changing this pattern:
> 
>   struct property *prop;
>   const __be32 *p;
>   u32 val;
>  
>   of_property_for_each_u32(np, "xyz", prop, p, val) { ... }
> 
> to this:
> 
>   u32 val;
> 
>   of_property_for_each_u32(np, "xyz", val) { ... }
> 
> So, removing the 3rd and 4th arguments which are typically meant to be
> internal. Those two parameters used to be unavoidable until the kernel
> moved to building with the C11 standard unconditionally. Since then, it is
> now possible to get rid of them. However a few users of
> of_property_for_each_u32() do actually use those arguments, which
> complicates the transition. For this reason this series does the following:
> 
>  * Add of_property_for_each_u32_new(), which does not have those two
>    arguments (patch 1)
>  * Convert _almost_ every usage to of_property_for_each_u32_new()
>  * Rename of_property_for_each_u32() to of_property_for_each_u32_old() and
>    deprecate it, as a incentive to code not (yet) in mainline to upgrade
>    to the *_new() version (last patch)

I don't really see the point of introducing the _old variant. Let's get 
this done in one step.

> 
> The plan for the next series is to additionally:
> 
>  * Convert the few remaining of_property_for_each_u32_old() instantes to
>    of_property_for_each_u32_new()
>  * Remove of_property_for_each_u32_old()
>  * Rename of_property_for_each_u32_new() to of_property_for_each_u32()

Honestly, I think there's few enough users we could just convert the 
whole thing in one patch. It's all got to go thru 1 tree anyways. If 
there's new cases in -next, then I'd be happy to send it to Linus at the 
end of the merge window.

Rob

