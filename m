Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C002C2B1F71
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Nov 2020 17:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgKMQBG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Nov 2020 11:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMQBG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Nov 2020 11:01:06 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B29C0613D1;
        Fri, 13 Nov 2020 08:01:05 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u18so14502761lfd.9;
        Fri, 13 Nov 2020 08:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hoBSr1hUr4Yp5kI+akqrOIxu0KqM4JsPnQSdm0rncXc=;
        b=Iqp7Q1Dqs7vv9QGINYyhZh6TR5wRoaUPd3RhKQWt0ku9yoFH50o9ftnXu8wZQLQjBN
         MupgjrQGeT789VP/M8QE1sy/ylWbvDZw1mirTsfOtgX9YCxwPLfZgeXNtkbfSicj3mjc
         lYhS7NJIWNgah5tKE+4q1Lc+J820S2ov1Vc3fzrgEtmx/YUNRnT8msOz5Id3R/AqGPXm
         ALQOgA0+xXEcZ8b1ExsRmkNEI2LBybyGzkH45EMmQ5Xw3OATNYPWjByAhArGQ8x53eXj
         qh2pqZYGCT33Ofuz8gQztaUtn1VBKB4rqScC1JLZCISwSwTHqgo8wHhMc9SL7g4O5vKv
         Kpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hoBSr1hUr4Yp5kI+akqrOIxu0KqM4JsPnQSdm0rncXc=;
        b=Pu2YbLOExQmHIJ5wI7KOm2C+1GD4Sw04HIlCucpmRjBbmqick6M7D8MXKNzcAkF4Nn
         MMyrcazSpMo7kf2qXtNCUJwq8xEvZVm8RjX3mxM+gFFeZQLi260zBeWP5vaa4YKrnn/v
         A5AgRAxBviacJX9vFbByeca/umz+moUKJbcw4hgqpScGUIiwOWpdDQc70iwjjK2gYJQr
         Cjqx/hbIqi6tDzZ/i1rDmacEb4ldj6Ec7bnu2xmEtbrtESwD2S5tElpVtgbC0NOg4ntL
         jL4wDiftK2sBtmyP9m5C95u6yDGerGTM6xovY0ad+7D7KqgF1yIC+i3IUYe/hUkH4AB3
         3ctQ==
X-Gm-Message-State: AOAM531L3tR75zrc5OHoMsQookP85XN8ggqy78XQX5KqRsqpqVzPRXEY
        Svo3mAgCFypSucTIkwEkk75Ch98yV3Q=
X-Google-Smtp-Source: ABdhPJxFVXaegDtK2tbA+H+UL7oS/td2SYsq+RSjYI0ie8ZOQU72DsoUiPJfNs83bgfYy1Sdm28Jlw==
X-Received: by 2002:a19:6b07:: with SMTP id d7mr1163717lfa.509.1605283259019;
        Fri, 13 Nov 2020 08:00:59 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id o17sm1503541lfg.136.2020.11.13.08.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 08:00:58 -0800 (PST)
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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
 <cd147ab0-1304-a491-7a56-ee6199c02d32@gmail.com>
 <2716c195-083a-112f-f1e5-2f6b7152a4b5@gmail.com>
 <CAPDyKFqUMsH9dCZ=OYqfdLt==+-8NjK9n=S5jGGNXZu6Y9q=2w@mail.gmail.com>
 <1f7e90c4-6134-2e2b-4869-5afbda18ead3@gmail.com>
 <20201112204358.GA1027187@ulmo>
 <25942da9-b527-c0aa-5403-53c9cc34ad93@gmail.com>
 <CAPDyKFomk7mw7-wpZFPOfT27CEXuCbzRiBoicH5-k7QF_pphVw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1f644c22-991c-7d27-b147-f12489e7ed7d@gmail.com>
Date:   Fri, 13 Nov 2020 19:00:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <CAPDyKFomk7mw7-wpZFPOfT27CEXuCbzRiBoicH5-k7QF_pphVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

13.11.2020 17:45, Ulf Hansson пишет:
> On Thu, 12 Nov 2020 at 23:14, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 12.11.2020 23:43, Thierry Reding пишет:
>>>> The difference in comparison to using voltage regulator directly is
>>>> minimal, basically the core-supply phandle is replaced is replaced with
>>>> a power-domain phandle in a device tree.
>>> These new power-domain handles would have to be added to devices that
>>> potentially already have a power-domain handle, right? Isn't that going
>>> to cause issues? I vaguely recall that we already have multiple power
>>> domains for the XUSB controller and we have to jump through extra hoops
>>> to make that work.
>>
>> I modeled the core PD as a parent of the PMC sub-domains, which
>> presumably is a correct way to represent the domains topology.
>>
>> https://gist.github.com/digetx/dfd92c7f7e0aa6cef20403c4298088d7
> 
> That could make sense, it seems.
> 
> Anyway, this made me realize that
> dev_pm_genpd_set_performance_state(dev) returns -EINVAL, in case the
> device's genpd doesn't have the ->set_performance_state() assigned.
> This may not be correct. Instead we should likely consider an empty
> callback as okay and continue to walk the topology upwards to the
> parent domain, etc.
> 
> Just wanted to point this out. I intend to post a patch as soon as I
> can for this.

Thank you, I was also going to make the same change, but haven't
bothered to do it so far. Please feel free to CC me on the patch.
