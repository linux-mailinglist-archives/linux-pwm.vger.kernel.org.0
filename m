Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B883E23E943
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Aug 2020 10:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgHGIjW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Aug 2020 04:39:22 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41853 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgHGIjW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Aug 2020 04:39:22 -0400
Received: by mail-ot1-f67.google.com with SMTP id a65so1013601otc.8;
        Fri, 07 Aug 2020 01:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vKfgGnjXRpTaiAEIZ5vtKn7CB7zEFKghH7Cgz6HwfSg=;
        b=bfT4mi20W9DGvBITOhaBmgDEieFceoKvqyCriWDQCYxZG1w1fyrNunIwxTAyvdClrv
         xLwulZzRNs1qjnx4RQh4aruM30Rw2fJ30L3BJqlCdfKX6vrKrbvwv3DwjoHxVY1I9Nxt
         kWJBVwAuTbY1Q22khcWiXEwmxVKqNMydP5R3MORHF65N9quXoVV6hdb/5fmNSTekhK8k
         J9UHkyuzUKk3B8IEGGWIwtgX3KXS8P3KX5lmUBYxXidOl0Ts+Wu4G2+x4NapypZrdTnc
         0z/sf7+NIz0B+tGd3X+3o3ig5R159wehyM8+Dha+OWChJ8Il/kzXpyeVUWuzwqr3NiOs
         Eckw==
X-Gm-Message-State: AOAM533mW7yvzuKEUfUrhZSxVC9Spp2vdfSKzNBhS3F5+oGstBwQKVQ9
        JaX9Ohj7g+vM8ePy+xU2FMpOu4JceNorSNGMc7k=
X-Google-Smtp-Source: ABdhPJzxabCXC24U/rTq2tBqlEz/WWYILzDohzuiG2HrpUTh6ZjgHU3FAKFNGT0WWLpgTg2BdtVX6Yst1SGXEZif/t8=
X-Received: by 2002:a05:6830:1b79:: with SMTP id d25mr10192558ote.107.1596789561162;
 Fri, 07 Aug 2020 01:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200806183152.11809-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200806183152.11809-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200806183152.11809-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Aug 2020 10:39:09 +0200
Message-ID: <CAMuHMdXK1mfmYjCMWYNqMVy7jJ9Hh7kBZMBbzyD-pkwrHB6Pjw@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: pwm: renesas,tpu-pwm: Document r8a7742 support
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
> Document r8a7742 specific compatible strings. No driver change is
> needed as the fallback compatible string "renesas,tpu" activates the
> right code in the driver.
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
