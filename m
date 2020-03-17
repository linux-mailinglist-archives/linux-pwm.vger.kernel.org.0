Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 160CA188C9A
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 18:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgCQRw7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 13:52:59 -0400
Received: from web0081.zxcs.nl ([185.104.29.10]:36948 "EHLO web0081.zxcs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgCQRw7 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 17 Mar 2020 13:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Message-ID:References:In-Reply-To:Subject:Cc:To:
        From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kYE0yHNNN9LAxleq7P2y1gIFBIIP2Wmb0USpvPZmwSM=; b=qr4URIDH2cQk45mFHknGWBzW2M
        bQwg7rAVDWTrTlb+Z7P+knyEsBmvdVuw715UOGwMdlsgnc0J+GP2h7kE1SRvVF2db1VaaD+lk6ZYB
        GjTvXOPCjHahkS4pxBwaNS1Q/1FtkUg4N2zkbVL1KZVx8EMGPArFgZqfRNArCEwg2c6XDh11B3ibz
        ShxBPIbEE7Sd12Pqk75icoOHKKHX/8iFLszEoR2pNpYJ2bd0yB7OXCgMmYQeDPICfmdaYI7TNuLZh
        mqni9XKg0dFLx2iNrechiSS9sn3CYPDYRD1Hya2ZZUKFH3GAOUrftrUfhPS7EhoKlkwSatcGJbQ+2
        zUL7BQSA==;
Received: from spamrelay.zxcs.nl ([185.104.28.12]:41856 helo=mail-slave01.zxcs.nl)
        by web0081.zxcs.nl with esmtp (Exim 4.92.3)
        (envelope-from <dev@pascalroeleven.nl>)
        id 1jEGOY-003b4c-Dm; Tue, 17 Mar 2020 18:52:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 17 Mar 2020 18:52:50 +0100
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: pwm: sun4i: pwm-backlight not working since 5.6-rc1
In-Reply-To: <20200317173208.t5s63pfz3byxsgzi@pengutronix.de>
References: <6185b5540ca082d887d7d13330c9d938@pascalroeleven.nl>
 <20200312132942.2kfspvmoc3mxkdx4@pengutronix.de>
 <6e995c4c22c4e6c93acb1f491e5aa109@pascalroeleven.nl>
 <20200316072613.37lnjfloac4npudf@pengutronix.de>
 <20200317173208.t5s63pfz3byxsgzi@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.2
Message-ID: <ddd9b9c5b3d28a30c888fdcfc1ac6d64@pascalroeleven.nl>
X-Sender: dev@pascalroeleven.nl
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2020-03-17 18:32, Uwe Kleine-König wrote:
> Hello Pascal,
> 
> On Mon, Mar 16, 2020 at 08:26:13AM +0100, Uwe Kleine-König wrote:
>> On Thu, Mar 12, 2020 at 04:06:07PM +0100, Pascal Roeleven wrote:
>> > On 2020-03-12 14:29, Uwe Kleine-König wrote:
>> > > On Thu, Mar 12, 2020 at 01:22:13PM +0100, Pascal Roeleven wrote:
>> > > > Hi all,
>> > > >
>> > > > I am working on adding an old A10 device to mainline and noticed an
>> > > > issue
>> > > > when testing on 5.5.8 vs master.
>> > > >
>> > > > Since 5.6-rc1, I can't control the brightness of my LCD backlight
>> > > > anymore.
>> > > > The backlight stays on full brightness instead. I am controlling the
>> > > > brightness value via sysfs for testing.
>> > > >
>> > > > I am not sure if this is a general pwm-sun4i issue or if it is
>> > > > related to
>> > > > the backlight. However I narrowed it down to one commit for pwm-sun4i:
>> > > >
>> > > > fa4d81784681a26bcf7d2a43c6ac5cf991ef28f5
>> > > >
>> > > > If I use pwm-sun4i.c from 5b090b430d750961305030232314b6acdb0102aa on
>> > > > master, the backlight works fine. Unfortunately, due to my lack of
>> > > > kernel
>> > > > experience, I can't see how the commit above broke it.
>> > >
>> > > Hmm, I cannot see how fa4d81784681a26bcf7d2a43c6ac5cf991ef28f5 breaks
>> > > this. Looking at the output of
>> > >
>> > > 	git show -b fa4d81784681a26bcf7d2a43c6ac5cf991ef28f5
>> > >
>> > > (i.e. ignoring whitespace changes) I don't see how the behaviour you're
>> > > reporting can be explained.
>> > >
>> > > Are you sure that fa4d81784681a26bcf7d2a43c6ac5cf991ef28f5 is the bad
>> > > commit?
>> > >
>> > > Can you install a tool to inspect register values and check how the
>> > > affected registers change if you switch kernel versions and/or pwm
>> > > settings?
>> > >
>> > > (e.g.
>> > > 	memtool md 0x1c20e00+0xc
>> > > )
>> > >
>> > > Best regards
>> > > Uwe
>> >
>> > Thanks for your response.
>> >
>> > Yes I am sure that is the commit. If I am on master, and replace pwm-sun4i.c
>> > with the one from 5b090b43, everything works. If I then apply fa4d8178, it
>> > stops working.
>> >
>> > And strangely the output of the registers is exactly the same before and
>> > after fa4d8178:
>> >
>> > 01c20e00: 00000050 00130014 00000000 (full brightness)
>> > 01c20e00: 00000050 00130006 00000000 (min brightness)
>> >
>> > Even when I'm on 5b090b43 and cherry-pick fa4d8178 can I reproduce the
>> > issue.
>> 
>> Very strange. I'm out of sensible ideas. The remaining ones are:
>> 
>> - enable tracing in the kernel and boot with
>> 
>> 	trace_event=pwm
>> 
>>   And then check after the problem occurred in
>>   /sys/kernel/debug/tracing/trace if something sticks out.
>> 
>> - Try modifying the registers using memtool. E.g.
>> 
>> 	memtool mw 0x01c20e04 0x00130012
>> 
>> - Do you have equipment to check the actual output of the PWM 
>> hardware?
>>   If so, what do you see?
> 
> I assume the sun4i-series you sent earlier today resolves the problems
> you reported here?
> 
> Best regards
> Uwe

Hi Uwe,

Yes it does, but as Emil mentioned it's probably not complete. It's just 
an RFC for now to make sure it doesn't cause a regression. Turns out the 
Allwinner PWM controller is even more pickier than I thought.

Again, thank you for your help.
