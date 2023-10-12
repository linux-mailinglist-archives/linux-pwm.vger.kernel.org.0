Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6797C72AA
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379608AbjJLQbD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379561AbjJLQa5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF574D9
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaL-0004ib-8T; Thu, 12 Oct 2023 18:30:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaK-001C5p-NU; Thu, 12 Oct 2023 18:30:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaK-00F5Mf-ET; Thu, 12 Oct 2023 18:30:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 009/109] pwm: cros-ec: Drop unused member from driver private data
Date:   Thu, 12 Oct 2023 18:28:37 +0200
Message-ID: <20231012162827.1002444-120-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=575; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ujula++TXbhE0SZQG854ACCK5x7mja1DiNzyzXx6EI0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB626BWIeVJy2LuXdMNhJP48RZBVZPyfAXdDu wBI17QoSn+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgetgAKCRCPgPtYfRL+ TrKeB/417hMcq1vvY+ICgHtRP+jjCgB35rz1Ip2zyD5u6GkZTUtTSxRaWnqUM1Iuikq2+MprfZU e2OMxQoF1AUmVngP5qZvp83nBOXCyabvFPqkGTRtP5Fe3UgbwMOCFY+AOavXMH5xADTJLOB4eG6 vkfHgPfBypXteFKpjipBI2KSsKvgI3wWzwzQleAyRJzPEHl/nyhY2XxaMNIfQpA9tNal6rDcaHz ejJZNq/lP2+jg2n7Ssj0ESXTYniElgkv4AK1cAWGsV0ws8WBoQs/FkSqmYfOdXpEoD1KSt/a2Ne QkibyDAmuk3+xnbIOUiisMMQvHQqD3i80PsnP+QosfPato2M
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

.dev is unused, so it can just be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-cros-ec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 0598c9c6f5aa..0ce8220646ea 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -25,7 +25,6 @@
  * @channel: array with per-channel data
  */
 struct cros_ec_pwm_device {
-	struct device *parent;
 	struct cros_ec_device *ec;
 	struct pwm_chip chip;
 	bool use_pwm_type;
-- 
2.42.0

