Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7608184DBA
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2020 18:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgCMRhN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Mar 2020 13:37:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32871 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCMRhM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Mar 2020 13:37:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so13187674wrd.0;
        Fri, 13 Mar 2020 10:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i1EqL4yPiJPp0lfszNYpw2j5gmjj3xYdE+hdJBiRqMg=;
        b=WTW7PxvAXfZejxpAWViKjBB360ST4Lckt5ygv7v8Dc76v6AjfTcJdodk82KSqgzJuJ
         IVqTrng2dJLkK64E/c/POE/fJOhXwGw/lE3Mwv/2yXBGXir8j1X/1ABpUAuGcnJ780n2
         IyX2ld15KFS6hDhT4EA3HbshvoBB/91oNDfHY0BzlD2sLz1m2TNemq+mAuZe3Vem/0wA
         qYXRfe3RTKx7ZE9bsNwyFL04pW76xoBremAtA6ri5kCaybQbRhwfKnBolTjoBQbrMhQP
         RMUC8Ufjm8ZjyrP2WbKwN9qrFda0XaVjncntXqjCEQxiG6Pr+/DDq3//eAb4/9oSXRYw
         2dqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i1EqL4yPiJPp0lfszNYpw2j5gmjj3xYdE+hdJBiRqMg=;
        b=kOqpsKHhAd9JxbcxlzDMfEP6qCa7cyeKwBN2TxggKg5su3/HB89RmPeBxRzj0qpixq
         pLvAwYQrKMgaC/kOOnhTdPT+PXz9UzDOYr0XabXrjGSDdK0ighZuFkrQIyfcuODI9/lm
         M6SE1lyToEcxtrNXYQWdyeZAtA7vzM4b84UuqiU0iBmpAi2sIDT7CWWt2u+QfTwy2Kkd
         egNj3aMuqQHVy6ZTEevQlwBp3aX2qkw9dNfCh0Q3St8s1x2YKRSC1e+DcfXYtYRhrZT1
         OQS+w2o6IIEO+2i57/CEqDx9dCDOE/2rsdSN+b6pwupmi8UZqyvKbuzh3y3Y1U2LljtJ
         dJ5Q==
X-Gm-Message-State: ANhLgQ2aQLZHdVqzX63s7aFiSRK5Vd5up/yD35LERO+3DTjI3JIeq+Wz
        n2eH2MT5PpuhCqFc1MSVT0g=
X-Google-Smtp-Source: ADFU+vsvMoQos+G1Js0ft5uNgMfQrgtI/JPzvS2NpP/XpdQKJx0n1obiIiqCU1AAjgwTEWbM984vGg==
X-Received: by 2002:adf:f584:: with SMTP id f4mr19670059wro.77.1584121030491;
        Fri, 13 Mar 2020 10:37:10 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id v2sm14317608wme.2.2020.03.13.10.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 10:37:09 -0700 (PDT)
Subject: Re: [PATCH] pwm: bcm2835: Dynamically allocate base
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Ray Jui <rjui@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
References: <20200203213536.32226-1-f.fainelli@gmail.com>
 <08e2b640f0a7713d905295fc4f75df49617be6c1.camel@suse.de>
 <3b22decc-9ebd-3522-4fd7-e5721c8b25b2@gmail.com>
 <20200220210718.4vrn6u2c2remeuhm@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <773a00f4-178d-4d3e-a2d1-f82564457a0f@gmail.com>
Date:   Fri, 13 Mar 2020 10:37:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220210718.4vrn6u2c2remeuhm@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 2/20/2020 1:07 PM, Uwe Kleine-König wrote:
> [Dropping Bart Tanghe from recipents as the address bounces]
> 
> Hello Thierry,
> 
> On Thu, Feb 20, 2020 at 11:14:00AM -0800, Florian Fainelli wrote:
>> On 2/4/20 1:17 AM, Nicolas Saenz Julienne wrote:
>>> On Mon, 2020-02-03 at 13:35 -0800, Florian Fainelli wrote:
>>>> The newer 2711 and 7211 chips have two PWM controllers and failure to
>>>> dynamically allocate the PWM base would prevent the second PWM
>>>> controller instance being probed for succeeding with an -EEXIST error
>>>> from alloc_pwms().
>>>>
>>>> Fixes: e5a06dc5ac1f ("pwm: Add BCM2835 PWM driver")
>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>> ---
>>>
>>> Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>
>> Thierry, is there any chance we can get this applied for an upcoming
>> 5.6-rcX? Thank you!
> 
> to assist you with patch sorting:
> 
> # revisions < v6 of "Convert period and duty cycle to u64"
> pwclient -s Superseded 1237020 1237019 1229049 1229050 1222396
> 
> # most of "Add support for Azoteq IQS620A/621/622/624/625" v5 isn't for pwm
> pwclient -s "Not Applicable" 1238908 1238907 1238906 1238904 1238903 1238901
> 
> # most of "Add support for Azoteq IQS620A/621/622/624/625" v4 isn't for pwm
> pwclient -s "Not Applicable" 1224598 1224597 1224596 1224594 1224593 1224592
> pwclient -s "Superseeded" 1224595
> 
> # "backlight: pwm_bl: Use gpiod_get_value_cansleep() to get initial
> # state" already applied by Lee Jones
> pwclient -s "Not Applicable" 1031586
> 
> # Problem resolved by Michal Vokáč
> pwclient -s "Rejected"  1059267
> 
> (Not sure "Rejected" is the right state.)

Thierry, can we get this patch included in v5.7? I have not seen it show
up in linux-next yet.

Thank you!
-- 
Florian
