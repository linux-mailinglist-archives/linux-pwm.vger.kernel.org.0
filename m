Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45AC2EAB32
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Jan 2021 13:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbhAEMuc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Jan 2021 07:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbhAEMub (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Jan 2021 07:50:31 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86F2C061793;
        Tue,  5 Jan 2021 04:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bqNMDEYrecUR3M+dtWwwtcySm0za9HVVgygO49cltX4=; b=FCK6Wx4ClTXTLJF/RcMApdDjQ
        AYx4P4TsOP12UPGxtWDEbi8Fk9lPUx98sIBRJm9Fv9V6r/1SvMykicrTuh50JnufrG8SyXeyxEchw
        0tXUVknnRLGXboTK9+nerjucRV3gJ0teneoHMyna/x1ki0wcZAyNe93lGDFJMQl/nDxWdXVOVBhBA
        Pjo1TWRNlIV3vpTcINKvwRBu0k1ovsilOQrfJNsPcx6ipHKiRGEeiZ27QHn3GdfIHf0QJRsobQ/ov
        R94FSY7uoDVRuXD/qib6O34CCyyu8aAM2ypAEXng4xTRAuIzJDuZm1zZrbWPZTV7JbH7jgstreX0E
        +vAId1mlQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45098)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kwlm9-0000lV-Up; Tue, 05 Jan 2021 12:49:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kwlm2-0007jF-52; Tue, 05 Jan 2021 12:49:18 +0000
Date:   Tue, 5 Jan 2021 12:49:18 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/4] gpio: mvebu: fix pwm get_state period calculation
Message-ID: <20210105124917.GC1551@shell.armlinux.org.uk>
References: <cover.1609849176.git.baruch@tkos.co.il>
 <0cd077886d37699bdf0a20295fd8ee422e5285b5.1609849176.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cd077886d37699bdf0a20295fd8ee422e5285b5.1609849176.git.baruch@tkos.co.il>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jan 05, 2021 at 02:42:28PM +0200, Baruch Siach wrote:
> The period is the sum of on and off values.
> 
> Reported-by: Russell King <linux@armlinux.org.uk>
> Fixes: 757642f9a584e ("gpio: mvebu: Add limited PWM support")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/gpio/gpio-mvebu.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 672681a976f5..ac7cb6d3702e 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -679,17 +679,13 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
>  	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), &u);
>  	val = (unsigned long long) u * NSEC_PER_SEC;
>  	do_div(val, mvpwm->clk_rate);
> -	if (val < state->duty_cycle) {
> +	val += state->duty_cycle;
> +	if (val > UINT_MAX)
> +		state->period = UINT_MAX;
> +	else if (val)
> +		state->period = val;
> +	else
>  		state->period = 1;

Are you sure this is the correct solution? Aren't you introducing
rounding errors?

The hardware will count to (on + off) clock ticks, so the right way
to convert that is to add the two together and then convert to
nanoseconds, which may result in a single rounding error. If you
convert each individually to nanoseconds, then you can end up with
two sets of rounding errors.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
