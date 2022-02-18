Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F194F4BBD18
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Feb 2022 17:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiBRQL0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 18 Feb 2022 11:11:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiBRQLY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 18 Feb 2022 11:11:24 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4629F2B3AFA
        for <linux-pwm@vger.kernel.org>; Fri, 18 Feb 2022 08:11:06 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id gb39so16194659ejc.1
        for <linux-pwm@vger.kernel.org>; Fri, 18 Feb 2022 08:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2OloDpJvsjdWi7wGdly9G9Fl4hNwVdVhIAytmuuXRs=;
        b=EkJRBZvSnj9R4IxbhdruXGy1aYW2yS2ue39KyFuXYWoUHS8yMXNEtcICUEj45dcK7D
         Ju1waEUm5V22tInwgU0e5alziJzVuCyDNowFFx/G8WGjFod0Jk+kODbiGWAn11xCkIY6
         Nb4cJq6//pZhbOaTWDt3uiAOK54AuW1bKNcUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2OloDpJvsjdWi7wGdly9G9Fl4hNwVdVhIAytmuuXRs=;
        b=pXxtanXdfLXG2kDMg0YAco/7ThijZ4/qg1wAYZSFcU8CtnwRcHawi4lp6gaPtmdkUM
         joF8Pxv8hwioRxseelE6V+Zfq2xk1zu32iGr2CCR3xrHMIOFA7F1sM3WIigifaT0rI9D
         b3tHPneyZS7YUtBrmEVh3SUwiviX2WL6DTVp5N/M8mmOmRUbItrXUQtnIXZCRhyz0kOF
         FBr0kxt4DJKbUOF1Wr3vKhatxNAX5Be168HZk6wYxROIFhfyuzSUUFMiy4yanEk4jjQQ
         Q7bUOmk248cKHD4utzuRnsBl37ogB1im8PuzriXyiJqDBdFdHvJX4euRM+jE8NELqd39
         2BIA==
X-Gm-Message-State: AOAM533wuCntddKjpTPtrmORLbtLDqMHJfmtZze0Sr+tbCmUywwt7uaM
        1QuGsYhYZk+vrlvNsRqe6znzB77lCNCX5kEqP/c=
X-Google-Smtp-Source: ABdhPJyFZ2QvE7q4v8OxqPntMKKIjNyXd/iE4BkgdKBj6eJu4uKQKCP0k0IczwF3mvL0z+cwHx7Usw==
X-Received: by 2002:a17:906:65d0:b0:6ce:29b2:bdbe with SMTP id z16-20020a17090665d000b006ce29b2bdbemr6741507ejn.572.1645200664498;
        Fri, 18 Feb 2022 08:11:04 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id w4sm4960481edc.73.2022.02.18.08.11.03
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 08:11:04 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id u2so14248860wrw.1
        for <linux-pwm@vger.kernel.org>; Fri, 18 Feb 2022 08:11:03 -0800 (PST)
X-Received: by 2002:adf:ef07:0:b0:1e3:333f:a101 with SMTP id
 e7-20020adfef07000000b001e3333fa101mr6712804wro.301.1645200663316; Fri, 18
 Feb 2022 08:11:03 -0800 (PST)
MIME-Version: 1.0
References: <20220216045620.1716537-1-bjorn.andersson@linaro.org> <20220216045620.1716537-2-bjorn.andersson@linaro.org>
In-Reply-To: <20220216045620.1716537-2-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 18 Feb 2022 08:10:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xj5k7JROP1PFY9tmXxLY7FRJNdr-+UmkCW_YGqpDkFew@mail.gmail.com>
Message-ID: <CAD=FV=Xj5k7JROP1PFY9tmXxLY7FRJNdr-+UmkCW_YGqpDkFew@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] leds: Add driver for Qualcomm LPG
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Satya Priya Kakitapalli <c_skakit@qti.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh+dt@kernel.org>,
        linux-leds@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-pwm <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Tue, Feb 15, 2022 at 8:54 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> +static int lpg_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +                        const struct pwm_state *state)
> +{
> +       struct lpg *lpg = container_of(chip, struct lpg, pwm);
> +       struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
> +       int ret;
> +
> +       if (state->polarity != PWM_POLARITY_NORMAL)
> +               return -EINVAL;
> +
> +       mutex_lock(&lpg->lock);
> +
> +       if (state->enabled) {
> +               ret = lpg_calc_freq(chan, state->period);
> +               if (ret < 0)
> +                       goto out_unlock;
> +
> +               lpg_calc_duty(chan, state->duty_cycle);
> +       }
> +       chan->enabled = state->enabled;
> +
> +       lpg_apply(chan);
> +
> +       triled_set(lpg, chan->triled_mask, chan->enabled ? chan->triled_mask : 0);
> +
> +out_unlock:
> +       mutex_unlock(&lpg->lock);
> +
> +       return ret;
> +}

My compiler (correctly) yelled that `ret` is returned uninitialized if
`state->enabled` is false. I initialized `ret` to 0 and the problem
went away. I assume that the patch will need to spin to fix that
unless everything else looks great and a maintainer wants to fix that
when applying.

With that fix, I was able to use Bjorn's patch along with Satya's
patches adding pm8350c support (removing the now defunct
"pwm_9bit_mask" property) to make the PWM on my board work. Thus, once
the error my compiler complained about is fixed I'm happy with my
`Tested-by` being added.

For now I haven't actually reviewed the code here, but if folks feel
like it needs an extra pair of eyes then please yell and I'll find
some time to do it.

-Doug
