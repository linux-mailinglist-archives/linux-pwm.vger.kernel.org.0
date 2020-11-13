Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2120B2B22AF
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Nov 2020 18:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgKMRkx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Nov 2020 12:40:53 -0500
Received: from foss.arm.com ([217.140.110.172]:42758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbgKMRkw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 13 Nov 2020 12:40:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D6711042;
        Fri, 13 Nov 2020 09:40:51 -0800 (PST)
Received: from [10.57.53.43] (unknown [10.57.53.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6B8C3F718;
        Fri, 13 Nov 2020 09:40:42 -0800 (PST)
Subject: Re: About devm_platform_ioremap_resource [Was: Re: [PATCH 01/32] pwm:
 sun4i: convert to devm_platform_ioremap_resource]
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     alexandre.belloni@bootlin.com, heiko@sntech.de,
        Yangtao Li <tiny.windzz@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-riscv@lists.infradead.org, festevam@gmail.com,
        f.fainelli@gmail.com, shc_work@mail.ru,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        khilman@baylibre.com, wens@csie.org, jonathanh@nvidia.com,
        linux-rockchip@lists.infradead.org,
        ludovic.desroches@microchip.com,
        bcm-kernel-feedback-list@broadcom.com, linux-imx@nxp.com,
        slemieux.tyco@gmail.com, linux-pwm@vger.kernel.org,
        rjui@broadcom.com, s.hauer@pengutronix.de, mripard@kernel.org,
        vz@mleia.com, linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, paul.walmsley@sifive.com,
        matthias.bgg@gmail.com, linux-amlogic@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, sbranden@broadcom.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.ferre@microchip.com, palmer@dabbelt.com,
        kernel@pengutronix.de, shawnguo@kernel.org,
        claudiu.beznea@microchip.com, nsaenzjulienne@suse.de
References: <20191229080610.7597-1-tiny.windzz@gmail.com>
 <20201112161346.gp5nenuagx5wmwl2@pengutronix.de>
 <20201112190649.GA908613@ulmo>
 <20201112211429.kfyqzkmmchjo6pll@pengutronix.de>
 <20201113070343.lhcsbyvi5baxn3lq@pengutronix.de>
 <20201113161153.GB1408970@ulmo>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6cddd32c-50eb-4399-02bc-d4377237134c@arm.com>
Date:   Fri, 13 Nov 2020 17:40:41 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201113161153.GB1408970@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2020-11-13 16:11, Thierry Reding wrote:
> On Fri, Nov 13, 2020 at 08:03:43AM +0100, Uwe Kleine-König wrote:
>> Hello,
>>
>> [Added lkml and the people involved in commit 7945f929f1a7
>> ("drivers: provide devm_platform_ioremap_resource()") to Cc:. For the
>> new readers: This is about patches making use of
>> devm_platform_ioremap_resource() instead of open coding it. Full context
>> at https://lore.kernel.org/r/20201112190649.GA908613@ulmo]
>>
>> On Thu, Nov 12, 2020 at 10:14:29PM +0100, Uwe Kleine-König wrote:
>>> On Thu, Nov 12, 2020 at 08:06:49PM +0100, Thierry Reding wrote:
>>>> I also think that it's overly narrow is scope, so you can't actually
>>>> "blindly" use this helper and I've seen quite a few cases where this was
>>>> unknowingly used for cases where it shouldn't have been used and then
>>>> broke things (because some drivers must not do the request_mem_region()
>>>> for example).
>>>
>>> You have a link to such an accident?
>>
>> I got a hint in private here: https://lore.kernel.org/r/1555670144-24220-1-git-send-email-aisheng.dong@nxp.com
>>
>> devm_platform_ioremap_resource() is platform_get_resource() +
>> devm_ioremap_resource() and here it was used to replace
>> platform_get_resource() + devm_ioremap().
>>
>> IMHO the unlucky thing in this situation is that devm_ioremap_resource()
>> and devm_ioremap() are different by more than just how they get the area
>> to remap. (i.e. devm_ioremap_resource() also does
>> devm_request_mem_region().)
>>
>> So the problem is not the added wrapper, but unclear semantics in the
>> functions it uses.
> 
> The semantics aren't unclear. It's just that the symbol name doesn't
> spell out every detail that the function implements, which, frankly, no
> function name ever does, at least not for anything beyond simple
> instructional examples. That's what we have documentation for and why
> people should read the documentation before they use a function and make
> (potentially wrong) assumption about what it does.
> 
>>                     In my eyes devm_ioremap() and
>> devm_platform_ioremap_resource() should better be named
>> devm_request_ioremap() and devm_platform_request_ioremap_resource()
>> respectively. Is it worth to rename these for clearity?
> 
> I think function names are always a compromise between giving you the
> gist of what the implementation does and being short enough so it
> doesn't become difficult to read or use.
> 
> One of the reasons why I dislike the addition of helpers for every
> common special case (like devm_platform_ioremap_resource()) is because
> it doesn't (always) actually make things easier for developers and/or
> maintainers. Replacing three lines of code with one is a minor
> improvement, even though there may be many callsites and therefore in
> the sum this being a fairly sizeable reduction. The flip side is that
> now we've got an extra symbol with an unwieldy name that people need
> to become familiar with, and then, like the link above shows, it doesn't
> work in all cases, so you either need to fall back to the open-coded
> version or you keep adding helpers until you've covered all cases. And
> then we end up with a bunch of helpers that you actually have to go and
> read the documentation for in order to find out which one exactly fits
> your use-case.
> 
> Without the helpers it's pretty simple to write, even if a little
> repetitive:
> 
>    1) get the resource you want to map
>    2) request the resource
>    3) map the resource
> 
> 2) & 3) are very commonly done together, so it makes sense to have a
> generic helper for them. If you look at the implementation, the
> devm_ioremap_request() implementation does quite a bit of things in
> addition to just requesting and remapping, and that's the reason why
> that helper makes sense.
> 
> For me personally, devm_platform_ioremap_resource() is just not adding
> enough value to justify its existence. And then we get all these other
> variants that operate on the resource name (_byname) and those which
> remap write-combined (_wc). But don't we also need a _byname_wc()
> variant for the combination? Where does it stop?

Arguably the worst thing about devm_platform_ioremap_resource() is that 
it was apparently the gateway drug to a belief that 
devm_platform_get_and_ioremap_resource() is anything other than a 
hideous way to obfuscate an assignment...

Robin.
