Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91CE082E54
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Aug 2019 11:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732197AbfHFJFm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Aug 2019 05:05:42 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37703 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732142AbfHFJFm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Aug 2019 05:05:42 -0400
Received: by mail-oi1-f196.google.com with SMTP id t76so65531997oih.4;
        Tue, 06 Aug 2019 02:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QfbDgMOotWTAyYvQiX8SxTtnQD7e/TyD66TPUlPJL8I=;
        b=krV9wp4+hKxktxKHfGIRrKqxU7g1b0eQRNbjvBq2C0Tcs+z1FwqJEudO1TVAYyaMXT
         WFlF5f1kFV5J+uqzsUXPfomntadaSvCzwL4blle3QQwthcz8gPi1xbXNR/qmB5rI5FuV
         SkgqHn7lYi9Cpjo2Ywk9xMa/oHoJ6tcPSvwYTGZrMIJcrORQx19Uae33wcnpCOvsXBwd
         ESIYoKnZKLO/U1CFcn9fqS45scMAIxabr26vtaJpx0C/SHm17+1l8SU9UQgIs30uhnUs
         Wr3Z/MqacvTkApfbdAnS5cQJ6Bt6MZXhev1qAEzBTUr7qwYUxG3zZDxa/GpB+bVLKWO4
         3mDw==
X-Gm-Message-State: APjAAAUwwiHY4ANLeEOfxIxQQ8RpxwZJlMSO7wt7j6KVN8fsJNr56paZ
        vTzZ0UX8RUdBHgb/F83dVMMZu3lUyZs5jTjDs1Y=
X-Google-Smtp-Source: APXvYqxnyJKb+RO93KgakDACxeG7wt3V+Pci2cUPeAp/O0Wduac4vNwuA9rNno4/+K5z42TsNwZzZKfm+WRzN7V7Sjk=
X-Received: by 2002:aca:3bc6:: with SMTP id i189mr937877oia.153.1565082341070;
 Tue, 06 Aug 2019 02:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1562576868-8124-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Aug 2019 11:05:30 +0200
Message-ID: <CAMuHMdWw1Gh_CxgiO5gd+MY0vUvWX_ACDj+L3_Wcomkaf5Oo4Q@mail.gmail.com>
Subject: Re: [PATCH RFC 5/7] pwm: rcar: remove a redundant condition in rcar_pwm_apply()
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
> Since the rcar_pwm_apply() has already check whehter state->enabled
> is not set or not, this patch removes a redundant condition.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

This is completely independent from the rest of the series, and can be applied
immediately, right?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
