Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D87719C3A1
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Apr 2020 16:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbgDBOKD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Apr 2020 10:10:03 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38577 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgDBOKD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Apr 2020 10:10:03 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jK0Xh-0001co-Hh; Thu, 02 Apr 2020 16:10:01 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jK0Xg-0002b2-J6; Thu, 02 Apr 2020 16:10:00 +0200
Date:   Thu, 2 Apr 2020 16:10:00 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Subject: Re: [PATCH -next] pwm: make pwm_apply_state_debug static
Message-ID: <20200402141000.6y2lzjn4ei7hd67w@pengutronix.de>
References: <20200402065718.32433-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200402065718.32433-1-yanaijie@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Apr 02, 2020 at 02:57:18PM +0800, Jason Yan wrote:
> Fix the following gcc warning:
> 
> drivers/pwm/core.c:467:6: warning: symbol 'pwm_apply_state_debug' was
> not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Looks sensible:

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
