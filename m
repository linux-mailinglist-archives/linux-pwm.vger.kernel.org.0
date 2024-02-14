Return-Path: <linux-pwm+bounces-1458-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA5985461B
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D350C1F2E040
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5760318AF9;
	Wed, 14 Feb 2024 09:34:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F81B964
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903292; cv=none; b=EIHqUkuUq8HelXVyDXHVutM8Eacuz+Jtc8P9XgOH502WAqQSSqukg0Knt6a+gPkun27p2Ez671+kN1CBFsYljo0TxjljTSwTn57DKznGvMhnARDVfTlj1K4Ud3HCZ5KVmJuzf0ovfQT1zsgs4QsstHHKTN3PQH7yyVzTv+Wjp5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903292; c=relaxed/simple;
	bh=M1nEGGN/fPFDSJOK21XZySIBys2oNuAKlHcwEQ/zv4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RB/rKuxK4orLV/J9Sda42fpDez9oYnP5y0B/DITJDWzfrfyc9wcj7kBQNABM0+IJNnyKOcbP8RTpXDsicbuv+S51Iw5YNdkbbcM/XZo6+2LuZbVujPudd19ekq9BDUxzerpM1JO/oK6+qqStubDW2WVHtdOarPzI1B2N3zzpzbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBfB-0006HN-Cp; Wed, 14 Feb 2024 10:34:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-000fId-33; Wed, 14 Feb 2024 10:34:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-004YAV-01;
	Wed, 14 Feb 2024 10:34:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v6 158/164] staging: greybus: pwm: Drop unused gb_connection_set_data()
Date: Wed, 14 Feb 2024 10:33:25 +0100
Message-ID:  <bd2759c325c295f3d9f990609d97eb83a8ca88b8.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=858; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=M1nEGGN/fPFDSJOK21XZySIBys2oNuAKlHcwEQ/zv4Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIkA+NtUEwLP5yv1mdRK3Xtx8yWwXEI9nruC3 IlSeNt79ACJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyJAAAKCRCPgPtYfRL+ TrhIB/kB+h3ionhC/Mew5x6ZfPliRoU6LLmabn0oLQefOLgNRAdh4H3EtAKlG4+OM9VB23ngHBo 0VWdPKHgY0J1PKWRr4CsodzMAVUHOzQa3TVpkShyzvgIC4e29GvwjoLX+PzkqIPoPVJfaJWNITz 2xPLdZc9MuIIhQLqUUoXjZw60wFy51pH1koHEKqN1tTvE542Yd3dkONrwbCZOX1l3gIkR4y3NT9 kgZmahAbrSY0s9n6K/Ct8Db0Ix4DxYRfPvwf1CkEz+A6G5X5SCzS4cTWvIeCiiMq9+K0tzHLITE sNVYYqk0T2KFrO2ktnOnt+IzWeT9jkDXNvnHdCw3L7OurLn3
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

The driver never calls gb_connection_get_data(). If there was another
caller (say the greybus core) it cannot use the value because the type
of pwmc (= struct gb_pwm_chip) is only defined in the pwm driver.

So drop the call to gb_connection_set_data().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/staging/greybus/pwm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index 3099c2a3611c..c7a2e874a62b 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -260,7 +260,6 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
 	}
 
 	pwmc->connection = connection;
-	gb_connection_set_data(connection, pwmc);
 	gb_gbphy_set_data(gbphy_dev, chip);
 
 	ret = gb_connection_enable(connection);
-- 
2.43.0


