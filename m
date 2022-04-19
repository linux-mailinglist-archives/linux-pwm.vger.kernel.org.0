Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCC650661C
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Apr 2022 09:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbiDSHok convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 19 Apr 2022 03:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiDSHoj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Apr 2022 03:44:39 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F54C14087;
        Tue, 19 Apr 2022 00:41:58 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id hf18so11147504qtb.0;
        Tue, 19 Apr 2022 00:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=odQjkTfv7xOPBrASg1PJdJLrZe70jVsmX4Go7kEqewU=;
        b=A9UGnI7oDZKrlS4LfnBDNK+bZeQQd+j+TCDxkuM5YCXiHmNX2ogLKHSRnGWkelDUEU
         sDL0uHcrreWpHgL4+UA4nENlPE+fWXsmCVFsi3RtzR+AdUX91Ac+STX4A5nPaUW5xdKp
         Kc4KB5Ky9fyjXhVdOMj1E2gg7J6pCDqZczg7lQcK32sdtKgR4xM0/Dh/7BGSnecaK5lT
         VP+UmsHF7hkkSXlKP5PP9YUa0VEW3HpMj9n4bWan+zFIlV4sfJoU2ba0iWhMlGJcXTD8
         io2J/rOHeBHJkwnyCgIGbiqDSJBdF2s6bXuQCCsggmKr/Ail37YLbAHbNHn8xAm/fGjJ
         GqwQ==
X-Gm-Message-State: AOAM530amYA2HJF3fU7ASQLsKRsTa1IQXJmbEhRR9Fh9CHHvWeG5lRLg
        jznAd3UEffPOu45TPVwJ/RhPmc3UNpqmuA==
X-Google-Smtp-Source: ABdhPJwVh3ERDEPqUgS97oQyUtPs+1ru94WLyDGrU3T2W1I7yX+cwg9Ef/e39xcEb/nvZntHCiE5FA==
X-Received: by 2002:a05:622a:428e:b0:2f1:ef4d:a393 with SMTP id cr14-20020a05622a428e00b002f1ef4da393mr9345873qtb.642.1650354117415;
        Tue, 19 Apr 2022 00:41:57 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id c4-20020a37b304000000b0069ec13803adsm808903qkf.7.2022.04.19.00.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 00:41:57 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2ef4a241cc5so156082817b3.2;
        Tue, 19 Apr 2022 00:41:56 -0700 (PDT)
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr14141287ywb.132.1650354116663; Tue, 19
 Apr 2022 00:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220413085050.61144-1-u.kleine-koenig@pengutronix.de>
 <20220413085050.61144-6-u.kleine-koenig@pengutronix.de> <CAMuHMdX7Kic2WG+f6hAdjz7SGSjWfi-UTdOrxtmV6D4zE3zh1Q@mail.gmail.com>
In-Reply-To: <CAMuHMdX7Kic2WG+f6hAdjz7SGSjWfi-UTdOrxtmV6D4zE3zh1Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Apr 2022 09:41:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV7okyXpM=q1AMiv1xZSWPGpL1Kz0wzQSAtcKdfE88+kQ@mail.gmail.com>
Message-ID: <CAMuHMdV7okyXpM=q1AMiv1xZSWPGpL1Kz0wzQSAtcKdfE88+kQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] pwm: renesas-tpu: Improve precision of period and
 duty_cycle calculation
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Thu, Apr 14, 2022 at 12:27 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Apr 13, 2022 at 10:51 AM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > Dividing by the result of a division looses precision. Consider for example
> > clk_rate = 33000000 and period_ns = 500001. Then
> >
> >         clk_rate / (NSEC_PER_SEC / period_ns)
> >
> > has the exact value 16500.033, but in C this evaluates to 16508. It gets
> > worse for even bigger values of period_ns, so with period_ns = 500000001,
> > the exact result is 16500000.033 while in C we get 33000000.
> >
> > For that reason use
> >
> >         clk_rate * period_ns / NSEC_PER_SEC
> >
> > instead which doesn't suffer from this problem. To ensure this doesn't
> > overflow add a safeguard check for clk_rate.
> >
> > Incidentally this fixes a division by zero if period_ns > NSEC_PER_SEC.
> > Another side effect is that values bigger than INT_MAX for period and
> > duty_cyle are not wrongly discarded any more.
>
> You forgot to mention that pwm_state.period is no longer truncated to u32.

Please ignore this bogus comment.
Sorry for the fuzz.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
