Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8274A5D0A
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Sep 2019 22:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfIBUTK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Sep 2019 16:19:10 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41579 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfIBUTJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Sep 2019 16:19:09 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i4sn5-0006Mr-0d; Mon, 02 Sep 2019 22:19:07 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i4sn3-0002eH-TQ; Mon, 02 Sep 2019 22:19:05 +0200
Date:   Mon, 2 Sep 2019 22:19:05 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Patrick Havelange <patrick.havelange@essensium.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 0/6] pwm: ensure pwm_apply_state() doesn't modify the
 state argument
Message-ID: <20190902201905.kyduxnehcjfzitrc@pengutronix.de>
References: <20190824153707.13746-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190824153707.13746-1-uwe@kleine-koenig.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Aug 24, 2019 at 05:37:01PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> this series eventually changes the prototype of pwm_apply_state to take
> a const struct pwm_state *, see the last patch for a rationale.
> 
> Changes since v2 apart from rebasing and so covering a few more drivers
> is mainly addressing the concern that after state was rounded and
> applied at least pwm_get_state should return the rounded values. See
> patch 2.

I thought a bit on this series and there is a question about it.
Depending on what is considered the right answer for it, this series
might have to change.

The key question is:

  - Is pwm_get_state() supposed to return
    a) the last requested configuration; or
    b) the last actually implemented configuration?

(If the difference is unclear: consider a PWM that can only implement
the following periods:

	1 ms, 2 ms, 3 ms, 4 ms, 5 ms, 6 ms, ...

and a consumer requested 4.2 ms. Should pwm_get_state() return .period = 4
ms (assuming this was picked) or 4.2 ms?)

As of v5.3-rc5 it depends on the backend driver. For most of them 4.2 ms
is returned. My series tries to push it to return 4 ms instead. (But
this only works for backends that implement the .get_state() callback.
And it gets more complicated as the drivers are not free of surprises.)

Maybe we need functions for both answers?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
