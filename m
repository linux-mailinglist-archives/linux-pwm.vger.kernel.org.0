Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59842B87EC
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 23:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKRWrw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 17:47:52 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:36612 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgKRWrw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Nov 2020 17:47:52 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kfWEl-007oZ6-BZ; Wed, 18 Nov 2020 23:47:39 +0100
Date:   Wed, 18 Nov 2020 23:47:39 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] gpio: mvebu: update Armada XP per-CPU comment
Message-ID: <20201118224739.GF1853236@lunn.ch>
References: <cover.1605694661.git.baruch@tkos.co.il>
 <42dec69070e1f2b09b29606247635a57f780b765.1605694661.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42dec69070e1f2b09b29606247635a57f780b765.1605694661.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Nov 18, 2020 at 12:30:42PM +0200, Baruch Siach wrote:
> Commit 2233bf7a92e ("gpio: mvebu: switch to regmap for register access")
> introduced percpu_regs to replace percpu_membase. Update the comment to
> match.
> 
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Fixes: 2233bf7a92e7 ("gpio: mvebu: switch to regmap for register access")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
