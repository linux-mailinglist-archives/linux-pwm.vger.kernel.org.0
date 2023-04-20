Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877A96E8ED7
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Apr 2023 12:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjDTKEv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Apr 2023 06:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbjDTKEq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Apr 2023 06:04:46 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF62C1
        for <linux-pwm@vger.kernel.org>; Thu, 20 Apr 2023 03:04:44 -0700 (PDT)
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 342CE4427D
        for <linux-pwm@vger.kernel.org>; Thu, 20 Apr 2023 10:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681985081;
        bh=MPSX/AfZygcMhOCNuxX1ZecGolc5hbcZ2NhciybSDRM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=IOn8OldVF6rPGchlOhu8bM8FTFMFU/4uCWbu4z7hL3l7Vmg7KzHJCvgix4/MbrBRm
         lXQCtm9sj5PD+9hRuAbPZXVOt6HeLlFNbCqqzObfnmqRsDUZALXBXBR4LpximS8Myg
         vaCvR/CD0Eob0sIAXHF1JjCHLfGVXaTI7aEYoZtxvac2CNsZF9KPVlwIanBgD4siPo
         C87UOZxHDOsPbj/ENvhcL5ittUYsjGU3NOP9xS5nl77zraVdYEtOisalRLCPdZbT4v
         3vF8XAP1v0/Cu70rPdBEBWjQGZL/DXBQ8hBhI2xgREQznQXG1dLehyz7AoRUupnB19
         pREzMgFWAH6Kg==
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-74d0b039ecfso32776885a.2
        for <linux-pwm@vger.kernel.org>; Thu, 20 Apr 2023 03:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681985079; x=1684577079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPSX/AfZygcMhOCNuxX1ZecGolc5hbcZ2NhciybSDRM=;
        b=Yb6nyI9lc9FVQaTBa7k1yvIGBydmP86uUkiPvkZSRYEl0BMz9PmXAplDENKzbH7WIZ
         i8me1F3YEdlcfBshVoQarsJB+ocIQmXJUAVgioRVqig8KGP6wSR0gfsWG/XycHwm4xaN
         GZDL2WLPUVVX43SS0rCN0+K+l26dccjXRHfFON1eC9waIwi2pQXxkQDVoKU7uewqJ0Bu
         5/ITBk2CpDiO/cIneg2/bZrkntqVR3m5yJtwwg8gwvmdGIT+DMp1Vgo6oCvfoIr9AoFv
         qlSwr9hLv17KUwUxWvvmgdr7jNnjTK7Swar4+iouSwwsshj2qDEMdWbzxqUhAost2ge/
         uJJw==
X-Gm-Message-State: AAQBX9crcsJUlLvsghr4brciBDhsXKof9wBLSel5G/YKjrUpI9QfOaBq
        Svu4+sQ7t++qYiHOJrDZDgAN67buqAelT6JkS4YE0L+H8Muc30OHBN121M1DrR2SHcWiqNkfGwy
        h6m9F2WoDhMi0W6xxNET8je4T1nhXVTAbeXoOdmk/uJLpCVU+9eWN8NGDTZEL7A==
X-Received: by 2002:ac8:5792:0:b0:3ef:5733:29e4 with SMTP id v18-20020ac85792000000b003ef573329e4mr667776qta.64.1681985079079;
        Thu, 20 Apr 2023 03:04:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350YZOJhhJ2/DG8mPZrGpHZG2bUew/6AA3c59/iwkpF1lN4P7gKE74NKz6hnyMtvTbz3kA9sQrlj/oL+Xnlk50P8=
X-Received: by 2002:ac8:5792:0:b0:3ef:5733:29e4 with SMTP id
 v18-20020ac85792000000b003ef573329e4mr667740qta.64.1681985078844; Thu, 20 Apr
 2023 03:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230420093457.18936-1-nylon.chen@sifive.com> <20230420093457.18936-3-nylon.chen@sifive.com>
In-Reply-To: <20230420093457.18936-3-nylon.chen@sifive.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Thu, 20 Apr 2023 12:04:22 +0200
Message-ID: <CAJM55Z-smXpgL+QyTSeAWt=B-RS_qtbrFZtJpP-cQS0gsQnDSw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pwm: sifive: change the PWM controlled LED algorithm
To:     Nylon Chen <nylon.chen@sifive.com>
Cc:     aou@eecs.berkeley.edu, conor@kernel.org, geert+renesas@glider.be,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nylon7717@gmail.com, zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 20 Apr 2023 at 11:35, Nylon Chen <nylon.chen@sifive.com> wrote:
>
> The `frac` variable represents the pulse inactive time, and the result of
> this algorithm is the pulse active time. Therefore, we must reverse the
> result.
>
> The reference is SiFive FU740-C000 Manual[0]
>
> Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf [0]
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> ---
>  drivers/pwm/pwm-sifive.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> index 393a4b97fc19..d5d5f36da297 100644
> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -132,13 +132,13 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  {
>         struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
>         struct pwm_state cur_state;
> -       unsigned int duty_cycle;
> +       unsigned int duty_cycle, period;
>         unsigned long long num;
>         bool enabled;
>         int ret = 0;
>         u32 frac;
>
> -       if (state->polarity != PWM_POLARITY_INVERSED)
> +       if (state->polarity != PWM_POLARITY_NORMAL && state->polarity != PWM_POLARITY_INVERSED)
>                 return -EINVAL;
>
>         cur_state = pwm->state;
> @@ -154,10 +154,13 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>          * calculating the register values first and then writing them
>          * consecutively
>          */
> +       period = max(state->period, ddata->approx_period);

Hi Nylon,

I don't understand this patch. You introduce this new variable,
period, and set it here but you never seem to use it. If you planned
to use it instead of state->period below, why should it be the max of
the old period and what is requested? What happens if the consumer
wants to lower the period?

Also above you now allow both PWM_POLARITY_NORMAL and
PWM_POLARITY_INVERSED but you treat both cases the same.

/Emil

>         num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
>         frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
> -       /* The hardware cannot generate a 100% duty cycle */
>         frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> +       /* The hardware cannot generate a 100% duty cycle */
> +       frac = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
> +
>
>         mutex_lock(&ddata->lock);
>         if (state->period != ddata->approx_period) {
> --
> 2.40.0
>
