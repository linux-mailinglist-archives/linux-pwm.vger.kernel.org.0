Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65EF440677
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Oct 2021 02:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhJ3AuF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Oct 2021 20:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhJ3AuE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Oct 2021 20:50:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484EFC061570;
        Fri, 29 Oct 2021 17:47:35 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f3so16051883lfu.12;
        Fri, 29 Oct 2021 17:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f5pSbol+SAUF2G8wYmgreImXVWzxTzfGDNyGdsJ8f10=;
        b=hJ0sA1OddxEXXgHAtRjweLapPZPGbqdshvcw2Tfy9OFl/PTx0w40U/IrrTLQM/cMTX
         ox8CQPPki8tD8YoFZF0hsf1jFf6kfVPY2THCC6KnWFI2fdtYLXEB4f1j57YTSjSvqe2c
         6w1+tIemGa8k9cMzH2dQ+JHG91uTiQQqymTWTYCqL7hOJVbunp9LrEGSBbRqVh1RCpCS
         3mwh7UtScoB38K50epPcxxthR91tvJN2OAjD8TKbfKQWmM0KOG0avrqe8cV7hi3XH8Cv
         knJvnQfnsA47a1NCqx/YbL5WwWv3wuR0viZJWkeRq3/RjMWgWYeLHtVAWLwbbahNa1Ix
         HVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f5pSbol+SAUF2G8wYmgreImXVWzxTzfGDNyGdsJ8f10=;
        b=IvswPj/M2m0pHaZhI4MTKtso+xWMNMIyc9X0cOzjJGZgV5Q03kWI8bbrIBJ+pWishA
         auj9HTx4XeuW4tsyi1CA26Nix5mioWBpZ6TfsBtU5JHWYNnJ/zPK5qqiKd/KXaFVpIyk
         GT36ERtRufd85nZr8J0zls+ihfxW5L1cziHRUhX1caHrK1aWKsxxeIbdQpczr+Ig0qnp
         l3j4QjkXJqwjooxHoSENOcTpL+jil2ni67TRyvMIzaGvpK3afrn9jjczD1yjTfz8MjLN
         L6MDsbYoRyoklT9Du9nWsfpQmUaApNC4drWFqKMrDNvVlnhDcneLwCP/l/LPVUqMUjXg
         yw4Q==
X-Gm-Message-State: AOAM531n8xVzXDZmSX5p62ZeFnGwYmtbVUggQ3aaIXKN4LN0hufBqnqs
        YTnIbEyohiFqmIlT90812uM=
X-Google-Smtp-Source: ABdhPJwN0ai6X/I0wUNSQY3SnGxmvAqt4rJcwlbyjjdfP8ZGvjCDVG9DD8cgqM3eMxKr7GwQw3oR3w==
X-Received: by 2002:ac2:4c9a:: with SMTP id d26mr13421192lfl.344.1635554853534;
        Fri, 29 Oct 2021 17:47:33 -0700 (PDT)
Received: from [192.168.2.145] (46-138-44-18.dynamic.spd-mgts.ru. [46.138.44.18])
        by smtp.googlemail.com with ESMTPSA id d7sm852822ljl.18.2021.10.29.17.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 17:47:24 -0700 (PDT)
Subject: Re: [PATCH v14 20/39] pwm: tegra: Add runtime PM and OPP support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
References: <20211025224032.21012-1-digetx@gmail.com>
 <20211025224032.21012-21-digetx@gmail.com>
 <09c05206-c0e5-9a25-8ffa-b9291f6ea5ae@gmail.com>
 <CAJZ5v0i9OtA1nDiv8UXuF3ASdENFYJFV7+nMWm6Pcu=kw8k1aQ@mail.gmail.com>
 <4dc8a6bd-4072-ccbf-513b-221d286bd6d5@gmail.com>
 <CAJZ5v0hKQf-xZq2fx1pA5oxMqP_XJV=AG0Rqu7BKRUZGDz6H5Q@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <72160e55-6aa5-9541-43f2-fbf025f84ffb@gmail.com>
Date:   Sat, 30 Oct 2021 03:47:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hKQf-xZq2fx1pA5oxMqP_XJV=AG0Rqu7BKRUZGDz6H5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

29.10.2021 21:06, Rafael J. Wysocki пишет:
...
>>>> I just noticed that RPM core doesn't reset RPM-enable count of a device
>>>> on driver's unbind (pm_runtime_reinit). It was a bad idea to use
>>>> devm_pm_runtime_enable() + pm_runtime_force_suspend() here, since RPM is
>>>> disabled twice on driver's removal, and thus, RPM will never be enabled
>>>> again.
>>>>
>>>> I'll fix it for PWM and other drivers in this series, in v15.
>>>
>>> Well, for the record, IMV using pm_runtime_force_suspend() is
>>> generally a questionable idea.
>>>
>>
>> Please clarify why it's a questionable idea.
> 
> There are a few reasons.
> 
> Generally speaking, it makes assumptions that may not be satisfied.
> 
> For instance, it assumes that the driver will never have to work with
> the ACPI PM domain, because the ACPI PM domain has a separate set of
> callbacks for system-wide suspend and resume and they are not the same
> as its PM-runtime callbacks, so if the driver is combined with the
> ACPI PM domain, running pm_runtime_force_suspend() may not work as
> expected.

ACPI is irrelevant to the drivers touched by this series.

This series is about older ARM32 Tegra SoCs which either don't have ACPI
at all or it's unusable by Linux, like a non-standard ACPI of M$ Surface
tablets.

> Next, it assumes that PM-runtime is actually enabled for the device
> and the RPM_STATUS of it is valid when it is running.

Runtime PM presence is mandatory for Tegra and drivers take care of
enabling it, should be good here.

> Further, it assumes that the PM-runtime suspend callback of the driver
> will always be suitable for system-wide suspend which may not be the
> case if the device can generate wakeup signals and it is not allowed
> to wake up the system from sleep by user space.

There are no such 'wakeup' drivers in the context of this patchset.

> Next, if the driver has to work with a PM domain (other than the ACPI
> one) or bus type that doesn't take the pm_runtime_force_suspend()
> explicitly into account, it may end up running the runtime-suspend
> callback provided by that entity from within its system-wide suspend
> callback which may not work as expected.

Only platform bus and generic power domain are relevant for this patchset.

> I guess I could add a few if I had to.
> 

So far I can't see any problems.

If you have a better alternative on yours mind, please share.
