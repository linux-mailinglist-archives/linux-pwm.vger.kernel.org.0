Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C4E422EE9
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Oct 2021 19:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbhJERSJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Oct 2021 13:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbhJERSF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Oct 2021 13:18:05 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97E5C061749;
        Tue,  5 Oct 2021 10:16:14 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u18so89541742lfd.12;
        Tue, 05 Oct 2021 10:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v4VMlYai/5OJD6I0jXVUBp7T7QQDEKF1EDfzlyrXPNg=;
        b=W2HYfURkJzDMqxvMvdLnaSxyL8uT7r1csfbSZPSbXORQw+cwWFtMynJRUEG4LiQrHQ
         y3v5acYIRN1Eb0FbSRLCSIRtUZRGATp/wXu0GpAF7MIKkyEe30yYqs44aRZ5hx7PQUf8
         KTIq6kvEdh07WxUJ9lahyZFbc91AomDi579Y3/gpCjlzb6mopUwQ7ho2PCW0cuccDWMY
         /i99LFk5tTWbSOuutGf0fRJHd37tPZRn46J6NSoa+sUFqOvBAVR+EQT9iPI/71vRNDUs
         E1DUIcTLGVE0YH8x38A9SKJivF5TQbdR1jagf785PZye81GIeWabHB+XUJ5q/1UXW+WG
         AQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v4VMlYai/5OJD6I0jXVUBp7T7QQDEKF1EDfzlyrXPNg=;
        b=DuF4QpkjwFbd4dwlYAhig4rmQJm8ielyZnZ9Ys+SAdiAecq64Ir6wFBUuPbV4j1M+n
         l8WZxK7bHDsWhMoefwJ8ThuVZM6f2HxW6SJP+kANUWoH6YuK7xvfuAofdrEp+uPjbDQt
         e2JlK9dJNKr5t7emnh1CplDlaTY+g0h+lGvquMTkLSNTGGSaona6zhrrvCtDWTpQeoF8
         QNlx7oJuIC2y+Kr52lLRm+BSzcT2/n3hzqhc/wxoPLMLqcZ4IiNofE3rn4A0ThxHZhb+
         hwVsNNjbCj25/cAMYZBmkAeSgI+512ATeaK867OLdlENIY7XmKIqAT9NIGCr+lslVwWu
         6dlQ==
X-Gm-Message-State: AOAM530Y30SpHEqmWsHTtTGfeSHetiuNcwwgRNU1PxSomh39kkYnrjs/
        4rL44LG/rgUyZvo76ZOMgsQ=
X-Google-Smtp-Source: ABdhPJzFxn+EEvAfXINlDGqbDWfWJzkpl0QRwm+Z1jKxlyPCyoz5MyhKfZrnAr2zjaXtazuDCKJIlw==
X-Received: by 2002:a05:6512:10d0:: with SMTP id k16mr4573650lfg.530.1633454173285;
        Tue, 05 Oct 2021 10:16:13 -0700 (PDT)
Received: from [192.168.2.145] (79-139-163-57.dynamic.spd-mgts.ru. [79.139.163.57])
        by smtp.googlemail.com with ESMTPSA id o12sm2013505lft.254.2021.10.05.10.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 10:16:12 -0700 (PDT)
Subject: Re: [PATCH v13 13/35] drm/tegra: gr2d: Support generic power domain
 and runtime PM
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
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
 <20210926224058.1252-14-digetx@gmail.com>
 <CAPDyKFpzhv1UxjM0q5AWHVxTWC_cCO_Kg_6exO0o_=EoVvjo+w@mail.gmail.com>
 <aad7a508-7fb5-3418-f902-def80c365094@gmail.com>
 <CAPDyKFppSuP6FfaBaGn3o+8WvTT=vJ8XMzZ47WPQ1JKiUYyEpw@mail.gmail.com>
 <8d75436d-864a-7ce0-ba53-daa8b663035a@gmail.com>
 <CAPDyKFpqs5gUcym4q+GuiJy13eXqjEnx-eFdUT4bQpcfPAOEYw@mail.gmail.com>
 <f5b5e06a-71ed-1250-f0ad-692062e00e01@gmail.com>
 <CAPDyKFpWzLdKr0bYX4VYwNpPuJNEs=weEpNpDH6zfv9e8SaxJQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <65f5ea6a-5d04-57cc-f4e4-bf29f22af7f0@gmail.com>
Date:   Tue, 5 Oct 2021 20:16:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpWzLdKr0bYX4VYwNpPuJNEs=weEpNpDH6zfv9e8SaxJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

...
>> It's not a problem to change this patchset. The problem is that if
>> you'll grep mainline for 'pm_runtime_disable', you will find that there
>> are a lot of drivers in a potential trouble.
> 
> Let's start by fixing this patchset, please - then we can consider
> what to do with the other cases separately.

Yeah, should be better to discuss it separately.

...
>>  void __pm_runtime_disable(struct device *dev, bool check_resume)
>>  {
>> +       flush_work(&dev->power.work);
>> +
> 
> What about the latency this may introduce? I am not sure that is
> acceptable here!?

I'm not aware about any code which relies on the original 'cancelling'
behaviour, perhaps Rafael should have more insight.

...
>> The sysfs rpm-forbid is a separate problem and it's less troublesome
>> since it requires root privileges. It's also not something that
>> userspace touches casually. For now I don't know what could be done
>> about it.
> 
> As I said, the common method to address this problem is to run the
> following sequence:
> 
> pm_runtime_get_sync()
> "power off the device"
> pm_runtime_disable()
> pm_runtime_put_noidle()
> 
> This works even if user space, via sysfs, has triggered a call to
> pm_runtime_forbid(). Or doesn't it?
> 
> If you don't like it, pm_runtime_force_suspend() should work too, at
> least for your cases, I believe.

I'll update the patches, thank you.
