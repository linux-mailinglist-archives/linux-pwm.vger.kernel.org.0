Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8AA44004C
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Oct 2021 18:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhJ2Qar (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Oct 2021 12:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhJ2Qar (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Oct 2021 12:30:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521C2C061570;
        Fri, 29 Oct 2021 09:28:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so22114843lfu.5;
        Fri, 29 Oct 2021 09:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zb37U00i0UsxFiui6h8A52VDFSlAKY4vOYHPxpea81c=;
        b=TsfcoTQsth3GMbA87xy3JOsrwOf9WUKLzUc1wq2aKb8nm+h1lWm9UwjtFcoTaGbvKe
         sQ98YEE3QTH3m8zyDHhKCFjRS2hXMx5wd8getGuez1vRzftxlQjogBvlwfvmpymu6W7T
         ySq7aJHbfubll8P5mvCIAJdENcRSriG+nWUKGt8YXm41HMxIL0jeguvwUK7okHibeY+c
         0K6K3NNXM6vt4yGO7r8IfmgknSut+OZ/JVcueYwKiXs2/OlLlWtYgatm0NmVojWdmF+O
         pSRIxigawMyoXfrvt4/Wr7uKB1Lo6pJbK/PxNamCiFzGsZ7HRRdZQvolu6lW6C5IYH0R
         hbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zb37U00i0UsxFiui6h8A52VDFSlAKY4vOYHPxpea81c=;
        b=VJSxNq2dpbVCMcLy1BDVddhbv20lG7BG4ONLR0ytGMYJU0vgqoPxgV0tDgj87A1CUL
         GrV1+cDNqlrXNTGPF3Zt8M3lJ5oee0lX0NcGLv69Mk8alFtbsNwGWRoPjylxPDubyLFW
         yoHS6jlZAF3yguWMRtVJqBC+xURnFC2VbFw5H5JhwoKz8VbIv06fpv4zKFriMvyN4qiy
         T/JQjawpcncnHWoviFVMu6ILfA/Uwkdlzzh5U/MlbIt5NjdPCvY13u5LaRh5J3xhDm+z
         vP2K9k1EZrQo6Q/6JuAiUn82OYIcmEzKuWuUk6v+uj21h6YJ7Lt07BLzFJxZAOmQOSNm
         8uTQ==
X-Gm-Message-State: AOAM532QJCRiWxRwY1ojkjPiePxR4j5lSg0r7KRRxX9uKl7k44tH/2/y
        QaQGlK8eT1Z4yFoFq45Hv/E=
X-Google-Smtp-Source: ABdhPJxqvCXUpic4tjN7rVlUMkTQZOd/62uMiYgoMdbQ434pB4vyHg9RWPIeJ8n3oYvJT9rPA0Mo5w==
X-Received: by 2002:a05:6512:230b:: with SMTP id o11mr12461455lfu.490.1635524896479;
        Fri, 29 Oct 2021 09:28:16 -0700 (PDT)
Received: from [192.168.2.145] (46-138-44-18.dynamic.spd-mgts.ru. [46.138.44.18])
        by smtp.googlemail.com with ESMTPSA id m4sm644841lfu.107.2021.10.29.09.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 09:28:16 -0700 (PDT)
Subject: Re: [PATCH v14 20/39] pwm: tegra: Add runtime PM and OPP support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20211025224032.21012-1-digetx@gmail.com>
 <20211025224032.21012-21-digetx@gmail.com>
 <09c05206-c0e5-9a25-8ffa-b9291f6ea5ae@gmail.com>
 <CAPDyKFoa5eQTrNxyiFevUCWitUecX=hi=y7qv1dC2mqk0+0XBA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a1b9d966-5eb1-da02-5e77-6fe008e0c8a2@gmail.com>
Date:   Fri, 29 Oct 2021 19:28:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoa5eQTrNxyiFevUCWitUecX=hi=y7qv1dC2mqk0+0XBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

29.10.2021 18:28, Ulf Hansson пишет:
> On Fri, 29 Oct 2021 at 17:20, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 26.10.2021 01:40, Dmitry Osipenko пишет:
>>> +     ret = devm_pm_runtime_enable(&pdev->dev);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     ret = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     ret = pm_runtime_resume_and_get(&pdev->dev);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>>       /* Set maximum frequency of the IP */
>>> -     ret = clk_set_rate(pwm->clk, pwm->soc->max_frequency);
>>> +     ret = dev_pm_opp_set_rate(pwm->dev, pwm->soc->max_frequency);
>>>       if (ret < 0) {
>>>               dev_err(&pdev->dev, "Failed to set max frequency: %d\n", ret);
>>> -             return ret;
>>> +             goto put_pm;
>>>       }
>>>
>>>       /*
>>> @@ -278,7 +294,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
>>>       if (IS_ERR(pwm->rst)) {
>>>               ret = PTR_ERR(pwm->rst);
>>>               dev_err(&pdev->dev, "Reset control is not found: %d\n", ret);
>>> -             return ret;
>>> +             goto put_pm;
>>>       }
>>>
>>>       reset_control_deassert(pwm->rst);
>>> @@ -291,10 +307,15 @@ static int tegra_pwm_probe(struct platform_device *pdev)
>>>       if (ret < 0) {
>>>               dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
>>>               reset_control_assert(pwm->rst);
>>> -             return ret;
>>> +             goto put_pm;
>>>       }
>>>
>>> +     pm_runtime_put(&pdev->dev);
>>> +
>>>       return 0;
>>> +put_pm:
>>> +     pm_runtime_put_sync_suspend(&pdev->dev);
>>> +     return ret;
>>>  }
>>>
>>>  static int tegra_pwm_remove(struct platform_device *pdev)
>>> @@ -305,20 +326,44 @@ static int tegra_pwm_remove(struct platform_device *pdev)
>>>
>>>       reset_control_assert(pc->rst);
>>>
>>> +     pm_runtime_force_suspend(&pdev->dev);
>>
>> I just noticed that RPM core doesn't reset RPM-enable count of a device
>> on driver's unbind (pm_runtime_reinit). It was a bad idea to use
>> devm_pm_runtime_enable() + pm_runtime_force_suspend() here, since RPM is
>> disabled twice on driver's removal, and thus, RPM will never be enabled
>> again.
>>
>> I'll fix it for PWM and other drivers in this series, in v15.
> 
> Good catch - and sorry for not spotting it while reviewing!
> 
> Maybe devm_pm_runtime_enable() isn't that useful after all? Should we
> suggest to remove it so others don't fall into the same trap?

devm_pm_runtime_enable() was added to the recent v5.15 kernel. It's a
useful helper, if it's used consciously. I'm not going to remove its
usage entirely from this series, for example it still should be good to
use for Tegra FUSE and HDMI drivers.
