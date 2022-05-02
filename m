Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A63516C67
	for <lists+linux-pwm@lfdr.de>; Mon,  2 May 2022 10:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383915AbiEBIvW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 May 2022 04:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383968AbiEBIu7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 May 2022 04:50:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7058958E6E
        for <linux-pwm@vger.kernel.org>; Mon,  2 May 2022 01:47:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id p18so15828974edr.7
        for <linux-pwm@vger.kernel.org>; Mon, 02 May 2022 01:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYpQHYL5SUkj/kk4MRQrQhCiJiLDX2y0vsLoj8vEwOY=;
        b=g/xkLdQSS4fstIinvit+TJp/68RBb26pUrxi69oxmD+T1l9JE2sRE8wUtzeOAUTu88
         dTct3m+p+Gt0yNk0wEK7nIrV0NV5K6+HGhHv0P+VgDhWuHgff4fJMKSR4UUQFtRok3DI
         oTHKWVKPN7fWtd5EEnalUv+3FMg2BjOMpRG0hB33qWKbumqOgGnrN3FZOXCM0K+QqQWf
         7nFWXUpcE3w0qGJ/ibsL5IPp80VPE/GhCbKs7S41NfgQUfnOOIeGs+90PeMoyUUdHRv5
         jIjP9RHWJt/MMkF9i0S2OS8CXe3mbduGzbROcKCFjxlF3ZWPTZr1wYV6VP+ZSMwxou7P
         d1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYpQHYL5SUkj/kk4MRQrQhCiJiLDX2y0vsLoj8vEwOY=;
        b=jJBm3d+PYrCkl0xMkgqc45gVLr3AW/5/DW+E+ZjTU6Jw1HoHBzkO0jTxEMXSDyrcRq
         PkOcdl2VHsbREI5S4QGgH9vm3fhqIEWA5Fhs2UiPL1dCpjXMMoiIi/2jNoQkh/bVmu9t
         QoTHGFahkw4xNqOrlDqAFfJhWLm5Q4+bMVw2MYfpcq0q0WJoX8Z+DBV6B9nE3j4YIRq4
         wzIxfGwzsAyjJrmeGo8J4U2iY4sK7fD1y47BwhqP/n/5Ev/3vtsh3QIj0Uw3j8pUX0cW
         6ppoJ2sPL52yF4P41QYaonKaV+k/i/ERLmLjAQZY+QwWjKG3qQEhKlCFInp7r6PB/mDK
         9kEQ==
X-Gm-Message-State: AOAM533qzcS3sEzJcxUirGpdzV0bDz0FVucqyMtCs/0lLqAwq+Kpcvte
        xxmETYXX68kTGfKn+QZcp1jGDdBDXm7G0jg0qJEuDw==
X-Google-Smtp-Source: ABdhPJyeedvZw9SdaKGCKhS6IM3vLiDAkyLNkFyLGWoEwL/WWPn+zH0IKqxba8VILB+qr/75D2Kq4b6C0mgta4XBUxQ=
X-Received: by 2002:a05:6402:1a34:b0:425:ca01:58ec with SMTP id
 be20-20020a0564021a3400b00425ca0158ecmr12405487edb.373.1651481235999; Mon, 02
 May 2022 01:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <145383feecbe43f3bbd3e128143f7890f0314b3b.1649658220.git.baruch@tkos.co.il>
In-Reply-To: <145383feecbe43f3bbd3e128143f7890f0314b3b.1649658220.git.baruch@tkos.co.il>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 2 May 2022 10:47:05 +0200
Message-ID: <CAMRc=Mei_ZWPzSMHpC1Ao8nU487_SUq7qQGEDkxwdRb0jmx7cQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: mvebu: drop pwm base assignment
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Apr 11, 2022 at 8:25 AM Baruch Siach <baruch@tkos.co.il> wrote:
>
> pwmchip_add() unconditionally assigns the base ID dynamically. Commit
> f9a8ee8c8bcd1 ("pwm: Always allocate PWM chip base ID dynamically")
> dropped all base assignment from drivers under drivers/pwm/. It missed
> this driver. Fix that.
>
> Fixes: f9a8ee8c8bcd1 ("pwm: Always allocate PWM chip base ID dynamically")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/gpio/gpio-mvebu.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 4c1f9e1091b7..a2c8dd329b31 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -871,13 +871,6 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
>         mvpwm->chip.dev = dev;
>         mvpwm->chip.ops = &mvebu_pwm_ops;
>         mvpwm->chip.npwm = mvchip->chip.ngpio;
> -       /*
> -        * There may already be some PWM allocated, so we can't force
> -        * mvpwm->chip.base to a fixed point like mvchip->chip.base.
> -        * So, we let pwmchip_add() do the numbering and take the next free
> -        * region.
> -        */
> -       mvpwm->chip.base = -1;
>
>         spin_lock_init(&mvpwm->lock);
>
> --
> 2.35.1
>

Queued for fixes, thanks!

Bart
