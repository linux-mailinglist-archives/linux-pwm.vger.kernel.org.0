Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AE51EFC24
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 17:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgFEPFt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 11:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgFEPFt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 11:05:49 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB72C08C5C2;
        Fri,  5 Jun 2020 08:05:49 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t16so3732862plo.7;
        Fri, 05 Jun 2020 08:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zl3uXlckh/ILLSJmP4ICOMWaZeDZ9A0z1FTiwzLjSyw=;
        b=FhMZXa0pqbczzolzAxUWZ6l/cPlMoh4ca88ZnP72F5OYEn3zDPmaVkLsEhS4wZ+pb0
         OpUlPrw60Tua/44wX2E7hmR3oq/UIlBkX6MCzdidGL3xYk4Tk8eeCL6xZHOKj9vNCrAg
         guhsG/zT5eSHPtpXuIhpIMM6uloPsYE3bXwLAHewQdvx6qHVnWyuxAWjQ1fz3ckzVPDS
         5pUVso6Z2RoHxEz39lci25KPw6abx1Zkuq+KXgPKXiTANRvNBOou8K8pTFA0bYezdf9z
         TzKSMnbwvC/WXnzd6T9MMZ40cgzcmMVsVtAsAsviiHakm4fgNulNY9awZsOEFrTAdlAl
         USFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zl3uXlckh/ILLSJmP4ICOMWaZeDZ9A0z1FTiwzLjSyw=;
        b=GYqrFKMRkcEr+7RxNGLOOaliePFgZZ290Cdps9ZB2RwODWNybrQSVi6FsyZGg+mZmY
         K06mCvHU0pKZnAJ/FBQWZdfL94q5u7WYqT0UrfDSdzWRU5oybw2wqJBhjM3aB4CzxExa
         TJ8xt4mXWqIliUTd4dHLsVpgmZoSPh/ZlExuAcminVi853uBiTkGBCZ3ByLcWQDGLuu8
         FSc5FD3Fjg4ML1My/jyybmxgopnI1F5Lj7u8+c0z8rgGifUTULUd9uVEopNAbQiSAIEK
         7KqEQhUMVvYq60+7XAalmVMO1AXGd1QsiujKI6haXaLhFCw585oH/nJwaLPbQO7vwTuk
         dwxQ==
X-Gm-Message-State: AOAM530mhzap1oNr+mugY+h/BrK5zjli+L9Gz4OQUdLKrrI/yG/6P6gH
        z1uKFszoU3VZneBVENeveBw=
X-Google-Smtp-Source: ABdhPJyEI1zMv/msQyU+Ei4KhuaGEwq9i+HpH2+fhygN3bHJuK30LAKFw+2tG0snVq8JEO8lyyXIig==
X-Received: by 2002:a17:90a:20c2:: with SMTP id f60mr3704149pjg.29.1591369548704;
        Fri, 05 Jun 2020 08:05:48 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 5sm3155367pfc.143.2020.06.05.08.05.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jun 2020 08:05:44 -0700 (PDT)
Date:   Fri, 5 Jun 2020 08:05:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Michael Walle <michael@walle.cc>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 04/11] watchdog: add support for sl28cpld watchdog
Message-ID: <20200605150542.GA254229@roeck-us.net>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-5-michael@walle.cc>
 <CAHp75VdeD6zDc--R4NPHsiqQerzfNGwUikLN+WHMiZZVsQ8QSA@mail.gmail.com>
 <8f042c2442852c29519c381833f3d289@walle.cc>
 <CAHp75VfY0BD4CFu6Thx1wE-U0Zt1q8uTOLxkWTMdFk0MBuhYFQ@mail.gmail.com>
 <871a4990-5b94-3a17-01d4-74998375f08b@roeck-us.net>
 <20200605140911.GO2428291@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605140911.GO2428291@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jun 05, 2020 at 05:09:11PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 05, 2020 at 06:52:00AM -0700, Guenter Roeck wrote:
> > On 6/5/20 3:50 AM, Andy Shevchenko wrote:
> > > On Fri, Jun 5, 2020 at 1:24 PM Michael Walle <michael@walle.cc> wrote:
> > >> Am 2020-06-05 10:14, schrieb Andy Shevchenko:
> > >>> On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael@walle.cc> wrote:
> 
> ...
> 
> > >>>> +static bool nowayout = WATCHDOG_NOWAYOUT;
> > >>>> +module_param(nowayout, bool, 0);
> > >>>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started
> > >>>> (default="
> > >>>> +                               __MODULE_STRING(WATCHDOG_NOWAYOUT)
> > >>>> ")");
> > >>>> +
> > >>>> +static int timeout;
> > >>>> +module_param(timeout, int, 0);
> > >>>> +MODULE_PARM_DESC(timeout, "Initial watchdog timeout in seconds");
> > >>>
> > >>> Guenter ACKed this, but I'm wondering why we still need module
> > >>> parameters...
> > >>
> > >> How would a user change the nowayout or the timeout? For the latter
> > >> there is
> > >> a device tree entry, but thats not easy changable by the user.
> > > 
> > > Yes, it's more question to VIm and Guenter than to you.
> > > 
> > 
> > Has support for providing module parameters with the kernel command line
> > been discontinued/deprecated, or did it run out of favor ? Sorry if I
> > missed that.
> 
> Latter according to Greg KH. One of the (plenty) examples [1].
> 
> [1]: https://www.mail-archive.com/driverdev-devel@linuxdriverproject.org/msg96495.html
> 
What is the suggested replacement ?

Guenter
