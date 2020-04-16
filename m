Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C501ACD78
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2020 18:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgDPQUM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Apr 2020 12:20:12 -0400
Received: from foss.arm.com ([217.140.110.172]:37482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgDPQUK (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 16 Apr 2020 12:20:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C47F530E;
        Thu, 16 Apr 2020 09:20:09 -0700 (PDT)
Received: from [10.57.59.184] (unknown [10.57.59.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 508263F237;
        Thu, 16 Apr 2020 09:20:07 -0700 (PDT)
Subject: Re: [PATCH RFC 0/6] PWM fan support on Clearfog gt8k
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
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
 <20200416144231.GP657811@lunn.ch>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <628cde2b-0e1b-4c07-4321-8b23d0b34384@arm.com>
Date:   Thu, 16 Apr 2020 17:20:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416144231.GP657811@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2020-04-16 3:42 pm, Andrew Lunn wrote:
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
> Hi Robin
> 
> It is not really hope. It is very obvious when it is wrong, the whole
> machine stops dead when you are missing a clock. Very simple to test.

Heh, that's still what I meant - the driver hopes that carrying on will 
be OK, and the end user is left to pick up the pieces when it isn't ;)

Obviously that's less of an issue when said end-user is a kernel 
developer making a controlled change during SoC bringup, but perhaps 
more so for an eager inexperienced hacker cobbling together DTS 
fragments to convince a distro kernel to boot on some embedded device 
(even as the former I know I've had enough frustration from unclocked 
registers showing up in unexpected places - the best is when connecting 
an external debugger to see where it's stuck happens to enable the 
offending clock and let the CPU progress to somewhere else by the time 
it actually halts...). If it's possible to make a driver robust enough 
to fail cleanly, isn't that always nicer to debug?

Robin.
