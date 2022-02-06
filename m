Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654C24AB1DB
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Feb 2022 20:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiBFT7G (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 6 Feb 2022 14:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiBFT7G (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 6 Feb 2022 14:59:06 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A39DC06173B;
        Sun,  6 Feb 2022 11:59:02 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id st12so11262547ejc.4;
        Sun, 06 Feb 2022 11:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r0AolYwnEMWAYwClQfS+awCY3HSoJaTPYQMUCDSsilA=;
        b=VHnT9atIoj86ykYQE3oEP+6gzBJbZ0GsG51m7ntr2stwYRKSMI5rbThopQsaXqu3db
         Gtlt7RlhEHYAFIGr0M6ihRzt+YTDQ4yfuBTU5cDuyU1IjjJOh7/Ys5ApcRK+EQsRxrRJ
         I9L3cTrmhe+NsYQCHrjCwBtKjSbUk1VVsvBiwG2Tm9OhxsLPWyWsctt8wD9BvH7qwTF6
         a08B6hvKrnowgBU3jXKIqO8XSB3ReG4mpD3nEvofA2aJ74+rf/NwHOI0VGIiDP1Yq+wm
         t/0Z24GsJKzn0Zg0JAZvXw27Kr3sY8kcrNJy3Oo2aXj825Zk+L/TE+2T96clYfgN8N0e
         tB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0AolYwnEMWAYwClQfS+awCY3HSoJaTPYQMUCDSsilA=;
        b=ZcpV7POgYh2P/gAd95FV4pd+9NGqnHXVO/6qsrVFpCPTF4jW12aLtGOMnKS6BlnbU0
         pNWEwY5J8qZrWNcsKpNSiGFmYT/jNHMISYGNYBSb+MfsiYW4VyQKnFicvLBgQ7wcIonG
         freNkxQPhDJghkK3gMf+5/dhXizx+YajqK1G/LQ9XQOKt1qRQYsFjutZm0QnUAAj3FGf
         e2OoyXfpNXRNRkdElk7bMMl2YDEBxWtnNaGxC6xuXArxahZ/26UPUY6eyikVlhQ1zkZi
         Qks4aLgEXnw2cjlpXtnuR/Yjqp7u+bPphzBLVe26sHwJwVyjn0deL9QXkh0qdgQkaxWA
         iw1A==
X-Gm-Message-State: AOAM533rar5tj0obDoteUNNk0lr7osMHVTn4xS+Ji3GhK0Q/pTqLcZW3
        aM9f2UT+1uxe6ScaPx4UtQvMwK7gBug6dIgEA4PsX/JWG24=
X-Google-Smtp-Source: ABdhPJxKiNPRR6y9aW0iVWML9eMzd96YQf1itxxqOQvZQHMpo7+RxcdQY44Qc+bra+aNl4YBfeIIke90xA3NDaurnmI=
X-Received: by 2002:a17:907:2d92:: with SMTP id gt18mr7176481ejc.579.1644177540649;
 Sun, 06 Feb 2022 11:59:00 -0800 (PST)
MIME-Version: 1.0
References: <20220206193554.171070-1-sven@svenschwermer.de> <20220206193554.171070-3-sven@svenschwermer.de>
In-Reply-To: <20220206193554.171070-3-sven@svenschwermer.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 6 Feb 2022 21:58:24 +0200
Message-ID: <CAHp75VesxJFDy_QfC17xOt3nji1dA9NQh=bLnynfXRz-dfV7Lg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] leds: Add PWM multicolor driver
To:     Sven Schwermer <sven@svenschwermer.de>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        post@lespocky.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Feb 6, 2022 at 9:36 PM <sven@svenschwermer.de> wrote:
>
> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
>
> By allowing to group multiple monochrome PWM LEDs into multicolor LEDs,
> all involved LEDs can be controlled in-sync. This enables using effects
> using triggers, etc.

Thanks for the update!

...

> +       mcnode = device_get_named_child_node(&pdev->dev, "multi-led");
> +       if (!mcnode)
> +               return dev_err_probe(&pdev->dev, -ENODEV,
> +                                    "expected multi-led node\n");

> +       fwnode_for_each_child_node(mcnode, fwnode) {
> +               pwmled = &priv->leds[priv->mc_cdev.num_colors];
> +               pwmled->pwm = devm_fwnode_pwm_get(&pdev->dev, fwnode, NULL);
> +               if (IS_ERR(pwmled->pwm)) {
> +                       ret = PTR_ERR(pwmled->pwm);
> +                       dev_err(&pdev->dev, "unable to request PWM: %d\n", ret);

> +                       fwnode_handle_put(fwnode);
> +                       goto release_mcnode;

I would make a single return point for this...

> +               }
> +               pwm_init_state(pwmled->pwm, &pwmled->state);
> +
> +               ret = fwnode_property_read_u32(fwnode, "color", &color);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "cannot read color: %d\n", ret);

> +                       fwnode_handle_put(fwnode);
> +                       goto release_mcnode;

...and this.

> +               }
> +
> +               subled[priv->mc_cdev.num_colors].color_index = color;
> +               priv->mc_cdev.num_colors++;
> +       }

...

Something like

  err_release_fwnode:
      fwnode_handle_put(fwnode);

here

> +release_mcnode:
> +       fwnode_handle_put(mcnode);
> +       return ret;
> +}

If you consider that this makes ->probe() error path a bit confusing,
you can split out the loop to a helper where that single error path
will be engaged.

-- 
With Best Regards,
Andy Shevchenko
