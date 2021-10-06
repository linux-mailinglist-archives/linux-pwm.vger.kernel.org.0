Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F864248CA
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Oct 2021 23:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239657AbhJFVW3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 6 Oct 2021 17:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239488AbhJFVW2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 6 Oct 2021 17:22:28 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5582C061746;
        Wed,  6 Oct 2021 14:20:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n8so15199716lfk.6;
        Wed, 06 Oct 2021 14:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7tLLaK+FEaYHr56nHjbXad4JSKaQLC9aVN+Wg4j4X4w=;
        b=lDLQmpmt9gb3AJaiKrlFZZP5xQzR7S4e3gFVcwGsEraX5rvYbCISyX3eLe42ICVm30
         WSwIsR514+SPYhQWs7j4VfHiKuyYXfLdBDsQ0iVCr7y1eLaY01mGfgYhFed47bNWxR/y
         caBi3Dt6fpwXfGj1PTgx4MIj/w8UkBHcG2okl3FyIDdRN5WJWHF53/ajZAz8wtTohTSv
         jXXMaZJhUPaHyirAIWYdO1jhSrxUGcX0cSUXjum7aNqSSQ9iei83yBsnTpeC5nJl/rZl
         fHzHi7f8afTFobwolLQYUWf+WYM+VFVl32wlweZLC4ri0rF15lqNWo/AwHIKyq+xAZ4A
         yfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7tLLaK+FEaYHr56nHjbXad4JSKaQLC9aVN+Wg4j4X4w=;
        b=0GnIohvdCUz+hmycaZDuk5fdQnj5thyGNQfLtAu0q5tfccOzxlhUpyG2aq7cbg36mm
         Jt3ixTb5jh+1sf1kJFltvfwFy2SuaCqFYQ/2GKyNIhm/djLOkdFdISbTJv6k/uFR8ynA
         7569+HjplgVYsQaiEnBSGvMIv/67Cc6YZCfeNe+ia6cLjJUJQ+dOEWD/tsznM4K0ltS/
         mRWWO3VqGd7j9cQjBCOc4xftXTX5EWJgh9BkMYGaw4egH2jbfNCH4VVQn5MXYVoFYWhU
         kN5SVBlEj/ibnE9NJmVXEgKHBshE/AjG1XxL3EVFob5vkIUcJQYKf/WH4E/UXJNgBCxY
         7PPw==
X-Gm-Message-State: AOAM530AeNN2I5EJKYcKqkafI/zuLtXVJQVGeMUeM7sk4l59ZfgbQRyX
        20Egu4T8rmA1k06gTfQmjI0=
X-Google-Smtp-Source: ABdhPJwQC622dbAl50/cK12stk7nHISdUN4TNNE0R7buPRyxLUtPby8n1l4y/0q7oUNm6hKqveKPxQ==
X-Received: by 2002:a05:6512:3d93:: with SMTP id k19mr397196lfv.114.1633555234052;
        Wed, 06 Oct 2021 14:20:34 -0700 (PDT)
Received: from [192.168.2.145] (79-139-163-57.dynamic.spd-mgts.ru. [79.139.163.57])
        by smtp.googlemail.com with ESMTPSA id h20sm2382258ljc.76.2021.10.06.14.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 14:20:33 -0700 (PDT)
Subject: Re: [PATCH v13 06/35] clk: tegra: Support runtime PM and power domain
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
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
 <20210926224058.1252-7-digetx@gmail.com>
 <CAPDyKFq+LS4Jr1GyC-a-tGWPzGH0JxfJ9wKY=uQEBGYm952azw@mail.gmail.com>
 <24101cd6-d3f5-1e74-db39-145ecd30418b@gmail.com>
 <CAPDyKFreK7976PJL-1zySoza_yXM7rMQ64aODWUZ+U3L-uCa0w@mail.gmail.com>
 <4bdba8a2-4b9b-ed7d-e6ca-9218d8200a85@gmail.com>
 <CAPDyKFq_-HGPRNiNDmnEbuah0mUYoRUWVs1SvbQ6VNMMwEcXjA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f10567ec-c804-af5b-7d31-5977270a7b7a@gmail.com>
Date:   Thu, 7 Oct 2021 00:20:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq_-HGPRNiNDmnEbuah0mUYoRUWVs1SvbQ6VNMMwEcXjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

06.10.2021 15:38, Ulf Hansson пишет:
> In principle what you ask for, is if we can avoid calling
> __pm_runtime_disable() in __device_suspend_late() (and vice versa in
> device_resume_early()).
> 
> I think the short answer is no, at least from a generic point of view.
> Maybe we can figure out a way to allow this on a per device basis, as
> an opt-in solution. I am not sure what Rafael would think about this,
> let's see.
> 
> Another option to address the problem is already available to use for
> these kinds of cases. This would be to add also a pair of
> ->suspend|resume() callbacks to I2C driver. Along the lines of the
> below.
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index c883044715f3..589bf872ab25 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -1918,6 +1918,7 @@ static int __maybe_unused
> tegra_i2c_resume(struct device *dev)
>  }
> 
>  static const struct dev_pm_ops tegra_i2c_pm = {
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_put_noidle, pm_runtime_get_sync)
>         SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(tegra_i2c_suspend, tegra_i2c_resume)
>         SET_RUNTIME_PM_OPS(tegra_i2c_runtime_suspend, tegra_i2c_runtime_resume,
>                            NULL)
> 
> In this way, the device would already be runtime resumed, if there is
> call to pm_runtime_get_sync() from the clock framework due to the
> clk_prepare|unprepare() being called. If that also turns out to happen
> *after* runtime PM has been disabled for the device, the call to
> pm_runtime_get_sync() would still succeed (returning 1, see
> rpm_resume()), rather than a negative error code.
> 
> Yes, we may end up runtime resuming the device during system suspend,
> even if it turns out not to be needed. Although, that doesn't seem to
> be the case for the Tegra I2C driver, right?

Tegra I2C will turn off clocks on suspend regardless of RPM state.
Overall, it's a plausible solution, thank you!

As I said in the other reply, I'll simply remove the suspend ops from
clk driver, they are not needed anymore. The problem is gone.
