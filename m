Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3A81DE6E1
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2020 14:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgEVM2R (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 May 2020 08:28:17 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17473 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgEVM2R (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 08:28:17 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec7c5530001>; Fri, 22 May 2020 05:28:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 22 May 2020 05:28:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 22 May 2020 05:28:15 -0700
Received: from [10.26.74.233] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 May
 2020 12:28:12 +0000
Subject: Re: [PATCH V2] pwm: tegra: dynamic clk freq configuration by PWM
 driver
To:     Sandipan Patra <spatra@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     Bibek Basu <bbasu@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1587398043-18767-1-git-send-email-spatra@nvidia.com>
 <34ae18f5-494c-7bc7-0f30-2d1455bbcb55@nvidia.com>
 <BYAPR12MB3014B051AD088B42001A8132ADB40@BYAPR12MB3014.namprd12.prod.outlook.com>
 <21428954-41cc-c01a-bca2-7eb19f444272@nvidia.com>
 <BYAPR12MB30149CEB64B1BC3F9727AA68ADB40@BYAPR12MB3014.namprd12.prod.outlook.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ed46ffb7-87ef-8bfb-46f0-005042041658@nvidia.com>
Date:   Fri, 22 May 2020 13:28:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB30149CEB64B1BC3F9727AA68ADB40@BYAPR12MB3014.namprd12.prod.outlook.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590150483; bh=CgXFXHPH5kgfQyubxW7dV8GHkKx0zBOWtAsR0yOSWuI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=V2uiblw2yPFXm92/pXH60MbO6zNffGXJ6PyNWxUMyTPuQbLt4zobqbjbFe/u4Lwc8
         8f5JZItaBq9KainsZ/j5R9PbvwKJMbE1snS4AJEJqB2r9vIsZFaD/KAOLz5xWcJc4U
         E83DayLRfmei32RmAozkQZ2J7EVc7i9VXy16BRMOhCKY9RHWwHRp/0gn9jTOo3G2hg
         sT/JLHRS6woOQK3lVQzikLOGOK0Pq5yt9VxERecMJpFSTr3eRUULoUuxkhw9C8Q8fR
         dKhchx21h3IhHugF1m94BIlfEXY+mZZkhAriX3414O3eBkH0rBr7oO/pSubhvlVFq9
         EJb9ORsScZB/Q==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On 22/05/2020 13:12, Sandipan Patra wrote:

...

>>>>>  	/*
>>>>>  	 * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
>>>>>  	 * cycles at the PWM clock rate will take period_ns nanoseconds.
>>>>>  	 */
>>>>> -	rate = pc->clk_rate >> PWM_DUTY_WIDTH;
>>>>> +	if (pc->soc->num_channels == 1) {
>>>>
>>>> Are you using num_channels to determine if Tegra uses the BPMP? If so
>>>> then the above is not really correct, because num_channels is not
>>>> really related to what is being done here. So maybe you need a new SoC
>> attribute in the soc data.
>>>
>>> Here, it tries to find if pwm controller uses multiple channels (like
>>> in Tegra210 or older) or single channel for every pwm instance (i.e.
>>> T186, T194). If found multiple channels on a single controller then it
>>> is not correct to configure separate clock rates to each of the channels. So to
>> distinguish the controller and channel type, num_channels is referred.
>>
>> OK, then that makes sense. Maybe add this detail to the comment about why
>> num_channels is used.
> 
> Ok. Will update comment.
>  
>>
>>>>
>>>>> +		/*
>>>>> +		 * Rate is multiplied with 2^PWM_DUTY_WIDTH so that it
>>>> matches
>>>>> +		 * with the hieghest applicable rate that the controller can
>>>>
>>>> s/hieghest/highest/
>>>
>>> Got it.
>>>
>>>>
>>>>> +		 * provide. Any further lower value can be derived by setting
>>>>> +		 * PFM bits[0:12].
>>>>> +		 * Higher mark is taken since BPMP has round-up mechanism
>>>>> +		 * implemented.
>>>>> +		 */
>>>>> +		required_clk_rate =
>>>>> +			(NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
>>>>> +
>>>>
>>>> Should be we checking the rate against the max rate supported?
>>>
>>> If the request rate is beyond max supported rate, then the
>>> clk_set_rate will be failing and can get caught with error check
>>> followed by. Otherwise it will fail through fitting in the register's frequency
>> divider filed. So I think it is not required to check against max rate.
>>> Please advise if I am not able to follow with what you are suggesting.
>>
>> I think that it would be better to update the cached value so that it is not
>> incorrectly used else where by any future change. Furthermore, this simplifies
>> matters a bit because you can do the following for all devices, but only update
>> the clk_rate for those you wish to ...
>>
>>     rate = pc->clk_rate >> PWM_DUTY_WIDTH;
>>
> What I understood from above is, we will always use max rate for any further configurations.
> If this is the suggestion above, then I think its not the right way.

I am not saying that.

> If we consider only max rate then the pwm output can only be ranging from:
> Possible max output rate: rate
> Possible min output rate: rate/2^13 (13 bits frequency divisor)
> 
> But if we consider the min rate supported by the source clock then,
> min output rate can go beyond the current min possible and 
> that should be considered for finding actual limit of min output rate.
> 
> Based on this, in the driver it tries to find a suitable clock rate to achieve
> requested output rate.
> Please suggest if you think we can still improve this further.

What I am suggesting is you ...

 if (pc->soc->num_channels == 1) {
         required_clk_rate = (NSEC_PER_SEC / period_ns) <<
                              PWM_DUTY_WIDTH;

         err = clk_set_rate(pc->clk, required_clk_rate);
         if (err < 0)
                return -EINVAL;

         pc->clk_rate = clk_get_rate(pc->clk);
 }

 rate = clk_get_rate(pc->clk) >> PWM_DUTY_WIDTH;

That's all. I think this is simpler.

Jon
-- 
nvpublic
