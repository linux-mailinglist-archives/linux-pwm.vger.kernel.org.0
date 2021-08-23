Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39403F4DD2
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Aug 2021 17:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhHWPzP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Aug 2021 11:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbhHWPzO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Aug 2021 11:55:14 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3124DC061757;
        Mon, 23 Aug 2021 08:54:31 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i9so38834301lfg.10;
        Mon, 23 Aug 2021 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7mncJ6pduW/52O6ekhmOFTY3dWeez/jgkRyR/0Vdsyw=;
        b=GjDLwuw1u5t0huse+wcSUJvd9NlDsq9fLH5ifMhjoFLd/jX7arhT4V0b4pMg9fkZx0
         SFoXhZrGpDe1zyz7PwMpqtrmGVNRg4uenD426vrzx09jDp5+gZwPaSOWi2CzEdhHZN72
         biZ9w4cugGtwCB8oOkwmNR+z285tRdqilLSsiYBx3KMs+2gRQ2Qufwsaf9Kkn44cA20t
         ytzwyZjnYP+KTq05NUlj+435IalTyox6/J6oSbEJjWcMz4NbsCi+r8m8O7scEsRH0iPC
         mwCHAhLhpQqHYFd7f4axkEH/iwpXUU5wQP5pO5DMDqwE7H45GOLzvXAyvPw0J1h3bnVb
         85LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7mncJ6pduW/52O6ekhmOFTY3dWeez/jgkRyR/0Vdsyw=;
        b=IOpKGHvqrd6BLy/vZsEi4QxYtFeeOqNrn5QcSGeZ+5lN/MBYTkGTFqJBOV1k8ly3TM
         Ojlwfw0HLUc6pT+M3WPK1klUJGn/nzf3dGrbJXhkkoSw8z2d9t1EXb/7S7VhLNsaYZQo
         e+gfZ69TnaKu99jhOW+Yi8YO3PDNXWflArBxHkhLWHJJktQq/zo6CwEjbB6K/QeIdG46
         UJMdkfNoGWuJ875iEGA/Twlwv0Ur9cMq2shAGdx4om9hlCR+4KAQLmLHWa7CClMpyoUE
         BSpjbe32pK64XFoQ9qRh1Io9vewbflVYigrn+6J5eZx/SYiZd+8sUVveS9YHQXdwxCgg
         EF2A==
X-Gm-Message-State: AOAM531b3+f8AQBdQ/uobRHY/mYbnT6rZhH/BW/fwpuBAT8yUBQ6fi+k
        w5w22/1vPJAThf4sjKZK+/fW7k7i+KU=
X-Google-Smtp-Source: ABdhPJzNDGjnGQzIrcQXTM2iukhjwhqvC5wj3OdYqtfrrWEzlRV302pS9l5Dkjzi+NNxjkL6pb5dHg==
X-Received: by 2002:a05:6512:3157:: with SMTP id s23mr24865578lfi.247.1629734069444;
        Mon, 23 Aug 2021 08:54:29 -0700 (PDT)
Received: from [192.168.2.145] (46-138-120-72.dynamic.spd-mgts.ru. [46.138.120.72])
        by smtp.googlemail.com with ESMTPSA id u2sm1482543lfr.79.2021.08.23.08.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 08:54:28 -0700 (PDT)
Subject: Re: [PATCH v8 01/34] opp: Add dev_pm_opp_sync() helper
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
References: <20210818043131.7klajx6drvvkftoc@vireshk-i7>
 <a2a3c41f-c5e4-ee7e-7d48-03af8bac8863@gmail.com>
 <20210818045307.4brb6cafkh3adjth@vireshk-i7>
 <080469b3-612b-3a34-86e5-7037a64de2fe@gmail.com>
 <20210818055849.ybfajzu75ecpdrbn@vireshk-i7>
 <f1c76f23-086d-ef36-54ea-0511b0ebe0e1@gmail.com>
 <20210818062723.dqamssfkf7lf7cf7@vireshk-i7>
 <CAPDyKFrZqWtZOp4MwDN6fShoLLbw5NM039bpE3-shB+fCEZOog@mail.gmail.com>
 <20210818091417.dvlnsxlgybdsn76x@vireshk-i7>
 <CAPDyKFrVxhrWGr2pKduehshpLFd_db2NTPGuD7fSqvuHeyzT4w@mail.gmail.com>
 <20210818095044.e2ntsm45h5cddk7s@vireshk-i7>
 <CAPDyKFrFF00xGDWPCQnPwF0_QkG4TB2UqggpuBpp8LY_CMKP-A@mail.gmail.com>
 <0354acbe-d856-4040-f453-8e8164102045@gmail.com>
 <CAPDyKFoQdn1rm91iFNJwZwpSYcKJBjDLqtJB4KZAkhgY1Grm-Q@mail.gmail.com>
 <87073fc2-d7b3-98f4-0067-29430ea2adef@gmail.com>
 <CAPDyKFqSsAk8a5CTNpRT2z4Wvf8BehJKDbVhUKfHc2Jzj7aTNA@mail.gmail.com>
 <9129a9f0-8c9b-d8e0-ddf5-c8820871fb7f@gmail.com>
 <CAPDyKFrWeQVNgxzmiLBXJ2gQW=iFf4aG16xvZ+ag1MkhXs9-BQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9a783eb3-786b-a3b2-7854-2be6954527db@gmail.com>
Date:   Mon, 23 Aug 2021 18:54:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrWeQVNgxzmiLBXJ2gQW=iFf4aG16xvZ+ag1MkhXs9-BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

23.08.2021 13:46, Ulf Hansson пишет:
>>> ...
>>> dev_pm_opp_set_rate(rate)
>>> pm_runtime_get_noresume()
>>> pm_runtime_set_active()
>>> pm_runtime_enable()
>>> ...
>>> pm_runtime_put()
>>> ...
>>>
>>> We need to call genpd_set_performance_state() independently of whether
>>> the device is runtime suspended or not.
>>
>> I don't see where is the problem in yours example.
>>
>> pm_runtime_suspended() = false while RPM is disabled. When device is
>> resumed, the rpm_pstate=0, so it won't change the pstate on resume.
> 
> Yes, you are certainly correct, my bad! I mixed it up with
> pm_runtime_status_suspended(), which only cares about the status.
> 
> So, after a second thought, your suggestion sounds very much
> reasonable to me! I have also tried to consider all different
> scenarios, including the system suspend/resume path, but I think it
> should be fine.

It could be improved slightly to cover more cases.

> I also think that a patch like the above should be considered as a
> fix, because it actually fixes a problem, according to what I said in
> my earlier reply, below.
> 
> Fixes : 5937c3ce2122 ("PM: domains: Drop/restore performance state
> votes for devices at runtime PM").
> 
>>
>>> Although, it actually seems like good idea to update
>>> dev_gpd_data(dev)->rpm_pstate = state here, as to make sure
>>> genpd_runtime_resume() doesn't restore an old/invalid value that was
>>> saved while dropping the performance state vote for the device in
>>> genpd_runtime_suspend() earlier.
>>>
>>> Let me send a patch for this shortly, to close this window of a possible error.
>>
>> It will also remove the need to resume device just to change the clock
>> rate, like I needed to do it in the PWM patch of this series.
> 
> Do you want to send the patch formally? Or do you prefer it if I do it?

I'll send the patch.
