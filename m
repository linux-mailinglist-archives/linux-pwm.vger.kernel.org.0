Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879F323E8EF
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Aug 2020 10:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgHGIdK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Aug 2020 04:33:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38653 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgHGIdJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Aug 2020 04:33:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id q9so1014975oth.5;
        Fri, 07 Aug 2020 01:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+/ktwd2eq56E+T8xe03p+w5ifPA7UnV2IOtIMqW8Tw=;
        b=fv4bzrTDx0oB0jw62KQA1A1ejv6tRWLBkhLsT4Bx4qMV+vcCPH3KCaErqKcZJQRCAu
         vjJw40YcxTQN0Jztt7mBGHL0rGA0czfEzI2I8cN4HreZ6E3xTcPKISJZcRjQAe1/nOoB
         Mdh3evEnAB2B3qqppm3sDC+LE2F/FVyS3StAPfIBPrsqRGOJjleE9YiJ1FetVb0ICUpv
         KWRsgVLCFNSbcTTIXyDvBO5w/cF/NYxYJNIoVIfib06zLJ4Vl5V1XxsZZxIT9Z/7Yt8I
         dD8mcG77R3gMcwvVldGmpWzWA7CfKcfyghJMbyEIMplzRs+FZXyVFppOxDtNUimaZsea
         ZwXA==
X-Gm-Message-State: AOAM530wL8JxCApkp4nJkqOp6AVRHBpxj2QuzC1LovrrEdLwrS4cyRyN
        kJbHrZLs/rPqgztgnDxYTrGXRtNHTCGssf9Pf0dd4Q==
X-Google-Smtp-Source: ABdhPJxhrUU3Zm9nD9Vm59tFhYzmiYiVHBwgfYK/Pyuq0t61XBmaCQd3tfnTHRBwwLrPvbJwtVh91VunUWGUw0Y5GSM=
X-Received: by 2002:a9d:1b62:: with SMTP id l89mr121932otl.145.1596789188487;
 Fri, 07 Aug 2020 01:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200806183152.11809-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200806183152.11809-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200806183152.11809-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Aug 2020 10:32:56 +0200
Message-ID: <CAMuHMdUW4gSj_4MaJDVEzRyCjEjWc+h__17hwSxm02megDZF=w@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: pwm: renesas,pwm-rcar: Add r8a7742 support
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
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
> Document RZ/G1H (R8A7742) SoC bindings.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
