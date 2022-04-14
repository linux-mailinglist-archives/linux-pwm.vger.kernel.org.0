Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E120500963
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Apr 2022 11:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241023AbiDNJNx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Thu, 14 Apr 2022 05:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241668AbiDNJM6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Apr 2022 05:12:58 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7593EF1C;
        Thu, 14 Apr 2022 02:10:34 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id c199so3411593qkg.4;
        Thu, 14 Apr 2022 02:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FBeXkSZY1J2MFBj2q25L/4WKz0ZrR52C/jmx30iKjuY=;
        b=nASBJqqBL2ZAnW3ENC+QDcwqLpDlKnECyA1HRn/KHJNFbgVpi4NSeCgdlN9ma60qHf
         EEw/k+WDT4UgwBknNXimQd0SwkfpkLDe2BWLDT3x4UuOwWB67/hG4B2NXioxtVESkgdn
         sM5/fv7ayTWElDCyHS3QSKXiRFpP64cDqHqCRtQzgC47sgTa00ovmnR/uM4EeBM1/tGz
         ZuhypgZrZ9ozK56w7OUP0n7lU4KelO819VXVWPQmXiyi5SfaWMQ9qUk9lAAwBoOPBiuz
         Vpx5aVCDueHsr6kAyr2s7lzr7Zj4Xpq+YkooHGbnCKU9kGpML8e1dWzfFAw5MSyGMuJH
         D/xw==
X-Gm-Message-State: AOAM533Y/wjcBJtZyecOa1fAvarop0pX+PVgnV7emaQhk3ICP+UMyFnj
        FlrnqP8bLhTpc3zSdV/9m3vNAZtIrE7WeA==
X-Google-Smtp-Source: ABdhPJyIBPLRg5llVA/c5NYSryuta9ncF6eHqlEibGs90ilZUUjvXwsnCMp9umaJ4e8Xx621VRm19g==
X-Received: by 2002:a05:620a:2886:b0:699:bab7:ae78 with SMTP id j6-20020a05620a288600b00699bab7ae78mr1038912qkp.618.1649927433602;
        Thu, 14 Apr 2022 02:10:33 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id i5-20020a05620a074500b0069c310c5fbesm686208qki.135.2022.04.14.02.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 02:10:33 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2ec04a2ebadso48335397b3.12;
        Thu, 14 Apr 2022 02:10:32 -0700 (PDT)
X-Received: by 2002:a81:c703:0:b0:2d0:cc6b:3092 with SMTP id
 m3-20020a81c703000000b002d0cc6b3092mr1177887ywi.449.1649927432647; Thu, 14
 Apr 2022 02:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220413085050.61144-1-u.kleine-koenig@pengutronix.de> <20220413085050.61144-4-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220413085050.61144-4-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Apr 2022 11:10:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWXotV8_csMDHibd9sJuGDZYVbe+jcMKogMgX2JJotCwQ@mail.gmail.com>
Message-ID: <CAMuHMdWXotV8_csMDHibd9sJuGDZYVbe+jcMKogMgX2JJotCwQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] pwm: renesas-tpu: Rename variables to match the usual naming
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
> The driver used "pwm" for struct tpu_pwm_device pointers. This name is
> usually only used for struct pwm_device pointers which this driver calls
> "_pwm". So rename to the driver data pointers to "tpd" which then allows
> to drop the underscore from "_pwm".
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
