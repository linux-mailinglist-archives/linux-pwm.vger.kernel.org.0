Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 233C93093E
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2019 09:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfEaHUU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 31 May 2019 03:20:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34733 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEaHUU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 31 May 2019 03:20:20 -0400
Received: by mail-lj1-f196.google.com with SMTP id j24so8607079ljg.1;
        Fri, 31 May 2019 00:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jXZlTN/tiOKjaoNuJyBeyNNRI0OLDr8cxIPqp/wd1M=;
        b=beJtUwK/ZHm8UuJ38J1EkXcsUWEi7kpYZMJGVlNyBL131coWkt2I/GYzIf2A7lF824
         GrVaErsMrtnPdi8lpZ3SuG9Gvm1m80VJxDTpEvf35u8rnLIwAeMn2qke0U3YfY00zhri
         X6S6vZMbW2vqBWIXbpH5WkABhIC/o8eHOmzXihbw6Cy2Gkzx3iKKP7YIr8WNSAl0nsy8
         KE1ezB4ySlEg9rc98xsmme+6+1uC1v+VqAKkb+lXV8vUnHedOcMir9V12EzR345wI4O5
         ZMjVPIVdPKoq8h/PNR552SFu+LvHgFUmWtDdkU8iK7eBP/ti1QcSmjUM7eL/VGgjOosC
         7zYg==
X-Gm-Message-State: APjAAAUTQrygpHj8YR5h3ip83gzrj4QPRTZUuM42kp9qC/cFq2LXeAlD
        bgX9Mheu5il6LGcVJF4KfZ1LWYTy0T3L58/rwuA=
X-Google-Smtp-Source: APXvYqy6ygRoYPG6/kTbM5lCE2988kpz8i4vpTTTxOR6JEzh3aHGuTB2fum5nUyIcPyyvft3LPymZPtGDa23DZ4NrPg=
X-Received: by 2002:a2e:249:: with SMTP id 70mr4383095ljc.178.1559287218129;
 Fri, 31 May 2019 00:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <1559211367-25106-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1559211367-25106-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1559211367-25106-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 May 2019 09:20:06 +0200
Message-ID: <CAMuHMdVjOuvUyX3QJP-DOmYt3wzt3NOioDfm_CQhyZvOnGgy6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] pwm: Add power management descriptions
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Shimoda-san,

On Thu, May 30, 2019 at 12:21 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This patch adds power management descriptions that consumers should
> implement it.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

> --- a/Documentation/pwm.txt
> +++ b/Documentation/pwm.txt

> @@ -141,6 +145,9 @@ The implementation of ->get_state() (a method used to retrieve initial PWM
>  state) is also encouraged for the same reason: letting the PWM user know
>  about the current PWM state would allow him to avoid glitches.
>
> +Drivers should not implement any power management. In other words,
> +consumers should implement it as described as the "Using PWMs" section.

s/as/in/

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
