Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC9D530B7E
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2019 11:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfEaJ3H (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 31 May 2019 05:29:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43927 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfEaJ3H (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 31 May 2019 05:29:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id z5so8910293lji.10;
        Fri, 31 May 2019 02:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUf6l1XB2bvl+e6hg3vRcjvje4NI+sQCW/C6dejYJyc=;
        b=O6FaoB8DX7uUxskKsBN60B8jAfWgY5EJJJv4oq+j3P5pMOsfGdnKFFGfGE4XH379bh
         /e7J2jAUDJanBSe8Bl4lWPc/oUK7MxJ0PoQPU7NsK6WRqzurUhd6vNGSU6W2BI12pghf
         cmFS8uPo4vEObDhs79Z6rNxnFNhUyjiYtMUd/cFEh3PfQMkCnp66O/K6qQ9S9jBl84dq
         uXW/oyLXXUT4XNj5KuzyFjk9FCmghniY0iMWIZC1HsO5dEiHQScn+Lh3YkBz0vqsS4hu
         CBGiEgzxDZrRNWLWvnfHFC39EAFS3ALOUNs2tudus1swIdyifNnFumL/UkGI5dUpj2tT
         Gq1g==
X-Gm-Message-State: APjAAAVOCTsU3gqz5EQaOmP07AdjXENmMD/xiSjvHZYBv+0pycl0yndm
        t2G2SGrFYmDALjvt+KqMPgZejapJLnqGmZh036I=
X-Google-Smtp-Source: APXvYqznYWrhtD1JNoNavNCbVGrZ6oCrhG+Q0HWOShiIy4M/YNBwnQTiHPVI8bn7YyUw+IO7W7TLsWQZnhWIVOjuhZc=
X-Received: by 2002:a2e:6e01:: with SMTP id j1mr5033688ljc.135.1559294944859;
 Fri, 31 May 2019 02:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <1559211367-25106-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1559211367-25106-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdVjOuvUyX3QJP-DOmYt3wzt3NOioDfm_CQhyZvOnGgy6Q@mail.gmail.com> <OSAPR01MB3089658CD2E8DF789BA7737FD8190@OSAPR01MB3089.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB3089658CD2E8DF789BA7737FD8190@OSAPR01MB3089.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 May 2019 11:28:52 +0200
Message-ID: <CAMuHMdUkYChEX+uaxqAhHRTDKPST9HZNqOKGTf2kxM0F+_nsxQ@mail.gmail.com>
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

On Fri, May 31, 2019 at 11:22 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > On Thu, May 30, 2019 at 12:21 PM Yoshihiro Shimoda
> > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > This patch adds power management descriptions that consumers should
> > > implement it.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/Documentation/pwm.txt
> > > +++ b/Documentation/pwm.txt
> >
> > > @@ -141,6 +145,9 @@ The implementation of ->get_state() (a method used to retrieve initial PWM
> > >  state) is also encouraged for the same reason: letting the PWM user know
> > >  about the current PWM state would allow him to avoid glitches.
> > >
> > > +Drivers should not implement any power management. In other words,
> > > +consumers should implement it as described as the "Using PWMs" section.
> >
> > s/as/in/
>
> So, "... in described as ..." ?
>
> I'm not a native speaker, so that any cases below seem not so different to me :)
>
> 1. "... as described as ..."
> 2. "... in described as ..."
> 3. "... as described in ..."
> 4. "... in described in ..."

Sorry for being unclear: "... as described in ..."

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
