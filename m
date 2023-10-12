Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B59C7C72A1
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379568AbjJLQa5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379497AbjJLQa4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:56 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74520C6
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaJ-0004fv-Un; Thu, 12 Oct 2023 18:30:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaJ-001C5N-I6; Thu, 12 Oct 2023 18:30:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaJ-00F5ME-94; Thu, 12 Oct 2023 18:30:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 002/109] pwm: Provide a macro to get the parent device of a given chip
Date:   Thu, 12 Oct 2023 18:28:30 +0200
Message-ID: <20231012162827.1002444-113-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=RzgdXLTTWsuIZKdSW6uLws6q1DBPjw361uE8S4WXuy4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB6uoFrBG72BJU06kfJ39YbWPJPT2UX8NN+v8 jOPswVsRiuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgergAKCRCPgPtYfRL+ Tt23B/42Ufecu+NYPf3tQxCUHYUkL7JJpG4RFpE5xjRuOY8uVf6mifR9RZFl4e2jaNS6T2ZZnGe I682rXNBZyfbyHnxM168zw1WS48zBLI66B7H+oJczOUsm5Qf/zniZ+idhzSTUNeFDmAjh2fb2OU sx8+nY28IIF+YDKy8qCQ+gbHq4uHjzhIW+vc6+cnyTT3RLITHUQLig7v9n6GZDFmvxBj8aPr3S3 pA9Ba/pb2t9LmD1V36NrJHTlTc0pdAnegjcFxeMSHzxdug7lAGTEHxCcfWI3/yYkzZfTkTya8Lq Til3XPd0+qQ3eAOfIlusbwG+zcBCFeMMdOEqhBpwnW7RQPwQ
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

Currently a pwm_chip stores in it's struct device *dev member a pointer
to the parent device. Preparing a change that embeds a full struct
device in struct pwm_chip, this accessor macro should be used in all
drivers directly accessing chip->dev now. This way struct pwm_chip and
this macro can be changed without having to touch all drivers in the
same change set.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 include/linux/pwm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e14a8a2268c2..cb2c122ed84a 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -303,6 +303,11 @@ struct pwm_chip {
 	struct pwm_device *pwms;
 };
 
+static inline struct device *pwmchip_parent(struct pwm_chip *chip)
+{
+	return chip->dev;
+}
+
 #if IS_ENABLED(CONFIG_PWM)
 /* PWM user APIs */
 int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state);
-- 
2.42.0

