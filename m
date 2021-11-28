Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C496460A6E
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Nov 2021 22:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbhK1V4Y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 28 Nov 2021 16:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241083AbhK1VyX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 28 Nov 2021 16:54:23 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070DCC061758;
        Sun, 28 Nov 2021 13:50:57 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id u3so39434038lfl.2;
        Sun, 28 Nov 2021 13:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N7b1G8te/KH8djaz6IoJjV+icWZ0WR5IWmhcwgDYM7g=;
        b=cJKuiSKXD/Xz29LntYrD2aoIGTLEp6NSbTYTps4hyyyHBMJ07t16EAS4ljWkWHkFJl
         4pBL5oswWDaVW6Deh/kuPa6iFqv5yL/+nSOXmVzKpauwf261kWL7v3Yzsm8t9pnGhkPH
         II30iutdYC15AzIYfT9bmx+g9g44j4coxb2C0FMMEo667F4UUjApKfEpim8ikD+MBjbk
         V59xX8poIcqsCeuAwRz/0gti6J7hAfx0+FvH69DQZ4Fvkrgm87ULmgA9/gWF1Yh/CFUH
         /klnhH7tvuAZNaELd0A9nxNibcPjnzNU9TnLUDeBZpECqf2b55e0bV9/1SSIkzXyTfmA
         NVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N7b1G8te/KH8djaz6IoJjV+icWZ0WR5IWmhcwgDYM7g=;
        b=Ui9fdPQhRU2ITdBQkbuSulThaVkz54Tlnn55pL7L4Omnw5zYXAUJvaAe8niv6JJZIn
         wHfCTtESuKDU85dmTRkRxCBmjWTtwxLKmDPCYwj+izxdu9LcHbStEVFkDyReStBaJYrX
         p0xedsEYYU0/RVQhW9Ehc2+X8e7gX1V5HjQntPrwrt28WcJXotEAl63NQOFFEYH7E1HF
         oIZ+e8zI8XmQE/h1LqtEkQQ1oLjiqfBNK/A6ZbCuHeKdIaN611OwbyCbMgON9YfqyseG
         AkgUOW3h0rMOL5WiAWx98o1IQNrrlyg4ZjmIE0Jo1ntSSTyYUc+H0F8JzvA1XJP6N80E
         ifHA==
X-Gm-Message-State: AOAM530BPBSCqD9ottfgIgFfXbeEPvG5JUJA5T1WrtdTmL68aqcYHLx+
        ewWJrs4BN3rTKiCRdbXfkHs=
X-Google-Smtp-Source: ABdhPJxOEUHJJ9auAnJ/mU9Ts+B2Pn56ZsRiKYrw+w6nVmHBeiJe5hd9/65DDFm05AeOhvbxIB4qgg==
X-Received: by 2002:a05:6512:3f05:: with SMTP id y5mr4862526lfa.139.1638136254960;
        Sun, 28 Nov 2021 13:50:54 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id s4sm1177053ljp.73.2021.11.28.13.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 13:50:54 -0800 (PST)
Subject: Re: [PATCH v15 12/39] drm/tegra: gr2d: Support generic power domain
 and runtime PM
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
 <20211114193435.7705-13-digetx@gmail.com> <YaMX89bRBlqh0MvB@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0adb89a9-4642-2104-1ba5-ebb86c7ac4fc@gmail.com>
Date:   Mon, 29 Nov 2021 00:50:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaMX89bRBlqh0MvB@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

28.11.2021 08:47, Michał Mirosław пишет:
> On Sun, Nov 14, 2021 at 10:34:08PM +0300, Dmitry Osipenko wrote:
>> Add runtime power management and support generic power domains.
> [...]
>> @@ -104,10 +127,17 @@ static int gr2d_open_channel(struct tegra_drm_client *client,
>>  			     struct tegra_drm_context *context)
>>  {
>>  	struct gr2d *gr2d = to_gr2d(client);
>> +	int err;
>> +
>> +	err = pm_runtime_resume_and_get(client->base.dev);
>> +	if (err)
>> +		return err;
>>  
>>  	context->channel = host1x_channel_get(gr2d->channel);
>> -	if (!context->channel)
>> +	if (!context->channel) {
>> +		pm_runtime_put(context->client->base.dev);
> 
> Could host1x_channel_get/put() handle pm_runtime* calls ? I would expect
> this to be common code for the users.

We already have host1x code that manages runtime PM of the client
drivers, but it does that only for the code path of the new UAPI.

In case of the older UAPI, seems we can move the RPM get/put into
tegra/drm.c. I'll consider that change for v16, thank you.

> BTW, pm_runtime_resume_and_get() uses different dev than
> pm_runtime_put() in the error path - is this intended?

These functions use the same dev. The context->client is redundant
there, good catch.
