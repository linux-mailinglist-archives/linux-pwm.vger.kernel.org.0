Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512BC23E95F
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Aug 2020 10:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgHGIly (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Aug 2020 04:41:54 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39827 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgHGIly (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Aug 2020 04:41:54 -0400
Received: by mail-oi1-f195.google.com with SMTP id a24so1263319oia.6;
        Fri, 07 Aug 2020 01:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zzp+K2GPyoIa4F9OZDb+rsNjP4lb5poRPhzq+1eL15Y=;
        b=hR+k8YmTdh1FIc5sUQz6A/i65dIrvn0xB0L89LDC6RLAoa+PZuEhRHNfF13BSor8Bq
         6tP8+7wRqdl+ADE7S0uVSzlTEEH2yiMgBF0PMTUA8hBX7ZPQU7qJeVT2SgNqoL4jOirq
         +04E8NIgRrYfg33LzbHK3LTdKqNy1rJjn7b/a/+16NTBaDDFf+OnqMRSHvmSK4/npSyI
         r/j5EKCYr/Pbd8mFwKLZ6fkYWqvok9EHr8bBJF5X/NtTwEAfaU7mdWuUkyvkmgegpbol
         wFszRvbu7CYFFjWXrhU2QdFXrSw5lQm3ZLUKkLQnSU+aTl/mcuXMrnxfp+Q5tygoIQWM
         YRQg==
X-Gm-Message-State: AOAM532PbmX7dvZTbfQGeXk9ZriiHHR00ST99eRxQSPy0Ll0Mo+cZ72v
        Iq4Y7YeREHFvV6e+JUiWwf0SGSZyBcUndZ8l8X0=
X-Google-Smtp-Source: ABdhPJxZoihwBkNu0prCEBpXKmP9nlGBCfjAL6p1XSniby6Fpgu+SAlO+6dgCejY24aUTAcULPjp5/2hRgcMrAQw4Bc=
X-Received: by 2002:aca:4b54:: with SMTP id y81mr10330712oia.54.1596789712893;
 Fri, 07 Aug 2020 01:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200806183152.11809-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200806183152.11809-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200806183152.11809-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Aug 2020 10:41:41 +0200
Message-ID: <CAMuHMdUQckhhY-WHvOuqAD+qnsJwVEgvChsyCMXYQThZO=bdLw@mail.gmail.com>
Subject: Re: [PATCH 1/5] ARM: dts: r8a7742-iwg21d-q7: Enable cmt0
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Aug 6, 2020 at 8:32 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Enable cmt0 support on r8a7742-iwg21d-q7 board.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.10.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
