Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA8923E95B
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Aug 2020 10:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgHGIlr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Aug 2020 04:41:47 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42896 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgHGIlr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Aug 2020 04:41:47 -0400
Received: by mail-oi1-f195.google.com with SMTP id j7so1247007oij.9;
        Fri, 07 Aug 2020 01:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwyADCKf5mmqBEeNJLdW13ewX7urPDOSehGQsA3CvSo=;
        b=Ul0ZpYncie77uzrDplWSgzwvwntBLxqPK6Te2rSn/trPpueHHKoectie8bcRlwlRGB
         01683Z/uGfVYiLORM5cwFKsqkxsKIbTIQdZyY6tXH4JjKxpslXS62LlZswIcnYzLeSrP
         o01o8ZvvtadcYYfk5vjqKzP9+VM6t/ovsM5jbhUxbZ4Ob0am+Qns/57WHBR7gK7ZKGEe
         Bx7rgKmIxcx1cXF0vasJHiQ4ToIKzDOz+E+Q+MGyiJpPU2GJjhpa87sHo/mQDC6lJqm3
         LtkJ1rx/jj55bbFFC6DAu08YdioBOQeM2QBuXUPxORHMcengLiBm+dqoRn8ITcZQz4k1
         T26Q==
X-Gm-Message-State: AOAM531x7LiIngvmp+aPiRByO8wCEL0EeUpAULOtSY7ADH7sCiLoiPxk
        B5LD1sbW8h875u2K/BmWmYO2JL1KGzpdKzH3gzg=
X-Google-Smtp-Source: ABdhPJwO0HhS+ygyeQp5gCWMXwgPNODcLEhDyw5+l47YRQFuX8K1Yzx4Ge3KI3tAKQv8i7gINlqIvMKG8WQ/ihyBGVA=
X-Received: by 2002:aca:b742:: with SMTP id h63mr9851770oif.148.1596789706388;
 Fri, 07 Aug 2020 01:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200806183152.11809-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200806183152.11809-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200806183152.11809-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Aug 2020 10:41:34 +0200
Message-ID: <CAMuHMdVJU+M_vDAVViWUPsde8cgOo6VZGOdqFFDKLO2=MpN0pA@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: dts: r8a7742: Add TPU support
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
> Add TPU support to R8A7742 SoC DT.
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
