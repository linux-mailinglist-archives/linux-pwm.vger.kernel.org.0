Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D42113C23
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2019 08:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfLEHMQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Dec 2019 02:12:16 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35315 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLEHMQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Dec 2019 02:12:16 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iclJ8-0003Hm-7D; Thu, 05 Dec 2019 08:12:14 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iclJ7-0007BY-F2; Thu, 05 Dec 2019 08:12:13 +0100
Date:   Thu, 5 Dec 2019 08:12:13 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/4] pwm: cros-ec: Cache duty cycle value
Message-ID: <20191205071213.5ahi474skoz6y35p@pengutronix.de>
References: <20191021105739.1357629-1-thierry.reding@gmail.com>
 <20191021105739.1357629-2-thierry.reding@gmail.com>
 <041c05b7-f558-0249-0450-305dfa2697a9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <041c05b7-f558-0249-0450-305dfa2697a9@collabora.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Enric,

On Mon, Oct 21, 2019 at 03:48:59PM +0200, Enric Balletbo i Serra wrote:
> On 21/10/19 12:57, Thierry Reding wrote:
> >  static const struct pwm_ops cros_ec_pwm_ops = {
> > +	.request = cros_ec_pwm_request,
> > +	.free = cros_ec_pwm_free,
> 
> nit: Align using tabs for readability.

My personal opinion here is that not aligning is saner in the long run.
For me at least it doesn't disturb readability, and once you have

	.request	= cros_ec_pwm_request,
	.free		= cros_ec_pwm_free,
	.get_state	= cros_ec_pwm_get_state,
	.apply		= cros_ec_pwm_apply,
	.owner		= THIS_MODULE,

and want to set a new member with a long name, fixing the unrelated
lines adds churn and not fixing them looks as ugly as it does with mixed
styling. So I prefer to go with "<space>=<space>" from the start.

> >  	.get_state	= cros_ec_pwm_get_state,
> >  	.apply		= cros_ec_pwm_apply,
> >  	.owner		= THIS_MODULE,

But given that the already existing members are already using some
indention following this style seems right.

@Thierry: You didn't pick up this in your pull request. Should it stay
as it is now with the mixed style to not add churn, or should we fix to
something uniform?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
