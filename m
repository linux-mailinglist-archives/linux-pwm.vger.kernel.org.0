Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418A023E963
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Aug 2020 10:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgHGImB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Aug 2020 04:42:01 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44254 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgHGImA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Aug 2020 04:42:00 -0400
Received: by mail-ot1-f67.google.com with SMTP id h22so1006825otq.11;
        Fri, 07 Aug 2020 01:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EuE9ZvNThURrHlMo7DrkflgpgDg4kFzM6F/82/bt324=;
        b=d2jwFZa1WUgVwO28R0+1v9ox5WBo7I1sZ7m70T4jgxfB3TeVK5/d6ldXkVSKAXHqxD
         LxHkSI9jMyhmtPMv+S+lEc7P13FHtZ3c5i1JCn79eOJlMYGNrbTyexkuLpEwzak/VwpM
         kWwy4XjEg1LtIKkXwaZKGu9JoKvaFn4mczLvOA7cOgAOLje9+9jha2+sA5dq7KkUw+Bx
         8hY9FMh/ORTQfVcLFUIOrUy8hw3pLHulImvicnu6fo+PaWMLm3GPylAzanj0zqqOfzF7
         RHdG1Xv7RTKB0P4XEMGYy7XTzchJLRB2GqAopEREvGFxg55TbFHDxagGrNiMoYLFzose
         REYg==
X-Gm-Message-State: AOAM5306wejT7a8EMNhP3PtKnTpUO1w/sfRx3mlmuO/xBNIh+9v56lLF
        O9/wkT2x6hMjzheEVVs0bcd/L5wVGf8GjVm45lI=
X-Google-Smtp-Source: ABdhPJwBeAUgTGEsTNrlsej1xswDH5qOGXSZdoF1SrlkOotebVVizSKrdUdx1gV3jrpWCM+r9XlcYdncStnGaJ9cMqE=
X-Received: by 2002:a05:6830:1b79:: with SMTP id d25mr10197009ote.107.1596789719357;
 Fri, 07 Aug 2020 01:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200806183152.11809-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200806183152.11809-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200806183152.11809-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Aug 2020 10:41:48 +0200
Message-ID: <CAMuHMdX12mdhfhmzcEsXYu73wt-iTHBg-hF6_CYvS+jfrr15Cg@mail.gmail.com>
Subject: Re: [PATCH 3/5] ARM: dts: r8a7742: Add PWM SoC support
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
> Add the definitions for pwm[0123456] to the SoC .dtsi.
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
