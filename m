Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B0D50098A
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Apr 2022 11:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbiDNJVI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Thu, 14 Apr 2022 05:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241631AbiDNJVF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Apr 2022 05:21:05 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D5850B34;
        Thu, 14 Apr 2022 02:18:37 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id gg1so2647440qvb.11;
        Thu, 14 Apr 2022 02:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fMhQIJRfgWS4EhM9otCXpnI/MleaIst3KRLaxVN72yU=;
        b=Altr5Mk9/bbLqhI8u2Nwr8xto5/yFIx4i/FVobSBPWBrM40ZCMKkb4g3c+D/eEQTOh
         r31LMMlljNT4tegOvu051WuVVZ/SqaEIz39votJyCYzRyU/qxEJh6bzpTeGGMdt6aBnm
         wHu/WWh4tl3ox50Kfwcctx9LGVHZiYy6VJ2QNM2ooGwuwm88+2DBNvpsx4Xtfv28ftIt
         bRzSPtFo653nknJJjQnBu+OAXInuhCvFnyarcyhSWNfLXzUNU2JwSv3HTvHqMf6jAQ8J
         wvzdTfiNbSzoAbym40Q/JEnyVsrmJhrhKFIou5fCW1LLbsr0qEXoNERj8GPRBxKgSGxH
         rX5A==
X-Gm-Message-State: AOAM533Kr1zYi4/d2uPEudZNbBO3wb8CCe8Uxn1ROY9WavReFzxx3dIx
        OSUxI1ggctE8Nh2tZlipzW4z9unrqxcdFQ==
X-Google-Smtp-Source: ABdhPJzRdNV1Lnt8jsTtw9LrDyJgI2adjVEaQgPh7itcTpS8O12WidisEpvkHsn/+wROIJqTuySvnw==
X-Received: by 2002:a05:6214:5282:b0:443:9905:a58f with SMTP id kj2-20020a056214528200b004439905a58fmr2431439qvb.98.1649927916563;
        Thu, 14 Apr 2022 02:18:36 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id c17-20020ac85a91000000b002e1dd8ae44bsm919401qtc.29.2022.04.14.02.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 02:18:36 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id i20so8306806ybj.7;
        Thu, 14 Apr 2022 02:18:36 -0700 (PDT)
X-Received: by 2002:a5b:24e:0:b0:63d:cba0:3d55 with SMTP id
 g14-20020a5b024e000000b0063dcba03d55mr967311ybp.613.1649927915827; Thu, 14
 Apr 2022 02:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220413085050.61144-1-u.kleine-koenig@pengutronix.de> <20220413085050.61144-3-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220413085050.61144-3-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Apr 2022 11:18:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUsmjjKWBWNWr9DCmbWM8CJzXxDbcpjzystYhT3tgFtjg@mail.gmail.com>
Message-ID: <CAMuHMdUsmjjKWBWNWr9DCmbWM8CJzXxDbcpjzystYhT3tgFtjg@mail.gmail.com>
Subject: Re: [PATCH 3/6] pwm: renesas-tpu: Implement .apply() callback
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Apr 13, 2022 at 10:51 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> To eventually get rid of all legacy drivers convert this driver to the
> modern world implementing .apply().
>
> As pwm->state might not be updated in tpu_pwm_apply() before calling
> tpu_pwm_config(), an additional parameter is needed for tpu_pwm_config()
> to not change the implemented logic.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

The display backlight still works fine on r8a7740/armadillo, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
