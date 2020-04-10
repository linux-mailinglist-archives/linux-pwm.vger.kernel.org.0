Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE6561A44BE
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2020 11:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgDJJxA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Apr 2020 05:53:00 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35498 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgDJJxA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Apr 2020 05:53:00 -0400
Received: by mail-ot1-f67.google.com with SMTP id v2so1409934oto.2;
        Fri, 10 Apr 2020 02:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WkWwzn6YeiH97R3rel3d96sMrt4qw1hNgtH8S0pnb/U=;
        b=lUgMLc0DET6rX2AtQxGqMyfjIxyLm1xPUCf6qEObnAA08zW7f23+hX5HPtaKDAm4bj
         hj0/7hDYyBDach5nGPBDlWgkF/XOV+1xRIOl4cVgidDRlofbrsQipoUgydHT/gXvnnOm
         Wjyge+tiingAZGMVnnQA7TjQ5W1uo6YtGwz3UHlGQb69Gah20wewjZmhGLE8W2TpjOhI
         LSkkg4rYD2s291Wwsy7HNFRDA0F9flGef2jsAb/RnsMkLxDVSz4gjogCPLGp47q6soKb
         xH46olpw6JdjKycw6ooSXqRRYB18ZNbIaxf27kd5DKM4mEPyHrdzcrXAFWJNOAOG9s8D
         u8bw==
X-Gm-Message-State: AGi0PuagS7IAnzffXQ4v4M7O8SQ81cnGyCZ13Bzhg+kiIk+uLQFB0Yc7
        gnBe9LCd7H1J57PIw7QIKtoKl79cuRwf4uFxTt4hOg==
X-Google-Smtp-Source: APiQypJDGqP88kz2JgC3FTRzslzM5k/7JsDjztZddhZhiv6YKMirZ3Xo1POwSWon8u7yKV3u+MJRBdqabA/IxzxGK2k=
X-Received: by 2002:a9d:76c7:: with SMTP id p7mr3400549otl.145.1586512380034;
 Fri, 10 Apr 2020 02:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <1586510057-31562-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1586510057-31562-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Apr 2020 11:52:49 +0200
Message-ID: <CAMuHMdXGtHsiO3h-ToJjQz6yedAV6oTkpar0ro1tw3Q3TMf1Kg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pwm: rcar: add r8a77961 support
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Apr 10, 2020 at 11:15 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Add support for r8a77961 (R-Car M3-W+).
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
