Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73A3460A87
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Nov 2021 23:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242396AbhK1WIp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 28 Nov 2021 17:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhK1WGp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 28 Nov 2021 17:06:45 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47858C061746;
        Sun, 28 Nov 2021 14:03:28 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id n12so39510119lfe.1;
        Sun, 28 Nov 2021 14:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BmJDsI1frubqpSHpwgLMDcWP2GRwtD3Aeu0GDNSS4Ao=;
        b=JqJrLFejdvwG6EFcUaec1471GQnF4o7rWmB6ZJgoVyHzKIkkY8XPck6x3CHTcSe3mr
         7c3WWIfu0LFTWTIWtfr1xMf1sIz9hSxmJjNmg5EpOoGtRIqQYrl7w/0PM+7DPJe3Nxtk
         rN6rxwckbCb/tFQBuTom9QWJWe368iYPCHR6SzKZyxcrZavR0Qvz3FBbGQQWlxES0zx3
         AyGMKx7T8uiK3LGqvY6k4r/pZaiGv/E3eR+VX0o1y8VwEVOx6vlL8inxXaHnS9nNzCHP
         /sog83T0MTHqC7MSI4QlW3DNzKcOyj4MQKPD+Rgk5qe7wAw3+rNMhs5lE34rRjfMa9d6
         m5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BmJDsI1frubqpSHpwgLMDcWP2GRwtD3Aeu0GDNSS4Ao=;
        b=2IyZfutJKoDVgqLl0NkZ9nNbbLeMeOYzflxGGeJZeU/Nk/wkiRvelTK/KnbHvMUhmY
         HQVB5hKUlT7BDy2p0ueeoxkDpbmVm0m91JzvvRL5Dr8hk9mVYcDeNuaHI5iiRDPjI+rU
         FS+9NQfTTCmKdaJscGCTk5m/+HBZM9bh41ZhbZaLm2/iOxwn5hP9EeQ8aIBBX1X/rUUt
         TfOzH8TIKSdDQLT7+j2dwpQtYVC8Cm4kqT2P1G7jpQzIpEZul+8L2zCojl1DBbVCvAAi
         UeBfBTTvk157fn9Go7aG+KiiyTmqwOhsHDM5kabyGm7kwpD4N4v5xDUu2DGI5DsHBDaX
         o4vw==
X-Gm-Message-State: AOAM532p99SoNYyMqvD0XUfWn1H9VeUXqrvWjaPngyU+cO0DP5GB2+bp
        +z/C47jDV4HwDwAsbTWlGXI=
X-Google-Smtp-Source: ABdhPJxrPfjj0n+sgrY4w60/8r91odYTvOOfn9dIP0FlQoVAM5bMvzeBYaBIJ/QlbWNLbD8x9ctRNA==
X-Received: by 2002:ac2:5fb1:: with SMTP id s17mr6692388lfe.587.1638137006608;
        Sun, 28 Nov 2021 14:03:26 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id s13sm1117685lfg.126.2021.11.28.14.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 14:03:26 -0800 (PST)
Subject: Re: [PATCH v15 00/39] NVIDIA Tegra power management patches for 5.17
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
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
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20211114193435.7705-1-digetx@gmail.com>
 <YaMWaKqQ+c8G08mJ@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6e364419-c4ef-a6d6-6538-9b04f1cfe9c7@gmail.com>
Date:   Mon, 29 Nov 2021 01:03:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaMWaKqQ+c8G08mJ@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

28.11.2021 08:40, Michał Mirosław пишет:
> On Sun, Nov 14, 2021 at 10:33:56PM +0300, Dmitry Osipenko wrote:
>> This series adds runtime PM support to Tegra drivers and enables core
>> voltage scaling for Tegra20/30 SoCs, resolving overheating troubles.
>>
>> All patches in this series are interdependent and should go via Tegra tree
>> for simplicity.
> [...]
> 
> I would suggest pushing all the fixes to the front of the series (those are
> at least patches 1, 3, 17, 27-31 and 39).

All those patches, apart from 17, should be irrelevant to stable kernel.
There is no real benefit in reordering them, IMO. The patches are
grouped logically in this series.

In the case of patch 17, perhaps won't hurt to add stable tag to it.
Then the "drm/tegra: submit:" patches could be swapped to prioritize the
fix, though there is no danger of a merge conflict there.
