Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAEC2E928F
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Jan 2021 10:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbhADJ0I (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 Jan 2021 04:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbhADJ0I (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Jan 2021 04:26:08 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB38C061574;
        Mon,  4 Jan 2021 01:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V04ZqaHHc3N4cGcE8hdnQA0zTH4Xzj0ZsOCp5n+7/bE=; b=WPUr6ii1e/ernb82oDx5L0zAD
        yg7yzcfZRLWBwTRKvDmVRo1sBWDVU8gskRpadsZS4awAkUFdz2sIxnpcvfAbWOZ9FsPIBRPPUYkHI
        Imc5jjQDXzJggRFdhCpFwKG/dpC0tbKD/GKXGJfeVOC44p9MLqnJg+GYmiFiAqrA55kK1560yV0U0
        JCI6F+cXJ6mqaJyG/9ndoABkN+edgb4iwHAQ4B0Nk0QTFfjoCw5XK405N31lM35+EPaFAk1JstTI5
        iDjJg9bJ9Arb/LIXvSxKKrkwv2St/8fl8U67SoCJBKOfkIWTWyu7qBuIZZlWnkSG7/3+rNuCgeD1Q
        jDFvoGLYg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45050)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kwM6j-0008AS-G7; Mon, 04 Jan 2021 09:24:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kwM6c-0006fN-5A; Mon, 04 Jan 2021 09:24:50 +0000
Date:   Mon, 4 Jan 2021 09:24:50 +0000
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
Subject: Re: [PATCH v4 0/3] gpio: mvebu: Armada 8K/7K PWM support
Message-ID: <20210104092449.GA1551@shell.armlinux.org.uk>
References: <cover.1607601615.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1607601615.git.baruch@tkos.co.il>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Dec 10, 2020 at 02:15:57PM +0200, Baruch Siach wrote:
> This series makes two changes to v3:
> 
>   * Remove patches that are in LinusW linux-gpio for-next and fixes
> 
>   * Rename the 'pwm-offset' property to 'marvell,pwm-offset' as suggested by 
>     Rob Herring
> 
> The original cover letter follows (with DT property name updated).
> 
> The gpio-mvebu driver supports the PWM functionality of the GPIO block for
> earlier Armada variants like XP, 370 and 38x. This series extends support to
> newer Armada variants that use CP11x and AP80x, like Armada 8K and 7K.
> 
> This series adds adds the 'marvell,pwm-offset' property to DT binding. 
> 'marvell,pwm-offset' points to the base of A/B counter registers that 
> determine the PWM period and duty cycle.
> 
> The existing PWM DT binding reflects an arbitrary decision to allocate the A
> counter to the first GPIO block, and B counter to the other one. In attempt to
> provide better future flexibility, the new 'marvell,pwm-offset' property 
> always points to the base address of both A/B counters. The driver code still 
> allocates the counters in the same way, but this might change in the future 
> with no change to the DT.
> 
> Tested AP806 and CP110 (both) on Armada 8040 based system.

Did you see the patches I sent during the last year doing this and
adding support for the fan on the GT-8k?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
