Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCE62E931B
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Jan 2021 11:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbhADKHs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 Jan 2021 05:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbhADKHs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Jan 2021 05:07:48 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2B6C061574;
        Mon,  4 Jan 2021 02:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iB8VDERroWSABUgrwCWnEDI6F4BOeb/hqsj74gIV3e0=; b=LH4HYLWkGGII5XUQ2r73l9+OB
        v+uGv8xtz0PQ2Xo3txuxTvVg1aF30JDIkUnuH7qYSCfIuJ6S7Mxnx8iUWsnGqpXx92hfgWUS741pi
        bCt157/gu31tIf2/QdDIw8KgztgV1QjbDl4o5bmSBR2kfNVrzQcnXgpF3vnCGrGTXwlC2HteSYfe2
        eAW/zC1Q+yjDqBkrysGm0dD8Aov6/GL31c2PgrUCxX/R5+vUSxjHZUFibeSjy6XFyPYnefIyHDOBG
        DDpL7iZ0RWBydZegbjrVeZ4VnonuaGGeWwZKOyGOJfxbUO+xlsyw96VsFGmWzmpcfvY4aVLpyen7v
        3QnO10/EA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45052)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kwMlO-0008CR-Qk; Mon, 04 Jan 2021 10:06:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kwMlJ-0006gY-Fm; Mon, 04 Jan 2021 10:06:53 +0000
Date:   Mon, 4 Jan 2021 10:06:53 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        linux-pwm@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v4 1/3] gpio: mvebu: add pwm support for Armada 8K/7K
Message-ID: <20210104100653.GB1551@shell.armlinux.org.uk>
References: <cover.1607601615.git.baruch@tkos.co.il>
 <61a022834dce86eefa3144e696078946f332bdfe.1607601615.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61a022834dce86eefa3144e696078946f332bdfe.1607601615.git.baruch@tkos.co.il>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Dec 10, 2020 at 02:15:58PM +0200, Baruch Siach wrote:
> @@ -781,51 +787,80 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
>  	struct device *dev = &pdev->dev;
>  	struct mvebu_pwm *mvpwm;
>  	void __iomem *base;
> +	u32 offset;
>  	u32 set;
>  
> -	if (!of_device_is_compatible(mvchip->chip.of_node,
> -				     "marvell,armada-370-gpio"))
> -		return 0;
> -
> -	/*
> -	 * There are only two sets of PWM configuration registers for
> -	 * all the GPIO lines on those SoCs which this driver reserves
> -	 * for the first two GPIO chips. So if the resource is missing
> -	 * we can't treat it as an error.
> -	 */
> -	if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm"))
> +	if (of_device_is_compatible(mvchip->chip.of_node,
> +				    "marvell,armada-370-gpio")) {
> +		/*
> +		 * There are only two sets of PWM configuration registers for
> +		 * all the GPIO lines on those SoCs which this driver reserves
> +		 * for the first two GPIO chips. So if the resource is missing
> +		 * we can't treat it as an error.
> +		 */
> +		if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm"))
> +			return 0;
> +		offset = 0;
> +	} else if (mvchip->soc_variant == MVEBU_GPIO_SOC_VARIANT_A8K) {
> +		int ret = of_property_read_u32(dev->of_node,
> +					       "marvell,pwm-offset", &offset);
> +		if (ret < 0)
> +			return 0;

The reason my patches were rejected was because I was trying to keep
compatibility with the existing DTs w.r.t the clock - and Uwe didn't
like that.

I notice that you keep compatibility by detecting the presence or
absence of the marvell,pwm-offset property which achieves the same
goal.

Also, you are missing fixing a bug in the PWM register calculations
for get_state().

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
