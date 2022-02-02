Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267214A7AD0
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Feb 2022 23:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347809AbiBBWKK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Feb 2022 17:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347799AbiBBWKJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Feb 2022 17:10:09 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E73C06173B;
        Wed,  2 Feb 2022 14:10:09 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 200so989560qki.2;
        Wed, 02 Feb 2022 14:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Rr5xR3phcMmOtciTLGMao2x+J3LzUpf33KP5PgsG6mw=;
        b=fcP42zsjJKBRLsCCLNxeBAvGoAUH+RgY1jYrpOhhT8bMHr7+15EWYSucDQfP1oORdR
         v8va2D+TIvGEUfFpYyk+KAAnpvrPj2Do2UURxQqDM2NZ0yrVKHV/Tmvmi8VnHPqEl5Sj
         FzsjYO1CSUmsISBtPa5x3zIEsUBOu9RZDDuPyg2QqPpe+3i2ouYdl1b7XJc+7Yz287oe
         n4Ll3sdxxGbRuNPqe8Va40e5cgmVlDZI5fIN6fBWjGY94knmRKOKljCldyrgDLu4eqFI
         61yZGnSZcmCnvpc5Ppek75k/hWgHufZ8NwnxWp4bgKiaLrzdRDurexHwqhp4Nqyni8AG
         h/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=Rr5xR3phcMmOtciTLGMao2x+J3LzUpf33KP5PgsG6mw=;
        b=C65pH2rY/pHA4/UDlbE1AUvm+emU4zTl6GaizZbzr+Fh/rvc/8XlEKFYQ/8VxXMcjQ
         BmtafWC6iCpmqVuiZtDjXjFUlkCPyp9tYtOr4OTczSuIQI4bm2uluGhfuuO/K+vWkAYG
         cdnZwllIAFIdM5tutCsBgVIsiDA6SEhg8zPWgi5uBrsMtvaswkVj1GZIK6OQUjqh4n+L
         m7hxSWM89ijjSe8fBzEgH6ZaObRsv5QxVZg8ZNOpJ2x7SQKVPgu6sBcelO2oGLzmfYmN
         YuFCxLVN8k/DsnM62FtrFMLgTm0iTVpinTdyqXeYETiQNKIF5rQ33xURA2TiDZUYxWTo
         jwVQ==
X-Gm-Message-State: AOAM532SVVHVa1PIRrbf07l6oATCpnGr0hBEKCAMYp8zxgLDbbS+zNWj
        t7vHb6vsHErwe1lSfKyiSQ==
X-Google-Smtp-Source: ABdhPJwRpKyRhMilcGtomGensbv6thBpUXpxVK7cAkdNeBk0lqsREJF6QVbIyABhwvxgVYCy4DCMsQ==
X-Received: by 2002:a37:4648:: with SMTP id t69mr21000172qka.702.1643839808031;
        Wed, 02 Feb 2022 14:10:08 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id o13sm7298868qtv.36.2022.02.02.14.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 14:10:07 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:c4e6:e49c:6958:ac58])
        by serve.minyard.net (Postfix) with ESMTPSA id 68539181297;
        Wed,  2 Feb 2022 22:10:06 +0000 (UTC)
Date:   Wed, 2 Feb 2022 16:10:05 -0600
From:   Corey Minyard <minyard@acm.org>
To:     "Verdun, Jean-Marie" <verdun@hpe.com>
Cc:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Wang Kefeng <wangkefeng.wang@huawei.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Hao Fang <fanghao11@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Richard Weinberger <richard@nod.at>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, Marc Zyngier <maz@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [Openipmi-developer] [PATCH] HPE BMC GXP SUPPORT
Message-ID: <20220202221005.GD2091156@minyard.net>
Reply-To: minyard@acm.org
References: <nick.hawkins@hpe.com>
 <20220202165315.18282-1-nick.hawkins@hpe.com>
 <20220202175635.GC2091156@minyard.net>
 <3E9905F2-1576-4826-ADC2-85796DE0F4DB@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E9905F2-1576-4826-ADC2-85796DE0F4DB@hpe.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Feb 02, 2022 at 06:14:57PM +0000, Verdun, Jean-Marie wrote:
> > This is far too big for a single patch.  It needs to be broken into
> > functional chunks that can be reviewed individually.  Each driver and
> > each device tree change along with it's accompanying code need to be
> > done in individual patches.  The way it is it can't be reviewed in any
> > sane manner.
> 
> > -corey
> 
> Thanks for your feedback. We are getting a little bit lost here, as our plan was to submit initial
> 
> - bindings
> - dts for SoC and 1 board
> - initial platform init code
> 
> Then drivers code avoiding to send many dts updates which might complexify the review. We wanted to send all drivers code to relevant reviewers by tomorrow.
> 
> So, what you are asking ( do not worry I am not trying to negotiate, I just want to avoid English misunderstandings as I am French) is to send per driver
> 
> - binding
> - dts update
> - driver code
> 
> For each driver through different submission (with each of them containing the 3 associated parts) ?

Arnd gave an excellent explaination for this.

To be clear, you need to split out changes to individual subsystems and
submit those to the maintainers for that subsystem and not send them to
everyone.  That way you reduce sending emails to people who don't need
to see them.

Once you have a set of patches for a subsystem, you can submit them as one
set.  That is generally preferred.  The "git send-email" or "git
format-patch" tools are generally what we use, they let you compose a
header message where you can give an overall explaination, then it sends
the individual changes as followup messages to the header message.

-corey

> 
> What shall be the initial one in our case as we are introducing a platform ? An empty dts infrastructure and then we make it grow one step at a time ?
> 
> vejmarie
> 
> ﻿
>  
> 
> 
> _______________________________________________
> Openipmi-developer mailing list
> Openipmi-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openipmi-developer
