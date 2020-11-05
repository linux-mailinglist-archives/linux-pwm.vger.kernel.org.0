Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C312E2A820F
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 16:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbgKEPWQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Nov 2020 10:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbgKEPWQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Nov 2020 10:22:16 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5261BC0613CF;
        Thu,  5 Nov 2020 07:22:14 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id l10so1979097lji.4;
        Thu, 05 Nov 2020 07:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L7OVsr5m178XbCaCzAWNkdQoFi3/3zu9mN+yPgl2DUs=;
        b=ZUE+lII34sxgdJMzK2yn/f7sQCJw/4+mRXBdMBq1/bhBQWtfS/PtExzwYtktIoAWgY
         SU7g93lwJ2c7NK0CDwzeo+RytY043NhbabYKjJOBr7tIMP5wlLP/u6h82rzBRDjVxP9j
         EdnAYAZOpmyMs1GUR/kcd37x1kAewnXFex0wqQUKK37hfYXxUIOMvhuhv9Kkm4bWWj03
         NYOfuJLDcjhyyGqGtJNpIUWkJQCG6veMjv1sZZ5dae38lEVIkii3wjlD54ZKITpqpnKX
         8VoeiDhs1BxqGTAhX5SPmAP4HQXgACk2ac5ePAi3NeEKCHu2erytV3AEJlNMrsBJq5S8
         bmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L7OVsr5m178XbCaCzAWNkdQoFi3/3zu9mN+yPgl2DUs=;
        b=twh5NJEnuJ62dpTxoXovRD4gCmY0BG4D9sS+edVQQaMZPACU1iuomMN04SrNwtNh22
         xGgIaIIGj3vyBZ9oADNuwuwDVf+fnX79IRtDyPVBi0M7BStghUDNZRkAK7Of7dOgEVq2
         SIFpM8RU39rOH0UKaL6zhX5IarWKE5o/lAJs701DcXrY8D5qmZXojcDNMiGQbuL4vFlv
         8D9WQ5rOyXrCiJFoIgj2thbGswp7134dZ+pdmXKUUX7/i80MgJ+K3pCsyLmzkqt0AXue
         PI8v+6G9SRCSt0uBy0cXjRGyCVaq8m9rxGnt7vnEEBfr03P1sJFKGC2UktRMnFqD8Kr0
         RDQw==
X-Gm-Message-State: AOAM533I23gWFQ5iK/2hzADTQc84tAIocMgvEeppzzNkLTtmlUB8KQgy
        KSeJV8Z1IXgIGjbGxm2PEqKG+a1OJ9E=
X-Google-Smtp-Source: ABdhPJwC5ZQ/5zYH2nUFCy93HeDhVeV9bcOjajKeeVZadnE++shSnXPj1s2oA0r6x39bDtt0cphAoQ==
X-Received: by 2002:a2e:9a0e:: with SMTP id o14mr1127768lji.340.1604589731407;
        Thu, 05 Nov 2020 07:22:11 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.googlemail.com with ESMTPSA id 144sm176642ljj.48.2020.11.05.07.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 07:22:10 -0800 (PST)
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
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
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20201104234427.26477-1-digetx@gmail.com>
 <CAPDyKFr7qTU2RPhA_ZrbCayoTTNUEno1zdmvmv+8HBe-Owrfeg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cd147ab0-1304-a491-7a56-ee6199c02d32@gmail.com>
Date:   Thu, 5 Nov 2020 18:22:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFr7qTU2RPhA_ZrbCayoTTNUEno1zdmvmv+8HBe-Owrfeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

05.11.2020 12:45, Ulf Hansson пишет:
...
> I need some more time to review this, but just a quick check found a
> few potential issues...

Thank you for starting the review! I'm pretty sure it will take a couple
revisions until all the questions will be resolved :)

> The "core-supply", that you specify as a regulator for each
> controller's device node, is not the way we describe power domains.
> Instead, it seems like you should register a power-domain provider
> (with the help of genpd) and implement the ->set_performance_state()
> callback for it. Each device node should then be hooked up to this
> power-domain, rather than to a "core-supply". For DT bindings, please
> have a look at Documentation/devicetree/bindings/power/power-domain.yaml
> and Documentation/devicetree/bindings/power/power_domain.txt.
> 
> In regards to the "sync state" problem (preventing to change
> performance states until all consumers have been attached), this can
> then be managed by the genpd provider driver instead.

I'll need to take a closer look at GENPD, thank you for the suggestion.

Sounds like a software GENPD driver which manages clocks and voltages
could be a good idea, but it also could be an unnecessary
over-engineering. Let's see..
