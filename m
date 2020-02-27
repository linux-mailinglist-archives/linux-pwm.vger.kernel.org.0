Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBD5171741
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Feb 2020 13:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgB0MdQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Feb 2020 07:33:16 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43955 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbgB0MdQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Feb 2020 07:33:16 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j7ILr-00083D-5Z; Thu, 27 Feb 2020 13:33:15 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j7ILq-0005l7-Ir; Thu, 27 Feb 2020 13:33:14 +0100
Date:   Thu, 27 Feb 2020 13:33:14 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mediatek@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] pwm: mediatek: add longer period support
Message-ID: <20200227123314.mkg6jqai64b3paxw@pengutronix.de>
References: <1582789610-23133-1-git-send-email-sam.shih@mediatek.com>
 <1582789610-23133-2-git-send-email-sam.shih@mediatek.com>
 <20200227080450.rkvwfjx6vikn5ls3@pengutronix.de>
 <1582797590.25607.10.camel@mtksdccf07>
 <20200227105244.orwitjst3wzoqcsq@pengutronix.de>
 <1582806427.27775.1.camel@mtksdccf07>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1582806427.27775.1.camel@mtksdccf07>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Sam,

On Thu, Feb 27, 2020 at 08:27:07PM +0800, Sam Shih wrote:
> > > 
> > > + /* The pwm source clock can be divided by 2^clkdiv. When the clksel  +
> > > * bit is set to 1, The final clock output needs to be divided by an +  *
> > > extra 1625.
> > > +  */
> > 
> > I'd write:
> > 
> > The source clock is divided by 2^clkdiv or iff the clksel bit is set by
> > 2^clkdiv + 1625.
> > 
> 
> Great, the comment is short and clear. 
> But maybe change “2^clkdiv + 1625” to “the product of 2^clkdiv and 1625”
> is clearer ?

Writing a formula in words isn't helpful. If my formula was wrong use
the right one. I wrote

	2^clkdiv + 1625

(which implicitly means (2^clkdiv) + 1625), if this is wrong write

	2^clkdiv * 1625

or whatever is the right one then. And use parenthesis if you doubt
clearness.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
