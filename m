Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3792D0576
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Dec 2020 15:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgLFOU0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 6 Dec 2020 09:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgLFOU0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 6 Dec 2020 09:20:26 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD6DC0613D0;
        Sun,  6 Dec 2020 06:19:45 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 4F998C63D6; Sun,  6 Dec 2020 14:19:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1607264381; bh=b+lxpFhX380M587pcy0Ld+WRWVJiMOZQGdYfRe41wBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t8uuCqeoDREUaHCJN3yn3zDTKf/wo6N1A+IrTAKE6hbJLJOzZ3DEo9p75zG8ETNeI
         4YVLKwSK2Hjqpt/5faOEo27UhLxgiuRC8eRtPpzOO9660HPqc+vDt9H82WFGdhbDsx
         3zUyV6uOpWty/QYKtdwdF0lXsococi/+bkEv5ahUjBVrQmdvYmD9eTcpBrir4RRU5r
         k9ZeATD6ZWJ2r1F2eMSlOxn/JssRLcbhAiVhrrCpOza9vzeBfrslqcExrpHkauwcfg
         RHRXXxJjguTLg6oJ5Tdnu+C5zf+5URo0Hd5Z0kYBeRk7AdlVyW4iEE0R8loE1Wonam
         18h1BZGYAoI1g==
Date:   Sun, 6 Dec 2020 14:19:41 +0000
From:   Sean Young <sean@mess.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, thierry.reding@gmail.com,
        lee.jones@linaro.org, nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: bcm2835: Support apply function for atomic
 configuration
Message-ID: <20201206141941.GA24807@gofer.mess.org>
References: <202011281128.54eLfMWr-lkp@intel.com>
 <1606564926-19555-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201129181050.p6rkif5vjoumvafm@pengutronix.de>
 <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
 <20201204084417.GA2154@gofer.mess.org>
 <20201204111326.qjux6k2472dmukot@pengutronix.de>
 <20201204113846.GA6547@gofer.mess.org>
 <20201204232834.xzsafkzfmfpw7pqz@pengutronix.de>
 <20201205173444.GA1265@gofer.mess.org>
 <20201205192510.o76pjs3yc524nwvm@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201205192510.o76pjs3yc524nwvm@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe,

On Sat, Dec 05, 2020 at 08:25:10PM +0100, Uwe Kleine-König wrote:
> On Sat, Dec 05, 2020 at 05:34:44PM +0000, Sean Young wrote:
> > What real life uses-cases are there for round down? If you want to round
> > down, is there any need for round up?
> 
> The scenario I have in mind is for driving a motor. I have to admit
> however that usually the period doesn't matter much and it's the
> duty_cycle that defines the motor's speed. So for this case the
> conservative behaviour is round-down to not make the motor run faster
> than expected.

I am reading here that for driving motors, only the duty cycle matters,
not the period.

> For other usecases (fan, backlight, LED) exactness typically doesn't
> matter that much.

So, the use-cases you have are driving motor, fan, backlight, and led.
And in all these cases the exact Hz does not matter.

The only uses case where the exact Hz does matter is pwm-ir-tx. 

So, I gather there are no use-cases for round-down. Yes, should round-down
be needed, then this is more difficult to implement if the driver always
does a round-closest. But, since there is no reason to have round-down,
this is all academic.

Your policy of forcing new pwm drivers to use round-down is breaking
pwm-ir-tx.

Thanks,

Sean
