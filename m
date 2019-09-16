Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D97B3AF0
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Sep 2019 15:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfIPNFu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Sep 2019 09:05:50 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38459 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732852AbfIPNFu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Sep 2019 09:05:50 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i9qhP-0003EZ-Lw; Mon, 16 Sep 2019 15:05:47 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i9qhP-0003PX-Dj; Mon, 16 Sep 2019 15:05:47 +0200
Date:   Mon, 16 Sep 2019 15:05:47 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Offer to co-maintain drivers/pwm [Was: Re: [PATCH] PWM: drop legacy
 wrapper for changing polarity]
Message-ID: <20190916130547.xflkrm7dwgnec7dx@pengutronix.de>
References: <20181015082152.5900-1-u.kleine-koenig@pengutronix.de>
 <20181104211945.ychhco6vrmuf6jtc@pengutronix.de>
 <20181120165758.pwprvrhzpftkghap@pengutronix.de>
 <20181130085942.epcatcj3zeegprz6@pengutronix.de>
 <20181206092057.avcew6a33l3lo7kk@pengutronix.de>
 <20181211212658.vxxci7npev2dnjou@pengutronix.de>
 <20181212102547.GN15092@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181212102547.GN15092@ulmo>
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

On Wed, Dec 12, 2018 at 11:25:47AM +0100, Thierry Reding wrote:
> I certainly wouldn't mind a little help. Reviewing patches will
> definitely help move things along.

I'm a bit frustrated with the state of the list of open patches. There
were little feedback from you on the list since July, during this time
https://patchwork.ozlabs.org/project/linux-pwm/list/ grew by ~1.5 pages
and there are still topics that I want to bring forward that depend on
you to cooperate. As I spend quite some time reviewing patches here, I
wonder if you'd be willing to give me maintainer-status for the pwm
patchwork to update the state on the various patches there. If you want
I can also add me to the MAINTAINERS file (as reviewer or maintainer --
whatever you consider sensible). I'd also like to have pwm patches
applied in a more expeditious way and expose them in next.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
