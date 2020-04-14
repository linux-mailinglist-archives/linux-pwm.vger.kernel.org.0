Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B281A8990
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2020 20:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504028AbgDNSaP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Apr 2020 14:30:15 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:30329 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503995AbgDNSaJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Apr 2020 14:30:09 -0400
Received: from [192.168.42.210] ([93.22.132.55])
        by mwinf5d85 with ME
        id SiW42200V1Bs39H03iW4Yb; Tue, 14 Apr 2020 20:30:06 +0200
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 14 Apr 2020 20:30:06 +0200
X-ME-IP: 93.22.132.55
Subject: Re: [PATCH] pwm: Add missing '\n' in log messages
To:     Thierry Reding <thierry.reding@gmail.com>, paul@crapouillou.net,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200411153528.30130-1-christophe.jaillet@wanadoo.fr>
 <20200414135827.GB3593749@ulmo>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <f13a8754-3866-d3d2-eaff-29cb6d14ff8d@wanadoo.fr>
Date:   Tue, 14 Apr 2020 20:30:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414135827.GB3593749@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Le 14/04/2020 à 15:58, Thierry Reding a écrit :
> On Sat, Apr 11, 2020 at 05:35:28PM +0200, Christophe JAILLET wrote:
>> Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.
>>
>> Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/pwm/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>> index 9973c442b455..bca04965bfe6 100644
>> --- a/drivers/pwm/core.c
>> +++ b/drivers/pwm/core.c
>> @@ -537,7 +537,7 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
>>   
>>   	if (!state->enabled && s2.enabled && s2.duty_cycle > 0)
>>   		dev_warn(chip->dev,
>> -			 "requested disabled, but yielded enabled with duty > 0");
>> +			 "requested disabled, but yielded enabled with duty > 0\n");
>>   
>>   	/* reapply the state that the driver reported being configured. */
>>   	err = chip->ops->apply(chip, pwm, &s1);
> I don't think this is strictly necessary any longer since the logging
> functions are supposed to add these themselves nowadays. But I like the
> consistency of this, so I'll apply this anyway.
>
> Thanks,
> Thierry

Hi Thierry,

I've sent more or less 10 similar patches against files updated 
recently, that is to say against files which are actively maintained.

I've done it to get feedback on the acceptances rate of such proposals.
The goal is not to flood everyone with such patches, but rather to see 
if adding a new kind of test to checkpatch.pl makes sense.

Being able to detect early missing trailing '\n' would help maintainers 
and patch providers.

You are the 2nd person (I've added Paul Cercueil in copy of my reply) 
who reports that he is thinking that it is no more required to add a '\n'.


If you have any pointer about it, it would be much appreciated.

It would mean, that either this additional checkpatch test is useless, 
or maybe that it should be reversed and spot *un*needed '\n'.

CJ
