Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9918379509
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 19:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhEJRKR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 10 May 2021 13:10:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3053 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbhEJRKR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 13:10:17 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ff6gS3zHFz70gFg;
        Tue, 11 May 2021 00:57:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 19:09:09 +0200
Received: from localhost (10.52.123.16) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 10 May
 2021 18:09:08 +0100
Date:   Mon, 10 May 2021 18:07:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Wolfram Sang <wsa@kernel.org>,
        "Oleksij Rempel" <o.rempel@pengutronix.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <kernel@pengutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
        <linux-spi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: Re: [PATCH v6 RESEND 0/6] clk: provide new devm helpers for
 prepared and enabled clocks
Message-ID: <20210510180727.0000056d@Huawei.com>
In-Reply-To: <20210510061724.940447-1-u.kleine-koenig@pengutronix.de>
References: <20210510061724.940447-1-u.kleine-koenig@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.123.16]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 10 May 2021 08:17:18 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> Hello,
> 
> this is just a resend as I didn't get any feedback in the two weeks
> since the original v6 submission. Would be nice to hear something back,
> I'm trying for more than half a year now to get feedback. :-\

I have a bunch of usecases in IIO, (many with local devm_add_action_or_reset()
doing the same thing.)

+CC Alex who sent out a series add more local handling of this case
today.

Code seems correct and clean to me, but whether the clk maintainers
want to encourage this pattern is down to them (I've had similar discussions
about regulators in the past where we've agreed to disagree on this topic).

Jonathan

> 
> Best regards
> Uwe
> 
> Uwe Kleine-König (6):
>   clk: generalize devm_clk_get() a bit
>   clk: Provide new devm_clk_helpers for prepared and enabled clocks
>   pwm: atmel: Simplify using devm_clk_get_prepared()
>   rtc: at91sam9: Simplify using devm_clk_get_enabled()
>   i2c: imx: Simplify using devm_clk_get_enabled()
>   spi: davinci: Simplify using devm_clk_get_enabled()
> 
>  drivers/clk/clk-devres.c     | 96 ++++++++++++++++++++++++++++++------
>  drivers/i2c/busses/i2c-imx.c | 12 +----
>  drivers/pwm/pwm-atmel.c      | 15 +-----
>  drivers/rtc/rtc-at91sam9.c   | 22 ++-------
>  drivers/spi/spi-davinci.c    | 11 +----
>  include/linux/clk.h          | 87 +++++++++++++++++++++++++++++++-
>  6 files changed, 176 insertions(+), 67 deletions(-)
> 
> 
> base-commit: a38fd8748464831584a19438cbb3082b5a2dab15

