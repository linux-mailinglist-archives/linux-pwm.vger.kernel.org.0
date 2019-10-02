Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5B82C48A4
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2019 09:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfJBHfv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Oct 2019 03:35:51 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47083 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfJBHfu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Oct 2019 03:35:50 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iFZAr-0006yA-2D; Wed, 02 Oct 2019 09:35:49 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iFZAp-0006KA-In; Wed, 02 Oct 2019 09:35:47 +0200
Date:   Wed, 2 Oct 2019 09:35:47 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Baolin Wang <baolin.wang@linaro.org>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Subject: Re: [PATCH RFC] pwm: add debug knob to help driver authors
Message-ID: <20191002073547.kst4pql7nflqpacg@pengutronix.de>
References: <20190815093839.23710-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190815093839.23710-1-u.kleine-koenig@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Thierry,

On Thu, Aug 15, 2019 at 11:38:39AM +0200, Uwe Kleine-König wrote:
> This patch adds some additional checks to the pwm core that help getting
> the details right. The check about rounding isn't approved yet, but I
> consider that sensible as it helps consistency when all drivers round in
> the same direction. The other checks are in line with what I understood
> are the intended requirements.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> this patch is only compile tested up to now but still I think it adds
> useful diagnostics for driver authors that helps even more than an exact
> documentation. Feedback welcome.

do you consider the idea here worthwile? If so I'd update the patch to
current mainline and address the feedback I got so far.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
