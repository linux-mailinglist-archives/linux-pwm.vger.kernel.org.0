Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8EF1ACC24
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2020 17:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442790AbgDPPzz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Apr 2020 11:55:55 -0400
Received: from foss.arm.com ([217.140.110.172]:36704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442004AbgDPPzu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 16 Apr 2020 11:55:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D78930E;
        Thu, 16 Apr 2020 08:55:48 -0700 (PDT)
Received: from [10.57.59.184] (unknown [10.57.59.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19F1B3F237;
        Thu, 16 Apr 2020 08:55:45 -0700 (PDT)
Subject: Re: [PATCH RFC 0/6] PWM fan support on Clearfog gt8k
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <CACRpkdaL4-Z36aKOVW4o2MtCG9fbqm4gxZN3QjejVRPBZrzxxA@mail.gmail.com>
 <20200416135039.GL657811@lunn.ch>
 <5c7cb0ff-bf49-640a-3c4a-ef71495af7b7@arm.com>
 <20200416145517.GK25745@shell.armlinux.org.uk>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <010ccb32-42f1-cc32-0527-e608fc91a879@arm.com>
Date:   Thu, 16 Apr 2020 16:55:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416145517.GK25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2020-04-16 3:55 pm, Russell King - ARM Linux admin wrote:
> On Thu, Apr 16, 2020 at 03:37:40PM +0100, Robin Murphy wrote:
>> On 2020-04-16 2:50 pm, Andrew Lunn wrote:
>> [...]
>>> Clocking with Marvell devices has always been interesting. Core IP
>>> like this gets reused between different generations of SoCs. The
>>> original Orion5x had no clock control at all. Latter SoCs have had
>>> more and more complex clock trees. So care has to be taken to not
>>> change old behaviour when adding support for new clocks.
>>
>> FWIW, that sounds like a good argument for encoding the clock requirements
>> of each variant in the of_match_data, so the driver doesn't have to simply
>> trust the DT and hope.
> 
> Please read my patches.  This is exactly what I'm doing.  I'm preserving
> as closely as possible the current driver behaviour while adding support
> for the Armada 8040 PWM while keeping compatibility with older DT.
> 
> And I'm doing that by keying off the match data, exactly as you're
> suggesting above.

AFAICS you're encoding the *PWM capability* in the match data and using 
that to extend the existing behaviour, which comprises using soc_variant 
to maybe treat the stashed error code as fatal somewhere else much later 
if CONFIG_PWM happens to be enabled, and is subtle enough that at least 
two reviewers overlooked or failed to make sense of it.

Compare and contrast with how self-contained and obvious this is:

-	mvchip->clk = devm_clk_get(&pdev->dev, NULL);
-	/* Not all SoCs require a clock.*/
-	if (!IS_ERR(mvchip->clk))
-		clk_prepare_enable(mvchip->clk);

+	/* Not all SoCs require a clock.*/
+	if (data->needs_clock)
+		mvchip->clk = devm_clk_get(&pdev->dev, NULL);
+		if (IS_ERR(mvchip->clk))
+			return PTR_ERR(mvchip_clk);
+		clk_prepare_enable(mvchip->clk);
+	}

If achieving the same end result by very different and roundabout means 
constitutes "exactly the same thing", does me having written this email 
mean that my house is exactly the same as the Arm office and someone 
else will be along to clean the kitchen shortly? Here's hoping... :D

Robin.
