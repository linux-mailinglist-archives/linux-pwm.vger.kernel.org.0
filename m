Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941CA32C576
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Mar 2021 01:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbhCDAVF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 3 Mar 2021 19:21:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:44952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1582388AbhCCICw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 3 Mar 2021 03:02:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BAAD64EAE;
        Wed,  3 Mar 2021 07:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614758358;
        bh=JjnnxrV4J+6mEkOXKozS9ispJERNvaiOE044Pm3tY1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OjSg/6HUPLnBmGdLAPNLFWk2dv8fx//IhKHY1qgtQvREnxAbbaJc5eBznrQxGzJl7
         Q/rnIcMPPZoHcCWqt2RwNus+/idQDB/L5niWmLZ5KBiIL9nBKog6Ilo7wiKXOyafos
         Crm4mGV2hrYJcVq8TTVpVpDiC/4eb0AtoO3dxOadkZ3G/uUEe51k5Pj8ryMu7p5yPx
         ZzM7DswLHqzxdEJGeXe6Cuqy1VXT4hmtxbh8nU734Xw2EHYSNiG8sqfZdtfN6VquVW
         swMjEE274n3KfE8FaKJiwH540tOljGFm9d9yvYD5vQlUEbn/s5UnPl4sJPkn2lHyVO
         K2AXG7r2bpTgQ==
Date:   Wed, 3 Mar 2021 15:59:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 7/7] ARM: dts: imx50-kobo-aura: Add Netronix embedded
 controller
Message-ID: <20210303075907.GB15865@dragon>
References: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
 <20210124214127.3631530-8-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210124214127.3631530-8-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Jan 24, 2021 at 10:41:27PM +0100, Jonathan Neuschäfer wrote:
> Enable the Netronix EC on the Kobo Aura ebook reader.
> 
> Several features are still missing:
>  - Frontlight/backlight. The vendor kernel drives the frontlight LED
>    using the PWM output of the EC and an additional boost pin that
>    increases the brightness.
>  - Battery monitoring
>  - Interrupts for RTC alarm and low-battery events
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Applied, thanks.
