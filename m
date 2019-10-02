Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F44C4B00
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2019 12:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfJBKIt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Oct 2019 06:08:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34590 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfJBKIt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Oct 2019 06:08:49 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iFbYq-0008CL-HC; Wed, 02 Oct 2019 10:08:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: sun4i: redundant assignment to variable pval
Date:   Wed,  2 Oct 2019 11:08:44 +0100
Message-Id: <20191002100844.10490-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable pval is being assigned a value that is never read. The
assignment is redundant and hence can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pwm/pwm-sun4i.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 6f5840a1a82d..53970d4ba695 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -156,7 +156,6 @@ static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
 	if (sun4i_pwm->data->has_prescaler_bypass) {
 		/* First, test without any prescaler when available */
 		prescaler = PWM_PRESCAL_MASK;
-		pval = 1;
 		/*
 		 * When not using any prescaler, the clock period in nanoseconds
 		 * is not an integer so round it half up instead of
-- 
2.20.1

