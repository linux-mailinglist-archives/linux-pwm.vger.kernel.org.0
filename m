Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1213682E03
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Aug 2019 10:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbfHFIqk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Aug 2019 04:46:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35151 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbfHFIqk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Aug 2019 04:46:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id j19so13911890otq.2;
        Tue, 06 Aug 2019 01:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGx7OEbbHcEV2w9H3KvoPYcJkfNqLu1d76yfzh3ihzM=;
        b=jYCSV0hlaJS/d5E1eJPgF/+Y53D+p9EaQGZtczL0qFNt9UzaPjLJ4+gWc3N4wM1cd/
         Vuox9ztcdPLKFgqNQpEtiCCB5xBC9meMfqjTJVphwJTY8bPhFGJRnbQD7p1ExFxV6l37
         P4jdLNzlZ6N9B6x105jKYtg28Dv/HMohMqgXSnNOi8t1JtdyWStTXoG3vJdn4TjNiL1I
         RqdMhrItwHYdFuK3RrKkiivPWBG63SFkG7ChEGrukGjIAPE47gXCKEboGQFbdRoAwd3z
         KPGksJAgJGjjFf4le1xNsaDh4r0tjTPYejemOBP5nmpNuz7JexhLdrSkl0ArB28hczOC
         A/Jg==
X-Gm-Message-State: APjAAAWnKwX3V8t/chKa2L6Ve5mtViqYmwdlpINT/xdKUP/g0m5taY5P
        rgOp8JscyU+voeA8uZJ3+hBNz3IP4WXO35oSFIA=
X-Google-Smtp-Source: APXvYqyNaZsygswEAtjR4k0Nway6gN8Y0iUdHyJsAvJLog/5CAoHUTzY4BT1ud1NbghiluUe+b85WnjklCz5/sj+FFY=
X-Received: by 2002:a05:6830:210f:: with SMTP id i15mr2225162otc.250.1565081199519;
 Tue, 06 Aug 2019 01:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1562576868-8124-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Aug 2019 10:46:27 +0200
Message-ID: <CAMuHMdW-65G6CNKL5fY_dZ=UScgJsdmHzi+Qd9hs4qYqPnHJZg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/7] pinctrl: sh-pfc: add new flags into struct sh_pfc_pin_config
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

On Mon, Jul 8, 2019 at 11:08 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> To clean/modify the code up later, this patch just adds new flags
> "mux_set" and "gpio_enabled" into the struct sh_pfc_pin_config.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
