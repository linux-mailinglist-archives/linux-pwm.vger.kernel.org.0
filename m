Return-Path: <linux-pwm+bounces-2165-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CC18BFDF4
	for <lists+linux-pwm@lfdr.de>; Wed,  8 May 2024 15:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04F51F22F79
	for <lists+linux-pwm@lfdr.de>; Wed,  8 May 2024 13:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F7169D29;
	Wed,  8 May 2024 13:06:27 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089525820C
	for <linux-pwm@vger.kernel.org>; Wed,  8 May 2024 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715173587; cv=none; b=IdTThSgvuptohgBVKZ+fdnqPeIijdsN4rMEFVZl/cIYJQ1J3HDH6Ge/AQ233aqev0UBAmAyHFx1a027I3+g1I+vL3yZl8WZrgzPL64QOk061xfv3ScKOZYR+0GTcLO4uzGCsdnv98tphJtLntW0DLqtKI6yHtLyYlBcBaJ0aq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715173587; c=relaxed/simple;
	bh=lYzegP9PsNlC56PloEbS04Iw01FsD6Xjm+d+vGjLpik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iuevA1oFYJs0Qp4MvQK7RuCkSVZj3mvGfD16m+yX5gGm7SE9MshdhL7lzyY4eAfcz09P1NOxO1Ulo2+GaaYNcxU+WctsOjHDTlQlqZhwan+DrkAdtyKuadX+RrPF0jxqIVetZJctABJHBtAPqR7jcJr5fBK8IYsRTQEInWn5AIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4h03-0002f1-6t; Wed, 08 May 2024 15:06:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4h02-000Hcc-NZ; Wed, 08 May 2024 15:06:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4h02-000XKs-27;
	Wed, 08 May 2024 15:06:22 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH] pwm: pca9685: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Wed,  8 May 2024 15:06:18 +0200
Message-ID: <20240508130618.2148631-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=lYzegP9PsNlC56PloEbS04Iw01FsD6Xjm+d+vGjLpik=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmO3jK7VKfLIphUT6xwp24+byxJFS0s2DyJ0jiY xQ69FCrfiSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZjt4ygAKCRCPgPtYfRL+ TgTyB/9oH/K8V+I/0Irw6TwZ9rINbahRf2PsEWRoCQaU7dBDLyVWgLSxstk2naRinJ0wRBrNrro HMuoAQqv+b/dnOvVWFexVdo5KGTzajAF8coCnMh4H0riO2j5Vr+0zlbwyxw/7t+JbQrU3AD21yP XlYktiN0xQHSWdEPdPOsXij6T/xJr7ibKdSopcA14Ua+FB9JDBpD0DtZkNpPz1dSNH8OPvzG4yP YYHRM9W3TAuQbRq2J1XOCRMM0NwnSwMOPgDi9tESiinBtEnddN1Z/n0h1ddMaXRC94o/orpur1D 9JZCj5H04fynwAXBTcpZfimLqci+K809HbxLcrZsAEzH3s6X
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

The driver doesn't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

While add it, also remove the trailing commas after the sentinel entry.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-pca9685.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index c5da2a6ed846..1298b29183e5 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -634,8 +634,8 @@ static int __maybe_unused pca9685_pwm_runtime_resume(struct device *dev)
 }
 
 static const struct i2c_device_id pca9685_id[] = {
-	{ "pca9685", 0 },
-	{ /* sentinel */ },
+	{ "pca9685" },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, pca9685_id);
 

base-commit: e7b4ef8fffaca247809337bb78daceb406659f2d
-- 
2.43.0


