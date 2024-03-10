Return-Path: <linux-pwm+bounces-1737-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6775887762C
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 12:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAB62817A3
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 11:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B871EB52;
	Sun, 10 Mar 2024 11:01:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18751EB45
	for <linux-pwm@vger.kernel.org>; Sun, 10 Mar 2024 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710068475; cv=none; b=QKTEhWzzwYuVwHhseK0IZDLFOOk8uH2eozBcRxz+PbYVXK5JJLkL4MJwct0J6aDOT7KkRH/QFhgWGiunn7WkuIMVsf9jsXadQJ+zpjFZsbeZQO4C3KaHLnXYwuQwfKGWKDqYFHN/S23aXl+5r/ATSFv+4ac4fKHPjEu49E8W/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710068475; c=relaxed/simple;
	bh=wHOsi921r24FLfUjDL1pD6JN49hPi4fdjfPIUjXMMY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1M7TCjFYqjmq9AUs6Tb2JOXsesyoTCu7Bkv1enb6qIh+ShXvOlAGLCnez3RYilvSpWInlBGejuclnD9qSjxMOKl65y+Zfl7/tWxC8kQCjzjqeMVGUe+zaeFTH8m8kqbgj81RpXQLeSrTiyELSSrsKTyzKQgfSkzE7Yd3qLV8wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvW-0000rP-Kv; Sun, 10 Mar 2024 12:01:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvW-005V0w-53; Sun, 10 Mar 2024 12:01:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvW-003OFm-0A;
	Sun, 10 Mar 2024 12:01:10 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: Ajit Pal Singh <ajitpal.singh@st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Lee Jones <lee@kernel.org>,
	kernel@pengutronix.de
Subject: [PATCH 5/6] pwm: sti: Use devm_kcalloc() instead of calculating the size for devm_kzalloc()
Date: Sun, 10 Mar 2024 12:00:58 +0100
Message-ID:  <17062aef42e6677629a056e25c6916d8b6eaedeb.1710068192.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710068192.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710068192.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=948; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=wHOsi921r24FLfUjDL1pD6JN49hPi4fdjfPIUjXMMY8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7ZLt1+Iydse7JMNy7sVIrtnX+gR9cHFtMpPT6 19k3xbR3XaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe2S7QAKCRCPgPtYfRL+ TuYrCACA+AS/9RavleUi3fh0/LzGHPISHE/qXTrVJYc7BD4jx8CLWPzdAz5NHO/NdbeJpnD1AE/ IC2hP0u/ACvwkUEw26zQi0AIXdLPAcxPRncJANKPsRb0oT74Mw4FAVtQ5XKy9m+c1kkrPUkuKai CjjkUtA0J3hs0DLdOd+rxbgzdbGhnCthlQY6fJjY2XulValat0IULAI4Cg38xj4dD6J2Z0yScot VNFUutkNeckxdBQ8HAv+9T0YBYIRWWEXRHKz1lVJRX9Pwn/huNUL8yJQN0YS8mtS8F5iDbEl7qj hdsBtN4a/G5V/rnabewy9iTKOIr8NVWMXQQUAHHEn58I+yQg
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Using a multiplication to calculate the size of an allocation isn't
recommended in case the mulitplication overflows. While the chance this
happens is low, preventing such an error is easy enough; so do that.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sti.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index e8fdf96d8cc4..7a7d1c622a17 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -613,7 +613,8 @@ static int sti_pwm_probe(struct platform_device *pdev)
 			return dev_err_probe(dev, PTR_ERR(pc->cpt_clk),
 					     "failed to get PWM capture clock\n");
 
-		pc->ddata = devm_kzalloc(dev, pc->cpt_num_devs * sizeof(*pc->ddata), GFP_KERNEL);
+		pc->ddata = devm_kcalloc(dev, pc->cpt_num_devs,
+					 sizeof(*pc->ddata), GFP_KERNEL);
 		if (!pc->ddata)
 			return -ENOMEM;
 	}
-- 
2.43.0


