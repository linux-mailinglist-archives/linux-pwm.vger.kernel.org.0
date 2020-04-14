Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75001A8682
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2020 19:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390547AbgDNRBA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Apr 2020 13:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732396AbgDNRAn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Apr 2020 13:00:43 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34DFC061A10
        for <linux-pwm@vger.kernel.org>; Tue, 14 Apr 2020 10:00:42 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o19so6722865qkk.5
        for <linux-pwm@vger.kernel.org>; Tue, 14 Apr 2020 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GIN7IF6qYtKF4gSfr/AeRIvPX7/eCFsh4TApVUETWoE=;
        b=WJK29o3K5MXm6p3VWzbGrHsk0KBRUyWWpDHcGXG/HUX36uIXx5JyvHKhiu1s3JtLtU
         V7gkFI/q1KmdLMhMMUxBqFlgpBaa0ZkNYnWmTKON4gWBw5jxIE0XBUAq91eeIGYap3zZ
         OYhvWUkFkEL5+ErE8/pYC7Unq7WRkY9b6ox3OTtr13DORJy7fe4UWueM3dLYCpcH+haM
         7s83titQwzbdrha9nbAnzXASShQuNXplRRlunOROJBdfg3Qf8CHG61pH9bI8Yw4wFfA2
         c4dSOcHuk/T/b5dEH1oSwrARzE52d5vcmU9CxIdgyuhRNmOaqHvCyIjmpsCkx6zA/Qs+
         xdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GIN7IF6qYtKF4gSfr/AeRIvPX7/eCFsh4TApVUETWoE=;
        b=Q/Aotz8yPU8n+/cqGbz+VDuzJlv5HdQOvgL1r46ctnXW6/Sd5q1DMNUAR43IvDDwqh
         S4mo5NP8ZcCrSPTPeSpSLJd/ZqOOEGGXo5qs7irCrNPj68+T5XaZcemDShsI3HR1WxoV
         7LQVpjIkS2Wf1OVCZCJ3IokU4CqEKtHMDovW84PmdFBLTOCb4+N7IrgZbpPLhoh3wOca
         FugZccys7hTa91RIsTqUAKqBnmmO4iONIvNP8WnhJeSiDZPcZsO9SXIB4ab9krb6OPt5
         wC8i/A4g4GPY0yYLaKvSb7wySJovTO37fLoUpvfymWBw1JCQ7NL4gzqTheF+e1a7HNmO
         o8IA==
X-Gm-Message-State: AGi0PuZ9Z2bUFUvobmDi00pRy/SWNLLr/vaDQ9dPabU33BFns9sT4lQY
        P6uCzZkDrXV6Tej3iYxbW3pA/yMzys79lKbMbyoPdg==
X-Google-Smtp-Source: APiQypJAVUbx87PMTgMxPYPAUoh9xIaPNebw3vKNOCwEq+Xku6Borru68lB1wY/XGBsCVLhWsPFHE8/a8s5sITgt6DA=
X-Received: by 2002:a05:620a:5f1:: with SMTP id z17mr18160792qkg.21.1586883642039;
 Tue, 14 Apr 2020 10:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200402203656.27047-1-michael@walle.cc> <20200402203656.27047-11-michael@walle.cc>
 <CAMpxmJVE3PgVCxkQ-ryc5=KSrKcpdmk1cnJUxJBz9QFCx-e_+A@mail.gmail.com>
 <80bd8661ec8a1f5eda3f09a267846eaa@walle.cc> <CAMpxmJVC7e9JnHzBo-h8M1+KmcA32=Rvxo7+znH=-kAbcCr_LQ@mail.gmail.com>
 <e0388a2137e23d76b2415a7549c01dd1@walle.cc>
In-Reply-To: <e0388a2137e23d76b2415a7549c01dd1@walle.cc>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 14 Apr 2020 19:00:30 +0200
Message-ID: <CAMpxmJW1x4Orh1BZ4TUoCsYeaAAZ4NBUNvoMG9JgP0iLvXTOtg@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] gpio: add a reusable generic gpio_chip using regmap
To:     Michael Walle <michael@walle.cc>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

wt., 14 kwi 2020 o 12:07 Michael Walle <michael@walle.cc> napisa=C5=82(a):
> >>
> >> So the best from a user perspective I've could come up with was:
> >>
> >>    ->base_reg =3D GPIO_REGMAP_ADDR(addr);
> >>
> >> I'm open for suggestions.
> >>
> >
> > Maybe setting the pointer to ERR_PTR(-ENOENT) which will result in
> > IS_ERR() returning true?
>
> Unfortunatly, its not a pointer, but only a regular unsigned int (ie
> the type the regmap API has for its "reg" property). It could be a
> pointer of course but then the user would have to allocate additional
> memory.
>
> -michael
>

Eek, of course it's not a pointer. If possible I'd like to avoid this
GPIO_REGMAP_ADDR() macro, so how about having some separate field for
invalid offsets making every offset 'valid' by default?

Linus: do you have a better idea?

Bart
