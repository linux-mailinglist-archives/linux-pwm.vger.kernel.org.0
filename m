Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010E1508F2C
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Apr 2022 20:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353112AbiDTSP2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 20 Apr 2022 14:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345342AbiDTSP1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Apr 2022 14:15:27 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637F646B0E;
        Wed, 20 Apr 2022 11:12:41 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id b17so1927539qvp.6;
        Wed, 20 Apr 2022 11:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iCvqyqb88M2fI7W+AsUTud002oqRgrzQz/NYl1RGqK0=;
        b=gsESFkPMvxai2ySukHYzd/A5k5qAb5ygnuviXY1JJ9Wvn5hP7QuvDebM5aNIlyqD6m
         AvYFoBISQKP3OUduIqJSoKYR7dVmZFVxFEfQAEQSnG0/JpOZC0R4ameDHEczABMgS5vk
         yiU1+rKDDg2suPpDBGGtJ2OSh/oItqTS/g407eItjvnf9ZQLq2g5d/mlq80liMnxyChz
         87e5u2OaJ7eWZCzvADZ7UC0RyYKKuNezieXOYRPIQMHCNGGjLkn7nuiCOQj1LMEtUfAx
         cnUxJROOy1Dp/u74I4h21UYCvOKehptED65p7asPV4KQ1a2SElv4Kn1XcNcZIgvbGuAe
         ZbRQ==
X-Gm-Message-State: AOAM533dh89nhuO/4f8fgc2JnHIGbXm+brE4Z5QpvmfTDrpGi+l0nZVc
        r/jcnDiRTU2SlQdDtQjZFvCqk8PB5HyTpTi2
X-Google-Smtp-Source: ABdhPJwABTie4TKLo/i+7I5i2HQ65N/SoQxtDGFODNhuXupM7FRgpEHWYXgRu+SVVuLVz5AV14hBkw==
X-Received: by 2002:ad4:5c4f:0:b0:443:fd5b:b7ba with SMTP id a15-20020ad45c4f000000b00443fd5bb7bamr16516543qva.0.1650478360235;
        Wed, 20 Apr 2022 11:12:40 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id l130-20020a37a288000000b0069e8290f28asm1822665qke.97.2022.04.20.11.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 11:12:39 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2eba37104a2so27703107b3.0;
        Wed, 20 Apr 2022 11:12:39 -0700 (PDT)
X-Received: by 2002:a81:4f0d:0:b0:2ec:1556:815 with SMTP id
 d13-20020a814f0d000000b002ec15560815mr22367487ywb.256.1650478358870; Wed, 20
 Apr 2022 11:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Apr 2022 20:12:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW-PCcXKFxX-00c+e+gTPUVp+Gmq09dGsFx2ZBEjzyELA@mail.gmail.com>
Message-ID: <CAMuHMdW-PCcXKFxX-00c+e+gTPUVp+Gmq09dGsFx2ZBEjzyELA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] pwm: renesas-tpu: Various improvements
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Wed, Apr 20, 2022 at 2:12 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> I reworked the series to improve the renesas-tpu PWM driver after
> feedback I got from Geert. The changes are:
>
>  - Add Geert's tags for the first two patches
>    (I didn't add them for the other patches as I changed these enough to
>    not carry the tags forward.)
>  - Use tpu_pwm_disable instead chip->ops->disable (which is NULL now)
>    fixing a crash in v1.
>  - The calculation now uses a switch instead of ilog2.
>    Looking at the compiled code for ARM this is more effective and I
>    assume the same holds true for other platforms.

Display backlight on the R-Mobile A1-based Atmark Techno
Armadillo-800EVA still works fine, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
