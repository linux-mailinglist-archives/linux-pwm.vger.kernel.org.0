Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A67C182E13
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Aug 2019 10:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbfHFItq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Aug 2019 04:49:46 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34026 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732206AbfHFItq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Aug 2019 04:49:46 -0400
Received: by mail-oi1-f194.google.com with SMTP id l12so4809950oil.1;
        Tue, 06 Aug 2019 01:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGsM7pwNfNhypZYgQFIcaWofv38d0hmWofEdR0NtNiQ=;
        b=VRdKBUsli2gnniTOaZA9MP0FqBhcw26ezjeOlaKnbaKbhE/y++NlMOVrJzgRwNdZ46
         vocUO0h7oSdxt70uruqlX+q/TDxplsHaD+z2qvWzDqVOoZE3k1nbsDGDtpzSSWrG2YBQ
         PS/AnrL1IpvxOMTy//nQwCcHlB3Bo+RI+RgqEZXT/wI1ZrBgAyIse3B/G5ByRAMMFQJE
         2WIO2UQgPaj/xvvH/q9ebG9+k7qqcS5QXm9vVhQ6zkteA5p336kv7keNGLEy7I64Xdps
         v59FR3kEgn02KHIkB7kbT5P95Brtj+/c1wEimE915WNaBq3eIKKvtWgsAsbGAknJabGC
         CxkA==
X-Gm-Message-State: APjAAAXiL1HnULo9hTWJLJUPz3LDVe8+iKnkmubw+qQvg2Q1j4qOB48M
        ciQgbyHMIZ4rmsAqUeaRhbIZpJ413vLBLWbjq9M=
X-Google-Smtp-Source: APXvYqwuOQUfUJbqvnFx04K816C3jKe2zq5l/JtyJF2mmCR5Qu0WkmmFcibhWo6DNxgmpO/XSWdCMjmFXggotgQEEmM=
X-Received: by 2002:aca:338a:: with SMTP id z132mr1059577oiz.54.1565081385290;
 Tue, 06 Aug 2019 01:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CACRpkdZqTaA04bja16xh338JiwoSqFpH_2rV95FaF7YhawQzMg@mail.gmail.com> <TYAPR01MB4544031C6A027A3690FFFB77D8DD0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB4544031C6A027A3690FFFB77D8DD0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Aug 2019 10:49:33 +0200
Message-ID: <CAMuHMdUqDsMA_uZ+Sen15kgue8DoQee0vd4qmUXmFX+cRT11EA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/7] pinctrl: sh-pfc: remove incomplete flag "cfg->type"
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Shimoda-san,

On Mon, Jul 29, 2019 at 7:16 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Linus Walleij, Sent: Monday, July 29, 2019 8:02 AM
> >
> > On Mon, Jul 8, 2019 at 11:08 AM Yoshihiro Shimoda
> > <yoshihiro.shimoda.uh@renesas.com> wrote:
> >
> > > The old commit c58d9c1b26e3 ("sh-pfc: Implement generic pinconf
> > > support") broke the cfg->type flag to PINMUX_TYPE_FUNCTION because
> > > sh_pfc_pinconf_set() didn't call sh_pfc_reconfig_pin().
> > > Now if we fix the cfg->type condition, it gets worse because:
> > >  - Some drivers might be deferred so that .set_mux() will be called
> > >    multiple times.
> > >  - In such the case, the sh-pfc driver returns -EBUSY even if
> > >    the group is the same, and then that driver fails to probe.
> > >
> > > Since the pinctrl subsystem already has such conditions according
> > > to @set_mux and @gpio_request_enable, this patch just remove
> > > the incomplete flag from sh-pfc/pinctrl.c.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >
> > This looks like it should have a Fixes: tag as well.
>
> I got it. The Fixes tag should be:
>
> Fixes: c58d9c1b26e3 ("sh-pfc: Implement generic pinconf support")

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > Geert will decide what to do with this.
>
> I got it.
>
> > Can all the pinctrl patches be applied independently of the other
> > changes so Geert can apply and send me those patches in his pull
> > requests?
>
> The pinctrl patches (1/7 through 3/7) can be applied on next-20190726
> so I think Geert can apply these patches into his repo.

Looks mostly OK to me (I have some comments on 3/7).
I'll apply it to my local tree, so it will receive some testing on all
boards I have.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
