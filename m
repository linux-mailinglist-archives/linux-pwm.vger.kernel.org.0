Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8DA430940
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2019 09:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfEaHVM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 31 May 2019 03:21:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44149 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEaHVM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 31 May 2019 03:21:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so7053090lfm.11;
        Fri, 31 May 2019 00:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=844e7XSfrXXPLqEl8KVe4Pz1r6PAX8QhQY8vm9eXlNA=;
        b=gU2fWQDgVcWxYhOkuvhHtRiiMj8gCECQ3PNE+Spm7/xpvKopxhnR79sWe8HYOGUzu+
         LykMxl28QkpjpFV+VJP0DThhz/G/3yY9KPErGu+Kv1Qal/rVdyNrImsM3ctKmim1D8i8
         0b46SFMRCZd2TPTqJt1OoB6z/HwNfNiha7ocrmzVl0tY8p7UtYG7eMh1uoJ5IVQ4O0CI
         h4daDfxzJ/s7oxh8XuPUGUlnX3wrdIRQOZ0pTyWq0AkZ/YaIN1l9CnzG8jZbP4r0DYHc
         tL94q6Q5yFikzoPIez/WTsqWOYdmSfVWqH+4zj91GGx5zw6vGMFv/1M/RB4kCgPMvJlo
         n+Ng==
X-Gm-Message-State: APjAAAU/DPgA+pyqlpRWZL9yXzzdB9dXKn5QoRw6JqGSAHYe4WXpxGOt
        hIlbSgiZ9g86KjHy64ZXVTv3n7dA6rUk6fAwIFQ=
X-Google-Smtp-Source: APXvYqzsHZDALn96uljKDTKnjSbGc+XZ++yQtvbcpy5ZshWWqPrpt7P2YI++9ePg7ukfa5X8TYSHfsZ0pO6IIHtBFMo=
X-Received: by 2002:ac2:52a8:: with SMTP id r8mr4630982lfm.20.1559287270106;
 Fri, 31 May 2019 00:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <1559211367-25106-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1559211367-25106-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1559211367-25106-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 May 2019 09:20:58 +0200
Message-ID: <CAMuHMdXhkJW5bp=Jay2ekqkFtUdaaLGD4uRFZe4NoG-CHu_Qdg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] pwm: sysfs: Switch to SPDX identifier
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
> Adopt the SPDX license identifier headers to ease license compliance
> management.
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
