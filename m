Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D70513D0B9
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2019 17:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404890AbfFKPZg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Jun 2019 11:25:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52483 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404781AbfFKPZg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Jun 2019 11:25:36 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1haieU-0001Up-HC; Tue, 11 Jun 2019 17:25:34 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1haieT-0004TX-5o; Tue, 11 Jun 2019 17:25:33 +0200
Date:   Tue, 11 Jun 2019 17:25:33 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, palmer@sifive.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, sachin.ghadi@sifive.com
Subject: Re: [PATCH v13 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20190611152533.satxxae7dfrovgny@pengutronix.de>
References: <1560231884-15694-1-git-send-email-yash.shah@sifive.com>
 <1560231884-15694-3-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1560231884-15694-3-git-send-email-yash.shah@sifive.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Tue, Jun 11, 2019 at 11:14:44AM +0530, Yash Shah wrote:
> [...]
> +static int pwm_sifive_remove(struct platform_device *dev)
> +{
> +	struct pwm_sifive_ddata *ddata = platform_get_drvdata(dev);
> +	bool is_enabled = false;
> +	struct pwm_device *pwm;
> +	int ret, ch;
> +
> +	for (ch = 0; ch < ddata->chip.npwm; ch++) {
> +		pwm = &ddata->chip.pwms[ch];
> +		if (pwm->state.enabled) {
> +			is_enabled = true;
> +			break;
> +		}
> +	}
> +	if (is_enabled)
> +		clk_disable(ddata->clk);
> +
> +	clk_disable_unprepare(ddata->clk);
> +	ret = pwmchip_remove(&ddata->chip);
> +	clk_notifier_unregister(ddata->clk, &ddata->notifier);
> +
> +	return ret;

I think the return value of a platform driver's remove callback is
ignored. So usually you should return 0.

Not sure this is worth addressing in a new round, so if noone else has
something to criticise that justifies a new round, take my

	Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

> +}

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
