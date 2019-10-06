Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52C71CD8F6
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Oct 2019 21:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfJFTsg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 6 Oct 2019 15:48:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33411 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfJFTsg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 6 Oct 2019 15:48:36 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iHCWA-0003wz-A6; Sun, 06 Oct 2019 21:48:34 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iHCW9-0003eu-CV; Sun, 06 Oct 2019 21:48:33 +0200
Date:   Sun, 6 Oct 2019 21:48:33 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] pwm: Fix kerneldoc for apply operation
Message-ID: <20191006194833.6r2fujpx36smhwey@pengutronix.de>
References: <20191006044326.12043-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191006044326.12043-1-bjorn.andersson@linaro.org>
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

On Sat, Oct 05, 2019 at 09:43:26PM -0700, Bjorn Andersson wrote:
> As the @state passed to apply() is now const the comment in the
> kerneldoc about drivers being expected to adjust the parameters is no
> longer valid. Update it to reflect the API change.
> 
> Fixes: 71523d1812ac ("pwm: Ensure pwm_apply_state() doesn't modify the state argument")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

This is a duplicate of https://patchwork.ozlabs.org/patch/1171851/.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
