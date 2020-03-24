Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97EFF19136F
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Mar 2020 15:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgCXOnP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Mar 2020 10:43:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41447 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgCXOnP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Mar 2020 10:43:15 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jGklo-0001vv-Na; Tue, 24 Mar 2020 15:43:08 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jGkln-0000tK-B5; Tue, 24 Mar 2020 15:43:07 +0100
Date:   Tue, 24 Mar 2020 15:43:07 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-pwm@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v11 10/12] backlight: pwm_bl: Use 64-bit division function
Message-ID: <20200324144307.kxhqzyjj4evrouqa@pengutronix.de>
References: <cover.1584667964.git.gurus@codeaurora.org>
 <17fc1dcf8b9b392d1e37dc7e3e67409e3c502840.1584667964.git.gurus@codeaurora.org>
 <20200320133123.GD5477@dell>
 <20200324110710.GL5477@dell>
 <20200324125735.2mjuvbxt5bpon2ft@pengutronix.de>
 <20200324130410.dwlg767ku6kwequv@holly.lan>
 <20200324142441.GD442973@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200324142441.GD442973@dell>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Mar 24, 2020 at 02:24:41PM +0000, Lee Jones wrote:
> On Tue, 24 Mar 2020, Daniel Thompson wrote:
> 
> > On Tue, Mar 24, 2020 at 01:57:35PM +0100, Uwe Kleine-König wrote:
> > > Hello Lee,
> > > 
> > > On Tue, Mar 24, 2020 at 11:07:10AM +0000, Lee Jones wrote:
> > > > On Fri, 20 Mar 2020, Lee Jones wrote:
> > > > 
> > > > > On Thu, 19 Mar 2020, Guru Das Srinagesh wrote:
> > > > > 
> > > > > > Since the PWM framework is switching struct pwm_state.period's datatype
> > > > > > to u64, prepare for this transition by using div_u64 to handle a 64-bit
> > > > > > dividend instead of a straight division operation.
> > > > > > 
> > > > > > Cc: Lee Jones <lee.jones@linaro.org>
> > > > > > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > > > > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > > > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > > > > Cc: linux-pwm@vger.kernel.org
> > > > > > Cc: dri-devel@lists.freedesktop.org
> > > > > > Cc: linux-fbdev@vger.kernel.org
> > > > > > 
> > > > > > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > > > > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > > > > ---
> > > > > >  drivers/video/backlight/pwm_bl.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > 
> > > > > Can this patch be taken on its own?
> > > > 
> > > > Hellooooo ...
> > > 
> > > Conceptually it can. As the last patch depends on this one (and the
> > > others) some coordination might be beneficial. But that's up to Thierry
> > > to decide how (and if) he want this series to be applied.
> > 
> > ... and on the backlight side we definitely need to know about the "if"
> > otherwise there's no point in taking it.
> 
> Right.
> 
> I'm happy to wait for Thierry.  Although this isn't the only set he's
> currently blocking.  Is he okay?  On holiday perhaps?

The newest commit by him in next is from last week. My guess is he
just didn't come around yet to care for the PWM duties.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
