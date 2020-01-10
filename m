Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9A6613681E
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2020 08:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgAJHQg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Jan 2020 02:16:36 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50833 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgAJHQg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Jan 2020 02:16:36 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ipoWy-0001uc-Ik; Fri, 10 Jan 2020 08:16:28 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ipoWw-0002B5-MH; Fri, 10 Jan 2020 08:16:26 +0100
Date:   Fri, 10 Jan 2020 08:16:26 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     thierry.reding@gmail.com, mripard@kernel.org, wens@csie.org,
        p.zabel@pengutronix.de, Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] pwm: sun4i: Fix wrong pointer passed to PTR_ERR()
Message-ID: <20200110071626.5xmthg43j24p5ha2@pengutronix.de>
References: <20200110012515.32965-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200110012515.32965-1-weiyongjun1@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jan 10, 2020 at 01:25:15AM +0000, Wei Yongjun wrote:
> PTR_ERR should access the value just tested by IS_ERR, otherwise
> the wrong error code will be returned.
> 
> Fixes: 5b090b430d75 ("pwm: sun4i: Add an optional probe for bus clock")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

there is already a patch, see

	https://patchwork.ozlabs.org/patch/1220206/

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
