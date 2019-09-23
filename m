Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67664BAFEB
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2019 10:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfIWIt7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Sep 2019 04:49:59 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56293 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbfIWIt7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Sep 2019 04:49:59 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iCK2g-0001bh-2r; Mon, 23 Sep 2019 10:49:58 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iCK2f-0000jI-PZ; Mon, 23 Sep 2019 10:49:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/3] MAINTAINERS: Add myself as reviewer for the PWM subsystem
Date:   Mon, 23 Sep 2019 10:49:37 +0200
Message-Id: <20190923084937.20358-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190923084937.20358-1-u.kleine-koenig@pengutronix.de>
References: <20190923084937.20358-1-u.kleine-koenig@pengutronix.de>
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

I spend some time in the nearer past reviewing pwm patches. Honor this
by adding me as a reviewer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e9cfed834b2..0fa11c5d2c7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13243,6 +13243,7 @@ F:	drivers/media/rc/pwm-ir-tx.c
 
 PWM SUBSYSTEM
 M:	Thierry Reding <thierry.reding@gmail.com>
+R:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
-- 
2.23.0

