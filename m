Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E552111848D
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Dec 2019 11:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfLJKMf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Dec 2019 05:12:35 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40981 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJKMf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Dec 2019 05:12:35 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iecVL-00015W-G5; Tue, 10 Dec 2019 11:12:31 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iecVK-0005Q1-2t; Tue, 10 Dec 2019 11:12:30 +0100
Date:   Tue, 10 Dec 2019 11:12:29 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     walter harms <wharms@bfs.de>
Cc:     Colin King <colin.king@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] pwm: sun4i: Narrow scope of local variable
Message-ID: <20191210101229.rvqelc2hanisd2cp@pengutronix.de>
References: <20191002101624.gljyf7g4nia2rcbx@pengutronix.de>
 <20191205072404.6858-1-u.kleine-koenig@pengutronix.de>
 <5DE8C1E3.4080204@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5DE8C1E3.4080204@bfs.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Walter,

On Thu, Dec 05, 2019 at 09:37:55AM +0100, walter harms wrote:
> Am 05.12.2019 08:24, schrieb Uwe Kleine-König:
> > +			unsigned int pval;
> > +
> >  			if (!prescaler_table[prescaler])
> >  				continue;
> >  			pval = prescaler_table[prescaler];
> 
> 
> nit picking:
> Doing the assignment first would remove the only use
> of prescaler_table[prescaler].

nit picking: it would be reduced to a single use?!

> unsigned int pval = prescaler_table[prescaler];
> if ( ! pval )
>   continue;

Right, will send a v2 with that.

> if you feel adventures you could also replace the for() for a while()
> since we know that prescaler == 0.
> 
> while ( prescaler < PWM_PRESCAL_MASK )
> {
> unsigned int pval = prescaler_table[prescaler++];
> ....

That however has some side effects as prescaler is used after leaving
the loop.

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
