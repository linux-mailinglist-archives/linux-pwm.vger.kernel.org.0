Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18BFC82EA0
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Aug 2019 11:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbfHFJXx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Aug 2019 05:23:53 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36237 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbfHFJXx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Aug 2019 05:23:53 -0400
Received: by mail-ot1-f66.google.com with SMTP id r6so90786686oti.3;
        Tue, 06 Aug 2019 02:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UeKI+wyGIyCm+Z7vX+Uc5wPRZnjQXw15qspoovmCKP4=;
        b=ZsCUE6QXdyLnc7DYO13z3zwTTdLLc49mvH6lqP3d98zuS/qfp7PYMvOrGLdGD386FK
         tbAb5ZGvU/UEMaBbBhSYDAU23z/84MIoUXFflyDRl8tVouZoP08coElxFvNGW9Kgrt0M
         zkQjpIBDqLtsod6dNfxuz9OzjAwX8gQhJXRkcQj9zVBUOoVW1Y5p17YxmNOSg+6tL6Pi
         v93GJ62V4RoSmrtVtPr1lDwFr/XOMMU9f7Pl+1b08pS105woAQxfBlv7HnunZN6Kg2c4
         Xpdf49XzxJv1ycO0yepfZdrDonD6IXGBeuzc4nxOuoL2MGeaqQcjCbSMbFADCMM60fxw
         3jfg==
X-Gm-Message-State: APjAAAXj0zBbGgd3dttqvqyfvVKbuyaVXufKr5yUUDVMAowzDvgwl1YC
        88o033Z3D+2vSJOdRkJKxRjnlWsImaJHUFEDbKM=
X-Google-Smtp-Source: APXvYqzoue7LKiVS/fp2yo6a8EkRmr9Vdba6hiJplbafhOoXjkmNz+1Zf6SN7RotjA7UU2od04sn0L2mqC8LAWcPnsY=
X-Received: by 2002:a9d:529:: with SMTP id 38mr2294075otw.145.1565083432454;
 Tue, 06 Aug 2019 02:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1562576868-8124-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Aug 2019 11:23:41 +0200
Message-ID: <CAMuHMdVcAw_ApKMmrV7DaoJBGUZ1GzW3kmxnsTn72FtCGWhXPA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/7] pinctrl: sh-pfc: remove incomplete flag "cfg->type"
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Shimoda-san,

On Mon, Jul 8, 2019 at 11:08 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> The old commit c58d9c1b26e3 ("sh-pfc: Implement generic pinconf
> support") broke the cfg->type flag to PINMUX_TYPE_FUNCTION because
> sh_pfc_pinconf_set() didn't call sh_pfc_reconfig_pin().
> Now if we fix the cfg->type condition, it gets worse because:
>  - Some drivers might be deferred so that .set_mux() will be called
>    multiple times.
>  - In such the case, the sh-pfc driver returns -EBUSY even if
>    the group is the same, and then that driver fails to probe.
>
> Since the pinctrl subsystem already has such conditions according
> to @set_mux and @gpio_request_enable, this patch just remove
> the incomplete flag from sh-pfc/pinctrl.c.

Do we need to set sh_pfc_pinmux_ops.strict = true?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
