Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E64E3B6AB6
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Sep 2019 20:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfIRSkq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Sep 2019 14:40:46 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37747 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfIRSkq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Sep 2019 14:40:46 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iAesa-00059E-Ip; Wed, 18 Sep 2019 20:40:40 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iAesZ-0002ge-3I; Wed, 18 Sep 2019 20:40:39 +0200
Date:   Wed, 18 Sep 2019 20:40:39 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     thierry.reding@gmail.com, alexandre.torgue@st.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2] pwm: stm32-lp: add check in case requested period
 cannot be achieved
Message-ID: <20190918184039.27dtd3zguawijsqo@pengutronix.de>
References: <1568818461-19995-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1568818461-19995-1-git-send-email-fabrice.gasnier@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Sep 18, 2019 at 04:54:21PM +0200, Fabrice Gasnier wrote:
> LPTimer can use a 32KHz clock for counting. It depends on clock tree
> configuration. In such a case, PWM output frequency range is limited.
> Although unlikely, nothing prevents user from requesting a PWM frequency
> above counting clock (32KHz for instance):
> - This causes (prd - 1) = 0xffff to be written in ARR register later in
> the apply() routine.
> This results in badly configured PWM period (and also duty_cycle).
> Add a check to report an error is such a case.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

If you are interested to improve the driver further, there are a few
things that I would welcome to see fixed in a tested patch:

 - duty calculation uses requested instead of implemented period.
 - stm32_pwm_lp_apply calls pwm_get_state
 - Calculation of prd could be done without a loop
 - A hint about relevant documentation in the driver's header would be
   great
 - Documentation about behaviour of the hardware is missing:
   - Does the hardware complete the currently running period when
     STM32_LPTIM_CR is cleared?
   - Does the output stop in the inactive output level when the PWM is
     stopped?
 - clk_get_rate might be called without the clock being enabled.
 - The driver does:

 	ret = regmap_write(priv->regmap, STM32_LPTIM_CMP, prd - (1 + dty));

   That looks wrong. (Consider dty == prd.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
