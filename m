Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0CB7FE2E
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Aug 2019 18:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389595AbfHBQJ3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Aug 2019 12:09:29 -0400
Received: from vern.gendns.com ([98.142.107.122]:42544 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389527AbfHBQJ1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 2 Aug 2019 12:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5lPK0SoTI4WivVBlQ9V5Or5hsa5f4C2zi5txmZLiDXk=; b=x/8NUPy9GYoK/3ZMnIU7rsBH5Q
        FK/PnJoOW2As+ToVB3LSg2p5I2uuuCxaIJ/FdaFyEp/MM2FfqDXZQi2Y0yZrPFuDdslFV0yXEQrEo
        Yekp0W7LVivL+2P0VBAmFUM4/mrXEJXHt0Ij0+7jlu4V2Pwtuuu0XpaIo1VqscTa4rPCQGHrcGagF
        UEmVsh/sCBBBKPbQNrDZL3KKjG8O+22SM/SPMIdkcG3UYq/jYkNo7bWUym+8Vk1fDtQxxyTQ0XXBw
        F9VLKz9Kj+t+kLTpQ3KcwMZ7liFDK+aBKKSXW0wNQPot+o7ZUfYwiu1JtOTioRcsgmRMM+gUNAsk/
        ei8pnOpg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:42682 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1hta7P-004v16-AL; Fri, 02 Aug 2019 12:09:23 -0400
Subject: Re: [PATCH 2/4] counter: new TI eQEP driver
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20190722154538.5314-1-david@lechnology.com>
 <20190722154538.5314-3-david@lechnology.com> <20190802092727.GB30522@icarus>
From:   David Lechner <david@lechnology.com>
Message-ID: <f45ec1f4-6463-12d9-9459-35fe7b46671a@lechnology.com>
Date:   Fri, 2 Aug 2019 11:09:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802092727.GB30522@icarus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 8/2/19 4:27 AM, William Breathitt Gray wrote:
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index a7e57516959e..ddcbb8573894 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -499,7 +499,7 @@ config  PWM_TIEHRPWM
>>   
>>   config  PWM_TIPWMSS
>>   	bool
>> -	default y if (ARCH_OMAP2PLUS) && (PWM_TIECAP || PWM_TIEHRPWM)
>> +	default y if (ARCH_OMAP2PLUS) && (PWM_TIECAP || PWM_TIEHRPWM || TI_EQEP)
>>   	help
>>   	  PWM Subsystem driver support for AM33xx SOC.
> I was surprised to see this pwm Kconfig change in this patch. Is
> PWM_TIPWMSS required for TI_EQEP to work? If not required, then this
> could be a separate patch; otherwise, put in a mention about why in the
> commit message so that the purpose of this change is clearer.
> 

This enables the parent bus for power management. Since this is the second
comment about this, I wonder if it would make sense to move this out of the
PWM subsystem and into drivers/bus/ since it is no longer exclusive to PWM
devices.
