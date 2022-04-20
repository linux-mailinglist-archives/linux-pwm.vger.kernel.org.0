Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE77508F1E
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Apr 2022 20:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbiDTSNy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 20 Apr 2022 14:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346995AbiDTSNx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Apr 2022 14:13:53 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C02946179;
        Wed, 20 Apr 2022 11:11:07 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d14so1576578qtw.5;
        Wed, 20 Apr 2022 11:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tuOuuZ8RzrhSD6HkG5IffR5NCzB4JuyXD2VhOYW8pNM=;
        b=M7urgjidQPelAapaNnH0s1vQgZOIYB+BaTWtH1JdGLBm60Sk1Rkt2SQ6KasE/+NZIu
         5COutkx62uUigqS8pPjZjhKcH/lwxGe1tZbBLMSfwZsgdOpe2KJSu4lNOpMEBRquN0yK
         x4BrVb++IcdzdrScsrXo5rB52ZalCfpE0w+MBF8qJBo8cdExvyFb5/fKQ1wx5GqQI/rc
         WxPOc5U9Fck7QTiyREDNaU9Jx9UUUPm95JneXYWFxS04Pha6j5oCX7wxThE9kUn8FHhh
         ggmroGTCIvjw2w6OdFA8dsHhXcS0P2JRm12T4Kf9TyLHulwBwIUI5MUZHwoBtuS3eRNR
         MjZQ==
X-Gm-Message-State: AOAM530LC4gwXSsN7rWYGWioFpY6HlXs8V1Q/2wmZnS5w6KiotIYKWSl
        75m3ZxDBEODsQaOQTEB6kdgmnFg9CbqvwnIB
X-Google-Smtp-Source: ABdhPJzz+2ZXjxCN7U/EjSvT3/kw6GrOm+ke1JtzNoR41xlfAe97vinpt2dZwb3SBadPMoPhMIFXAg==
X-Received: by 2002:a05:622a:6206:b0:2f1:d7bc:7522 with SMTP id hj6-20020a05622a620600b002f1d7bc7522mr14790872qtb.556.1650478266193;
        Wed, 20 Apr 2022 11:11:06 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id e16-20020ac85990000000b002f33eb4523asm2031321qte.18.2022.04.20.11.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 11:11:05 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id r189so4357045ybr.6;
        Wed, 20 Apr 2022 11:11:05 -0700 (PDT)
X-Received: by 2002:a25:8087:0:b0:641:dd06:577d with SMTP id
 n7-20020a258087000000b00641dd06577dmr21041576ybk.207.1650478265318; Wed, 20
 Apr 2022 11:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de> <20220420121240.67781-7-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220420121240.67781-7-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Apr 2022 20:10:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUEOvRHXbMW6ncvB-5AZc_ivgparfLo_uOGHCRfZX7Avw@mail.gmail.com>
Message-ID: <CAMuHMdUEOvRHXbMW6ncvB-5AZc_ivgparfLo_uOGHCRfZX7Avw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] pwm: renesas-tpu: Improve precision of period and
 duty_cycle calculation
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Apr 20, 2022 at 2:12 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> Dividing by the result of a division looses precision. Consider for example
> clk_rate = 33000000 and period_ns = 500001. Then
>
>         clk_rate / (NSEC_PER_SEC / period_ns)
>
> has the exact value 16500.033, but in C this evaluates to 16508. It gets
> worse for even bigger values of period_ns, so with period_ns = 500000001,
> the exact result is 16500000.033 while in C we get 33000000.
>
> For that reason use
>
>         clk_rate * period_ns / NSEC_PER_SEC
>
> instead which doesn't suffer from this problem. To ensure this doesn't
> overflow add a safeguard check for clk_rate.
>
> Note that duty > period can never happen, so the respective check can be
> dropped.
>
> Incidentally this fixes a division by zero if period_ns > NSEC_PER_SEC.
> Another side effect is that values bigger than INT_MAX for period and
> duty_cyle are not wrongly discarded any more.
>
> Fixes: 99b82abb0a35 ("pwm: Add Renesas TPU PWM driver")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
