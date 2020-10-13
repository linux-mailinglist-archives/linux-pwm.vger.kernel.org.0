Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06DF28CA22
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Oct 2020 10:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391413AbgJMIVt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Oct 2020 04:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391409AbgJMIVt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Oct 2020 04:21:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4235C0613D0
        for <linux-pwm@vger.kernel.org>; Tue, 13 Oct 2020 01:21:48 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSFZ3-0002lB-Hs; Tue, 13 Oct 2020 10:21:45 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSFZ2-00053N-Q3; Tue, 13 Oct 2020 10:21:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 0/2] clk: provide new devm helpers for prepared and enabled clocks
Date:   Tue, 13 Oct 2020 10:21:30 +0200
Message-Id: <20201013082132.661993-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

this series introduces new helpers around devm_clk_get that return the
clk already prepared or prepared and enabled.

To show the benefit I converted drivers/pwm to these functions. (As this
conversion fixes a few bugs I intend however to split the pwm patch per
driver, so please don't apply yet.)

Best regards
Uwe

Uwe Kleine-König (2):
  clk: provide new devm helpers for prepared and enabled clocks
  [RFC] pwm: make use of devm_clk_{prepared,enabled}

 drivers/clk/clk-devres.c      | 85 ++++++++++++++++++++++++++++------
 drivers/pwm/pwm-atmel.c       | 12 +----
 drivers/pwm/pwm-bcm-iproc.c   | 14 +-----
 drivers/pwm/pwm-bcm2835.c     | 18 +-------
 drivers/pwm/pwm-berlin.c      | 13 +-----
 drivers/pwm/pwm-brcmstb.c     | 24 ++--------
 drivers/pwm/pwm-hibvt.c       | 16 ++-----
 drivers/pwm/pwm-imx-tpm.c     | 18 ++------
 drivers/pwm/pwm-lpc18xx-sct.c | 23 ++-------
 drivers/pwm/pwm-mtk-disp.c    | 27 ++---------
 drivers/pwm/pwm-rockchip.c    | 13 +-----
 drivers/pwm/pwm-samsung.c     | 11 +----
 drivers/pwm/pwm-sifive.c      | 23 +++------
 drivers/pwm/pwm-spear.c       | 17 ++-----
 drivers/pwm/pwm-sun4i.c       | 24 ++++------
 drivers/pwm/pwm-tiehrpwm.c    | 17 +------
 drivers/pwm/pwm-vt8500.c      | 11 +----
 include/linux/clk.h           | 87 ++++++++++++++++++++++++++++++++++-
 18 files changed, 208 insertions(+), 245 deletions(-)

-- 
2.28.0

