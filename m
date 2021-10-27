Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886E643D1CD
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Oct 2021 21:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243711AbhJ0TmQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 27 Oct 2021 15:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhJ0TmQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 27 Oct 2021 15:42:16 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5DDC061570;
        Wed, 27 Oct 2021 12:39:50 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s19so6517531ljj.11;
        Wed, 27 Oct 2021 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rAmPJfYHzRC+rm0bfc8zWvJNQrGo60yLoxqPzW5j78A=;
        b=Nf8FrgqEjAxhNRNr6ZyQdcPUhhOJYQ0gmHrNA+/9hDUzrt7itfhaONpqMxhY6dWN6B
         iDQg+mxMHuf7ZWvUMb7Lzt4OX51hiY2jaolNc5XtLM6ZPthyIo6jx1g/u+ORa9Cp/4PS
         E/oDftg2l6dE2E4zoU+e5kIOHFhISGDziHSz2dC4w+1lMFYzXXHpsP8Ds/pbSafnV8QE
         2SGd4nvFamN/ZFYZfE/7IISgYBw98NM4uOOAybsDqUf1Q2c/oCNJdHF6yeaEJgEtKpNu
         7/zbJs5OjypWNUtSZLbD/EmdazCUy5iZbB1aZdR7Oyx8ENzeVxshzHuutTrGwt/a8Vfu
         i0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rAmPJfYHzRC+rm0bfc8zWvJNQrGo60yLoxqPzW5j78A=;
        b=L4FYe366hzU2EKjOq2kJ7J29VzHYlrcrj5IC33sfAArc71MHdfQBgvaQK0Ve2Yf0L6
         UvUdC2dVYKxeDIfFd6wJIcZfwTaFE/8N+2tkjms85fVhwd8uJMKu6nI5zuWlO6cuk2xo
         4mgzctCd1P6gId6FydPkaE62JuL7UxnnMm/qiPWUWkZiiXqBh9L3qDlHsZYm/HOF0F1i
         AbXK8HF+UPexVRMnFIy7zvV2wnFWQyEdscJ5VOE9IcMQHEDbjL5veiw7rNtzM1gTFj5S
         Qj4fKtavjQZAoxUKf9PpITM/Yt3wIbdvdOM51xW/Y4h6YN4fBx+nI5M14U4H3A+Ov3aA
         8WLg==
X-Gm-Message-State: AOAM530OmEk/Sl+fmgZAFoUIOq2AnM7uiy/LawIbSBL70QSvkkZMqF9A
        dGhv15XgFkaP8oyWJcEmuaw=
X-Google-Smtp-Source: ABdhPJxarReFU7RnxAQqcknPbpQOUIP5VL6i4EpFxgGeK2aS9UED9Jy4im3s+hZp3RGqU6hEovYD0g==
X-Received: by 2002:a2e:7804:: with SMTP id t4mr4801093ljc.305.1635363588626;
        Wed, 27 Oct 2021 12:39:48 -0700 (PDT)
Received: from [192.168.2.145] (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.googlemail.com with ESMTPSA id bq19sm84272lfb.144.2021.10.27.12.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 12:39:48 -0700 (PDT)
Subject: Re: [PATCH v14 29/39] soc/tegra: regulators: Prepare for suspend
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
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
References: <20211025224032.21012-1-digetx@gmail.com>
 <20211025224032.21012-30-digetx@gmail.com>
 <CAPDyKFrQfACqtHtsnbk9fJpfaXWgD6-GEy2HFq8DxMTe4+zZmA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a8280b5b-7347-8995-c97b-10b798cdf057@gmail.com>
Date:   Wed, 27 Oct 2021 22:39:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrQfACqtHtsnbk9fJpfaXWgD6-GEy2HFq8DxMTe4+zZmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

27.10.2021 18:47, Ulf Hansson пишет:
>> Depending on hardware version, Tegra SoC may require a higher voltages
>> during resume from system suspend, otherwise hardware will crash. Set
>> SoC voltages to a nominal levels during suspend.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> I don't understand the reason why you need to use pm notifiers to
> manage these things. Those are invoked really early during the system
> suspend process and really late during the system resume process.

The suspend/resume time doesn't matter as long as venc genpd resumes
earlier than regulator is unprepared during late resume. Hence early
suspend and late resume suit well.

> In regards to this, you are mentioning the behaviour in genpd around
> system suspend/resume in a comment a few lines below, and that it's
> problematic for the venc domain. Can you perhaps share some more
> information, just to make sure we shouldn't fix the problem in genpd
> instead?

GENPD core force-resumes all domains early during system resume and this
causes odd problem on Tegra20 device in regards to resuming of video
encoder domain where SoC sometimes hangs after couple milliseconds since
the time of ungating the domain if SoC core voltage is low at that time.

Initially I was blaming WiFi driver because somehow this problem didn't
happen if WiFi chip was disabled [1]. I dived into debugging and found
that hang happens after ungating venc early during resume from suspend,
i.e. when genpd core resumes it.

[1] https://www.spinics.net/lists/linux-wireless/msg212116.html

Interestingly, this problem isn't reproducible when system is fully
resumed, i.e. venc can be freely gated/ungated at a low voltage without
any visible problems.

What's also interesting, it's impossible to reproduce hang on a second
resume from suspend if it didn't happen on the first resume. Need to
reboot and try again in that case.

In the end I found that bumping SoC core voltage 100% solves the trouble.

I knew that downstream kernel bumps voltage during suspend, but it
doesn't explain why. I replicated the suspicious behaviour of downstream
kernel and the problem has gone. Could be that this only masks the real
problem, but I don't have more information and the problem is solved.
