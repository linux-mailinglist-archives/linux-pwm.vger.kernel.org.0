Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93A921359E9
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2020 14:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbgAINSh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jan 2020 08:18:37 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36505 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbgAINSh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jan 2020 08:18:37 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ipXhi-0005IE-Nk; Thu, 09 Jan 2020 14:18:26 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ipXhh-0000jy-9i; Thu, 09 Jan 2020 14:18:25 +0100
Date:   Thu, 9 Jan 2020 14:18:25 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] pwm: sun4i: Fix inconsistent IS_ERR and PTR_ERR
Message-ID: <20200109131825.beaspmfaxh4gpcx5@pengutronix.de>
References: <20200109072735.GA22886@embeddedor>
 <20200109074445.73n3vapjl4vfjtsu@pengutronix.de>
 <CAJiuCcdFiXVtECtVGz3N9oUM38ca=MDmdK4+T+peUKKzNr_5KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCcdFiXVtECtVGz3N9oUM38ca=MDmdK4+T+peUKKzNr_5KQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Thu, Jan 09, 2020 at 10:14:00AM +0100, Clément Péron wrote:
> On Thu, 9 Jan 2020 at 08:44, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Hello Gustavo,
> >
> > On Thu, Jan 09, 2020 at 01:27:35AM -0600, Gustavo A. R. Silva wrote:
> > > Fix inconsistent IS_ERR and PTR_ERR in sun4i_pwm_probe().
> > >
> > > The proper pointers to be passed as arguments are pwm->clk and pwm->bus_clk.
> 
> Thanks for the catch.
> 
> As these patches are still in next should we update them or apply a fix ?

That's for Thierry to answer.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
