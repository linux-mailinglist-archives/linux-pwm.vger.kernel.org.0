Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C611288376
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Oct 2020 09:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbgJIH3N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Fri, 9 Oct 2020 03:29:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40635 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729434AbgJIH3N (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Oct 2020 03:29:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id l4so8142321ota.7;
        Fri, 09 Oct 2020 00:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TZu92qiZmprJz4xY5XGWsuMnNEtOh62QeeHfcOInjis=;
        b=kS0K61+IAMRJkGV5JjFGzIuwqy7sFu59n6+PhaTU0Kig1r1CKO9t46HmO95HD2/YE+
         PCdVXu8gn0dZbO9RR1cDBWfgVl/25LBICAU/L3e3N/anJ2WtM0ymFmji96Owc6jNBt3W
         I8P2V2c0vZOwMUcVv6huKopWqYh33cOTQiKzq4gRTXoPwyDuJdv58DkC4sxI5lkIUH31
         227Aa74CmIbYb1g26UvYCNnS1HeVIMsUyNTwpzzL+j9B1trfFPSZreXm5ay/YMZ69pGL
         HhPsvCu5rYoPnox0PXsxOZ46jR0Mk+Ssz5l38bBStDmY2tTZ/1KCmlMi4bTa13RVoERf
         +KwA==
X-Gm-Message-State: AOAM531OuDE7KvELGq6t7ZZNLUVzP+/UKGkWru/ED/EQNU03q8S2I6O2
        7UHpo4bR5b8CyrVKI4kUJfyb5JrFjcLFtXG9TN4=
X-Google-Smtp-Source: ABdhPJx2s9+IjUHCYpooT393jauSRHwcUd4oixIz8mmPzyg0lefkXwZecHVBO0bm+VqbrAkr/554QGvN7emfUS9TRHI=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr8042871otb.250.1602228552596;
 Fri, 09 Oct 2020 00:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201006081910.1238-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201006081910.1238-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20201009062445.5g6xck2i5olssokd@pengutronix.de>
In-Reply-To: <20201009062445.5g6xck2i5olssokd@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 9 Oct 2020 09:29:01 +0200
Message-ID: <CAMuHMdVYSENwm-Lpd9b3dfzRAxzEtTDXxrut-wGJKhTuRcHQCQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: renesas,tpu-pwm: Document
 r8a7742 support
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Fri, Oct 9, 2020 at 8:25 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Oct 06, 2020 at 09:19:09AM +0100, Lad Prabhakar wrote:
> > Document r8a7742 specific compatible strings. No driver change is
> > needed as the fallback compatible string "renesas,tpu" activates the
> > right code in the driver.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Acked-by: Rob Herring <robh@kernel.org>
>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> Which tree is this patch series supposed to go in via? pwm or renesas?

Usually non-core DT binding updates go in through the subsystem tree.
So please take it through the PWM tree.

If you prefer to change that, please let me know, and I can queue it in
renesas-dt-bindings-for-v5.11, to go in through arm-soc.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
