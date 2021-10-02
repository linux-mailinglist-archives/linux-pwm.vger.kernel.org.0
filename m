Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6BD41FE14
	for <lists+linux-pwm@lfdr.de>; Sat,  2 Oct 2021 22:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhJBUqh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 2 Oct 2021 16:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbhJBUqg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 2 Oct 2021 16:46:36 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357FBC061714;
        Sat,  2 Oct 2021 13:44:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j5so48530857lfg.8;
        Sat, 02 Oct 2021 13:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T5NA95fXjewFVQZ7RXmQGjvZaYL3KLG4ILjTuHYXm9E=;
        b=VInxURP7xctDXfL0Dl1Z5iIuI8Z57STPldPnyJ+NEoakoMviQJJZLMTDvRJajSYeUA
         L6hAx+33fXvlxHQdSLAb2swwYgCSXcm4IHTOs4QNGPXy0n+3kc1PaSRsPOeccYBdBeZd
         i/GVKW6ch0QjgR5Al9izKnsKjtkLP9b6WFxxbgQj5xOtMJ+SSJ3vI3nxrqadHVRi/RnA
         W6QxtWyfIbdShJzgMDhIpqfX5qzkmNQXHlvgGM11cFUopWEMKunpWxyqUcwKJKYvFAG5
         +vztm6uVxmXOzcI8Wt5yVr3CSoQmJa2Le0PpZjwLrPdDyp4eM6GhDyuSByQAckD1zOgW
         c3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T5NA95fXjewFVQZ7RXmQGjvZaYL3KLG4ILjTuHYXm9E=;
        b=o+AkgwIXTGmhQJOReVcp/TKkZzv7PXYcfMekTaitKUtIJwq9Jx49Ek3A6rzLNWnGDw
         P14BK/n3ooXkpVEH9nCyL8FXZYN7ZEwDQcX/HwTKjBIRyMgJudlk3iv1sfciLtZTSdOR
         vwOpvOwVQIenigGsvIM5EuTWq+4BDfs+q6YQF1gWnaCKscYOjk/MGgW3xBNn8ZhUdVCZ
         7xYmRwRBj20i5ZIDmJzuKM5BziIPaasu+aA7E2ExtPF5uOYuwbOaw7T/wguPP+RgSZQ4
         IMKvmtAHcPJB8dSJI9T5/DLw2qkb2FpwIt50gSksOXa8MP0ZwlDi4BPe4g+NLYlyBgjd
         yb5A==
X-Gm-Message-State: AOAM5320QoRG2UTT3/F5jVU3Ku5BPR/cGcwERvAogi3KnHxkjgIS1xsP
        utURybmrqidGKVMJdilKdqs=
X-Google-Smtp-Source: ABdhPJzClEAya5hcn4TqFZQoHIn0mpgv86q3zG4rhbGd/Hwr0saEHFeEJIpz6XM0cCQNRVK631z4Mw==
X-Received: by 2002:a2e:80cd:: with SMTP id r13mr5454584ljg.415.1633207488462;
        Sat, 02 Oct 2021 13:44:48 -0700 (PDT)
Received: from [192.168.2.145] (94-29-52-238.dynamic.spd-mgts.ru. [94.29.52.238])
        by smtp.googlemail.com with ESMTPSA id v27sm1233535lfp.0.2021.10.02.13.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 13:44:47 -0700 (PDT)
Subject: Re: [PATCH v13 06/35] clk: tegra: Support runtime PM and power domain
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <24101cd6-d3f5-1e74-db39-145ecd30418b@gmail.com>
Date:   Sat, 2 Oct 2021 23:44:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq+LS4Jr1GyC-a-tGWPzGH0JxfJ9wKY=uQEBGYm952azw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

01.10.2021 15:32, Ulf Hansson пишет:
>> +static __maybe_unused int tegra_clock_pm_suspend(struct device *dev)
>> +{
>> +       struct tegra_clk_device *clk_dev = dev_get_drvdata(dev);
>> +
>> +       /*
>> +        * Power management of the clock is entangled with the Tegra PMC
>> +        * GENPD because PMC driver enables/disables clocks for toggling
>> +        * of the PD's on/off state.
>> +        *
>> +        * The PMC GENPD is resumed in NOIRQ phase, before RPM of the clocks
>> +        * becomes available, hence PMC can't use clocks at the early resume
>> +        * phase if RPM is involved. For example when 3d clock is enabled,
>> +        * it may enable the parent PLL clock that needs to be RPM-resumed.
>> +        *
>> +        * Secondly, the PLL clocks may be enabled by the low level suspend
>> +        * code, so we need to assume that PLL is in enabled state during
>> +        * suspend.
>> +        *
>> +        * We will keep PLLs and system clock resumed during suspend time.
>> +        * All PLLs on all SoCs are low power and system clock is always-on,
>> +        * so practically not much is changed here.
>> +        */
>> +
>> +       return clk_prepare(clk_dev->hw->clk);
> I am trying to understand, more exactly, what you intend to achieve
> with the clk_prepare() here. It looks a bit weird, to me. Can you try
> to elaborate a bit more on the use case?

The Tegra GENPD driver enable/disable clocks when domain is turned on.
This can't be done during early system resume, when domains are getting
turned on by the drivers core, because when clock is enabled, it's
getting prepared (RPM-resumed) and this preparation fails because
performance state of the clock goes up and it doesn't work during the
early resume time since I2C, which applies the state to hardware, is
suspended and can't work at that early time.

Secondly, Tegra has arch-specific low level assembly which touches
clocks during last phase of system suspend and in the beginning of
resume. Hence, clocks should stay prepared during suspend just because
technically clock should be prepared before it can be enabled.

> Is this rather about making sure that the clock's corresponding PM
> domain stays powered on during system suspend? In that case, I think
> there may be an alternative option....
> 

This is not about domain staying powered on, this is about keeping the
performance state of the domain high during suspend.
