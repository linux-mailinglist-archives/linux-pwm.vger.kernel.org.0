Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DFD1EF2A5
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 10:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgFEIDL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 04:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEIDL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 04:03:11 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72146C08C5C2;
        Fri,  5 Jun 2020 01:03:11 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d66so4559872pfd.6;
        Fri, 05 Jun 2020 01:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHwub92QAXzXijZjt4YnToucQrRKEkeW4WsAEf/TOL4=;
        b=T8Yqt6jKBgrcWFcSffwTEeC/DOrsly6hcsf69VAlxmTs1ZkOehtZHCN7riSnT3gjwT
         pwfj5PueFKNhmJk8jDfM+NXKjSrQU9zgXAekkgppiNN9ds0DBn6vPZiVykL3SXkqMCfF
         uL46/XNSmQuoB0SX1CzXwIik9VoRrLwTmb3o8z9ycl2M6IJZOGG9O7zkDv2PUN1u18x2
         AZV+346+RapXYzcm6fPw9qK0LGn48ACHQgw9vVntQS1+xnurdH9xdl8iMUZ76J9HYm+u
         Zo02L+Rpnc4wLLdQxU7tY7UXyXdl/1q6194tmsMtvV/DYRLv+TjWstktsFCKcnboAKMI
         +CBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHwub92QAXzXijZjt4YnToucQrRKEkeW4WsAEf/TOL4=;
        b=fBp3B+keN/vdglU5rddp0E5rN0Ivvt0OweZeKLgdwX7Yl/BvkGAgjG+8uBlnx7KbDq
         1KBIcfAxAguq+EJ3p8o5D743X0sp8vbmo4rsazn6fuIPcRNa6o9MzOk84WFbQeZOhkJU
         4PNt5fZ4M0AzjwVFFOLHx9YPiTJjcw2nIXde2Yru6KnxsPYY0fPU/MyQECY9lfE3Tbho
         3vxEmqMLpw91IckJvTieEPFVoLvelCmjHVUYgVPDGG40baaSCR53VZnfV8ROkoB/Y8Gm
         2LGhvVbBaz1Qn0D72FEGYzl7mgjEvhFknGFRLGOy53SbN+omW6HfGnHqYYLQ0z8khin8
         2D3g==
X-Gm-Message-State: AOAM5318vwTfJdLyoSnZtkKnkPetmAEoo8L4GSYCDjRpkZQIT/qPu0gI
        PKZh4BLOd4OW/vZlf32lVu9X4Ur9xhfXWQXVCuE=
X-Google-Smtp-Source: ABdhPJw2VSZ6DRFi00rf7DMs7d0yVlBq9BqobpT3xUZu+XAE5n8q6rYFKa5+khR6g8c2wjiKOciXdvfUo1oI3CLEiLw=
X-Received: by 2002:a63:ff52:: with SMTP id s18mr8530984pgk.203.1591344190940;
 Fri, 05 Jun 2020 01:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-3-michael@walle.cc>
 <CAHp75Vd-R3yqhq88-whY6vdDhESpzvFCsbi-ygSTjfXfUzOrtg@mail.gmail.com>
In-Reply-To: <CAHp75Vd-R3yqhq88-whY6vdDhESpzvFCsbi-ygSTjfXfUzOrtg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Jun 2020 11:02:54 +0300
Message-ID: <CAHp75VfKtt7ZnVdE+n7JjGH-MXsOch-GNZpbv5r780a=VsgZXQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management controller
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

On Fri, Jun 5, 2020 at 11:01 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jun 5, 2020 at 12:16 AM Michael Walle <michael@walle.cc> wrote:

...

> > Please note that the MFD driver is defined as bool in the Kconfig
> > because the next patch will add interrupt support.

> > +       bool "Kontron sl28 core driver"
> > +       depends on I2C=y
>
> Why not module?

To be clear, I have read above, but it didn't shed a light.

-- 
With Best Regards,
Andy Shevchenko
