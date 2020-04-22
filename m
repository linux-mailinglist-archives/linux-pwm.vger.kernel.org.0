Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4749D1B3AE9
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Apr 2020 11:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgDVJNL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 22 Apr 2020 05:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726431AbgDVJNL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 22 Apr 2020 05:13:11 -0400
X-Greylist: delayed 1968 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Apr 2020 02:13:11 PDT
Received: from web0081.zxcs.nl (web0081.zxcs.nl [IPv6:2a06:2ec0:1::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D264C03C1A6
        for <linux-pwm@vger.kernel.org>; Wed, 22 Apr 2020 02:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Message-ID:References:In-Reply-To:Subject:Cc:To:
        From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vpGUfuTiVLd2vA91ue4c0K9V/4VZKL+mbW8WcjO/LrA=; b=Ki4mBfA7ZnNAsIT4ktrRzJONzz
        qGcH4XX8vK9hT0WegeJHXHi9GvfaTzDrFsGGzgrIGxVbAd1awjUtXZFs+hVnKXbXeoLyFQr5KtIhP
        xlYu37mmaPdqJlz6jaJwzzlIzXOseOphSdyN+fY8h8JEb9IvKQLpMTBV59EIQdTAuW734Vupni4Ew
        UDtTt1uueJRAdHdKXCAh2bm8uKhnnhxF2mqQyggxYa3shekii9sWDk8UbiHKGeVw2RoqY2QbFUydF
        O5qgvGJ81fO9ehCniBZrn1P3xFqFjxgkMcwboDpUly3hRVJ2fFevFnkoLglHEQefQwj65hHLEFFDb
        lkr/7p3w==;
Received: from spamrelay.zxcs.nl ([185.104.28.12]:50258 helo=mail-slave01.zxcs.nl)
        by web0081.zxcs.nl with esmtp (Exim 4.93.0.4)
        (envelope-from <dev@pascalroeleven.nl>)
        id 1jRAvU-002uIq-5s; Wed, 22 Apr 2020 10:40:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 Apr 2020 10:40:11 +0200
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K?= =?UTF-8?Q?=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [RFC PATCH 4/4] pwm: sun4i: Delay after writing the
 period
In-Reply-To: <f1d9a17e-df9e-dc12-603d-84e908a04b81@sholland.org>
References: <20200317155906.31288-1-dev@pascalroeleven.nl>
 <20200317155906.31288-5-dev@pascalroeleven.nl>
 <f1d9a17e-df9e-dc12-603d-84e908a04b81@sholland.org>
User-Agent: Roundcube Webmail/1.4.2
Message-ID: <fd36eddb87b529498e0429afe3521da7@pascalroeleven.nl>
X-Sender: dev@pascalroeleven.nl
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2020-04-22 05:43, Samuel Holland wrote:
> Hello Pascal,
> 
> On 3/17/20 10:59 AM, Pascal Roeleven wrote:
>> When disabling, ensure the period write is complete before continuing.
>> This fixes an issue on some devices when the write isn't complete 
>> before
>> the panel is turned off but the clock gate is still on.
>> 
>> Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
>> ---
>>  drivers/pwm/pwm-sun4i.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
>> index a11d00f96..75250fd4c 100644
>> --- a/drivers/pwm/pwm-sun4i.c
>> +++ b/drivers/pwm/pwm-sun4i.c
>> @@ -299,6 +299,10 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, 
>> struct pwm_device *pwm,
>>  	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
>>  	next_period = jiffies + usecs_to_jiffies(cstate.period / 1000 + 1);
>> 
>> +	/* When disabling, make sure the period register is written first */
>> +	if (!state->enabled && cstate.enabled)
>> +		sun4i_pwm_wait(next_period);
>> +
> 
> It is not visible from the context of this patch, but this call to
> sun4i_pwm_wait() ends up calling msleep() inside a spinlock, which 
> isn't
> allowed. The spinlock should probably be converted to a mutex, 
> considering that
> sun4i_pwm_apply() already sleeps and takes mutexes.
> 
> Regards,
> Samuel
> 

Yes you're right. A different implementation of this patch series is 
being worked on, in which I'll take this into account. Unfortunately I 
have other things to work on at the moment, so it might take a while.

Regards,
Pascal
