Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46521E2231
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2020 14:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389295AbgEZMoq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 May 2020 08:44:46 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19636 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389253AbgEZMop (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 May 2020 08:44:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ecd0ee40000>; Tue, 26 May 2020 05:43:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 May 2020 05:44:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 May 2020 05:44:45 -0700
Received: from [10.26.75.251] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 May
 2020 12:44:42 +0000
Subject: Re: [PATCH V3] pwm: tegra: dynamic clk freq configuration by PWM
 driver
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Sandipan Patra <spatra@nvidia.com>, <treding@nvidia.com>,
        <u.kleine-koenig@pengutronix.de>
CC:     <bbasu@nvidia.com>, <ldewangan@nvidia.com>,
        <kyarlagadda@nvidia.com>, <linux-pwm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1590492335-25857-1-git-send-email-spatra@nvidia.com>
 <81646862-8cbd-95f1-506d-ea375e365d69@nvidia.com>
Message-ID: <c83f7297-f3da-2b49-bc1a-42bffe7faabd@nvidia.com>
Date:   Tue, 26 May 2020 13:44:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <81646862-8cbd-95f1-506d-ea375e365d69@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590496996; bh=gexxHh16gksRF9BTtF3bTfa5GP1hWo5k5VQsBxeZLfg=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HApgLsETzU8HCKkwGg8sgYwV82HlZdvVYj9kMt0uQ+/Jfq4FvXHfTCJwgjgKMLv9g
         47gpVUo68iKyWcsgMQKjp0n3IcBJhvet3SLj5/8riF4apjligVbwth218GUKD12Hgi
         ly6B3ByVrbGU0wcpSEoKmpa40mZI3EblfAjBjcwfyCSY1fQ7TKrpZl9S7S40uofQn5
         AbjzHpUklC/G2H/xp2KWuzVfXJOWtdAWhMGXWDErvZ5L4t/8q+YmUbJTE7yhpPQW2q
         zZ7GaKN+jqYFkO2EnAW+fmAfMSoEi232Bx0UfP9TFum/pgGe4kjNkOaHmySfhU50z1
         wuSPYHFUeNYjw==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On 26/05/2020 13:05, Jon Hunter wrote:
> 
> On 26/05/2020 12:25, Sandipan Patra wrote:
>> Added support for dynamic clock freq configuration in pwm kernel driver.
>> Earlier the pwm driver used to cache boot time clock rate by pwm clock
>> parent during probe. Hence dynamically changing pwm frequency was not
>> possible for all the possible ranges. With this change, dynamic calculation
>> is enabled and it is able to set the requested period from sysfs knob
>> provided the value is supported by clock source.
>>
>> Changes mainly have 2 parts:
>>   - T186 and later chips [1]
>>   - T210 and prior chips [2]
>>
>> For [1] - Changes implemented to set pwm period dynamically and
>>           also checks added to allow only if requested period(ns) is
>>           below or equals to higher range.
>>
>> For [2] - Only checks if the requested period(ns) is below or equals
>>           to higher range defined by max clock limit. The limitation
>>           in T210 or prior chips are due to the reason of having only
>>           one pwm-controller supporting multiple channels. But later
>>           chips have multiple pwm controller instances each having
>> 	  single channel support.
>>
>> Signed-off-by: Sandipan Patra <spatra@nvidia.com>

...

>>  	/*
>> +	 *  Period in nano second has to be <= highest allowed period
>> +	 *  based on max clock rate of the pwm controller.
>> +	 *
>> +	 *  higher limit = max clock limit >> PWM_DUTY_WIDTH
>> +	 *  lower limit = min clock limit >> PWM_DUTY_WIDTH >> PWM_SCALE_WIDTH
> 
> Not sure why we mention the lower limit if we are not testing this
> condition. Does not appear to be relevant here. Or should we be checking
> this as well?

The above comment appears to be incorrect. Looking further at the code,
the code seems fine but the comment is confusing. I think you mean to
say that 'the period needs to be greater than the minimum period' and
that ...

 min period = max clock limit >> PWM_DUTY_WIDTH
 max period = min clock limit >> PWM_DUTY_WIDTH >> PWM_SCALE_WIDTH

> 
>> +	 */
>> +	if (period_ns < pc->min_period_ns)
>> +		return -EINVAL;
> 
> Something does not seem right here. If this is the highest allowed
> period, shouldn't this variable be called 'max_period_ns'?

Jon

-- 
nvpublic
