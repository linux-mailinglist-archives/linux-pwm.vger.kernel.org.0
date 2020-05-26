Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013321E2124
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2020 13:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388927AbgEZLpb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 May 2020 07:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgEZLpa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 May 2020 07:45:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CAAC03E97E;
        Tue, 26 May 2020 04:45:29 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e11so9122605pfn.3;
        Tue, 26 May 2020 04:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VSjBKQ188VN+osbdQoX9ee2yKdR3xSpQdFMBIIS2iRo=;
        b=FDAuPnwkXQ6PjDDsg3dF3rfJsYtyhBmdzJZcWcf2N7P7BIjuao5N1E4wJRa+iweALY
         P0zpqEm0W9PmgSJnmCwkEm48Wk5KmZJ30ZSi3FHRBmr9nOBQcjwTWT1C6U+KmlZUGA0D
         geIq5A+hykN9R2zpgj3T4/oWZQZOIj9HpKIaRjAf5ZIsmqVzazUgVgn0aOdfezzS0GB1
         ODbcjpnlT9XVd9l2nWBkDIGOHVyAjuqV0G0C0c3A4UdiA4CCaXE0r35BNBJBk7+zhOjY
         TvHXYOSAladLy7SGRJ+9UXvlZR0bDY2fAPy1wst+ff+4OS8oJUpFqTQFlRpSmOArJ85S
         VXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VSjBKQ188VN+osbdQoX9ee2yKdR3xSpQdFMBIIS2iRo=;
        b=K8bqp00LlCKzA3MH0SQdkIMARnIKdE6UxySOn+y7pDjuK4XwU/QHiucxMulP2qwnBD
         YWc9MoMZY8NV/q3ygNRYxLWAzAe+nLBRN3TGvaYSd0sBZ8x+3pzD0ZF7yDxMjxWmtUdG
         uneDiafkldvYbSbFHyD7JtGzJPKBzcVv2WtXtBTio3gpQqRhsQH7x7Mls0+7imCr+ktG
         fYImzFvk4uIyjb5NX8MMLeC5VCaaOQBz9WPDq5Q14azEH6UzIZYMeJluEn036as5kkaO
         wU5W88Uh7GeqWCc8E3grkQW6luuVwUAxAFGx8UYbemHFVVf7+6WEcImk3ULB7Fr3me8k
         6v+w==
X-Gm-Message-State: AOAM5338WZCBU5BnWjx9s3XvpeMJtP5IEfUXaOLxFim6l/QF341Ml6+0
        rToMGIHGmrNiV95wzpYUCo675xmR
X-Google-Smtp-Source: ABdhPJwVqN+H4XXugQ8p/6ZMKiDtuAPAJExv30hpTBw882wb5HKSh3024bTqf8FurnTxwDA7hcJQmg==
X-Received: by 2002:a62:770f:: with SMTP id s15mr5385129pfc.121.1590493528810;
        Tue, 26 May 2020 04:45:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n10sm15495902pfd.192.2020.05.26.04.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 04:45:28 -0700 (PDT)
Subject: Re: [PATCH 1/2] hwmon: pwm-fan: Add profile support and add remove
 module support
To:     Sandipan Patra <spatra@nvidia.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "kamil@wypas.org" <kamil@wypas.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Bibek Basu <bbasu@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1590469565-14953-1-git-send-email-spatra@nvidia.com>
 <20200526070450.sackolk6m3qv7omy@pengutronix.de>
 <BYAPR12MB30140CD3D7C7263594FD4F30ADB00@BYAPR12MB3014.namprd12.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <bfd4525f-65cc-4887-43a0-feef36dedd48@roeck-us.net>
Date:   Tue, 26 May 2020 04:45:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB30140CD3D7C7263594FD4F30ADB00@BYAPR12MB3014.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 5/26/20 2:05 AM, Sandipan Patra wrote:
> Hi Uwe,
> 
> 
> 
>> -----Original Message-----
>> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Sent: Tuesday, May 26, 2020 12:35 PM
>> To: Sandipan Patra <spatra@nvidia.com>
>> Cc: Thierry Reding <treding@nvidia.com>; Jonathan Hunter
>> <jonathanh@nvidia.com>; kamil@wypas.org; jdelvare@suse.com; linux@roeck-
>> us.net; robh+dt@kernel.org; Bibek Basu <bbasu@nvidia.com>; Bitan Biswas
>> <bbiswas@nvidia.com>; linux-pwm@vger.kernel.org; linux-
>> hwmon@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> tegra@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 1/2] hwmon: pwm-fan: Add profile support and add remove
>> module support
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On Tue, May 26, 2020 at 10:36:04AM +0530, Sandipan Patra wrote:
>>> This change has 2 parts:
>>> 1. Add support for profiles mode settings.
>>>     This allows different fan settings for trip point temp/hyst/pwm.
>>>     T194 has multiple fan-profiles support.
>>>
>>> 2. Add pwm-fan remove support. This is essential since the config is
>>>     tristate capable.
>>
>> These two are orthogonal, aren't they? So they belong in two patches.
>>
>> You have to expand the binding documentation.
>>
>>> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
>>> ---
>>>  drivers/hwmon/pwm-fan.c | 112
>>> ++++++++++++++++++++++++++++++++++++++++++------
>>>  1 file changed, 100 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c index
>>> 30b7b3e..26db589 100644
>>> --- a/drivers/hwmon/pwm-fan.c
>>> +++ b/drivers/hwmon/pwm-fan.c
>>> @@ -3,8 +3,10 @@
>>>   * pwm-fan.c - Hwmon driver for fans connected to PWM lines.
>>>   *
>>>   * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>>> + * Copyright (c) 2020, NVIDIA Corporation.
>>>   *
>>>   * Author: Kamil Debski <k.debski@samsung.com>
>>> + * Author: Sandipan Patra <spatra@nvidia.com>
>>>   */
>>>
>>>  #include <linux/hwmon.h>
>>> @@ -21,6 +23,8 @@
>>>  #include <linux/timer.h>
>>>
>>>  #define MAX_PWM 255
>>> +/* Based on OF max device tree node name length */
>>> +#define MAX_PROFILE_NAME_LENGTH      31
>>>
>>>  struct pwm_fan_ctx {
>>>       struct mutex lock;
>>> @@ -38,6 +42,12 @@ struct pwm_fan_ctx {
>>>       unsigned int pwm_fan_state;
>>>       unsigned int pwm_fan_max_state;
>>>       unsigned int *pwm_fan_cooling_levels;
>>> +
>>> +     unsigned int pwm_fan_profiles;
>>> +     const char **fan_profile_names;
>>> +     unsigned int **fan_profile_cooling_levels;
>>> +     unsigned int fan_current_profile;
>>> +
>>>       struct thermal_cooling_device *cdev;  };
>>>
>>> @@ -227,28 +237,86 @@ static int pwm_fan_of_get_cooling_data(struct
>> device *dev,
>>>                                      struct pwm_fan_ctx *ctx)  {
>>>       struct device_node *np = dev->of_node;
>>> +     struct device_node *base_profile = NULL;
>>> +     struct device_node *profile_np = NULL;
>>> +     const char *default_profile = NULL;
>>>       int num, i, ret;
>>>
>>> -     if (!of_find_property(np, "cooling-levels", NULL))
>>> -             return 0;
>>> +     num = of_property_count_u32_elems(np, "cooling-levels");
>>> +     if (num <= 0) {
>>> +             base_profile = of_get_child_by_name(np, "profiles");
>>> +             if (!base_profile) {
>>> +                     dev_err(dev, "Wrong Data\n");
>>> +                     return -EINVAL;
>>> +             }
>>> +     }
>>> +
>>> +     if (base_profile) {
>>> +             ctx->pwm_fan_profiles =
>>> +                     of_get_available_child_count(base_profile);
>>> +
>>> +             if (ctx->pwm_fan_profiles <= 0) {
>>> +                     dev_err(dev, "Profiles used but not defined\n");
>>> +                     return -EINVAL;
>>> +             }
>>>
>>> -     ret = of_property_count_u32_elems(np, "cooling-levels");
>>> -     if (ret <= 0) {
>>> -             dev_err(dev, "Wrong data!\n");
>>> -             return ret ? : -EINVAL;
>>> +             ctx->fan_profile_names = devm_kzalloc(dev,
>>> +                     sizeof(const char *) * ctx->pwm_fan_profiles,
>>> +                                                     GFP_KERNEL);
>>> +             ctx->fan_profile_cooling_levels = devm_kzalloc(dev,
>>> +                     sizeof(int *) * ctx->pwm_fan_profiles,
>>> +                                                     GFP_KERNEL);
>>> +
>>> +             if (!ctx->fan_profile_names
>>> +                             || !ctx->fan_profile_cooling_levels)
>>> +                     return -ENOMEM;
>>> +
>>> +             ctx->fan_current_profile = 0;
>>> +             i = 0;
>>> +             for_each_available_child_of_node(base_profile, profile_np) {
>>> +                     num = of_property_count_u32_elems(profile_np,
>>> +                                                     "cooling-levels");
>>> +                     if (num <= 0) {
>>> +                             dev_err(dev, "No data in cooling-levels inside profile
>> node!\n");
>>> +                             return -EINVAL;
>>> +                     }
>>> +
>>> +                     of_property_read_string(profile_np, "name",
>>> +                                             &ctx->fan_profile_names[i]);
>>> +                     if (default_profile &&
>>> +                             !strncmp(default_profile,
>>> +                             ctx->fan_profile_names[i],
>>> +                             MAX_PROFILE_NAME_LENGTH))
>>> +                             ctx->fan_current_profile = i;
>>> +
>>> +                     ctx->fan_profile_cooling_levels[i] =
>>> +                             devm_kzalloc(dev, sizeof(int) * num,
>>> +                                                     GFP_KERNEL);
>>> +                     if (!ctx->fan_profile_cooling_levels[i])
>>> +                             return -ENOMEM;
>>> +
>>> +                     of_property_read_u32_array(profile_np, "cooling-levels",
>>> +                             ctx->fan_profile_cooling_levels[i], num);
>>> +                     i++;
>>> +             }
>>>       }
>>>
>>> -     num = ret;
>>>       ctx->pwm_fan_cooling_levels = devm_kcalloc(dev, num, sizeof(u32),
>>>                                                  GFP_KERNEL);
>>>       if (!ctx->pwm_fan_cooling_levels)
>>>               return -ENOMEM;
>>>
>>> -     ret = of_property_read_u32_array(np, "cooling-levels",
>>> -                                      ctx->pwm_fan_cooling_levels, num);
>>> -     if (ret) {
>>> -             dev_err(dev, "Property 'cooling-levels' cannot be read!\n");
>>> -             return ret;
>>> +     if (base_profile) {
>>> +             memcpy(ctx->pwm_fan_cooling_levels,
>>> +               ctx->fan_profile_cooling_levels[ctx->fan_current_profile],
>>> +                                             num);
>>> +     } else {
>>> +             ret = of_property_read_u32_array(np, "cooling-levels",
>>> +                             ctx->pwm_fan_cooling_levels, num);
>>> +             if (ret) {
>>> +                     dev_err(dev, "Property 'cooling-levels' cannot be read!\n");
>>> +                     return -EINVAL;
>>> +             }
>>>       }
>>>
>>>       for (i = 0; i < num; i++) {
>>> @@ -390,6 +458,25 @@ static int pwm_fan_probe(struct platform_device
>> *pdev)
>>>       return 0;
>>>  }
>>>
>>> +static int pwm_fan_remove(struct platform_device *pdev) {
>>> +     struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
>>> +     struct pwm_args args;
>>> +
>>> +     if (!ctx)
>>> +             return -EINVAL;
>>> +
>>> +     if (IS_ENABLED(CONFIG_THERMAL))
>>> +             thermal_cooling_device_unregister(ctx->cdev);
>>> +
>>> +     pwm_get_args(ctx->pwm, &args);
>>> +     pwm_config(ctx->pwm, 0, args.period);
>>> +     pwm_disable(ctx->pwm);
>>
>> What is what you really here? Is it only that the PWM stops oscillating, or is it
>> crucial that the output goes to its inactive level?
>>
>> (The intended semantic of pwm_disable includes that the output goes low, but
>> not all implementations enforce this.)
>>
>> Also please don't introduce new users of pwm_config() and pwm_disable() use
>> pwm_apply() instead.
>>
>> I wonder if this unregistration is "safe". When the driver is in use I'd expect that
>> the hwmon device doesn't go away and so the devm unregistration callback that
>> belongs to
>> devm_hwmon_device_register_with_groups() blocks. But at this time the PWM
>> is already stopped and so the device stops functioning earlier.
>>
>> Best regards
>> Uwe
>>
> 
> Thanks for reviewing the changes.
> 
> I see that pwm_fan_shutdown() which has got merged recently, can also be used for
> module remove functionality. May be it will need a little bit of tweak in the code.
> However I should have not made both multiple profiles support and fan remove functionality on
> same patch.
> 

Pointing out explicitly:

ret = devm_add_action_or_reset(dev, pwm_fan_pwm_disable, ctx);

cdev = devm_thermal_of_cooling_device_register(dev, ...)

Guenter
