Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC6D2A96D4
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Nov 2020 14:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgKFNRT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Nov 2020 08:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgKFNRR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Nov 2020 08:17:17 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38995C0613CF;
        Fri,  6 Nov 2020 05:17:17 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 126so1860678lfi.8;
        Fri, 06 Nov 2020 05:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PfeixKrzsL46qhVQbUUdb6DbSd1S0EMYRuybLQNU1/k=;
        b=lg3hkZm7P25mT76/EiBZKMX9rM35SHKXFtDDMNMyuybG7pZ9GLdujDnb/snXEdZuOE
         O1XEA9ClNNtaX5qSYh7ncrwbbztO4OLS1Tz0Whoh0CkglFXZtqLJZrGYf4qMX7xbO4N9
         kP0OrdkSIWnmeqH9Syo0ZE91d0lbC13DJUCcVloa24tNriQ9PbAU1usA16wtQm2RaqeB
         Q2Vze3+ENHkimZDRFaupbyfMF9A5/sjGDv24PaYkJkspH0+kyNRFWbP7C5sXzxYJK38b
         RAOCNA6IR6HuCs4WSAyuab6Hb0IKVlIorOLMIzPq7sTruYyAKH9DW8JL59OaCl/toWXN
         62hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PfeixKrzsL46qhVQbUUdb6DbSd1S0EMYRuybLQNU1/k=;
        b=Gk/3BEhWYHBYyuhetlW0n6fa7sO3UjNYkLB8/jGxYIMRBDVYIl2lB8BFPATBcXYqjQ
         rcYm3AOICNrl8l3a44FQpD5R+DQiyHZzm+GrGk2Y6cGPb5G/ZNeTLHnqcfhgiKyx540g
         2gNDJNRKbY82p/2iAZF6qJuq+SYpDIl5Q9AwhDnijGZpFfPG1lIgi6vnW/IfxjTboicl
         0vCIXmXv2KAc2fkJM2L2T1czJhakuD0qVYaTzUxaS/A8W9WEzk6or596+T6Rj/+lN/8N
         sevwbl4iU7x3n7Z98GM4jlkIHHsJDGoLXbfKpGH4qs7a7Zl/ZbITTE94w/faLEjXJkm9
         HDyQ==
X-Gm-Message-State: AOAM532D+EkPoYt8CEFxbN9QSbEGmnevZvz5MikjsbwhPH9O3CdslMR7
        wT4Mu6ANtXLKWLRgQXtkBeIPCOGFiBY=
X-Google-Smtp-Source: ABdhPJzECHN6OMSqEGY9TM6AG4zUXHGmlFcCs46h2OzcdpdI3/ezCJG0veXmwpdjSihGTDog0yaTzA==
X-Received: by 2002:a19:f518:: with SMTP id j24mr830455lfb.307.1604668635552;
        Fri, 06 Nov 2020 05:17:15 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.googlemail.com with ESMTPSA id 9sm159077lfy.251.2020.11.06.05.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 05:17:14 -0800 (PST)
Subject: Re: [PATCH v1 17/30] mmc: sdhci-tegra: Support OPP and core voltage
 scaling
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        driver-dev <devel@driverdev.osuosl.org>,
        linux-pwm@vger.kernel.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-usb@vger.kernel.org,
        "open list:SECURE DIGITAL HO..." <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-18-digetx@gmail.com>
 <CAOh2x==sy1w7_oEV8=toC6uQnSN44wyOixbP_X0BrMsnm1AUFg@mail.gmail.com>
 <6fa54ce6-d5ae-d04f-7c77-b62c148d92b7@gmail.com>
 <20201106061513.uyys7njcqcdlah67@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a6926456-8bce-a438-bfaa-be334208f004@gmail.com>
Date:   Fri, 6 Nov 2020 16:17:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201106061513.uyys7njcqcdlah67@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

06.11.2020 09:15, Viresh Kumar пишет:
> Setting regulators for count as 0 doesn't sound good to me.
> 
> But, I understand that you don't want to have that if (have_regulator)
> check, and it is a fair request. What I will instead do is, allow all
> dev_pm_opp_put*() API to start accepting a NULL pointer for the OPP
> table and fail silently. And so you won't be required to have this
> unwanted check. But you will be required to save the pointer returned
> back by dev_pm_opp_set_regulators(), which is the right thing to do
> anyways.

Perhaps even a better variant could be to add a devm versions of the OPP
API functions, then drivers won't need to care about storing the
opp_table pointer if it's unused by drivers.
