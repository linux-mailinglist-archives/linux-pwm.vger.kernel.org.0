Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3871B30965
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2019 09:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfEaHfl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 31 May 2019 03:35:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36051 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaHfl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 31 May 2019 03:35:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id m22so8379506ljc.3;
        Fri, 31 May 2019 00:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6ebcKxZF9m5OfLmJMVYK7A0lA5TY/zy0LBs8Sge/nk=;
        b=n8cNdQJowaL/oISoHaNn6CvCUpyEIQe8F+COuU9EJfE4nqiAfFDwDVVfyq2DHDk6Qr
         a6gF9CY2EXuBQtoR1ywRyAHW2miSaJavyGsCxcPknO6dF+J9uSWpY+7muGr/IcVEoK7x
         82YbKKNsQVCqsRauwlReYnS1Bf4iJuCA3dl9NwnYcx68ZUjnEG7Pia/xTx2JdxS24/Hs
         VortuPp6t0ArzUPSIXejCxSPsPzMG/BCywX0oHowu7ld+zAyL9P0KjrMZCeJAly/4Oze
         hJeZNE/WYNgtyCJZMdONDP4EZtnMq4aIUtwIkgQKDaaKEhMwdRQ3fbNApnysr9h738J0
         o3uw==
X-Gm-Message-State: APjAAAWwwlyg6KObghhShsrdlfw2mYCsz94WArFttRoX1Q5v3YtuibJJ
        m0dfBQS0T08HblQxj3hnSMe422KVcEMIjuQpYQzbXTN7
X-Google-Smtp-Source: APXvYqythphVukBrd53saY1opGpuo7T5CbJXbz18DXkwqwtASKg6vC9pCA7pnSV1qoMZ6Cdtm0eHiiX6tvy9Do+2nQE=
X-Received: by 2002:a2e:9185:: with SMTP id f5mr1874592ljg.51.1559288139207;
 Fri, 31 May 2019 00:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <1559211367-25106-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1559211367-25106-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1559211367-25106-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 May 2019 09:35:27 +0200
Message-ID: <CAMuHMdVDm6bfUVqyJLxuattOcjZDg3qoJg9s1ZYdRn+KXeSezg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] pwm: rcar: Remove suspend/resume support
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, May 30, 2019 at 12:21 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> According to the Documentation/pwm.txt, all PWM consumers should
> implement power management instead of the PWM driver. So, this
> patch removes suspend/resume support.
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
