Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC3DDBD84F
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Sep 2019 08:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407134AbfIYGaQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Sep 2019 02:30:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43883 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390491AbfIYGaQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Sep 2019 02:30:16 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iD0oQ-0000V4-7q; Wed, 25 Sep 2019 08:30:06 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iD0oN-0004YK-QR; Wed, 25 Sep 2019 08:30:03 +0200
Date:   Wed, 25 Sep 2019 08:30:03 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v9 03/11] pwm: mediatek: remove a property "has-clks"
Message-ID: <20190925063003.aht4platmfalcqru@pengutronix.de>
References: <1568933351-8584-1-git-send-email-sam.shih@mediatek.com>
 <1568933351-8584-4-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1568933351-8584-4-git-send-email-sam.shih@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Sep 20, 2019 at 06:49:03AM +0800, Sam Shih wrote:
> We can use fixed-clock to repair mt7628 pwm during configure from
> userspace. The SoC is legacy MIPS and has no complex clock tree.
> Due to we can get clock frequency for period calculation from DT
> fixed-clock, so we can remove has-clock property, and directly
> use devm_clk_get and clk_get_rate.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Acked-by: Uwe Kleine-Kö <u.kleine-koenig@pengutronix.de>
> ---
> Changes since v9:
> Added an Acked-by tag

Argh, my name was croped and ended up in this state in
5c50982af47ffe36df3e31bc9e11be5a067ddd18. Thierry, any chance to repair
that? Something
like

	git filter-branch --msg-filter 'sed "s/Kleine-Kö /Kleine-König /"' linus/master..

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
