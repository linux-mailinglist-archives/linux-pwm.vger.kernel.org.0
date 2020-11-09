Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287052AB0F6
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Nov 2020 06:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgKIFo1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Nov 2020 00:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbgKIFo0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Nov 2020 00:44:26 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB9CC0613CF;
        Sun,  8 Nov 2020 21:44:26 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id o24so2104540ljj.6;
        Sun, 08 Nov 2020 21:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tP/FC+dGBVrN2Wu8oXQnKtpDTfMWbwFyza2NqExwg6k=;
        b=MF8cnp2AWnOeOFRVEsfISikechA/Ixz1dFtKA8EgNEABu0PMsQFBkxVZC9/X6pUcCe
         YCstLNYyQSqmrwsXdkEUDWuPG5PCoO2SSVswz61RwaNiabmwuGC3EC9eP4JjZ3wJeSko
         ZGU99oWOCzpS9yRI4Ql1qoXvkCMEw6ATGuaOQwRDMWXlQinOXCPAbWDVg+WLs/w3Lpg/
         bsINkLXHuxqm/a+sc+xKKFHnEbRzewuPpyGaSTK/KxjfNRNH1n4VXkLAss2GE2604eXS
         LT8gPvlTcD+f93W5lhLaMN86VYx2ryKNggibpsCNQqOr8rlh3BYSz6umwZJS4F7Oyd+G
         m1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tP/FC+dGBVrN2Wu8oXQnKtpDTfMWbwFyza2NqExwg6k=;
        b=teCKClo76pbpCWT5cKsSECsJ9JlKEsGd3fN5XXqakrEsGIL2bEbV1CtwU8rIZev6m/
         awOcXGJ9z1kA8MrzYxhdaDDTsVxgxuGEtSbXskXLHLIHS6Ie0Ye2ARICyiv3b+2uBh8e
         ZViob4tBZ3f/qx2rLONDJ7bKo+9Oe4xS965rYaUa5EJjq9SMdi24Pa7qnPlb2Rswjxbv
         3zbn4QuXz16b5QytvFl+lkccd5nBN6AFAC4YCAnDeu4yM2I1HU23vDc8HdiHEUM6BU6Q
         JEysWNrEkK7QCpVSW/I9kc+5gMy2lZVRcZxPFOY4FYP8Rejs9rZ7wB42y2W6c2xzapNL
         /hlA==
X-Gm-Message-State: AOAM533O/uEoEuTkQ9DDu8+7iB+L+IVF0EfKnzrKpztRl635Q1GvPMlv
        cixAKIbAlM2GPNrLNcb2gVne62Gfo28=
X-Google-Smtp-Source: ABdhPJxu6oKJy+ZV+CaEDK/OMuxRF+UUWvmu4xrMjC+USQe4mAvLAS4RZx8UuslTomnJ7nU1Nr4O3g==
X-Received: by 2002:a2e:9e4b:: with SMTP id g11mr5749822ljk.337.1604900664608;
        Sun, 08 Nov 2020 21:44:24 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id 4sm1672440lfi.150.2020.11.08.21.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 21:44:23 -0800 (PST)
Subject: Re: [PATCH v1 17/30] mmc: sdhci-tegra: Support OPP and core voltage
 scaling
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Frank Lee <tiny.windzz@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
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
References: <20201104234427.26477-18-digetx@gmail.com>
 <CAOh2x==sy1w7_oEV8=toC6uQnSN44wyOixbP_X0BrMsnm1AUFg@mail.gmail.com>
 <6fa54ce6-d5ae-d04f-7c77-b62c148d92b7@gmail.com>
 <20201106061513.uyys7njcqcdlah67@vireshk-i7>
 <a6926456-8bce-a438-bfaa-be334208f004@gmail.com>
 <CAEExFWsp0DWw1yO84e3vzr_YZkqkd+pyPfQQR3J2W6n3wTX4Jw@mail.gmail.com>
 <20201109050010.g47zojh6wafvwqva@vireshk-i7>
 <c584b301-e052-7f01-335d-8f9160865198@gmail.com>
 <20201109051014.oa6bt4g3ctm2hnuy@vireshk-i7>
 <4476fed9-a356-b7f1-32ee-935343e23038@gmail.com>
 <20201109053546.xupmmsx5qccn46tr@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <33a7ad95-a8cf-7b88-0f78-09086c1a4adf@gmail.com>
Date:   Mon, 9 Nov 2020 08:44:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201109053546.xupmmsx5qccn46tr@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

09.11.2020 08:35, Viresh Kumar пишет:
> On 09-11-20, 08:19, Dmitry Osipenko wrote:
>> Thanks, I made it in a different way by simply adding helpers to the
>> pm_opp.h which use devm_add_action_or_reset(). This doesn't require to
>> add new kernel symbols.
> 
> I will prefer to add it in core.c itself, and yes
> devm_add_action_or_reset() looks better. But I am still not sure for
> which helpers do we need the devm_*() variants, as this is only useful
> for non-CPU devices. But if we have users that we can add right now,
> why not.

All current non-CPU drivers (devfreq, mmc, memory, etc) can benefit from it.

For Tegra drivers we need these variants:

devm_pm_opp_set_supported_hw()
devm_pm_opp_set_regulators() [if we won't use GENPD]
devm_pm_opp_set_clkname()
devm_pm_opp_of_add_table()
