Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED640508F0A
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Apr 2022 20:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381400AbiDTSLA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 20 Apr 2022 14:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381398AbiDTSK7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Apr 2022 14:10:59 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C8941638;
        Wed, 20 Apr 2022 11:08:12 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d14so1570674qtw.5;
        Wed, 20 Apr 2022 11:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rJ5KdKb2Ihk3sdqTny8ustRpCF/DOHozaFbfN088QOY=;
        b=cI80pB+XC7yGZHepf3czsQKtw0qTNhr/7V2Tqm1ZDbvTayZi96vOnqSmr2c+lQ44yw
         zaTHbD+AJVOskTGVNo8Uph2YlLsgAmt5AzjbGiIjox5BhJrq4UXnnaZjWTWfvMQGWEo9
         8J+pR3wE0Sw8P8MbOM9D6tqE0Chpud+yzgTweNVbZV3jweP4ELKp4T71DEKKTqnS4a/j
         ffBWribEN9UQPC5DRQ7XAxstnGzp+jENZhFaBYW0KnhyKcTxMJyk/PjVCBo1d3rwNeKL
         VKxV8R6dQu1FBE29NB+ndt2UXSVGpLLowFkNkwPM959WT62XXgkqPb0bXbLu117zrxU9
         nWkA==
X-Gm-Message-State: AOAM530Rz/fa/S0/DwyOX9bB12p5RI6FggxChsBU+n+wKFmNRRXt13en
        GMSPUKOBq47olcmuujMiWw6aie1IIYRaMAEk
X-Google-Smtp-Source: ABdhPJy5Ny2ZC0qbdMFz/bkLUNl4Hk90YFLxu+hGz7bc/dZPgbdB1LcppTwg1wEbA/AlVz9V0/BWxg==
X-Received: by 2002:ac8:5a16:0:b0:2e1:ea00:b4e1 with SMTP id n22-20020ac85a16000000b002e1ea00b4e1mr14670584qta.329.1650478091700;
        Wed, 20 Apr 2022 11:08:11 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 15-20020ac8594f000000b002f200ea2518sm2230517qtz.59.2022.04.20.11.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 11:08:11 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2ec05db3dfbso27061727b3.7;
        Wed, 20 Apr 2022 11:08:11 -0700 (PDT)
X-Received: by 2002:a81:5210:0:b0:2ef:21e3:54dd with SMTP id
 g16-20020a815210000000b002ef21e354ddmr22467703ywb.438.1650478091017; Wed, 20
 Apr 2022 11:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de> <20220420121240.67781-4-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220420121240.67781-4-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Apr 2022 20:07:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW-qKUqG+nyq4YBHHLW2dKUPvttG3RqNU7W0js4Bp8n4Q@mail.gmail.com>
Message-ID: <CAMuHMdW-qKUqG+nyq4YBHHLW2dKUPvttG3RqNU7W0js4Bp8n4Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] pwm: renesas-tpu: Implement .apply() callback
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Apr 20, 2022 at 2:12 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> To eventually get rid of all legacy drivers convert this driver to the
> modern world implementing .apply().
>
> As pwm->state might not be updated in tpu_pwm_apply() before calling
> tpu_pwm_config(), an additional parameter is needed for tpu_pwm_config()
> to not change the implemented logic.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
