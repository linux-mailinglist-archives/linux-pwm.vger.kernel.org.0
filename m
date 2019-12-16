Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7EF1200F4
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Dec 2019 10:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfLPJY1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Dec 2019 04:24:27 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45009 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfLPJY0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Dec 2019 04:24:26 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1igmc2-0007UI-5I; Mon, 16 Dec 2019 10:24:22 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1igmc1-0007rp-8f; Mon, 16 Dec 2019 10:24:21 +0100
Date:   Mon, 16 Dec 2019 10:24:21 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-pwm@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v4] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20191216092421.qjifzrdggu7jgqj3@pengutronix.de>
References: <20191129191023.2209-1-miquel.raynal@bootlin.com>
 <20191212211434.455trhnlcvn26zl6@pengutronix.de>
 <20191216093955.177a04af@xps13>
 <20191216085424.x6fqr4gxkph5zqjh@pengutronix.de>
 <20191216101416.339d873f@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191216101416.339d873f@xps13>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Miquèl

On Mon, Dec 16, 2019 at 10:14:16AM +0100, Miquel Raynal wrote:
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote on Mon, 16 Dec
> 2019 09:54:24 +0100:
> > intensity = DIV_ROUND_DOWN_ULL((unsigned long long)state->duty_cycle * PWM_DC_STATES, state->period);
> > 
> > should be both more exact and cheaper to calculate. (But this is
> > somewhat moot given that state->period shouldn't be there.)
> > (And in general you have to care for overflowing, but I think that's not
> > a problem in practise here as struct pwm_state::duty_cycle is an int
> > (still), and PWM_DC_STATES is small.)
> 
> Do you plan to change duty_cycle type?

I don't, but https://patchwork.ozlabs.org/patch/1195481/

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
