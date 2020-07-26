Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DE722DD8C
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Jul 2020 11:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgGZJNF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Jul 2020 05:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGZJNF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Jul 2020 05:13:05 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28943C0619D2;
        Sun, 26 Jul 2020 02:13:05 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id o10so294355edh.6;
        Sun, 26 Jul 2020 02:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2+h3+87LaFJxbNS7QjYPeIj+UjU50oEwIWii9HZknM=;
        b=p+hEz1ItYIQQ2yioLM3bSE8t+EGfUj4kEXTeaUUwa+9qs/XLOP8Uci3EydPEwzgi8m
         pbI4IdHmXZ37enJvXWY1u/E7Ec9dl5uJq+gku4an9F6YX1qw+7l+eWPz/+m45uwtfniU
         0QFcc/WqOm81e0MxsxlmNBypWgM+HUjBTPmdh6VWnFhYhw0aOaudOEXwgDxE+pEsp4tG
         x+n1niyetYG5vunaTYUMs0YAMbHYgA6gKwnQrK3NZBc8eicz31JEctRh/zYQYzuB60gW
         sn51ppioOlpLSMqT0O5EduLs9+x/eWY2Kxu6HGNBNLzbbvSyut890uy+hRj0SoC552UK
         4zoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2+h3+87LaFJxbNS7QjYPeIj+UjU50oEwIWii9HZknM=;
        b=bPsuoLFooUaIa04ja07prbd5M+OqOuZVrO1YJgq6H9kYm6R/QosnnlTdQ/Dd/enskk
         +tn3Mm80lOyHm3HlSKBaMDzP5KvBy6mWg/VeWUv030I4xKGIgWoSwP+Gx1xm9SBRqRWP
         7mQ3XLIHMvS+KCuFifbf/9/UzBkKHLM4a5cM91aJL9/I9BG4CJ+wsSQkFj+zYJvtFFnU
         AI8BgA0HlljMVDqkMnTw4oz6ONBBfZpukBSmcxBAQEhHn/xY3RO2Anhs4+jgsBYYHYmd
         ZUa/xPr7AHlGPloKzub3O+/FxzAhcRKTFDv3gjNZjCOcBqx144Z0T0qX4XPYyemWgzbs
         GlLA==
X-Gm-Message-State: AOAM532tzMVOJO6Xovj4e6l2cHTb+BaCOR7syhwZ2cLlBQvt2AuBqLW/
        1xT/DsLtQGJK3wv+3g3AQOIuBXJ/W/r3cJu11Rk=
X-Google-Smtp-Source: ABdhPJyanvpC5G6K9EGy3sPcpR5eDP+Vp4msDGDK+Czg6cstj5s3pOZVk9ZbzWmWSVYWDBxRL72yZkcufdss2fyWLB4=
X-Received: by 2002:a50:a125:: with SMTP id 34mr16535885edj.306.1595754783926;
 Sun, 26 Jul 2020 02:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213659.273599-1-martin.botka1@gmail.com>
 <20200724213659.273599-3-martin.botka1@gmail.com> <CAHp75VdJ14p+_+XqxrgRrjXF7m6L4nGr5vB03NTM=0xjgw4c7Q@mail.gmail.com>
In-Reply-To: <CAHp75VdJ14p+_+XqxrgRrjXF7m6L4nGr5vB03NTM=0xjgw4c7Q@mail.gmail.com>
From:   Martin Botka <martin.botka1@gmail.com>
Date:   Sun, 26 Jul 2020 11:12:27 +0200
Message-ID: <CADQ2G_HkiAZx8OhfQ_jeizveMaB-QN9dfN6Tcwfk9XuF97rmOg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/6] pwm: core: Add option to config PWM duty/period
 with u64 data length
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> And all divisions go mad on 32-bit CPU, right?
> Please, if you thought about it carefully, update a commit message to
> clarify that.

Hello,
This patch will be dropped in V2 since another series already made these u64.
See a9d887dc1c60ed67f2271d66560cdcf864c4a578 in linux-next.
I have not tested compiling that commit in linux-next on 32 bit arch
but if it fails i can replace this commit with fix for that.

Also  I'm not the author of this commit.
Konrad Dybcio fast forwarded it to 5.8 from 4.14.
Fenglin Wu is the author and also created that commit message.

Thank you.

Best regards
Martin
