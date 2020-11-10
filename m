Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CA22AE226
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Nov 2020 22:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgKJVun (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Nov 2020 16:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgKJVum (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Nov 2020 16:50:42 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56985C0613D1;
        Tue, 10 Nov 2020 13:50:42 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id v18so16546150ljc.3;
        Tue, 10 Nov 2020 13:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QumWPjldyhkIYYrKZybLDjf0NEcp9tE/cFj+ALYFR9A=;
        b=JajzXzj+taW37LHKKk1rBUu2Z4ElUMNSSHS0K95OnI5UImwAIF74Qu+QTmiVzypvAS
         gAQiDrdU4a2B6Z9A/XX/OOpJu3zamPLYGVpiOdVUDJw7ZsRpBauLkm/3QQp5PvJ2UM4A
         LlfneuREhApeooZpB9lnnAX6U7j1XdRX88sCUzdxugTvIG1jP5PTHJPC3/8IUgW/bc/i
         LWgLoXa7caMAbqITehUnmz/UH2tBulw/gQUU8Cd3shJtQ+zvYfoUG1N8jDZq2ZIllOe/
         aCD81lT6Dj2NRU8sGRrZHHc26lsCxBQnWNgpAjWLB1z+6WE0AmdSq+A5dXHYbs0KDWUd
         P/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QumWPjldyhkIYYrKZybLDjf0NEcp9tE/cFj+ALYFR9A=;
        b=KtRbblHfKi1Ay5PEaAn1KZJFAZ3msWs02D6BzwC7cpXqRlnOnvOsDkoWebzQgSmqRn
         D0/46SSJdZtmRc8TYtLDSTqBcdmtD/q0X84oyL6u/lKoxtv+nppRHfvWEano4m6qmEmi
         rXQQvksoL6RzOfdbBrJHfSycz4On2/LJmHdR2XfZTqHuG++IzKFo82z+nNIQWQIJJ+gC
         z54/p8NqoA0PQEl1qM9KDrr6k3p55B55fy5vJteEuIRfeWw9c+VaI4mYgd82bPDT/auF
         QrpRkldWJXDRAM45Qad3pyoo7E/xRG8TWtB25rXPHZpkOFrL4IPkA2bBj06S5X6rNR1s
         bjyg==
X-Gm-Message-State: AOAM532fAQDNrGzkhk75e2G6DC7w9w8rVE8dImJHRYvrpFlR5L1Yu6V0
        q6s7cZc8D4FtniHhyZAm0VzFtSlyNKo=
X-Google-Smtp-Source: ABdhPJxca3fiSpZnzLwSSmf1STAmFU4WFUoLoBVs2ZCeEEkdDu9neVJtNB2ucZnGCMuP/Af+mNHRXw==
X-Received: by 2002:a2e:9583:: with SMTP id w3mr9542353ljh.25.1605045040627;
        Tue, 10 Nov 2020 13:50:40 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id x9sm12074lfg.93.2020.11.10.13.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 13:50:39 -0800 (PST)
Subject: Re: [PATCH v1 11/30] drm/tegra: dc: Support OPP and SoC core voltage
 scaling
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
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
        linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-12-digetx@gmail.com> <20201110202945.GF2375022@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7b0052e1-0ea7-b28f-ae46-52e669a980ac@gmail.com>
Date:   Wed, 11 Nov 2020 00:50:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201110202945.GF2375022@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

10.11.2020 23:29, Thierry Reding пишет:
>> +	/* legacy device-trees don't have OPP table */
>> +	if (!device_property_present(dc->dev, "operating-points-v2"))
>> +		return 0;
> "Legacy" is a bit confusing here. For one, no device trees currently
> have these tables and secondly, for newer SoCs we may never need them.
> 

I had the same thought and already improved such comments a day ago.
