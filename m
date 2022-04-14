Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8814D50095B
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Apr 2022 11:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241543AbiDNJKe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Thu, 14 Apr 2022 05:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbiDNJKb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Apr 2022 05:10:31 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB436E56B;
        Thu, 14 Apr 2022 02:08:06 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id i14so3520659qvk.13;
        Thu, 14 Apr 2022 02:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5xdXhC/4omTqXYsN6GdfvyHROpgmmmzDpX+h9CdEww4=;
        b=E5no0taA1723Z4QHRfxOJsWozjntb837RVjYLNZTjvpiND8h75uEZkUm+hy0pON1Nr
         QgZLTwS/qjZ++yl9zM5bRZhdxODv7kM9db/jkEOFnIBPaBBHQ1wpkSI9x+y02I6HxVbN
         cfi9igBbb9KdPkMZ/nPcY0tBjYQ70lLejFgWefBjQxywFexh1XzcykVSLgobNm2dyC38
         q/TSveh2tJWGKLisITfdCYCA4wIWwYkYf6hCUJ9yqMAYfMG+Z9TPOcpmOCt0Zkbgfmfo
         4sQdHL4YOhpjJuJWGVNjJk8JBolEfbXCwHXL2qsgVXwmlW31W9G1YvyhWxg8jT2C44W3
         ecLA==
X-Gm-Message-State: AOAM532aGbiqJGmeZV+JIz9UB+4/p+eaMll2pGM+jHDJ00ddW+TRVGJV
        P5K921H52BMe0ja6+8fJZIBlUtRgVTVH5g==
X-Google-Smtp-Source: ABdhPJx07+Z2Hc+xz7cMm51vx9ocq0JjnxpFvGY6bFdUdBQjw9KzqfrGv03A80m0PbwMWTnc8yC4mw==
X-Received: by 2002:ad4:5b89:0:b0:441:6e09:dbeb with SMTP id 9-20020ad45b89000000b004416e09dbebmr11858057qvp.53.1649927285692;
        Thu, 14 Apr 2022 02:08:05 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id o14-20020a05622a138e00b002e1e78c899fsm826428qtk.53.2022.04.14.02.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 02:08:05 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2edbd522c21so48220937b3.13;
        Thu, 14 Apr 2022 02:08:04 -0700 (PDT)
X-Received: by 2002:a81:4f0d:0:b0:2ec:1556:815 with SMTP id
 d13-20020a814f0d000000b002ec15560815mr1228297ywb.256.1649927284758; Thu, 14
 Apr 2022 02:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220413085050.61144-1-u.kleine-koenig@pengutronix.de> <20220413085050.61144-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220413085050.61144-2-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Apr 2022 11:07:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUUD4XtvU7DNqY=O+QM=41xdmcJFM3_-ERum8HXqfSSSA@mail.gmail.com>
Message-ID: <CAMuHMdUUD4XtvU7DNqY=O+QM=41xdmcJFM3_-ERum8HXqfSSSA@mail.gmail.com>
Subject: Re: [PATCH 2/6] pwm: renesas-tpu: Make use of devm functions
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
> This simplifies an error path in .probe() and allows to drop the .remove()
> function.
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
