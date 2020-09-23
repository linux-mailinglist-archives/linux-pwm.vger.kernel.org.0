Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6244D2758B3
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Sep 2020 15:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgIWN3i (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Sep 2020 09:29:38 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40615 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWN3i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Sep 2020 09:29:38 -0400
Received: by mail-oi1-f196.google.com with SMTP id t76so25005527oif.7;
        Wed, 23 Sep 2020 06:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rMoEuPGDAy971L25OQzzcUwzDymkiOVA4jg4tTeTHI=;
        b=Lea3InaDNDnXi04N6avkexks0kmaBfLs9johDZqyWZ+UwMdepz6gMikrBF7c7fc4jn
         bFJj/urKShgXHQFuuVr8uzbVvG+nJ0png9li+AkqfeDkfc9GxonahGMA1Q7VXYJzRapO
         El+FXFd2mxboXOp3toWcZX0jIX8x6TOgl06b5Ng0yqy5zX6uIYdErBEIcK0EGtvl3uqC
         g5D9EwOu6qVCnO9YXyIB4Zb4MpwrNQd5uWqUqwkz/ToYuG8sI868SJjpw/fmCLl1MxC3
         oBsdIOyv7WFQdcPmmfkIaoxNMCiWzXHhvctQ72+7UeH8C82f6QfF3abD0sJMlP/jbcti
         40zA==
X-Gm-Message-State: AOAM531EonW/bBhdS3K8QzcM2FgX9QnAsEZX/DTkeUgSbwJF8OIrACQR
        +bj4/39YTjof4SVk83b+90DBFobJNF5OXmpCxv3T6c1c
X-Google-Smtp-Source: ABdhPJziefyJq4JP9IubrLkGlZIwmizPmfyZzixhXhqNpkNSciMNfsNrp++kEzyejdd8neZ6NVOcBk24rZGIIwTUkDs=
X-Received: by 2002:aca:3bc3:: with SMTP id i186mr5442092oia.148.1600867777289;
 Wed, 23 Sep 2020 06:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200825104455.18000-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200825104455.18000-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdWmvcA8x-t=FgNOuMnAtw6j3OAgo8irmD5e2wrB+LfhHg@mail.gmail.com> <20200923121452.GD1848911@ulmo>
In-Reply-To: <20200923121452.GD1848911@ulmo>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Sep 2020 15:29:25 +0200
Message-ID: <CAMuHMdX=G0n4MWNUM46OcUzeKUc=i1Sv4J8tnU0=_Nkt=Pf6xA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: r8a774e1: Add PWM device nodes
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

On Wed, Sep 23, 2020 at 2:14 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> On Tue, Aug 25, 2020 at 03:32:08PM +0200, Geert Uytterhoeven wrote:
> > On Tue, Aug 25, 2020 at 12:45 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> > >
> > > This patch adds PWM[0123456] device nodes to the RZ/G2H (a.k.a R8A774E1)
> > > device tree.
> > >
> > > Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > i.e. will queue in renesas-devel for v5.10.
>
> Hi Geert,
>
> did you also pick up patch 1/2 in this series?

No, I typically don't take DT binding updates for non-core devices.
Can you please pick it up?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
