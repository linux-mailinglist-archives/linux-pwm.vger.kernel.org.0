Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268EB41F542
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Oct 2021 21:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355164AbhJATB5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 1 Oct 2021 15:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355112AbhJATB4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 1 Oct 2021 15:01:56 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C05AC06177E;
        Fri,  1 Oct 2021 12:00:12 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b20so42697028lfv.3;
        Fri, 01 Oct 2021 12:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e6gi0M/AqEbA7u3btM50oJv1wsjKr2syx1Jco1Jlq6c=;
        b=FAGbn4qSG8KlBDD00DSO8AFyqWHWvqs1m1gB5jMoP74MuYCbf5S0w4PCLfyLW/PKuk
         0PeEopSb+SMk/Po1VQtUDjZ2//xAQuYY7ezbPcxwU3pxjedXonVKrhplqAX4/A+whxQC
         Vm+24lhxFRzfPJvfB1g2KqNBWYxrF6YEQL4+cF76ZHLvZNFNvixtmd3hLckVq13kaFSr
         sBDrz9/D3MP5jZbXKqJehZgAZPCoRK7il91MQAZ5QkO7+OWVSkB3uKA67Ss+I1T5KKVM
         SG/tUl4bKpP05yxobSJjOUeHgYrApJi8HaKmllINb+YmbwMDq8i6CdSynRfQdvwj5dfW
         b4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e6gi0M/AqEbA7u3btM50oJv1wsjKr2syx1Jco1Jlq6c=;
        b=tqs1hksmGYt4ybvr6hNLwEJ+WqXiwHbCH675e8dr72qZELWFuW+R9yE292LtJccnSN
         /29n8ya9UaQ9BV15XJOfsrT3KQgMqZ623s00lcb41jMgdp0uuVsxHc8dxaAozDz2Zo+i
         BKGocFdWy0Ilx7GQDgtKATaJShAIvVi8NToq5t5u1aXFPCEfGCP+jKAaIaYw3at3PIf9
         U4q8TNAD1BiIDM78QpNzTgSraQ2MeTPOjezUQD983kSmgF4RRW80d4hb+ZcJ82KVTml4
         CQ53OIAKFor87pNP8XCA/FO30wKmPHimRQmYE68XS+r1JH7O8RnZDNoV7nQoKdVhbgEz
         AJVw==
X-Gm-Message-State: AOAM533yFdQs4Gyc6FkA83s35t/SylLk5vuylrSDrGO9EnSJaXfEWNaK
        XIKwAaPDbJ+oTMZDzrpaEXU=
X-Google-Smtp-Source: ABdhPJy1oSJ9yS1MaBKIwPeslGW2FPitJ2Zo2pJgC8IK1+6k8OKnhiFrQSrQ349eR2y3eq9o8WlyQg==
X-Received: by 2002:a05:6512:238e:: with SMTP id c14mr6922750lfv.19.1633114810476;
        Fri, 01 Oct 2021 12:00:10 -0700 (PDT)
Received: from [192.168.2.145] (79-139-163-198.dynamic.spd-mgts.ru. [79.139.163.198])
        by smtp.googlemail.com with ESMTPSA id c3sm479665ljh.58.2021.10.01.12.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 12:00:09 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8d75436d-864a-7ce0-ba53-daa8b663035a@gmail.com>
Date:   Fri, 1 Oct 2021 22:00:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFppSuP6FfaBaGn3o+8WvTT=vJ8XMzZ47WPQ1JKiUYyEpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

01.10.2021 17:55, Ulf Hansson пишет:
> On Fri, 1 Oct 2021 at 16:29, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 01.10.2021 16:39, Ulf Hansson пишет:
>>> On Mon, 27 Sept 2021 at 00:42, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> Add runtime power management and support generic power domains.
>>>>
>>>> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
>>>> Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
>>>> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
>>>> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/gpu/drm/tegra/gr2d.c | 155 +++++++++++++++++++++++++++++++++--
>>>
>>> [...]
>>>
>>>>  static int gr2d_remove(struct platform_device *pdev)
>>>> @@ -259,15 +312,101 @@ static int gr2d_remove(struct platform_device *pdev)
>>>>                 return err;
>>>>         }
>>>>
>>>> +       pm_runtime_dont_use_autosuspend(&pdev->dev);
>>>> +       pm_runtime_disable(&pdev->dev);
>>>
>>> There is no guarantee that the ->runtime_suspend() has been invoked
>>> here, which means that clock may be left prepared/enabled beyond this
>>> point.
>>>
>>> I suggest you call pm_runtime_force_suspend(), instead of
>>> pm_runtime_disable(), to make sure that gets done.
>>
>> The pm_runtime_disable() performs the final synchronization, please see [1].
>>
>> [1]
>> https://elixir.bootlin.com/linux/v5.15-rc3/source/drivers/base/power/runtime.c#L1412
> 
> pm_runtime_disable() end up calling _pm_runtime_barrier(), which calls
> cancel_work_sync() if dev->power.request_pending has been set.
> 
> If the work that was punted to the pm_wq in rpm_idle() has not been
> started yet, we end up just canceling it. In other words, there are no
> guarantees it runs to completion.

You're right. Although, in a case of this particular patch, the syncing
is actually implicitly done by pm_runtime_dont_use_autosuspend().

But for drivers which don't use auto-suspend, there is no sync. This
looks like a disaster, it's a very common pattern for drivers to
'put+disable'.

> Moreover, use space may have bumped the usage count via sysfs for the
> device (pm_runtime_forbid()) to keep the device runtime resumed.

Right, this is also a disaster in a case of driver removal.

>> Calling pm_runtime_force_suspend() isn't correct because each 'enable'
>> must have the corresponding 'disable'. Hence there is no problem here.
> 
> pm_runtime_force_suspend() calls pm_runtime_disable(), so I think that
> should be fine. No?

[adding Rafael]

Rafael, could you please explain how drivers are supposed to properly
suspend and disable RPM to cut off power and reset state that was
altered by the driver's resume callback? What we're missing? Is Ulf's
suggestion acceptable?

The RPM state of a device is getting reset on driver's removal, hence
all refcounts that were bumped by the rpm-resume callback of the device
driver will be screwed up if device is kept resumed after removal. I
just verified that it's true in practice.
