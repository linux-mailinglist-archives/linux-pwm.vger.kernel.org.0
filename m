Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5732B87E9
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 23:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgKRWqv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 17:46:51 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:36590 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgKRWqv (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Nov 2020 17:46:51 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kfWDg-007oYC-HA; Wed, 18 Nov 2020 23:46:32 +0100
Date:   Wed, 18 Nov 2020 23:46:32 +0100
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
Subject: Re: [PATCH 0/5] gpio: mvebu: Armada 8K/7K PWM support
Message-ID: <20201118224632.GE1853236@lunn.ch>
References: <cover.1605694661.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605694661.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Nov 18, 2020 at 12:30:41PM +0200, Baruch Siach wrote:
> The gpio-mvebu driver supports the PWM functionality of the GPIO block for 
> earlier Armada variants like XP, 370 and 38x. This series extends support to 
> newer Armada variants that use CP11x and AP80x, like Armada 8K and 7K.
> 
> This series adds adds the 'pwm-offset' property to DT binding. 'pwm-offset' 

One adds is enough.

> points to the base of A/B counter registers that determine the PWM period and 
> duty cycle.
> 
> The existing PWM DT binding reflects an arbitrary decision to allocate the A 
> counter to the first GPIO block, and B counter to the other one.

It was not arbitrary. I decided on KISS. The few devices i've seen
using this have been for a single GPIO/PWN controlled fan. KISS was
sufficient for that, so why make it more complex?

	   Andrew
