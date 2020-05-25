Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B211E11DE
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2020 17:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404066AbgEYPiT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 May 2020 11:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404040AbgEYPiT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 May 2020 11:38:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7772DC061A0E
        for <linux-pwm@vger.kernel.org>; Mon, 25 May 2020 08:38:19 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jdFBA-0004AX-Nm; Mon, 25 May 2020 17:38:16 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jdFBA-0008Id-19; Mon, 25 May 2020 17:38:16 +0200
Date:   Mon, 25 May 2020 17:38:16 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] pwm: jz4740: Enhance precision in calculation of
 duty cycle
Message-ID: <20200525153815.fthxiuzhsgj24kyo@pengutronix.de>
References: <20200525125722.36447-1-paul@crapouillou.net>
 <20200525125722.36447-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200525125722.36447-2-paul@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, May 25, 2020 at 02:57:20PM +0200, Paul Cercueil wrote:
> Calculating the hardware value for the duty from the hardware value of
> the period resulted in a precision loss versus calculating it from the
> clock rate directly.
> 
> (Also remove a cast that doesn't really need to be here)
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: New patch. I don't consider this a fix but an enhancement, since the old
>     	behaviour was in place since the driver was born in ~2010, so no Fixes tag.

I would not hesitate and add:

	Fixes: f6b8a5700057 ("pwm: Add Ingenic JZ4740 support")

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks for picking this up,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
