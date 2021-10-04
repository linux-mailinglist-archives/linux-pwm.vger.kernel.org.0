Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A66421336
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Oct 2021 17:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbhJDP7F (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 Oct 2021 11:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbhJDP7E (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Oct 2021 11:59:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A8EC061745;
        Mon,  4 Oct 2021 08:57:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id e15so73647536lfr.10;
        Mon, 04 Oct 2021 08:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oXxI7X/1bkoyfWLqsQl0b8N5L2M43qDxOhyRLjNgwgs=;
        b=pH5gGGqkZlMuFnRyIJAXiewuWBbmrXc4nrj48Dzw+Xc6gukr3JlL4bc0XqPdYPe5DQ
         NDB4vv+qA4gvKAo7lM0mnIDk8dHTj89Skv+bi+CnIwKoB0GbtflokeLFAGWMWBkGuUwO
         vnV+cxSUarX4fvwMNp98YdWmdtdCmVfrq9kQiTD/iscLYeiALsQL/FGXMsD8gWDMtQgb
         SdntlSYjQY8VC2aw+ENPn0LFmLD5mx6hdBsOFMb8vi+SpeKciwoN3fNZiNgmP/61OVVQ
         wnD2qG3x98rXnlrsSFT8O6Xj/b7E6uaK2TJJmtNceUOe0ut/Z6O07eTqHqNZmJmGlly8
         1zZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oXxI7X/1bkoyfWLqsQl0b8N5L2M43qDxOhyRLjNgwgs=;
        b=QQ9WkcJSRIIDfAKEViFn8odN8m6sW2AcT33Ny0B7YDP5A4VQ81xIgQqxi4C6wDMXPR
         uNmNAy/RH03b3YjBS31LpJ9OIpXzOG8p1dkPF3CbPnI1UxA03hcyqiiVyAUECWHidBP6
         SBTmsKbCWrJV94tEBqMc9dERYhtnwTKo8074npB1WNZeZP5zsYAVOkIHNwrZmZr36BS0
         7rsn5SQiYpJRQiPJUwT7Jz0NmMeIktq8LmsEaZ1jf2674GxgGYkzmyCjCA3H5Ce0Tsfm
         /ZkyShA9tanplHheIECAepB97n3lQ8uNY+xtaBIHXcM4WmrkSTSxMn9pWkO3unBBOH0f
         2aRg==
X-Gm-Message-State: AOAM531WtDx9XxSj2lAy81T91jDuTqUOVELcm5PFwqxYmTwmzMvMcGFO
        J3elyH6NxSZzGNZNv82xEow=
X-Google-Smtp-Source: ABdhPJwVBnc7vV9bh5UvETfiXZp05qVUc3d2AIsNbe2sLzFhSwuNlbIJLQFDdKH2jbPpxZ0FciK83w==
X-Received: by 2002:a05:6512:31c1:: with SMTP id j1mr15924982lfe.442.1633363033096;
        Mon, 04 Oct 2021 08:57:13 -0700 (PDT)
Received: from [192.168.2.145] (79-139-163-57.dynamic.spd-mgts.ru. [79.139.163.57])
        by smtp.googlemail.com with ESMTPSA id l9sm886038lje.32.2021.10.04.08.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 08:57:12 -0700 (PDT)
Subject: Re: [PATCH v13 13/35] drm/tegra: gr2d: Support generic power domain
 and runtime PM
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
References: <20210926224058.1252-1-digetx@gmail.com>
 <20210926224058.1252-14-digetx@gmail.com>
 <CAPDyKFpzhv1UxjM0q5AWHVxTWC_cCO_Kg_6exO0o_=EoVvjo+w@mail.gmail.com>
 <aad7a508-7fb5-3418-f902-def80c365094@gmail.com>
 <CAPDyKFppSuP6FfaBaGn3o+8WvTT=vJ8XMzZ47WPQ1JKiUYyEpw@mail.gmail.com>
 <8d75436d-864a-7ce0-ba53-daa8b663035a@gmail.com>
 <CAPDyKFpqs5gUcym4q+GuiJy13eXqjEnx-eFdUT4bQpcfPAOEYw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f5b5e06a-71ed-1250-f0ad-692062e00e01@gmail.com>
Date:   Mon, 4 Oct 2021 18:57:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpqs5gUcym4q+GuiJy13eXqjEnx-eFdUT4bQpcfPAOEYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

04.10.2021 14:01, Ulf Hansson пишет:
> On Fri, 1 Oct 2021 at 21:00, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 01.10.2021 17:55, Ulf Hansson пишет:
>>> On Fri, 1 Oct 2021 at 16:29, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> 01.10.2021 16:39, Ulf Hansson пишет:
>>>>> On Mon, 27 Sept 2021 at 00:42, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>>>
>>>>>> Add runtime power management and support generic power domains.
>>>>>>
>>>>>> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
>>>>>> Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
>>>>>> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
>>>>>> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/tegra/gr2d.c | 155 +++++++++++++++++++++++++++++++++--
>>>>>
>>>>> [...]
>>>>>
>>>>>>  static int gr2d_remove(struct platform_device *pdev)
>>>>>> @@ -259,15 +312,101 @@ static int gr2d_remove(struct platform_device *pdev)
>>>>>>                 return err;
>>>>>>         }
>>>>>>
>>>>>> +       pm_runtime_dont_use_autosuspend(&pdev->dev);
>>>>>> +       pm_runtime_disable(&pdev->dev);
>>>>>
>>>>> There is no guarantee that the ->runtime_suspend() has been invoked
>>>>> here, which means that clock may be left prepared/enabled beyond this
>>>>> point.
>>>>>
>>>>> I suggest you call pm_runtime_force_suspend(), instead of
>>>>> pm_runtime_disable(), to make sure that gets done.
>>>>
>>>> The pm_runtime_disable() performs the final synchronization, please see [1].
>>>>
>>>> [1]
>>>> https://elixir.bootlin.com/linux/v5.15-rc3/source/drivers/base/power/runtime.c#L1412
>>>
>>> pm_runtime_disable() end up calling _pm_runtime_barrier(), which calls
>>> cancel_work_sync() if dev->power.request_pending has been set.
>>>
>>> If the work that was punted to the pm_wq in rpm_idle() has not been
>>> started yet, we end up just canceling it. In other words, there are no
>>> guarantees it runs to completion.
>>
>> You're right. Although, in a case of this particular patch, the syncing
>> is actually implicitly done by pm_runtime_dont_use_autosuspend().
>>
>> But for drivers which don't use auto-suspend, there is no sync. This
>> looks like a disaster, it's a very common pattern for drivers to
>> 'put+disable'.
>>
>>> Moreover, use space may have bumped the usage count via sysfs for the
>>> device (pm_runtime_forbid()) to keep the device runtime resumed.
>>
>> Right, this is also a disaster in a case of driver removal.
>>
>>>> Calling pm_runtime_force_suspend() isn't correct because each 'enable'
>>>> must have the corresponding 'disable'. Hence there is no problem here.
>>>
>>> pm_runtime_force_suspend() calls pm_runtime_disable(), so I think that
>>> should be fine. No?
>>
>> [adding Rafael]
>>
>> Rafael, could you please explain how drivers are supposed to properly
>> suspend and disable RPM to cut off power and reset state that was
>> altered by the driver's resume callback? What we're missing? Is Ulf's
>> suggestion acceptable?
>>
>> The RPM state of a device is getting reset on driver's removal, hence
>> all refcounts that were bumped by the rpm-resume callback of the device
>> driver will be screwed up if device is kept resumed after removal. I
>> just verified that it's true in practice.
> 
> Note that, what makes the Tegra drivers a bit special is that they are
> always built with CONFIG_PM being set (selected from the "SoC"
> Kconfig).
> 
> Therefore, pm_runtime_force_suspend() can work for some of these
> cases. Using this, would potentially avoid the driver from having to
> runtime resume the device in ->remove(), according to the below
> generic sequence, which is used in many drivers.
> 
> pm_runtime_get_sync()
> clk_disable_unprepare() (+ additional things to turn off the device)
> pm_runtime_disable()
> pm_runtime_put_noidle()

It's not a problem to change this patchset. The problem is that if
you'll grep mainline for 'pm_runtime_disable', you will find that there
are a lot of drivers in a potential trouble.

I'm proposing that we should change pm_runtime_disable() to perform the
syncing with this oneliner:

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index ec94049442b9..5c9f28165824 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1380,6 +1380,8 @@ EXPORT_SYMBOL_GPL(pm_runtime_barrier);
  */
 void __pm_runtime_disable(struct device *dev, bool check_resume)
 {
+	flush_work(&dev->power.work);
+
 	spin_lock_irq(&dev->power.lock);

 	if (dev->power.disable_depth > 0) {

Objections?

The sysfs rpm-forbid is a separate problem and it's less troublesome
since it requires root privileges. It's also not something that
userspace touches casually. For now I don't know what could be done
about it.
