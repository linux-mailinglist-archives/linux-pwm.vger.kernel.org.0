Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94120255AD9
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Aug 2020 15:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgH1NJY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Aug 2020 09:09:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35284 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbgH1NIo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Aug 2020 09:08:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id ba12so1120747edb.2;
        Fri, 28 Aug 2020 06:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E+aHZUYr4/xAk5Vx/I2zH6eSvAeQy3DL/RIU7rMycss=;
        b=E6cZZR0YEuayjCgtPIhKLaUIm015EoxA1zp2DQ3mJjPxd8e8zcjzbcRiES2lP5KKil
         ZHyxfWyVrPmfud2YWtfm3unM/emunX0V+iZXtBUG9oHa3pw3fCHCAbTTZmfYdIQKHH0U
         rJT5GRgunJKmH1PyhbcYYS7Btq7HCcNhg5y1FuZZB0Qfo7Sl+fo9v6AMaXS4ztoHCxsR
         avp1g1C8naIobLfPK0qRzrne94ZuHbkeyJEBl9xZv+olRpo2HmP0MBQXX53WZqcOO/JZ
         tITcVbeNrmkmMhjjJ2jjzt85u1WmVXTJw2IxcJdBQ6duH9npieWavBV6l1Yrx3NgSErr
         J7zw==
X-Gm-Message-State: AOAM531Cr0WRLpsOxHehy9OwhcqbaIGYQtMpX3hNg6pX13RJ2Z2JcA4o
        /IQpt6b6ooKDnE9aSm6JNU4=
X-Google-Smtp-Source: ABdhPJw2sUyi5oI180j1s6a0iPM15L1BAjci1fZItmg5NmiUYVf2976kX7V0+smnXtOdifVljCX0Xg==
X-Received: by 2002:a50:bf08:: with SMTP id f8mr1717050edk.207.1598620121241;
        Fri, 28 Aug 2020 06:08:41 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id j21sm849059eja.109.2020.08.28.06.08.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Aug 2020 06:08:40 -0700 (PDT)
Date:   Fri, 28 Aug 2020 15:08:37 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v3 00/19] dt-bindings / arm64: Cleanup of i.MX 8 bindings
Message-ID: <20200828130837.GA14163@kozik-lap>
References: <20200825193536.7332-1-krzk@kernel.org>
 <CACRpkdb4j2kJvpY23G-os9gTktZW5HT287MsvMZxC=ovgn_9LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACRpkdb4j2kJvpY23G-os9gTktZW5HT287MsvMZxC=ovgn_9LQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 28, 2020 at 02:51:20PM +0200, Linus Walleij wrote:
> On Tue, Aug 25, 2020 at 9:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
> > This is a v3 of cleanup of i.XM 8 bindings and DTSes.
> 
> If you are going to be working a lot on Freescale SoC code going forward
> I wouldn't mind if you could add yourself as maintainer for the
> Freescale pin controller and GPIO at least, I already have high trust
> in you in general so if the Freescale maintainers also have that I think you
> should just sign up as maintainer. This makes it easier to do pull requests
> and things like that.

Thanks for encouragement.  Indeed I am planning to do more work around
i.MX 8M platforms from NXP/Freescale. However there are already four
maintainers for Freescale pin controller drivers so I doubt there is
need for fifth entry :).

Different question is the GPIO driver which apparently lacks entry in
Maintainers file.

Best regards,
Krzysztof

