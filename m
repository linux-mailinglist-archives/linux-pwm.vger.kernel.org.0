Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0D477851
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jul 2019 12:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfG0KvV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 27 Jul 2019 06:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfG0KvV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 27 Jul 2019 06:51:21 -0400
Received: from localhost (lfbn-1-17239-195.w86-248.abo.wanadoo.fr [86.248.61.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B0942081B;
        Sat, 27 Jul 2019 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564224680;
        bh=aC5qgfw92/SyHhkS/dx9G3VFGN8AyvxWdxsBO5J3CLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FUBL8iC2OQ/Iglwg6Jc5NYtBB7Vm/CzzU+JLG84hfHyy/3KjvuaCTfk8gZVZGe3l+
         jvgXa+7knlA8dhUsXjOeLPFXrGCCNQp/2TqEAFyu7IUg8ly7JlQ8FqK2rsd+PQ+Kx/
         RQsTfj02ruUkvhUxBwbOj2wEAIyzfioxipvV9NvA=
Date:   Sat, 27 Jul 2019 12:51:17 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     thierry.reding@gmail.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 6/6] arm64: dts: allwinner: h6: Add PWM node
Message-ID: <20190727105117.rcud3x6oskc43zso@flea.home>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-7-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726184045.14669-7-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jul 26, 2019 at 08:40:45PM +0200, Jernej Skrabec wrote:
> Allwinner H6 PWM is similar to that in A20 except that it has additional
> bus clock and reset line.
>
> Note that first PWM channel is connected to output pin and second
> channel is used internally, as a clock source to AC200 co-packaged chip.
> This means that any combination of these two channels can be used and
> thus it doesn't make sense to add pinctrl nodes at this point.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index e8bed58e7246..c1abd805cfdc 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -229,6 +229,16 @@
>  			status = "disabled";
>  		};
>
> +		pwm: pwm@300a000 {
> +			compatible = "allwinner,sun50i-h6-pwm";
> +			reg = <0x0300a000 0x400>;
> +			clocks = <&osc24M>, <&ccu CLK_BUS_PWM>;
> +			clock-names = "pwm", "bus";

We always have the bus clock first, so I'd really like to keep
that. We also usually use mod for the second clock, and not the name
of the device itself.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
