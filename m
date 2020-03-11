Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F27B181E29
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2020 17:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgCKQn7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Mar 2020 12:43:59 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49743 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729809AbgCKQn7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2020 12:43:59 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jC4Sb-0003LL-Pb; Wed, 11 Mar 2020 17:43:57 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jC4Sb-0002QZ-5r; Wed, 11 Mar 2020 17:43:57 +0100
Date:   Wed, 11 Mar 2020 17:43:57 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     thierry.reding@gmail.com, s.trumtrar@pengutronix.de,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pwm: pca9685: use gpio core provided macro
 GPIO_LINE_DIRECTION_OUT
Message-ID: <20200311164357.44bfscijrjfnjymk@pengutronix.de>
References: <1583941940-17194-1-git-send-email-gupt21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1583941940-17194-1-git-send-email-gupt21@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Mar 11, 2020 at 09:22:20PM +0530, Rishi Gupta wrote:
> GPIO core recently added macro to uniformly specify direction
> of a GPIO Line, so use it.
> 
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards and thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
