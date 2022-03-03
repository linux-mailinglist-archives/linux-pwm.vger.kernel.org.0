Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3569B4CB336
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Mar 2022 01:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiCCAEX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Mar 2022 19:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiCCAEV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Mar 2022 19:04:21 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E5018B
        for <linux-pwm@vger.kernel.org>; Wed,  2 Mar 2022 16:03:31 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id w4so1931563edc.7
        for <linux-pwm@vger.kernel.org>; Wed, 02 Mar 2022 16:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=712s7UNzasxlj0dwsyjRXVd8K8/HcJjmlNagNGk3tak=;
        b=ED9WDqjaIvY/PNhXMFZcJHPNR7h/tTUuq7WLYZ1ylEvNffoEcxKxybLHrav42m9Cnn
         RVEvb/IBLv+PhIPTpr690rtY8c24fbS5byCNqvx9Uwev3vYjz8sAMB11j/c+q3crVNAP
         sIZB594RAxB9rrrDgiPoWjkncYFw0ihals3NI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=712s7UNzasxlj0dwsyjRXVd8K8/HcJjmlNagNGk3tak=;
        b=VhLjJ6mb08ioMMlbFd7STo8l0GFM5cG5Y/WneoBPAl68Ye8kLFutB1Ugi7I2f2MoBN
         JukMA6jvjw+mAh6ty9uSRczYVwxEG/wxI0xk/C9ey7XcLEOWoJgoqEkWOHR2I+mpLgJY
         +FMrCiXpu2/zF666oRSUxBP6PL2vugIsS6r40nMXDIg7j3mO1uf7ZzuyObL7PlYctjzU
         +V9oK5GFdk/67KMSMJVe9emaiW4fPv3jcYJlneIrALVeMrHaJ+qKPZiScxbT/2AyxZEz
         QrAx0xr/qUoKUXjMN1qp+2BYx12f3O2Tbtj4DIRvE/cdfsUdSrwPikgdWIAl5m2yCbPt
         AbIg==
X-Gm-Message-State: AOAM532CqBfgniPxP+2H0KnMZUDHgG6jtVAW0vpGk21v316yiEvCy7QK
        7305bGVPF/umRMt83FaRfg5p1YMi7u4dpcWL
X-Google-Smtp-Source: ABdhPJy6WnIc+rrQIbXIb6th2IZHIACGoRnntqR7hZbDz6zI0bzsyaU6TpMGZ4odckTafnmPDZVfnA==
X-Received: by 2002:a05:6402:4396:b0:412:b131:fca6 with SMTP id o22-20020a056402439600b00412b131fca6mr31551914edc.133.1646265810011;
        Wed, 02 Mar 2022 16:03:30 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id cc20-20020a0564021b9400b00412f2502469sm158054edb.23.2022.03.02.16.03.28
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 16:03:28 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so2253189wmb.3
        for <linux-pwm@vger.kernel.org>; Wed, 02 Mar 2022 16:03:28 -0800 (PST)
X-Received: by 2002:a05:600c:190d:b0:381:6ea1:8cc with SMTP id
 j13-20020a05600c190d00b003816ea108ccmr1737073wmq.118.1646265807989; Wed, 02
 Mar 2022 16:03:27 -0800 (PST)
MIME-Version: 1.0
References: <20220218183116.2261770-1-bjorn.andersson@linaro.org> <20220218183116.2261770-2-bjorn.andersson@linaro.org>
In-Reply-To: <20220218183116.2261770-2-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Mar 2022 16:03:15 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UOLcu5xycimDsYTO1spwf=CMRPUSU3o0qRRC+a+zuRTQ@mail.gmail.com>
Message-ID: <CAD=FV=UOLcu5xycimDsYTO1spwf=CMRPUSU3o0qRRC+a+zuRTQ@mail.gmail.com>
Subject: Re: [PATCH v13 2/2] leds: Add driver for Qualcomm LPG
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-leds@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Luca Weiss <luca@z3ntu.xyz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Fri, Feb 18, 2022 at 10:29 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> +static void lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +                             struct pwm_state *state)
> +{
> +       struct lpg *lpg = container_of(chip, struct lpg, pwm);
> +       struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
> +       unsigned int pre_div;
> +       unsigned int refclk;
> +       unsigned int val;
> +       unsigned int m;
> +       u16 pwm_value;
> +       int ret;
> +
> +       ret = regmap_read(lpg->map, chan->base + LPG_SIZE_CLK_REG, &val);
> +       if (ret)
> +               return;
> +
> +       refclk = lpg_clk_rates[(val & PWM_CLK_SELECT_MASK) - 1];

I don't know why I didn't notice it before (maybe I was accidentally
not building with KASAN?), but in my recent boots I'm getting a KASAN
error pointing at the line above.

Sure enough, the above looks a bit on the unsafe side. If (val & 0x3)
is 0 then the "-1" will not be so wonderful. I put some printouts and,
indeed, it's not so great.

[    7.201635] DOUG: val is 0x00000004

Amazingly my `refclk` ends up as 0 and I guess somehow this doesn't
cause a divide by 0.


-Doug
