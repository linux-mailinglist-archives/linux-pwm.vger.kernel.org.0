Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C502260EE0
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Sep 2020 11:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgIHJjx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Sep 2020 05:39:53 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:51895 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbgIHJjx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Sep 2020 05:39:53 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 0E8EA24000F;
        Tue,  8 Sep 2020 09:39:46 +0000 (UTC)
Date:   Tue, 8 Sep 2020 11:39:46 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Shawn Guo <shawnguo@kernel.org>,
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
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Subject: Re: [PATCH v2 07/10] rtc: Introduce RTC_TIMESTAMP_END_2255
Message-ID: <20200908093946.GQ230586@piout.net>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
 <20200905133230.1014581-8-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200905133230.1014581-8-j.neuschaefer@gmx.net>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 05/09/2020 15:32:27+0200, Jonathan Neuschäfer wrote:
> Some RTCs store the year as an 8-bit number relative to the year 2000.
> This results in a maximum timestamp of 2255-12-31 23:59:59.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> v2:
> - New patch
> ---
>  include/linux/rtc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> index 22d1575e4991b..fcc086084a603 100644
> --- a/include/linux/rtc.h
> +++ b/include/linux/rtc.h
> @@ -154,6 +154,7 @@ struct rtc_device {
>  #define RTC_TIMESTAMP_END_2079		3471292799LL /* 2079-12-31 23:59:59 */
>  #define RTC_TIMESTAMP_END_2099		4102444799LL /* 2099-12-31 23:59:59 */
>  #define RTC_TIMESTAMP_END_2199		7258118399LL /* 2199-12-31 23:59:59 */
> +#define RTC_TIMESTAMP_END_2255		9025257599LL /* 2255-12-31 23:59:59 */

Honestly, I wouldn't bother adding that one unless you have examples of
other RTCs endng at the same date, I'm fine having the value and comment
directly in the probe function.

>  #define RTC_TIMESTAMP_END_9999		253402300799LL /* 9999-12-31 23:59:59 */
> 
>  extern struct rtc_device *devm_rtc_device_register(struct device *dev,
> --
> 2.28.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
