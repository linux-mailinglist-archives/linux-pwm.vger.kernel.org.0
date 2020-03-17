Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE0CC188CEF
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 19:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgCQSQH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 14:16:07 -0400
Received: from web0081.zxcs.nl ([185.104.29.10]:37432 "EHLO web0081.zxcs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgCQSQH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 17 Mar 2020 14:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Message-ID:References:In-Reply-To:Subject:Cc:To:
        From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LOiksUFklkg8wSbbFyDEYhs3LWuousOngRMWqAii9i8=; b=AIqIR7RZkQor4tIE+CJQZ1ubky
        cWI+1loIE7+hQieD4z4bM3dtv6C6dwYOQqN8U37FWkOGJHRhVf2xczQslWNHNVhxOc53wvM5rbcPe
        E5T35/G5SXiwyC/BcgujPt2qdLbkM+ZkO6NNQHLKWFdQ5MjOnx0iO+jhh3kYt2IoPNXDXHQGEMMc4
        ldbP3l3RSGR5T3vRhyMjjQaZlYOQ5jiJ+s3aVevvXYKL+//T2rIZV+e8Tn79oGsFgxQsHAlrq1Qxz
        DtEEL7xUzKvtzj3VJzKyCoWjMLIJXfvZWzmQGrVBUUIofutubM4SowbeRNx3SamkSNWunjclcUEnD
        RjlKv+0A==;
Received: from spamrelay.zxcs.nl ([185.104.28.12]:39506 helo=mail-slave01.zxcs.nl)
        by web0081.zxcs.nl with esmtp (Exim 4.92.3)
        (envelope-from <dev@pascalroeleven.nl>)
        id 1jEGkv-0048Ip-Pm; Tue, 17 Mar 2020 19:15:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Mar 2020 19:15:57 +0100
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K?= =?UTF-8?Q?=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-sunxi@googlegroups.com
Subject: Re: [RFC PATCH 0/4] pwm: sun4i: Properly turn pwm off and fix stuck
 output state
In-Reply-To: <CAO1O6sccq7c_S8ZMsChBKcVcCn-DDv6awZzNr2BEnh8TH6ZxGg@mail.gmail.com>
References: <20200317155906.31288-1-dev@pascalroeleven.nl>
 <CAO1O6sccq7c_S8ZMsChBKcVcCn-DDv6awZzNr2BEnh8TH6ZxGg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.2
Message-ID: <f96002831730bf262ee61df38642e042@pascalroeleven.nl>
X-Sender: dev@pascalroeleven.nl
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2020-03-17 17:45, Emil Lenngren wrote:
> Hi all,
> 
> Den tis 17 mars 2020 kl 17:00 skrev Pascal Roeleven 
> <dev@pascalroeleven.nl>:
>> 
>> Hi all,
>> 
>> For the last few days I've been debugging a lot to get pwm working 
>> again since
>> recent changes in 5.6-rc1 broke it for me.
>> 
>> Testing shows the pwm controller crashes (or the output gets stuck) 
>> when the
>> period register is written when the channel is disabled while the 
>> clock gate is
>> still on. Usually after multiple writes, but one write can also lead 
>> to
>> unpredictable behaviour. Patch 3 and 4 fix this.
>> 
>> Patch 2 contains a fix which wouldn't completely turn off the pwm if 
>> the
>> output is disabled. The clock gate needs to stay on for at least one 
>> more
>> period to ensure the output is properly disabled. This issue has been 
>> around
>> for a long time but has probably stayed unnoticed because if the 
>> duty_cycle is
>> also changed to 0, you can't tell the difference.
>> 
>> Patch 1 removes some leftovers which aren't needed anymore.
>> 
>> Obviously these patches work for my device, but I'd like to hear your 
>> opinion
>> if any of these changes make sense. After days, this one is a bit 
>> blurry for me.
>> 
>> Thanks to Uwe for some help with debugging.
>> 
>> Pascal.
>> 
>> Pascal Roeleven (4):
>>   pwm: sun4i: Remove redundant needs_delay
>>   pwm: sun4i: Disable pwm before turning off clock gate
>>   pwm: sun4i: Move delay to function
>>   pwm: sun4i: Delay after writing the period
>> 
>>  drivers/pwm/pwm-sun4i.c | 53 
>> ++++++++++++++++++++---------------------
>>  1 file changed, 26 insertions(+), 27 deletions(-)
>> 
>> --
>> 2.20.1
>> 
> 
> I also worked on sun4i-pwm some time ago, fixing a bunch of issues.
> One was that disabling the pwm sometimes didn't turn off the signal,
> because the gate and enable bit were modified in the same clock cycle.
> Another was that the current code used an unnecessary sleep of a whole
> period length (or more?) in case of an update to the period, which
> could be very time-consuming if it's a very long interval, like 2
> seconds.
> 
> Note that the behaviour is not unpredictable, if you know how it works 
> ;)
> I fiddled around a long time with devmem2, an oscilloscope and the
> prescaler set to max to figure out how works internally.
> 
> Please try my version I just posted at https://pastebin.com/GWrhWzPJ.
> It is based on this version from May 28, 2019:
> https://github.com/torvalds/linux/blob/f50a7f3d9225dd374455f28138f79ae3074a7a3d/drivers/pwm/pwm-sun4i.c.
> Sorry for not posting it inline, but GMail would break the formatting.
> It contains quite many comments about how it works internally. I also
> wrote a section at http://linux-sunxi.org/PWM_Controller, but it might
> be a bit old (two years), so please rather look at the code and the
> comments.
> 
> /Emil

Hi Emil,

Thank you very much, this is helpful. Ah it was your note on the wiki. 
That is indeed where I took the idea of keeping the gate on and 
disabling the panel from. As a scope is still on my wishlist, the rest 
was just trial-and-error. Judging from your code, there are more edge 
cases which might occur. I will test your code and try to integrate it. 
If it's okay with you, I can post it on your behalf?

If you ask me, it's really unfortunate Allwinner didn't provide a timing 
diagram for such a picky controller.
