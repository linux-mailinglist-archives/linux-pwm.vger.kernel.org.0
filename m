Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51EB1BC578
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2020 18:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgD1QmD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Apr 2020 12:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgD1QmC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Apr 2020 12:42:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B470C03C1AB;
        Tue, 28 Apr 2020 09:42:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so25488302wrx.4;
        Tue, 28 Apr 2020 09:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qRo9LWbuou3yJZOIzHh11HBE37Wj9pVnE6w0Sos6lqI=;
        b=nJ7X9rHGbqzZIvtWJKjlCCPW+lT1YtHO+ynJD2B2EPajWD87a1ZnleRB+6nOPMLT57
         f/yUl3yZVMm2CGJRWx9Ra+7Gq6EvIUgkPMQMthdzer26UCM6554zCGxBv8i5D84WE4JG
         L8YHBRMhJawEEU4js5QW5rvmS7399lDciOETHnJRf8ATXGeOM/b0Ji3rPdCy4gQ7FidA
         DXHq5kY6M2bKap1YNpKopG2xpHoVBWEcN5WKNxrwjjNaVdNwBIPBrSqYomV5TDuECM8W
         SJr42LJCK6gXrjpRsIzkDnv1xRd5a1ZtajlXRFbv8NXwGWTbiYyV75mU0XBobGDal3j2
         6CFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=qRo9LWbuou3yJZOIzHh11HBE37Wj9pVnE6w0Sos6lqI=;
        b=sVQ0If091ZcDAw2U6nUm5am0TPTMtr4Tf0e/Y4xzFrMfWP3SvKFm58q2JoiUiTNjrX
         7xG//KqXxwoNQkWVbUn6tBPPT2YQcvtaARCYFcXY5ifM5nmlahxUtco6JFMDDqWHwCnL
         v2S7VhSPYyYttqlYKDA0PJgpTOsU1Iewd2wXQ47CHT418Og+zTQPVr/OZdq1ejq4MJax
         ymh3y1VnBco2gHEaLdJ9odnIMRg4MW8wlT7DQMBq5pxPK9CEMcUP/aIK0OYqiHFGVMjP
         PjFGqXKYTkHqRVLmueRYfTVE5s3syuwhSSv1sQUFfthcbsOrYsB6JcNAdg8GbZOPxo0P
         3SQA==
X-Gm-Message-State: AGi0PuYUpx7yLPw5O2e/l2moQ5emHqZdz0+rWTHQ/KshImW8FQS/xHIs
        FuVvm8jeRYbiu60+7hof76U=
X-Google-Smtp-Source: APiQypJer/N7KP+o+gVoSro1HbuyKQWeY1aRmnHVGT3Ex0udIyz0jTQVI0nf81Iy+vPLOVJsybLaYQ==
X-Received: by 2002:adf:fe45:: with SMTP id m5mr36497044wrs.124.1588092120747;
        Tue, 28 Apr 2020 09:42:00 -0700 (PDT)
Received: from localhost (89-104-3-59.customer.bnet.at. [89.104.3.59])
        by smtp.gmail.com with ESMTPSA id i6sm28271829wrc.82.2020.04.28.09.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 09:41:59 -0700 (PDT)
From:   Peter Vasil <peter.vasil@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     peter.vasil@gmail.com, nightwolf@relghuar.net
Subject: [PATCH v2] pwm: sun4i: direct clock output support for Allwinner A64
Date:   Tue, 28 Apr 2020 18:41:50 +0200
Message-Id: <20200428164150.366966-1-peter.vasil@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Allwinner A64 is capable of a direct clock output on PWM (see A64
User Manual chapter 3.10). Add support for this in the sun4i PWM
driver.

Signed-off-by: Peter Vasil <peter.vasil@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 5c677c563349..18fbbe3277d0 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -352,6 +352,12 @@ static const struct sun4i_pwm_data sun4i_pwm_single_bypass = {
 	.npwm = 1,
 };
 
+static const struct sun4i_pwm_data sun50i_a64_pwm_data = {
+	.has_prescaler_bypass = true,
+	.has_direct_mod_clk_output = true,
+	.npwm = 1,
+};
+
 static const struct sun4i_pwm_data sun50i_h6_pwm_data = {
 	.has_prescaler_bypass = true,
 	.has_direct_mod_clk_output = true,
@@ -374,6 +380,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
 	}, {
 		.compatible = "allwinner,sun8i-h3-pwm",
 		.data = &sun4i_pwm_single_bypass,
+	}, {
+		.compatible = "allwinner,sun50i-a64-pwm",
+		.data = &sun50i_a64_pwm_data,
 	}, {
 		.compatible = "allwinner,sun50i-h6-pwm",
 		.data = &sun50i_h6_pwm_data,
-- 
2.25.1

