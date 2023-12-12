Return-Path: <linux-pwm+bounces-523-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C66D80E635
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 09:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC40B1F21968
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 08:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929B91A598;
	Tue, 12 Dec 2023 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="QHRl9oXF";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="V6n+/2VG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7D3D5;
	Tue, 12 Dec 2023 00:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702370075; bh=ZJmg/D8rsDFVuY4KX2dLUs2GuRoQzlNEMePV81ScWU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QHRl9oXFwz+oATGHYO7Wt2O7MVCDV7AS1PIAwv+DEGG+wGUP4JdJRtv/1vAzQ+pia
	 jOw6b/QuFJK8B3WfYtDLBfjBmXxTny/xUk6PrA7GUoqoIj7gJbnDexazRAbXKcRlHa
	 8Ipg9/0kRfWyu+XSQeSk9t5NBMubd3itDviCQjbWv+q4qsPvquPNI2uX4J4Wj6SXhj
	 Dl/Gi0Tl/QjIMPHzZPMdXynAPogHaNsJRqePfpiwjuQJoiKo+Z/WUTDPANYdcJJrj8
	 xs5WwJfiN+82te8A0I++qXH5YJlzR+ngCCv/qmYGF3sUpbDeUr2fHCiqiFhO9ZOzmN
	 nIOxbbHE13A3g==
Received: by gofer.mess.org (Postfix, from userid 501)
	id 88115100A05; Tue, 12 Dec 2023 08:34:35 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702370061; bh=ZJmg/D8rsDFVuY4KX2dLUs2GuRoQzlNEMePV81ScWU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V6n+/2VGWhYLAjdpbbPUxOdcp9ocm7vur5ZTEBEnYtOeuzEa50TfwgN7QCEf+nNQS
	 2JczxWc9pfIdw6V03tu6XNWKeCvWSS+mhOif4e3HF/fhqRnxLIMMpOkhpWDv+l4gBJ
	 rv0PJn198Q3JdEPfVm7U2vBLcVDg4PpZhC+0RrEHHmn63ZIr68pn4Pz78bvcBaqKuz
	 clvKRtJZdutLfr0BY7hHRfCZMYDvacvOpkN8LBHbFUwLwoU7QPdOb+DaxP62yM7DYn
	 3fVrQxS2/fZC5ZfaaZDXqE1h23FG63I7NjYYnzb5EJsTyvMk0OX4ZyIzExparbA/ha
	 UWDxHESeRxSkw==
Received: from localhost.localdomain (bigcore-58.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id E58521002A3;
	Tue, 12 Dec 2023 08:34:21 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sean Young <sean@mess.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/6] pwm: Replace ENOTSUPP with EOPNOTSUPP
Date: Tue, 12 Dec 2023 08:34:01 +0000
Message-ID: <af5b2e8ac6695383111328267a689bcf1c0ecdb1.1702369869.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702369869.git.sean@mess.org>
References: <cover.1702369869.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ENOTSUPP is not a standard error code and should be avoided.

Signed-off-by: Sean Young <sean@mess.org>
---
 include/linux/pwm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index b64b8a82415c4..c9cb87b59ac80 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -407,12 +407,12 @@ static inline int pwm_apply_might_sleep(struct pwm_device *pwm,
 					const struct pwm_state *state)
 {
 	might_sleep();
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int pwm_adjust_config(struct pwm_device *pwm)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
-- 
2.43.0


