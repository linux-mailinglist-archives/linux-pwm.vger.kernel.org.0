Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F782142D94
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2020 15:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgATObg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Jan 2020 09:31:36 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43413 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATObg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 09:31:36 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1itY5X-0008BC-4k; Mon, 20 Jan 2020 15:31:35 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1itY5W-0001f3-2f; Mon, 20 Jan 2020 15:31:34 +0100
Date:   Mon, 20 Jan 2020 15:31:34 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, CK Hu <ck.hu@mediatek.com>,
        linux-mediatek@lists.infradead.org, sj.huang@mediatek.com
Subject: Re: [PATCH v4 1/2] pwm: mtk_disp: fix pwm clocks not poweroff when
 disable pwm
Message-ID: <20200120143134.yqojufklnack27xf@pengutronix.de>
References: <20191217040237.28238-1-jitao.shi@mediatek.com>
 <20191217040237.28238-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191217040237.28238-2-jitao.shi@mediatek.com>
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

I fully agree to what Thierry said about the commit log.

One more comment:

On Tue, Dec 17, 2019 at 12:02:36PM +0800, Jitao Shi wrote:
> @@ -194,14 +194,6 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(mdp->clk_mm))
>  		return PTR_ERR(mdp->clk_mm);
>  
> -	ret = clk_prepare(mdp->clk_main);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = clk_prepare(mdp->clk_mm);
> -	if (ret < 0)
> -		goto disable_clk_main;
> -
>  	mdp->chip.dev = &pdev->dev;
>  	mdp->chip.ops = &mtk_disp_pwm_ops;
>  	mdp->chip.base = -1;

After this there is:

	if (!mdp->data->has_commit) {
		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug, ...);
		...
	}

So I wonder if dropping the clk_enables above is safe if there are some
register accesses later on.

Side note: The driver you're touching here is still using the legacy
API. Would be great to convert it to .apply() instead.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
