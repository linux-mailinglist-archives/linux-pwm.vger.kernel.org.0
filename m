Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2080C1429D1
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2020 12:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgATLsh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Jan 2020 06:48:37 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34433 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgATLse (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 06:48:34 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1itVXk-00074F-Sj; Mon, 20 Jan 2020 12:48:32 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1itVXk-0008IH-Iz; Mon, 20 Jan 2020 12:48:32 +0100
Date:   Mon, 20 Jan 2020 12:48:32 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengbin13@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH] pwm: remove set but not set variable 'pwm'
Message-ID: <20200120114832.uqa4dthodltu6xdv@pengutronix.de>
References: <20200119122202.14502-1-yukuai3@huawei.com>
 <20200120073407.ck2fmk7qdvqsfqsy@pengutronix.de>
 <55871ad5-4cb0-f3c8-a408-2c1be894126a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55871ad5-4cb0-f3c8-a408-2c1be894126a@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jan 20, 2020 at 07:40:37PM +0800, yukuai (C) wrote:
> On 2020/1/20 15:34, Uwe Kleine-König wrote:
> > Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")
> 
> Thank you for your advise! I'll add 'Fixes' in a V2 patch.
> 
> > Did you check that dropping the locking is save? (I didn't)
> > 
> > I'd assume that no harm is introduced, but mentioning that in the commit
> > log would be good.
> 
> I think dropping the lock is safe since there is nothing to be done
> inside the lock. However, I didn't run a full test. By the way, I'll
> mentioning it in a V2 patch.

There are (rare) situations where taking and dropping a lock might make
sense. For example if you have a another context and want to make sure
that a shared resource isn't about to be used.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
