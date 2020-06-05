Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444E81EF2F2
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 10:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgFEIQM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 04:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgFEIQL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 04:16:11 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F82C08C5C2;
        Fri,  5 Jun 2020 01:16:11 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q24so2413756pjd.1;
        Fri, 05 Jun 2020 01:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXdVxsGQNpOmqOgFOL5sHVJSy+udx7MLTpgYocPDlMI=;
        b=CmWf+Q1LPKkZFcz/UUCEbKgiD4xwszew0h0vP1mFw1Sri5IdNxgZoMooG8JO0czgk6
         atcXFR84tLy0cvzPKI1nKeJQl/vjaYcYzjMDSAFElp+J7NDj3DshbpW/Rhz5NrrC7aYS
         O2YT8xyZueQZsiPAZTU0ehVKvGYNpyJSsnWfcrrkGPazVl716JM4yAUWpHi2ZHkCdZEY
         10SeHCEghYnDA5rb2wk5xvQvGg4u/RGKrojjyJ2MeuMhogLguXaZuVi7sJnnMxLgrvG6
         oNepqfXmK4Hl6cDCyeYIch7viNWooW+94utqoB6gZ2sMx+YGxt2qmVONoin9lNo4LhWK
         g2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXdVxsGQNpOmqOgFOL5sHVJSy+udx7MLTpgYocPDlMI=;
        b=pGZs/41jR7Xhl5C+3mQH7AgaOS4NWOCila0QTucMi2V3L/o1hAVhuWcfzcFnc5OuLi
         VxAwAbuUKZbCukHkesAcwO4i+Si8f+VLRnw1ZvzPAQ+ZMRtkg8kFzNq7A5AaBheINgS5
         D3P6fSFarQkYLF2aOURCdD3k7IvHCxgSPYGYhlSha/qIAxdBGlavMgasQZZyWFng2QJU
         YbIiCSj5kN/HkSCxx4PQyN/LaZueRxGxj+rVSgZcko5wk8gbsm/Vbtg3P5JWkyHR0V4z
         EDd6V/b39vzj8eOHDNOq01aLQV3b2oXfrzkN/B9TV4jf70TrKzxUorxVQXW9Jdhih7wg
         t1Zg==
X-Gm-Message-State: AOAM531Q5l58rWSDtychxv7aeb9Up2yj0Bd1DKZPAXrwsB3JVayPGzio
        MOr+m60g4pF8cXW7CIXdYYTCDGTRRisuiJQYoPE=
X-Google-Smtp-Source: ABdhPJy3i2DiYiciOYsCGwbkuo32YvAjkeb6+tWaO1KQxza8n48SGhUI9qlNJgafRWk9Ki7WXIN2lLq/PTS+WyN/su0=
X-Received: by 2002:a17:902:b206:: with SMTP id t6mr8185421plr.262.1591344970979;
 Fri, 05 Jun 2020 01:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-6-michael@walle.cc>
In-Reply-To: <20200604211039.12689-6-michael@walle.cc>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Jun 2020 11:15:54 +0300
Message-ID: <CAHp75VdMSoj2+jKkA=oais2QAWBmvgzE6PLJdm6rebooubLCcw@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] pwm: add support for sl28cpld PWM controller
To:     Michael Walle <michael@walle.cc>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jun 5, 2020 at 12:16 AM Michael Walle <michael@walle.cc> wrote:
>
> Add support for the PWM controller of the sl28cpld board management
> controller. This is part of a multi-function device driver.
>
> The controller has one PWM channel and can just generate four distinct
> frequencies.

So same comments (extra comma, cargo cult headers, etc) are applied
here and perhaps to all other patches in the series.

-- 
With Best Regards,
Andy Shevchenko
