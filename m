Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40DA7045E9
	for <lists+linux-pwm@lfdr.de>; Tue, 16 May 2023 09:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjEPHNG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 16 May 2023 03:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjEPHNB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 16 May 2023 03:13:01 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5891030DA;
        Tue, 16 May 2023 00:12:55 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-55a10577911so194972307b3.0;
        Tue, 16 May 2023 00:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684221174; x=1686813174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tzYiC/0Tw67skv8TtmbPziFE9CjLTJsWbaQN9rj7dw=;
        b=IIdp7oK21xFoMsELXgbNuq/msZjpbXdaQNMb8DgZvGTp2prFAfQxBw1D5nTpfZkVnJ
         09raC9IucgVSnCw5z2nScltWjH7IJKuPLh1HKwq9MVOf+zXyx0Kff2RXME36DZUct+fC
         9lS8nW3JU4FH7+YN08WoT+UMCBTOZ0YJxsWZ29Vj++sx7ppzThhzD16rU27E7CbhXVK9
         2hGZqorZnZCWTt4uBBicyuH5mj9sYtRxnswwDsHLZ4WWUlh1g0i04LaUNzg2O2GvguNF
         0ovZeapHzXK13twabz9wdicHB0WPgjLFEyX2tscG+pr0MlgL41X/VsK0byBhgMHGGDGM
         EIww==
X-Gm-Message-State: AC+VfDw81UBJjb1xOJnWk2fvyRvKtAdBbskQ/ulRsSk0kXOFQCSBG2Y0
        wPKcrWECnu7VUxkBCmYxm4s1AiiydGyITA==
X-Google-Smtp-Source: ACHHUZ47BU3KpckIQgLK1ymcRqMLslfFwnAszeBwXhuzFJIzRnIQrtO4hmU/aKk7/HtwJQolhNV6wg==
X-Received: by 2002:a81:920c:0:b0:55a:a635:7e1e with SMTP id j12-20020a81920c000000b0055aa6357e1emr37373854ywg.31.1684221174194;
        Tue, 16 May 2023 00:12:54 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id w191-20020a0dd4c8000000b0054f50f71834sm399808ywd.124.2023.05.16.00.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 00:12:53 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-559e2051d05so194747287b3.3;
        Tue, 16 May 2023 00:12:53 -0700 (PDT)
X-Received: by 2002:a0d:e086:0:b0:560:ee0e:a1cb with SMTP id
 j128-20020a0de086000000b00560ee0ea1cbmr15239361ywe.33.1684221173100; Tue, 16
 May 2023 00:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230418102037.346405-1-biju.das.jz@bp.renesas.com> <20230516064304.cdiifro7lb7ne2jp@pengutronix.de>
In-Reply-To: <20230516064304.cdiifro7lb7ne2jp@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 16 May 2023 09:12:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5AgBa+dhtv+nxswsRfjY+xCL268wGDt--+-VXRhOU4g@mail.gmail.com>
Message-ID: <CAMuHMdV5AgBa+dhtv+nxswsRfjY+xCL268wGDt--+-VXRhOU4g@mail.gmail.com>
Subject: Re: [PATCH v16] pwm: Add Renesas RZ/G2L MTU3a PWM driver
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, May 16, 2023 at 8:43 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Apr 18, 2023 at 11:20:37AM +0100, Biju Das wrote:
> > +static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > +                              struct pwm_state *state)
> > +{
> > +     struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
> > +
> > +     pm_runtime_get_sync(chip->dev);
>
> Return value checking?

And please use the new(er) pm_runtime_resume_and_get() instead.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
