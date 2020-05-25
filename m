Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C27A1E11D2
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2020 17:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404205AbgEYPdi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 May 2020 11:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404201AbgEYPdh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 May 2020 11:33:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E57C061A0E
        for <linux-pwm@vger.kernel.org>; Mon, 25 May 2020 08:33:37 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jdF6c-0003kT-CK; Mon, 25 May 2020 17:33:34 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jdF6b-0008AX-Ev; Mon, 25 May 2020 17:33:33 +0200
Date:   Mon, 25 May 2020 17:33:33 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] pwm: jz4740: Drop dependency on MACH_INGENIC
Message-ID: <20200525153333.4wsm3dhkdzjjq6pc@pengutronix.de>
References: <20200525125722.36447-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200525125722.36447-1-paul@crapouillou.net>
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

On Mon, May 25, 2020 at 02:57:19PM +0200, Paul Cercueil wrote:
> Depending on MACH_INGENIC prevent us from creating a generic kernel that
> works on more than one MIPS board. Instead, we just depend on MIPS being
> set.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Nitpick: Your S-o-B should come last. So if you added my Ack the
resulting commit then has (after being picked up by a maintainer):

 .	Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 .	Signed-off-by: Paul Cercueil <paul@crapouillou.net>
 .	Signed-off-by: Peter Maintainer <...>

(quoted to not let patchwork pick up tags) while when the Ack is added
by the maintainer the result is

 .	Signed-off-by: Paul Cercueil <paul@crapouillou.net>
 .	Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 .	Signed-off-by: Peter Maintainer <...>

. So the order tells the reader who added a tag.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
