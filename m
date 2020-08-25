Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FE62519B3
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 15:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHYNcV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Aug 2020 09:32:21 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:38839 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHYNcU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Aug 2020 09:32:20 -0400
Received: by mail-oo1-f68.google.com with SMTP id z11so2701465oon.5;
        Tue, 25 Aug 2020 06:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AoPa6tIoCK3whU9pBPzOcV5Uo3NIFh12F5Ac6ptY9h0=;
        b=esWBPYuF9HYbSZYb8jEJOvte00O/TlqL1NLTlwOPPS2phgFLg4vg/MboaHH6bJ2sDL
         yDcz646gKiAuHlZ1kDiBeN46mUK1pdkEq2AegPk3tIACBkFftyEbvB0j07d3LOeZeElS
         sZNBMq/D25swdqtf3yuECW1b1YjDbFO+c06JCLsZVehjhry4HPhmhXChO1EzA954iteR
         rpbJXwtFWsLemvfKtVRUm7bNZMKgfqI9WfH0JHW4E2rOMgrJ3onikuCC5zb8iryuw3vV
         iefDq3C/oi3t4bELUTF4ov0zIIzufwyr6u/Cwuri723wFNWqqPNOOA39Znhys7t688va
         +kzQ==
X-Gm-Message-State: AOAM531QmEgY66wkH+OMM1hr/RrFmTOhk65t7YwpZnK1GJDAVQ2rPkoq
        NYSs423cB7ZJP7pyf2x9x0sS0eAIHxD8gVxz8ng=
X-Google-Smtp-Source: ABdhPJxLl4LjPnUw0osPkN7eyYfOkhZhX2vApW9KSn7zpZVt5FQDuryRNu96u+tAJACetGF/gPNsVbXqowakQy6v1oQ=
X-Received: by 2002:a4a:275e:: with SMTP id w30mr7058474oow.40.1598362339606;
 Tue, 25 Aug 2020 06:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200825104455.18000-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200825104455.18000-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200825104455.18000-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Aug 2020 15:32:08 +0200
Message-ID: <CAMuHMdWmvcA8x-t=FgNOuMnAtw6j3OAgo8irmD5e2wrB+LfhHg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: r8a774e1: Add PWM device nodes
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
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
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Aug 25, 2020 at 12:45 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
>
> This patch adds PWM[0123456] device nodes to the RZ/G2H (a.k.a R8A774E1)
> device tree.
>
> Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.10.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
