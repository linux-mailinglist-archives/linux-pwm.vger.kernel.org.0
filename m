Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A6E7EDEE2
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Nov 2023 11:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjKPKw0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Nov 2023 05:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjKPKwZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Nov 2023 05:52:25 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1BC1B2
        for <linux-pwm@vger.kernel.org>; Thu, 16 Nov 2023 02:52:21 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3Zys-0000s8-KE; Thu, 16 Nov 2023 11:52:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3Zyr-009Qjs-D0; Thu, 16 Nov 2023 11:52:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3Zyr-002Zzn-3n; Thu, 16 Nov 2023 11:52:17 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
        chrome-platform@lists.linux.dev, kernel@pengutronix.de
Subject: [PATCH] pwm: cros-ec: Drop unused member from driver private data
Date:   Thu, 16 Nov 2023 11:52:13 +0100
Message-ID: <20231116105212.650951-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=727; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=PtFb2v19D7ErEsZp4ooYXEwUA0E1EnNJY3/NquH5ers=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtTQL7HqEvdnHtmx5qtLwNK6KP6Yr+07OmNfmpxVnxwxr 8wsTa+6k9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJBE9l/18VG7WszqrZdmbP V+UJMk+X2HRorUriyv3rH1P9fqe4steV0ssf1faUuQd+mt4t0jdjuUa0dV2F7RXNqbX9u2pMHev 2Pf6fsT7PkCt0EtfnN/0pqTkfIjf8nPnD376wR8XRoaOunp/no+dZDo2XTB/+dOb+7TOWSTTh/h 50QfH9wa7XSXNDNQ83eMuUOv+OaXeJPPJrc4WkftvPyZePLCk1/1KoGeR7Y9vBX9+fHTGxK3wh2 SEd6rBwpoFw84Ifcyylzrt/nbmP9UTdpHtFHoe0oy+IXtiVnCPB13zonpzFtl/zHHsXbe13ms1c 3aiiETxp94uIJVLOexVdtznNUVOpEVtx/lJJ8JfKRYsNAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

.dev is unused since the driver was introduced in commit 1f0d3bb02785
("pwm: Add ChromeOS EC PWM driver"). Drop it.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-cros-ec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 4fbd23e4ef69..9a8f1b6a4e13 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -25,7 +25,6 @@
  * @channel: array with per-channel data
  */
 struct cros_ec_pwm_device {
-	struct device *dev;
 	struct cros_ec_device *ec;
 	struct pwm_chip chip;
 	bool use_pwm_type;

base-commit: d27abbfd4888d79dd24baf50e774631046ac4732
-- 
2.42.0.586.gbc5204569f7d.dirty

