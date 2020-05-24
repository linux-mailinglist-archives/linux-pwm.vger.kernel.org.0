Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1E11E013C
	for <lists+linux-pwm@lfdr.de>; Sun, 24 May 2020 19:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbgEXRoo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 May 2020 13:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387737AbgEXRoo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 24 May 2020 13:44:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709F3C061A0E
        for <linux-pwm@vger.kernel.org>; Sun, 24 May 2020 10:44:44 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jcuft-0000lZ-FB; Sun, 24 May 2020 19:44:37 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jcufq-0002cY-Dp; Sun, 24 May 2020 19:44:34 +0200
Date:   Sun, 24 May 2020 19:44:34 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com, cawa.cheng@mediatek.com,
        bibby.hsieh@mediatek.com, ck.hu@mediatek.com, stonea168@163.com,
        huijuan.xie@mediatek.com
Subject: Re: [PATCH 1/1] pwm: mtk_disp: implement .apply()
Message-ID: <20200524174434.tcnszokabt2ymh7x@pengutronix.de>
References: <20200410031955.111392-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200410031955.111392-1-jitao.shi@mediatek.com>
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

On Fri, Apr 10, 2020 at 11:19:55AM +0800, Jitao Shi wrote:
> implement the apply() for pwm.
> 
> Fix the clock clk_prepare_enable and clk_disable_unprepare mismatch,
> switch the driver to support the ->apply() method.

Adding support for get_state is a separate change.

Other than that this patch looks more complicated that I would expect,
I think you can make this easier to understand/review by moving the
mismatch to a separate patch, too.

Can you please respin with these hints in mind, then I'm willing to
invest some time for a deeper review. In general it's very welcome to
convert the mtk-disp driver to the atomic API. Thanks for addressing
that.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
