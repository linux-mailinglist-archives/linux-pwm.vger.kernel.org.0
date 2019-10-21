Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 279B7DE90E
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 12:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfJUKLa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 06:11:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58867 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJUKL3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 06:11:29 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iMUes-0006Rv-S9; Mon, 21 Oct 2019 12:11:26 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iMUes-0004zR-93; Mon, 21 Oct 2019 12:11:26 +0200
Date:   Mon, 21 Oct 2019 12:11:26 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: pwm_bl on i.MX6Q broken on 5.4-RC1+
Message-ID: <20191021101126.tw5bjyp76rbxudgj@pengutronix.de>
References: <CAHCN7xJSz+QhOb4vE6b67jh5jnSOHnw79EyX8RW91TqPkD__Lw@mail.gmail.com>
 <20191020182428.76l3ob4sxblrjr4m@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191020182428.76l3ob4sxblrjr4m@core.my.home>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Ondřej,

On Sun, Oct 20, 2019 at 08:24:28PM +0200, Ondřej Jirman wrote:
> On Wed, Oct 16, 2019 at 02:55:54PM -0500, Adam Ford wrote:
> > I have an i.MX6Q with an LCD and PWM controlled backlight.  On 5.4-RC1
> > through the current master (16 Oct 2019), the backlight does not come
> > on by default.  I can get it come on by manually setting the
> > brightness, but any video activity seems to blank the screen again
> > until I change the brightness again.
> 
> You might want to check PWM driver that's used on your SoC. I had a similar
> breakage on Allwinner SoCs, and it was caused by a broken get_state callback.
> The problem was there for a long time and it was only exposed by the commit you
> bisected to.

I added Adam to the recipents of the Thread "backlight: pwm_bl:
configure pwm only once per backlight toggle" here on this list. In this
thread the problem is analysed and it's a bit different than for sun4i.
I assume we don't need to follow up on this report given the discussion
is already ongoing elsewhere.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
