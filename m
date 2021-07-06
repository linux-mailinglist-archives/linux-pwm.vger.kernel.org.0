Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47F33BD990
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Jul 2021 17:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhGFPOO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Jul 2021 11:14:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35389 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhGFPON (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Jul 2021 11:14:13 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1m0mjV-0005Xt-73; Tue, 06 Jul 2021 15:11:33 +0000
From:   Colin King <colin.king@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] pwm: core: remove redundant assignment to pointer pwm
Date:   Tue,  6 Jul 2021 16:11:32 +0100
Message-Id: <20210706151133.33175-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer pwm is being initialized with a value that is never read and
it is being updated later with a new value. The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a28c8639af5b..35e894f4a379 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -846,7 +846,7 @@ EXPORT_SYMBOL_GPL(of_pwm_get);
  */
 static struct pwm_device *acpi_pwm_get(const struct fwnode_handle *fwnode)
 {
-	struct pwm_device *pwm = ERR_PTR(-ENODEV);
+	struct pwm_device *pwm;
 	struct fwnode_reference_args args;
 	struct pwm_chip *chip;
 	int ret;
-- 
2.31.1

