Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61860508811
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Apr 2022 14:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiDTM2I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 20 Apr 2022 08:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244115AbiDTM2F (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Apr 2022 08:28:05 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A6F1C91D;
        Wed, 20 Apr 2022 05:25:19 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d9so781480qty.12;
        Wed, 20 Apr 2022 05:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HJ0UgcnIkbA6AHJznojilX0imBhr1YXT1/wXEX6agp8=;
        b=ERcgKjTmfByXW50/gpFaNTWx7PR0nre43oGaE87nYkGF1fEHKSPQgXp5UYSmkLysEq
         A0P5Al7qr2nK23lulNKiqEYxrJo7kWixJCMUtoAv/P+Akk4L8ZboxbHSe5bMQs6Aisxw
         M69j9tQT6EuSiFUs0JA2rKxW6ejil/SC0BWeMnzFihpohaPFDTjT5FFaovmZxBNKJsiP
         xuV3WROwTBQqwq0IgGCrPd/UZgXhQxv+C2PZE30XA/daVmDCSuONtNIXzCSt/yuGf4y6
         IQfVj9WLX8s52M+mgs4juriL9G0Cy0PF+FB4ZEQz2uecdENwEw6eHHZGr8tM0id3aCr1
         GZoQ==
X-Gm-Message-State: AOAM531JBd8YIe+mb+UHFu2L8fwGH0K1Z7Z/+tfq8Cy5NsbzJW+TiUQG
        QYy7suafhnuZDdUc53iQmrCqatszqxC66Q==
X-Google-Smtp-Source: ABdhPJz7YvsmU6e5Mnn8UBcVu4TIsQAuOA0HX2HrsBFef5VslNevWSY7L5M6CAM4YIHWVXL2ZkZDfg==
X-Received: by 2002:ac8:5c42:0:b0:2f1:e7f8:3e62 with SMTP id j2-20020ac85c42000000b002f1e7f83e62mr13669785qtj.41.1650457518149;
        Wed, 20 Apr 2022 05:25:18 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id v65-20020a376144000000b0069e7842f2f5sm1385235qkb.52.2022.04.20.05.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 05:25:17 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2ec05db3dfbso15966597b3.7;
        Wed, 20 Apr 2022 05:25:17 -0700 (PDT)
X-Received: by 2002:a81:6ccb:0:b0:2f1:68f1:d90e with SMTP id
 h194-20020a816ccb000000b002f168f1d90emr18381119ywc.62.1650457516831; Wed, 20
 Apr 2022 05:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de> <20220420121240.67781-5-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220420121240.67781-5-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Apr 2022 14:25:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV90BHjyjfU=MLkG2yPa1oFFF7ADrpKsEAp9s83DGBkow@mail.gmail.com>
Message-ID: <CAMuHMdV90BHjyjfU=MLkG2yPa1oFFF7ADrpKsEAp9s83DGBkow@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] pwm: renesas-tpu: Rename variables to match the
 usual naming
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Apr 20, 2022 at 2:12 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> The driver used "pwm" for struct tpu_pwm_device pointers. This name is
> usually only used for struct pwm_device pointers which this driver calls
> "_pwm". So rename to the driver data pointers to "tpd" which then allows
> to drop the underscore from "_pwm".
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

This patch didn't change (compared to v1), so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
