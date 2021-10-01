Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C04B41F5E1
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Oct 2021 21:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhJATvy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 1 Oct 2021 15:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhJATvw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 1 Oct 2021 15:51:52 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBEEC061775;
        Fri,  1 Oct 2021 12:50:07 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x27so42934591lfu.5;
        Fri, 01 Oct 2021 12:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+3tCCW1vf690/4T30qcUTSO03STgS9Zq/gOdQmsNyEY=;
        b=lY0wpPfvEJC3ODP4sRKgGKoG8Swu6fLZXyhOhUQdBtt8vAmwxCUggKysIiRbfpVECz
         Cd3ipKChxLyI1Zlljt9jBoTItp7HmkRZNf+eWjSo0rRzLJpIXZuZSpuczURL7aSNbaxj
         i27N4TFDl5jVrgoDNEymG3WJmbBn2a47R0QIsqRS8kEVT2EURQYnYf+OZQh4u5X906wS
         OP71a4OED8ggbpaM9F9WPD+jQS6co7bb2ujJRxsbNvD0guBE62JtB6hzhNKWUuRSoEPm
         eED+tROxrUYQsEDU12h+rkOJTDJ9NZqCO/m7egmIDgFRlkZFJ+0EKU6mPddmAv9siSJx
         aPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+3tCCW1vf690/4T30qcUTSO03STgS9Zq/gOdQmsNyEY=;
        b=Z5MKWqJ44nV0FaQR+LgRdzd3D/DcVqURG5ba8wZhMGE6KgMLCzUFBhhYTmVTyQBSiM
         vNwu+vpY8LIhD+xGa9ojgjPJFqtlrkYRwnGfZtUWv+1VIWDFkOhqYXxYdF0hPJbVNetG
         S8++W0JJ0+D5pd2KnhJM23J6t6WVT9greYTkSOYvVI6IPOjq08LQViiqC/lajnFo5Q0T
         0Igx/O4Xuqs8oLbhIO6CKuvNrolM82bRTDCUffb8BmhZlj6OhSRUfUtpaKrmcpJ7OvUJ
         Y3gAkLXrodgyw33dv6gj6DADd8/B8t05KFDVKCzZE4dQQq4SWCDpv6WI8C6RCR4855K8
         rDEA==
X-Gm-Message-State: AOAM530roErC4l84PFvXKEHQXNYQSY4ucyZEkCIMviBdt0hp3MdwgF6J
        hfkgfiCo/u1AeTOnYR6Atr0=
X-Google-Smtp-Source: ABdhPJxYsYCCBKlCSGLAzxa6BXsGbqcTjHWvgb7beKpP4WisArOt1AAHN4vdv1Oz4AuVBT+h3gaDUA==
X-Received: by 2002:a2e:924d:: with SMTP id v13mr13579672ljg.380.1633117806218;
        Fri, 01 Oct 2021 12:50:06 -0700 (PDT)
Received: from [192.168.2.145] (79-139-163-198.dynamic.spd-mgts.ru. [79.139.163.198])
        by smtp.googlemail.com with ESMTPSA id d26sm835708ljj.45.2021.10.01.12.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 12:50:05 -0700 (PDT)
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
Message-ID: <7386079f-0dfe-9f55-6297-1f9ee67cd9d6@gmail.com>
Date:   Fri, 1 Oct 2021 22:50:04 +0300
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
>> +static int tegra_clock_sync_pd_state(struct tegra_clk_device *clk_dev)
>> +{
>> +       unsigned long rate;
>> +       int ret = 0;
>> +
>> +       mutex_lock(&clk_dev->lock);
>> +
>> +       if (!pm_runtime_status_suspended(clk_dev->dev)) {
>> +               rate = clk_hw_get_rate(clk_dev->hw);
>> +               ret = tegra_clock_set_pd_state(clk_dev, rate);
> Don't we need to sync the performance state even when the device is
> runtime suspended?
> 
> Perhaps the clock, via a child-clock for example, can get
> prepared/enabled (hence its device gets runtime resumed) before there
> is a clock rate update for it. Then there is no performance state set
> for it, right? Or maybe that isn't a problem?
> 

Good catch! Older versions of this patch had a special handling for clk
enable/disable. I just forgot to update this function, it's now not a
problem to change performance state of a suspended device and it
actually needs to be done. I'll correct it, thanks!
