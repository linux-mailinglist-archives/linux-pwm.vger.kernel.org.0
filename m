Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CC3622651
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Nov 2022 10:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiKIJKJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Nov 2022 04:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiKIJJW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Nov 2022 04:09:22 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BEBE001
        for <linux-pwm@vger.kernel.org>; Wed,  9 Nov 2022 01:09:04 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id m22so7739890eji.10
        for <linux-pwm@vger.kernel.org>; Wed, 09 Nov 2022 01:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nZcMBYbQMjldT4jC+RhNUKxz04c9G3hEjCKTpoC7vbg=;
        b=FageLjlZK2WZoj8juYOD9YLr+nPY2UYc4UrpUYhREtKyt+KyVpgc/2r1E6Ulg9GtIM
         vdyo4QlEoawvzBTI4GJaiyzSxf1NOkUQYU5lSUD1n/xR2pyy4AfqHrSKhRcktE0WAWYa
         Hc1xjH9NVPhbwFwQ5mI01trK+0fiPflauvvkR2uREdT4vU49peuB7TnUSao93hbXYfMj
         cmlZOxBKiWniUfrzD3IC7y6UUF169DGu7tAII1SU2d46H6KRhkeDbH8cklGtzOBXs2aG
         njXhDqFqlKUvcbvBCAD4j+DKsJyG/TWoqtegowcBaJnVT0PJPZzmQuQV+vDbH0jg478g
         eTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZcMBYbQMjldT4jC+RhNUKxz04c9G3hEjCKTpoC7vbg=;
        b=hZmBbRZFK+Km+AHvsyh3Gxt7ZXMNVhGbsFhCc8jbD4JEcp5OK7EHEAfAF82poyjesp
         oQiZ8YPHCQ4fxoEmtWVLtJayC4EbZhZLBAn3JwB/0GfoAUq8ua68q/oPqsCTlVj3qsQJ
         W5//xEE69uTe04SHeKG+/HtWioNkI4DD3POcGRfXhKabijQ53Unhr1hnBCe1aJ5pIsFy
         qzM41moTLzuLj2qE2mjERDfmhB8gTcytF239z/B0M+kfqD3kZzpgVypQrs+Soe+Q8BlK
         zTT/neAefHy3Gts5GIJ8PR23w/bxNwNjSAhdvjchs0IoDaahPWB4rjLmBnXLtq+sATTJ
         8NcA==
X-Gm-Message-State: ACrzQf3eo82URDomHRzOD65dEOl6WoqKUw8kszTOHJ0+ZVY7N2jjc4sh
        WuPg2P9gbI3JSGiaRB6AA1C+CBSNcMOOqxFivqwO6w==
X-Google-Smtp-Source: AMsMyM7Ffw6Xyta7TIuWJ0V9kBSj6DtO1Hw1mhv0q6xWxTB6nphGzVJ3kWpUp4HdDFHIf7BavRy7NQo9PuRvtZRw9Nc=
X-Received: by 2002:a17:907:c1e:b0:7ae:31a0:571e with SMTP id
 ga30-20020a1709070c1e00b007ae31a0571emr24253156ejc.690.1667984943106; Wed, 09
 Nov 2022 01:09:03 -0800 (PST)
MIME-Version: 1.0
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com> <20221108142226.63161-7-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221108142226.63161-7-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Nov 2022 10:08:51 +0100
Message-ID: <CACRpkdbVekP0kFpwexpb3NhqRSouNW7FhhRpSK0yRQTrJAGt4A@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] pinctrl: intel: Enumerate PWM device when
 community has a capabilitty
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Nov 8, 2022 at 3:22 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Some of the Communities may have PWM capability. In such cases,
> enumerate PWM device via respective driver. User is still responsible
> for setting correct pin muxing for the line that needs to output the
> signal.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

So:

> +#include <linux/platform_data/x86/pwm-lpss.h>
(...)
> +static int intel_pinctrl_probe_pwm(struct intel_pinctrl *pctrl,
> +                                  struct intel_community *community)
> +{
> +       static const struct pwm_lpss_boardinfo info = {
> +               .clk_rate = 19200000,
> +               .npwm = 1,
> +               .base_unit_bits = 22,
> +               .bypass = true,
> +       };
> +       struct pwm_lpss_chip *pwm;
> +
> +       if (!(community->features & PINCTRL_FEATURE_PWM))
> +               return 0;
> +
> +       pwm = pwm_lpss_probe(pctrl->dev, community->regs + PWMC, &info);
> +       if (IS_ERR(pwm) && PTR_ERR(pwm) != -ENODEV)
> +               return PTR_ERR(pwm);

This is alike a boardfile embedded into the pin control driver.

It's a bit backwards since we usually go the other direction, i.e. probe
a PWM driver or whatever and then that driver request its resources
that are assigned from e.g. DT or ACPI, and in this case that would
mean it request its pin control handle and the pins get set up.

I guess I can be convinced that this hack is the lesser evil :D

What is it in the platform that makes this kind of hacks necessary?
Inconsistent description in ACPI or is the PWM device simply
missing from the DSDT (or whatever is the right form in ACPI)
in already shipped devices that need it?

Or is it simply impossible to describe the PWM device in ACPI?

Yours,
Linus Walleij
