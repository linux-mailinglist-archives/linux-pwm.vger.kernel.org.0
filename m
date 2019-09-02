Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B103A5CDB
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Sep 2019 22:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfIBUGT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Sep 2019 16:06:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56891 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfIBUGT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Sep 2019 16:06:19 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i4saY-000596-5w; Mon, 02 Sep 2019 22:06:10 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i4saT-0002Nc-Kv; Mon, 02 Sep 2019 22:06:05 +0200
Date:   Mon, 2 Sep 2019 22:06:05 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Claudiu.Beznea@microchip.com
Cc:     thierry.reding@gmail.com, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 6/6] pwm: atmel: implement .get_state()
Message-ID: <20190902200605.2tipkzh3n7ylehku@pengutronix.de>
References: <20190824001041.11007-1-uwe@kleine-koenig.org>
 <20190824001041.11007-7-uwe@kleine-koenig.org>
 <8da4ef26-872f-beaf-b5cb-9d8cb93a2ce9@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8da4ef26-872f-beaf-b5cb-9d8cb93a2ce9@microchip.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Claudiu,

On Wed, Aug 28, 2019 at 10:26:18AM +0000, Claudiu.Beznea@microchip.com wrote:
> On 24.08.2019 03:10, Uwe Kleine-König wrote:
> > External E-Mail
> > This function reads back the configured parameters from the hardware. As
> > .apply rounds down (mostly) I'm rounding up in .get_state() to achieve
> > that applying a state just read from hardware is a no-op.
> 
> Since this read is only at probing, at least for the moment, and, as far as

Yes, up to now .get_state() is only called at probing time. There is a
patch series (by me) on the list that changes that. (Though I'm not
entirely sure this is a good idea. Will comment my doubts in that thread
later.)

> I remember, the idea w/ .get_state was to reflect in Linux the states of
> PWMs that were setup before Linux takes control (e.g. PWMs setup in
> bootloaders) I think it would no problem if it would be no-ops in this
> scenario.

IMHO it should be a no-op.

> In case of run-time state retrieval, pwm_get_state() should be
> enough. If one would get the state previously saved w/ this .get_state API
> he/she would change it, then it would apply the changes to the hardware. No
> changes of PWM state would be anyway skipped from the beginning, in
> pwm_apply_state() by this code:
> 
>         if (state->period == pwm->state.period &&
>             state->duty_cycle == pwm->state.duty_cycle &&
> 	    state->polarity == pwm->state.polarity &&
>             state->enabled == pwm->state.enabled)
> 		return 0;
> 
> But maybe I'm missing something.

There is a problem I want to solve generally, not only for the atmel driver.

For example I consider it "expected" that

	s1 = pwm_get_state(pwm)
	pwm_apply_state(pwm, s2)
	pwm_apply_state(pwm, s1)

ends in the same configuration as it started. For that it is necessary
(even for the atmel driver with the guard you pointed out above) to
round up in .get_state if .apply rounds down.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
