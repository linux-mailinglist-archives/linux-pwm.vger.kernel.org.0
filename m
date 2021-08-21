Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CE23F3BCA
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Aug 2021 19:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhHURep (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 21 Aug 2021 13:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhHURen (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 21 Aug 2021 13:34:43 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD23C061575;
        Sat, 21 Aug 2021 10:34:03 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id j12so8475978ljg.10;
        Sat, 21 Aug 2021 10:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IFNRcLXLjPsNOEY9uO49C8t2A331d7150PuMHBQ0iTI=;
        b=lUVy4r6EmCBUpkDfMifythiDTY/ondphd036uPMFa4RPvNLeL6L40wQqqsFEgfXx8X
         Xv7fDSH9MFGejR5k7WM2poITA05adirsqndUU8tLGvhp1bdvOoFZ+7h2u5kG5XUcYFy9
         YYZ9RqbElnB30bSXB1sTyZl+hy+cJ0JcScyJ7QYmzB7PI51NAqS1AKqC3e23DQIKFKMJ
         vLHVB8vLS51zw87ZvMLpqT5wkQu3NhsmaQ7Su/ZSfv0KWiuLLYyPme5jEBcvbTwStA3/
         KYZEiyZqnUMKaYYL1Y2Yeo4oE90zbAqGujX97l8WdEzhHbX0b72VQTFvODB/2MJ2eEW4
         tGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IFNRcLXLjPsNOEY9uO49C8t2A331d7150PuMHBQ0iTI=;
        b=bkd6giQVKttzqezpWvLaChF+M90adpYKHN9Mxf+KyBRcObfc5LqEOrFa1BE39SkZ7U
         Uj1SrkIgHBooKLO7xvRrmfZjUXUwiF74YCow4UrN/80SVFFS4lBrgHGmY3hM+mzqPSdU
         JdYpAT0vEAjqr43tpv3QPZBSyzznM30g86TUZMljm6IsI3MDSmEG2ZYCWEt/uG/yUpSK
         YlkWxW/VZ+6q6ByrJDBaohjH/VbrofqJG1H+OlsgPEPxVvYntT8ZPuaaUkrtutXR5zCn
         UFcmHPpDhGYoYQ7RHpQOK4JzJ7CyM7tOXqf9WAcWh/dJRtmRJHsL76WwXnsZMBKaIrJ+
         8aSA==
X-Gm-Message-State: AOAM533Uw7S4+7hyu5aSVCL05JgwwaEjtAknTOwxP/zcZhST3GagzHfP
        bYnZ1yABsCW/w19Ia+vfr98JjQLFX84=
X-Google-Smtp-Source: ABdhPJyO9VF4ra6RvNiH6n/UUkOW+Qh3yY6M28atOYzpaWkyjml2dkwAfMgDWLgva7AcA19E18buOw==
X-Received: by 2002:a2e:a606:: with SMTP id v6mr20443277ljp.366.1629567242153;
        Sat, 21 Aug 2021 10:34:02 -0700 (PDT)
Received: from [192.168.2.145] (46-138-120-72.dynamic.spd-mgts.ru. [46.138.120.72])
        by smtp.googlemail.com with ESMTPSA id d14sm966993lfq.195.2021.08.21.10.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 10:34:01 -0700 (PDT)
Subject: Re: [PATCH v8 01/34] opp: Add dev_pm_opp_sync() helper
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
References: <20210818043131.7klajx6drvvkftoc@vireshk-i7>
 <a2a3c41f-c5e4-ee7e-7d48-03af8bac8863@gmail.com>
 <20210818045307.4brb6cafkh3adjth@vireshk-i7>
 <080469b3-612b-3a34-86e5-7037a64de2fe@gmail.com>
 <20210818055849.ybfajzu75ecpdrbn@vireshk-i7>
 <f1c76f23-086d-ef36-54ea-0511b0ebe0e1@gmail.com>
 <20210818062723.dqamssfkf7lf7cf7@vireshk-i7>
 <CAPDyKFrZqWtZOp4MwDN6fShoLLbw5NM039bpE3-shB+fCEZOog@mail.gmail.com>
 <20210818091417.dvlnsxlgybdsn76x@vireshk-i7>
 <CAPDyKFrVxhrWGr2pKduehshpLFd_db2NTPGuD7fSqvuHeyzT4w@mail.gmail.com>
 <20210818095044.e2ntsm45h5cddk7s@vireshk-i7>
 <CAPDyKFrFF00xGDWPCQnPwF0_QkG4TB2UqggpuBpp8LY_CMKP-A@mail.gmail.com>
 <0354acbe-d856-4040-f453-8e8164102045@gmail.com>
 <CAPDyKFoQdn1rm91iFNJwZwpSYcKJBjDLqtJB4KZAkhgY1Grm-Q@mail.gmail.com>
 <87073fc2-d7b3-98f4-0067-29430ea2adef@gmail.com>
 <CAPDyKFqSsAk8a5CTNpRT2z4Wvf8BehJKDbVhUKfHc2Jzj7aTNA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9129a9f0-8c9b-d8e0-ddf5-c8820871fb7f@gmail.com>
Date:   Sat, 21 Aug 2021 20:34:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqSsAk8a5CTNpRT2z4Wvf8BehJKDbVhUKfHc2Jzj7aTNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

20.08.2021 15:42, Ulf Hansson пишет:
> On Thu, 19 Aug 2021 at 21:35, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 19.08.2021 16:07, Ulf Hansson пишет:
>>> On Wed, 18 Aug 2021 at 17:43, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> 18.08.2021 13:08, Ulf Hansson пишет:
>>>>> On Wed, 18 Aug 2021 at 11:50, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>>>>
>>>>>> On 18-08-21, 11:41, Ulf Hansson wrote:
>>>>>>> On Wed, 18 Aug 2021 at 11:14, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>>>>>> What we need here is just configure. So something like this then:
>>>>>>>>
>>>>>>>> - genpd->get_performance_state()
>>>>>>>>   -> dev_pm_opp_get_current_opp() //New API
>>>>>>>>   -> dev_pm_genpd_set_performance_state(dev, current_opp->pstate);
>>>>>>>>
>>>>>>>> This can be done just once from probe() then.
>>>>>>>
>>>>>>> How would dev_pm_opp_get_current_opp() work? Do you have a suggestion?
>>>>>>
>>>>>> The opp core already has a way of finding current OPP, that's what
>>>>>> Dmitry is trying to use here. It finds it using clk_get_rate(), if
>>>>>> that is zero, it picks the lowest freq possible.
>>>>>>
>>>>>>> I am sure I understand the problem. When a device is getting probed,
>>>>>>> it needs to consume power, how else can the corresponding driver
>>>>>>> successfully probe it?
>>>>>>
>>>>>> Dmitry can answer that better, but a device doesn't necessarily need
>>>>>> to consume energy in probe. It can consume bus clock, like APB we
>>>>>> have, but the more energy consuming stuff can be left disabled until
>>>>>> the time a user comes up. Probe will just end up registering the
>>>>>> driver and initializing it.
>>>>>
>>>>> That's perfectly fine, as then it's likely that it won't vote for an
>>>>> OPP, but can postpone that as well.
>>>>>
>>>>> Perhaps the problem is rather that the HW may already carry a non-zero
>>>>> vote made from a bootloader. If the consumer driver tries to clear
>>>>> that vote (calling dev_pm_opp_set_rate(dev, 0), for example), it would
>>>>> still not lead to any updates of the performance state in genpd,
>>>>> because genpd internally has initialized the performance-state to
>>>>> zero.
>>>>
>>>> We don't need to discover internal SoC devices because we use
>>>> device-tree on ARM. For most devices power isn't required at a probe
>>>> time because probe function doesn't touch h/w at all, thus devices are
>>>> left in suspended state after probe.
>>>>
>>>> We have three components comprising PM on Tegra:
>>>>
>>>> 1. Power gate
>>>> 2. Clock state
>>>> 3. Voltage state
>>>>
>>>> GENPD on/off represents the 'power gate'.
>>>>
>>>> Clock and reset are controlled by device drivers using clk and rst APIs.
>>>>
>>>> Voltage state is represented by GENPD's performance level.
>>>>
>>>> GENPD core assumes that at a first rpm-resume of a consumer device, its
>>>> genpd_performance=0. Not true for Tegra because h/w of the device is
>>>> preconfigured to a non-zero perf level initially, h/w may not support
>>>> zero level at all.
>>>
>>> I think you may be misunderstanding genpd's behaviour around this, but
>>> let me elaborate.
>>>
>>> In genpd_runtime_resume(), we try to restore the performance state for
>>> the device that genpd_runtime_suspend() *may* have dropped earlier.
>>> That means, if genpd_runtime_resume() is called prior
>>> genpd_runtime_suspend() for the first time, it means that
>>> genpd_runtime_resume() will *not* restore a performance state, but
>>> instead just leave the performance state as is for the device (see
>>> genpd_restore_performance_state()).
>>>
>>> In other words, a consumer driver may use the following sequence to
>>> set an initial performance state for the device during ->probe():
>>>
>>> ...
>>> rate = clk_get_rate()
>>> dev_pm_opp_set_rate(rate)
>>>
>>> pm_runtime_enable()
>>> pm_runtime_resume_and_get()
>>> ...
>>>
>>> Note that, it's the consumer driver's responsibility to manage device
>>> specific resources, in its ->runtime_suspend|resume() callbacks.
>>> Typically that means dealing with clock gating/ungating, for example.
>>>
>>> In the other scenario where a consumer driver prefers to *not* call
>>> pm_runtime_resume_and_get() in its ->probe(), because it doesn't need
>>> to power on the device to complete probing, then we don't want to vote
>>> for an OPP at all - and we also want the performance state for the
>>> device in genpd to be set to zero. Correct?
>>
>> Yes
>>
>>> Is this the main problem you are trying to solve, because I think this
>>> doesn't work out of the box as of today?
>>
>> The main problem is that the restored performance state is zero for the
>> first genpd_runtime_resume(), while it's not zero from the h/w perspective.
> 
> This should not be a problem, but can be handled by the consumer driver.
> 
> genpd_runtime_resume() calls genpd_restore_performance_state() to
> restore a performance state for the device. However, in the scenario
> you describe, "gpd_data->rpm_pstate" is zero, which makes
> genpd_restore_performance_state() to just leave the device's
> performance state as is - it will *not* restore the performance state
> to zero.
> 
> To make the consumer driver deal with this, it would need to call
> dev_pm_opp_set_rate() from within its ->runtime_resume() callback.
> 
>>
>>> There is another concern though, but perhaps it's not a problem after
>>> all. Viresh told us that dev_pm_opp_set_rate() may turn on resources
>>> like clock/regulators. That could certainly be problematic, in
>>> particular if the device and its genpd have OPP tables associated with
>>> it and the consumer driver wants to follow the above sequence in
>>> probe.
>>
>> dev_pm_opp_set_rate() won't enable clocks and regulators, but it may
>> change the clock rate and voltage. This is also platform/driver specific
>> because it's up to OPP user how to configure OPP table. On Tegra we only
>> assign clock to OPP table, regulators are unused.
>>
>>> Viresh, can you please chime in here and elaborate on some of the
>>> magic happening behind dev_pm_opp_set_rate() API - is there a problem
>>> here or not?
>>>
>>>>
>>>> GENPD core assumes that consumer devices can work at any performance
>>>> level. Not true for Tegra because voltage needs to be set in accordance
>>>> to the clock rate before clock is enabled, otherwise h/w won't work
>>>> properly, perhaps clock may be unstable or h/w won't be latching.
>>>
>>> Correct. Genpd relies on the callers to use the OPP framework if there
>>> are constraints like you describe above.
>>>
>>> That said, it's not forbidden for a consumer driver to call
>>> dev_pm_genpd_set_performance_state() directly, but then it better
>>> knows exactly what it's doing.
>>>
>>>>
>>>> Performance level should be set to 0 while device is suspended.
>>>
>>> Do you mean system suspend or runtime suspend? Or both?
>>
>> Runtime suspend.
> 
> Alright. So that's already taken care of for us in genpd_runtime_suspend().
> 
> Or perhaps you have discovered some problem with this?
> 
>>
>>>> Performance level needs to be bumped on rpm-resume of a device in
>>>> accordance to h/w state before hardware is enabled.
>>>
>>> Assuming there was a performance state set for the device when
>>> genpd_runtime_suspend() was called, genpd_runtime_resume() will
>>> restore that state according to the sequence you described.
>>
>> What do you think about adding API that will allow drivers to explicitly
>> set the restored performance state of a power domain?
>>
>> Another option could be to change the GENPD core, making it to set the
>> rpm_pstate when dev_pm_genpd_set_performance_state(dev) is invoked and
>> device is rpm-suspended, instead of calling the
>> genpd->set_performance_state callback.
>>
>> Then drivers will be able to sync the perf state at a probe time.
>>
>> What do you think?
> 
> I don't think it's needed, see my reply earlier above. However your
> change touches another problem though, see below.
> 
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index a934c679e6ce..cc15ab9eacc9 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -435,7 +435,7 @@ static void genpd_restore_performance_state(struct
>> device *dev,
>>  int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int
>> state)
>>  {
>>         struct generic_pm_domain *genpd;
>> -       int ret;
>> +       int ret = 0;
>>
>>         genpd = dev_to_genpd_safe(dev);
>>         if (!genpd)
>> @@ -446,7 +446,10 @@ int dev_pm_genpd_set_performance_state(struct
>> device *dev, unsigned int state)
>>                 return -EINVAL;
>>
>>         genpd_lock(genpd);
>> -       ret = genpd_set_performance_state(dev, state);
>> +       if (pm_runtime_suspended(dev))
>> +               dev_gpd_data(dev)->rpm_pstate = state;
>> +       else
>> +               ret = genpd_set_performance_state(dev, state);
>>         genpd_unlock(genpd);
> 
> This doesn't work for all cases. For example, when a consumer driver
> deploys runtime PM support in its ->probe() according to the below
> sequence:
> 
> ...
> dev_pm_opp_set_rate(rate)
> pm_runtime_get_noresume()
> pm_runtime_set_active()
> pm_runtime_enable()
> ...
> pm_runtime_put()
> ...
> 
> We need to call genpd_set_performance_state() independently of whether
> the device is runtime suspended or not.

I don't see where is the problem in yours example.

pm_runtime_suspended() = false while RPM is disabled. When device is
resumed, the rpm_pstate=0, so it won't change the pstate on resume.

> Although, it actually seems like good idea to update
> dev_gpd_data(dev)->rpm_pstate = state here, as to make sure
> genpd_runtime_resume() doesn't restore an old/invalid value that was
> saved while dropping the performance state vote for the device in
> genpd_runtime_suspend() earlier.
> 
> Let me send a patch for this shortly, to close this window of a possible error.

It will also remove the need to resume device just to change the clock
rate, like I needed to do it in the PWM patch of this series.
