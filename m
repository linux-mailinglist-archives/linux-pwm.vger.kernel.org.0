Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E15AD1584AB
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Feb 2020 22:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgBJVXC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 Feb 2020 16:23:02 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48825 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgBJVXC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Feb 2020 16:23:02 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1GWC-0000yJ-HW; Mon, 10 Feb 2020 22:23:00 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1GWA-00042p-PF; Mon, 10 Feb 2020 22:22:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] pwm: imx27: fix clk handling
Date:   Mon, 10 Feb 2020 22:22:37 +0100
Message-Id: <20200210212240.25513-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200209213106.5067-1-u.kleine-koenig@pengutronix.de>
References: <20200209213106.5067-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

while looking through the pwm-imx27 driver I found some more broken
clock handling additional to yesterday's patch (pwm: imx27: fix clk
handling in pwm_imx27_apply()). This series is to be applied on top of
this patch.

Uwe Kleine-König (3):
  pwm: imx27: Simplify helper function to enable and disable clocks
  pwm: imx27: Don't disable clks at device remove time
  pwm: imx27: Ensure clocks being on iff the PWM is on

 drivers/pwm/pwm-imx27.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

-- 
2.24.0

