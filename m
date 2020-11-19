Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E68C2B93B6
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Nov 2020 14:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgKSNes (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Nov 2020 08:34:48 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:38160 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgKSNer (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 19 Nov 2020 08:34:47 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kfk4z-007w8v-Lm; Thu, 19 Nov 2020 14:34:29 +0100
Date:   Thu, 19 Nov 2020 14:34:29 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] gpio: mvebu: add pwm support for Armada 8K/7K
Message-ID: <20201119133429.GS1804098@lunn.ch>
References: <cover.1605694661.git.baruch@tkos.co.il>
 <db0d6d619a0686eef1b15ca7409d73813440856f.1605694661.git.baruch@tkos.co.il>
 <20201118231811.GH1853236@lunn.ch>
 <878sax6f43.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sax6f43.fsf@tarshish>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> >> @@ -1200,6 +1235,13 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
> >>  
> >>  	devm_gpiochip_add_data(&pdev->dev, &mvchip->chip, mvchip);
> >>  
> >> +	/* Some MVEBU SoCs have simple PWM support for GPIO lines */
> >> +	if (IS_ENABLED(CONFIG_PWM)) {
> >> +		err = mvebu_pwm_probe(pdev, mvchip, id);
> >> +		if (err)
> >> +			return err;
> >> +	}
> >> +
> >
> > The existing error handling looks odd here. Why is there no goto
> > err_domain when probing the PWMs fails? I wonder if this a bug from me
> > from a long time again?
> 
> What would you release under the err_domain label? As far as I can see
> all resources are allocated using devres, and released automatically on
> failure exit.

The IRQ domain is still registers. So once the memory is automatically
freed, don't we have a potential use after free?

       Andrew
