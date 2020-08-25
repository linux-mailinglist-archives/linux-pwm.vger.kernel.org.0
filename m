Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E0D2519A1
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 15:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgHYN3p (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Aug 2020 09:29:45 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44970 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgHYN3l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Aug 2020 09:29:41 -0400
Received: by mail-oi1-f196.google.com with SMTP id h3so11579482oie.11;
        Tue, 25 Aug 2020 06:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NlGcF353UvEOTKYyfpjwDftImPGsiStlKykiIRESN1M=;
        b=QnRjfq1/BAzMIRRk7RS/m/pXubd4LBDzD1fRC0ty8fPqWKVBY4/ZZzz0vLmGHt98om
         wADXP0HgDR84qvdDhFD+FscBsQCc2EEooAi9JCGXGTDojZcwgxJBqNzYkxAAVI+p/F9W
         P9Y+376OpFiFRhj6u4f0c9kWsscpG/UBqIDCzbFrWr+llYmune0vWwLDPIItMXH82h3w
         +yJ+hCigf6Z98VVxJy2Z4Uu/1zTaD8l3IaqJ72vlk1RmJlMRUAb6N/nj+g7H/JQf7s24
         RIpzp1KsaUPg6cPHQLI7WqDhSStN+KeA5LkWwYoW774ritH1x/vLdtxL3FS3/ULzjyVF
         lCqg==
X-Gm-Message-State: AOAM530Q6uSxsR+CegVF1gLOv+E1ZOP+SzMT/8gyvKbdSqBgfIHLlRjG
        4+SplyuL1vjDtSg4Oqe7NeBQc7o1cQgJ+gDHjXs8OikT
X-Google-Smtp-Source: ABdhPJzZthb05n+gWg5spYhotIoaAgfZ5aJhCY+qYAIDFUR7B37VKtj16eZjem2uFKYXHyumQ8UnO/DtfPWwlqm8Vjc=
X-Received: by 2002:aca:adc4:: with SMTP id w187mr931178oie.153.1598362180689;
 Tue, 25 Aug 2020 06:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200825104455.18000-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200825104455.18000-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200825104455.18000-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Aug 2020 15:29:29 +0200
Message-ID: <CAMuHMdUVi+y+D54s7-AUO4nE0nU8GqMcvpJRb=dPEfQMujedaQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: renesas,pwm-rcar: Add r8a774e1 support
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
> Document RZ/G2H (R8A774E1) SoC bindings.
>
> No driver change is needed due to the fallback compatible value
> "renesas,pwm-rcar".
>
> Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
