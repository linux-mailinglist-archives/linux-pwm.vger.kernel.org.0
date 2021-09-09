Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3406404806
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Sep 2021 11:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhIIJuI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Sep 2021 05:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbhIIJuG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Sep 2021 05:50:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E8BC061757
        for <linux-pwm@vger.kernel.org>; Thu,  9 Sep 2021 02:48:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOGfv-0000GR-MP; Thu, 09 Sep 2021 11:48:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOGfv-0007fS-5f; Thu, 09 Sep 2021 11:48:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOGfv-0005n5-4Q; Thu, 09 Sep 2021 11:48:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH 1/2] pwm: Add might_sleep() annotations for !CONFIG_PWM API functions
Date:   Thu,  9 Sep 2021 11:48:48 +0200
Message-Id: <20210909094849.313936-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909094849.313936-1-u.kleine-koenig@pengutronix.de>
References: <20210909094849.313936-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=XvhPNMXnWwMN1sHwqLfEMvcJY20aZGzkN1dDlnwWbd8=; m=/lKx7rxVN0lJw1XTEHhyh1TXvRIPtM7zDTYkKiSMN3o=; p=RRk8RqGFm6D70uLuzQDcpZsZh+kpSMh8HHXe8YG7ffk=; g=3ef48e53ac7c3c92b78413d99d830910121d8c65
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmE52HkACgkQwfwUeK3K7AmCPwf+P3b dBVvBPMsXUVjEejhLIUbD3D/GUKeTYS/U3ScflIR+O239Erhy8ys7DAJC60KFYbSo61x5t9nnygKP tfXGfr476mLCCX/mK+ZP/jA8VVN0/ecYHy6tWUEpJ0Ud7W4uTabd3kUpJ/VEShKyfjOVChhrwC+cN IFRxJiFhbchmIWsACCzX/tOKAFmsVr7YOZOYM0h1CrgPK80NN453JmN42pySVg7hfe8SnNkTma6ln C8eBGZ4pvA4H/vm60M4zC9X64EdIIRhreKGWulHfAeYl4vY25OJUrF56Y5/YqqSS9HDD9Oug+d5Ye mBHbUnzHrzjiDBbaJLt7lwnNEJYgyiw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The normal implementations of these functions make use of mutexes. To
make it obvious that these functions might sleep also add annotations to
the dummy implementations in the !CONFIG_PWM case.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 include/linux/pwm.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 725c9b784e60..515e33978e97 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -429,11 +429,13 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
 #else
 static inline struct pwm_device *pwm_request(int pwm_id, const char *label)
 {
+	might_sleep();
 	return ERR_PTR(-ENODEV);
 }
 
 static inline void pwm_free(struct pwm_device *pwm)
 {
+	might_sleep();
 }
 
 static inline int pwm_apply_state(struct pwm_device *pwm,
@@ -493,12 +495,14 @@ static inline struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 						       unsigned int index,
 						       const char *label)
 {
+	might_sleep();
 	return ERR_PTR(-ENODEV);
 }
 
 static inline struct pwm_device *pwm_get(struct device *dev,
 					 const char *consumer)
 {
+	might_sleep();
 	return ERR_PTR(-ENODEV);
 }
 
@@ -506,16 +510,19 @@ static inline struct pwm_device *of_pwm_get(struct device *dev,
 					    struct device_node *np,
 					    const char *con_id)
 {
+	might_sleep();
 	return ERR_PTR(-ENODEV);
 }
 
 static inline void pwm_put(struct pwm_device *pwm)
 {
+	might_sleep();
 }
 
 static inline struct pwm_device *devm_pwm_get(struct device *dev,
 					      const char *consumer)
 {
+	might_sleep();
 	return ERR_PTR(-ENODEV);
 }
 
@@ -523,6 +530,7 @@ static inline struct pwm_device *devm_of_pwm_get(struct device *dev,
 						 struct device_node *np,
 						 const char *con_id)
 {
+	might_sleep();
 	return ERR_PTR(-ENODEV);
 }
 
@@ -530,6 +538,7 @@ static inline struct pwm_device *
 devm_fwnode_pwm_get(struct device *dev, struct fwnode_handle *fwnode,
 		    const char *con_id)
 {
+	might_sleep();
 	return ERR_PTR(-ENODEV);
 }
 #endif
-- 
2.30.2

