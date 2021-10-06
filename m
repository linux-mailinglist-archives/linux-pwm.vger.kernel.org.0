Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB726424A7D
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Oct 2021 01:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhJFXXa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 6 Oct 2021 19:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhJFXX3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 6 Oct 2021 19:23:29 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0962CC061746;
        Wed,  6 Oct 2021 16:21:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u18so16621926lfd.12;
        Wed, 06 Oct 2021 16:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a/ql+r46Ame/CsYV0fgunPq11GmpNhDml+WxJj5qjlw=;
        b=JKm7LKBrYq3LrZ9P4TjFV0xnEVV5oFhCjO8jq6QK7r2sFfCeLaVeWur8vvLPj+bcOK
         3ijaiGyLljSMAfPZa/VEYRjgPnOewdTfLJQxCvN+JoRDS0HLgzZ/q74pg+AjPcazOz5n
         Ojaq8PwZPy62kphplYEz4vipCog/VV6Km3G5D02Il8G/wXPvM3NBBGINMv+/vd2EsRW/
         ycYWRLlWm7GUP5avwqaptqbxeuw3LLjZMY0lQri8idx3TDLJaVfHQvWlFwviTkzmJ6Bh
         ZAj2Z9AxhyKDP0C7wPQxPxv1LVpnFliUedydnUalNZFKZFx7963POwxq1miRructAR4w
         QIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a/ql+r46Ame/CsYV0fgunPq11GmpNhDml+WxJj5qjlw=;
        b=EBwP1BVeDqljgyEpGZ7McX+6MlY4MUSKMMfczvA0rSMoZR5X1YYPRQfbLFGSS4xLe2
         fgbjU1lG2qtYkRmvMD0zSpeCFuEiXtONKodU5p6BD/c7W6YOez8h5SxZ048dZ0aEKBHB
         9UPimE5lcm/yjMJCzpmFZcI2HAS2pMWiQ+8fxc5ZEbapDom73e61exCBmMoBhhfOb2aO
         nqUiZo74y+cV/fDQ5Q2Jk2YiVFbYvmrf9MBY2ds158DA6bWz1hjtF4mkEB/gdQ9E2prU
         2H2pzCvMegz5ritUhNhrrKYNE9UvvQrNmjN/QE9jo2BT6MenNEn8DyUgljgx13erxBAX
         Q/bA==
X-Gm-Message-State: AOAM530rnz+zWu91sWjdFfBi6VHyI1C4iQBTnepx4kBiIufJftrGR5kC
        UToaIVHa9G9tBiCTrxZC20A=
X-Google-Smtp-Source: ABdhPJw1nzydLMDqpraN/PkeCiCqMRjExYJnqaQOWQLneLDJ9G5wjD+HFXU5hLbNfgyv+WR4nF9vzQ==
X-Received: by 2002:a2e:8858:: with SMTP id z24mr902852ljj.203.1633562494365;
        Wed, 06 Oct 2021 16:21:34 -0700 (PDT)
Received: from [192.168.2.145] (79-139-163-57.dynamic.spd-mgts.ru. [79.139.163.57])
        by smtp.googlemail.com with ESMTPSA id 9sm2377459ljo.78.2021.10.06.16.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 16:21:34 -0700 (PDT)
Subject: Re: [PATCH v13 06/35] clk: tegra: Support runtime PM and power domain
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
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
 <20210926224058.1252-7-digetx@gmail.com>
 <CAPDyKFq+LS4Jr1GyC-a-tGWPzGH0JxfJ9wKY=uQEBGYm952azw@mail.gmail.com>
 <24101cd6-d3f5-1e74-db39-145ecd30418b@gmail.com>
 <CAPDyKFreK7976PJL-1zySoza_yXM7rMQ64aODWUZ+U3L-uCa0w@mail.gmail.com>
 <4bdba8a2-4b9b-ed7d-e6ca-9218d8200a85@gmail.com>
 <74a47158-e2e4-5fd0-3f37-0b50d4ead4d9@gmail.com>
 <CAPDyKFr2-f1wM+6jF9vWJ-Nq80Zg1Z3qFP6saULOrBi1270HGw@mail.gmail.com>
 <b06bf794-b8b3-417b-58ef-4d815ca86c95@gmail.com>
 <4c7b1a4c-c136-3650-8f77-9f98caa506f7@gmail.com>
Message-ID: <2dd6bffc-9817-f4b1-0b92-f82f22fcf79a@gmail.com>
Date:   Thu, 7 Oct 2021 02:21:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4c7b1a4c-c136-3650-8f77-9f98caa506f7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

07.10.2021 01:01, Dmitry Osipenko пишет:
> 07.10.2021 00:14, Dmitry Osipenko пишет:
>> 06.10.2021 15:43, Ulf Hansson пишет:
>>> On Wed, 6 Oct 2021 at 00:43, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> 06.10.2021 01:19, Dmitry Osipenko пишет:
>>>> ...
>>>>> I reproduced the OFF problem by removing the clk prepare/unprepare from
>>>>> the suspend/resume of the clk driver and making some extra changes to
>>>>> clock tree topology and etc to trigger the problem on Nexus 7.
>>>>>
>>>>> tegra-pmc 7000e400.pmc: failed to turn off PM domain heg: -13
>>>>>
>>>>> It happens from genpd_suspend_noirq() -> tegra_genpd_power_off() -> clk
>>>>> -> GENPD -> I2C -> runtime-pm.
>>>>>
>>>>> -13 is EACCES, it comes from the runtime PM of I2C device. RPM is
>>>>> prohibited/disabled during late (NOIRQ) suspend by the drivers core.
>>>>
>>>> My bad, I double-checked and it's not I2C RPM that is failing now, but
>>>> the clock's RPM [1], which is also unavailable during NOIRQ.
>>>
>>> Yes, that sounds reasonable.
>>>
>>> You would then need a similar patch for the tegra clock driver as I
>>> suggested for tegra I2C driver. That should solve the problem, I
>>> think.
>>>
>>>>
>>>> [1]
>>>> https://elixir.free-electrons.com/linux/v5.15-rc4/source/drivers/clk/clk.c#L116
>>>>
>>>> Previously it was I2C RPM that was failing in a similar way, but code
>>>> changed a tad since that time.
>>>
>>> Alright. In any case, as long as the devices gets suspended in the
>>> correct order, I think it should be fine to cook a patch along the
>>> lines of what I suggest for the I2C driver as well.
>>>
>>> It should work, I think. Although, maybe you want to avoid runtime
>>> resuming the I2C device, unless it's the device belonging to the PMIC
>>> interface, if there is a way to distinguish that for the driver.
>>
>> Ulf, thank you very much for the suggestions! I was thinking about this
>> all once again and concluded that the simplest variant will be to just
>> remove the suspend ops from the clk driver since neither of PLLs require
>> high voltage. We now have voltage bumped to a nominal level during
>> suspend by Tegra's regulator-coupler driver and it's much higher than
>> voltage needed by PLLs. So the problem I was trying to work around
>> doesn't really exist anymore.
> 
> I hurried a bit with the conclusion, keep forgetting that I need to
> change the clock tree in order to test it all properly :/ It's not fixed
> yet.
> 

Please let me iterate once again. The problem we currently have is that
clock may be enabled during NOIRQ time. In order to enable clock, it
needs to be prepared. In order to prepare clock, the clock's device
needs to be runtime-resumed. The runtime PM is unavailable at the NOIRQ
time.

To solve this problem we need to prepare clock beforehand.

The clock will stay prepared during suspend, but this is not a problem
since all the clocks we care about don't require high voltage and
voltage is guaranteed to be bumped high during suspend by Tegra's
regulator-coupler driver anyways.

So everything we need to do is to keep clocks prepared. There are two
options how to do that:

[1] this patch which explicitly prepares clocks using clk API.

[2] Use runtime PM API, like this:

static const struct dev_pm_ops tegra_clock_pm = {
	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_resume_and_get, pm_runtime_put)
};

Ulf, are you now okay with the current variant [1] of the patch or you
prefer the second [2] option more?
