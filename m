Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184FC6FC41C
	for <lists+linux-pwm@lfdr.de>; Tue,  9 May 2023 12:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjEIKkr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 May 2023 06:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbjEIKko (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 May 2023 06:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7929C10F5
        for <linux-pwm@vger.kernel.org>; Tue,  9 May 2023 03:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683628797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vLHn9AB2CD+acOPlI2PhqGxPae7I/Rg8z9Y4j3TKXWg=;
        b=XKezna+3QOPBwn8jKfwwESY+9rsmbjGkBeF0KlifKtq2atj/nfactZ6q63+atgVnDNb6ql
        MEcvPWjKXTMknpxACU/nVESeNjWSCAk9nJmuCEkIVnZWt3NxdNNo4qWxUYV1vTrniuxdDB
        WoCtfTS77xsJ+vVe9cj0My/xe2D0NkE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-MllnmrsmMzWx8iRM_GGbNQ-1; Tue, 09 May 2023 06:39:56 -0400
X-MC-Unique: MllnmrsmMzWx8iRM_GGbNQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-50bcc3ee913so5324588a12.2
        for <linux-pwm@vger.kernel.org>; Tue, 09 May 2023 03:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683628795; x=1686220795;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLHn9AB2CD+acOPlI2PhqGxPae7I/Rg8z9Y4j3TKXWg=;
        b=QxS46hXiHettlEmFS1lqGgXImUqGz7POBlfII0T4Ya1aSo5AwRg6bEWmW6Zj8Cf6Xk
         VDoBT1HfbiFz7a4QwEkfl851ML0cvQDnORX0o054weak7ac9Uv4zAyAU+21ct9S8ldnz
         uGMYa4m0Rdhcv353Z3r5CJxLm5oD3rQnDPplw4gv62oaTevSfU0OmtEzbMDqLutnWvO6
         KdtWlcrI8Chh2GPh1Mm4EwC44hGzjc/uPHiJC+BZkkBpbvkOsKDnNUA/zZN9mqZYrSQO
         L154NLiXr2TqmRks5x/YBEx1odClc8JE2p9zZ0e6AjxKuub1YsffofQbZ3w7z56dG/Yj
         aMOw==
X-Gm-Message-State: AC+VfDwdX7CunqN9dYkyY37PWg1JJnhHRbId3z9SFg2IZT5INqb+zkkD
        NEdd0Kj6jHORxJQyPw3cXdkO+etF3L/+QfcU/+5x4t60GVvR2bvebkQNg7sKGZuu8FP11sKTUF8
        Ee/XQBxCLE44NV/TCZ+xF
X-Received: by 2002:a17:907:268a:b0:965:d17b:26d with SMTP id bn10-20020a170907268a00b00965d17b026dmr10324132ejc.35.1683628795414;
        Tue, 09 May 2023 03:39:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6rW686CHOJmqr0gUIxMsD6s2FCuU1kMGKoPm4g1jNdSwHV3nFCeisrzNFlikiGw7jVKPMipA==
X-Received: by 2002:a17:907:268a:b0:965:d17b:26d with SMTP id bn10-20020a170907268a00b00965d17b026dmr10324104ejc.35.1683628795026;
        Tue, 09 May 2023 03:39:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id r12-20020a1709062ccc00b0094e954fd015sm1160975ejr.175.2023.05.09.03.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 03:39:54 -0700 (PDT)
Message-ID: <5c77ccec-a6f8-4272-f9f7-96387255b2f0@redhat.com>
Date:   Tue, 9 May 2023 12:39:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 18/19] platform/x86: lenovo-yogabook: Add keyboard
 backlight control to platform driver
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20230430165807.472798-1-hdegoede@redhat.com>
 <20230430165807.472798-19-hdegoede@redhat.com>
 <20230504165307.tydqlk6sml7sp5qe@pengutronix.de>
 <CAHp75VdgFFk=q-=ZDiKwV02Tin19ZSmSS=fhwgRrE6v48s-u0w@mail.gmail.com>
 <20230505092111.qknupa2vooi7mqwl@pengutronix.de>
 <b61d7ca2-a1db-05a1-fee5-b68e0e94b99f@redhat.com>
In-Reply-To: <b61d7ca2-a1db-05a1-fee5-b68e0e94b99f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 5/6/23 13:26, Hans de Goede wrote:
> Hi Uwe, Andy,
> 
> On 5/5/23 11:21, Uwe Kleine-König wrote:
>> On Fri, May 05, 2023 at 12:07:02PM +0300, Andy Shevchenko wrote:
>>> On Thu, May 4, 2023 at 7:53 PM Uwe Kleine-König
>>> <u.kleine-koenig@pengutronix.de> wrote:
>>>> On Sun, Apr 30, 2023 at 06:58:06PM +0200, Hans de Goede wrote:
>>>
>>> ...
>>>
>>>> I don't know much about x86, but I think the table belongs to where this
>>>> "80862289:00" device is created.
>>>
>>> Just for your information, it's in drivers/acpi/acpi_lpss.c.
>>
>> Compared to drivers/platform/x86/lenovo-yogabook-wmi.c this file is
>> never compiled as a module and so patch #1 would become unnecessary.
>>
>> That file also already has a pwm_lookup table.
> 
> Right, the Cherry Trail SoCs in question have 2 PWM controllers
> the first controller is pretty much always used to control
> the brightness of the LCD screen. So we have a fixed pwm_lookup
> table for it there using the SoC's builtin display controller's
> device_name() as consumer-device-name.
> 
> The second PWM controller however is different it is mostly unused
> I'm aware of 2 cases where it is used and in both cases it is used
> to control the brightness of a backlight for fixed (etched into the
> glass) touch controls.
> 
> The problem is that in these cases there will be 2 totally different
> consumer devices. Looking at the lookup tabel checks in pwm_get()
> I see that it is possible to add a lookup which matches only by
> dev_id. So I could use this here and this would then also be in
> place for when I get around to writing a driver for the second
> case (that I'm ware of) which needs access to the second PWM controller.
> 
> So this then just leaves the question of what to name the con-id,
> since we won't be specifying a consumer-device-name I think it is
> best to keep the con_id quite generic, e.g.:
> 
> "pwm_soc_lpss_2"
> 
> to match with the existing:
> 
> "pwm_soc_backlight"
> 
> for the first PWM controller.
> 
> Uwe, Andy, is using a pwm_lookup with only a con_id match on
> "pwm_soc_lpss_2" ok with you ?

I've decided to go ahead and go this route.

So I've modified this patch to drop the pwm_lookup_table
from it and changed the con_id passed to pwm_get() to:
"pwm_soc_lpss_2".

And then merged patches 2-19 (1) into the pdx86/review-hans (2).

I'll also submit an acpi_lpss.c patch soon to add a
lookup-table entry for the "pwm_soc_lpss_2" con_id there.

Regards,

Hans


1) All the patches except for patch 1 which exported
   pwm_add_table() / pwm_remove_table()

2) Patches pending for pdx86/for-next


