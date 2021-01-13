Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1B32F5785
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Jan 2021 04:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbhANCBg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jan 2021 21:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbhAMXY6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Jan 2021 18:24:58 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C26DC061794;
        Wed, 13 Jan 2021 14:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kWNyCcRqQWlgKgnePjwJfWQop1S4JCvLZgBInQUzPdY=; b=cqqmJ5rbEOL8avTUSGdWvUEsyN
        YmOrhjodRNocq95noo1yW7xFc/YxPEbxUlTSECyMnjQRmfqcQIYg1IkZ3XftK/RIouJA9jekWt3Od
        o0w5+GxUdYuGcw4JZR4iKMzIRpSn6IUGH1Pk8SkeMQpRx7lZbCnk4M/Lf6cW/tJYgryM=;
Received: from p200300ccff0ba2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0b:a200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kzouc-0001n0-7u; Wed, 13 Jan 2021 23:46:47 +0100
Date:   Wed, 13 Jan 2021 23:46:45 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
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
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 4/7] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Message-ID: <20210113234645.52fcf73c@aktux>
In-Reply-To: <20210112203902.4e196d11@aktux>
References: <20210109180220.121511-1-j.neuschaefer@gmx.net>
        <20210109180220.121511-5-j.neuschaefer@gmx.net>
        <20210112203902.4e196d11@aktux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 12 Jan 2021 20:39:02 +0100
Andreas Kemnade <andreas@kemnade.info> wrote:

[...]
> > +static int ntxec_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct ntxec *ec = dev_get_drvdata(pdev->dev.parent);
> > +	struct ntxec_pwm *priv;
> > +	struct pwm_chip *chip;
> > +
> > +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->ec = ec;
> > +	priv->dev = &pdev->dev;
> > +
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	chip = &priv->chip;
> > +	chip->dev = &pdev->dev;  
> 
> Hmm, I needed
> chip->dev = &pdev->dev.parent to use the backlight example
> in patch 2/7.
> Not sure what the correct solution is. Maybe the pwm deserves its own
> devicetree node.
> 
probably just assigning the node from the parent.

   pdev->dev.of_node = pdev->dev.parent->of_node;

Regards,
Andreas
