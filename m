Return-Path: <linux-pwm+bounces-9575-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rDyDG/B0SmrVDQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9575-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 17:14:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 676B570A6E1
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 17:14:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b="OkLoRLu/";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9575-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9575-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5AF223007ACD
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Jul 2026 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6180C34751F;
	Sun,  5 Jul 2026 15:14:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DB8389DE0
	for <linux-pwm@vger.kernel.org>; Sun,  5 Jul 2026 15:14:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783264487; cv=none; b=Yh4vNIO8ywiVFLB2hRPQ0l9uPnEWQ7EDvYt7S/rLKv9YU4oE0Q4Qik03/vjyNbIEz1ApHQO6/IJBYixk6wagxdYfHWye75I571HqdCavKeK5wz7xNDTpZJNrJZqeBpsW0ufMorXy2/PLMz45LDImsKZ0/MuYI4jxNJwOIr2DItk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783264487; c=relaxed/simple;
	bh=DpyejrDsvcPcaRnwy14yP9N6Ja2CpaXRdZysc/KIjBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ao/NyPN4fQyb5tc+tQBYrX3yszFOilIhhoB15DMOTvj6ANGrP1DWiTSBclxK2AQZXyQ7Moa0dMoMyhsZjUyPsx73GLf3JpAT/s8jo+AqSE83WTdgwP3xRygxwY6QbjfZEeAO8siqF1jO5UVmHVUKFb2TcoLWR1OyvviYtJCJNAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=OkLoRLu/; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b27c7451so28430295e9.0
        for <linux-pwm@vger.kernel.org>; Sun, 05 Jul 2026 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783264481; x=1783869281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xhl+UnQBSClzrRs4eIqybEraL4edLN+OioubeLMQzQo=;
        b=OkLoRLu/X+JLhm752i+S+0JNMt5MKSznLSPi/pxV1HwyQABLz+gKIrZd7GSWV5x7+d
         5jK+LxnpS5+BRpe4tdfBhiPkOYQKB1Qmw11tqs1m3QySptS1C/uVBMkCLuD8KmmrTBSa
         whmncQYrKohW9r+nL/FuhC3tAFjLTHgMNyoPpZDGID3AweJQ9UzYpVNKBjSE+CQSlZk7
         Y0EOwOiE7rdcwzwVRh/IaadB2zPnEyqmCv7ZkGTh7lTiT5l/MUs10SY5ReAacMKZoTDE
         I7Hp+0AazNRf3DLn36fCFz6tO+mGn9WuCvOZrTV9HtbvidXUkEsyWrAv4o77uglbqNlM
         i6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783264481; x=1783869281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xhl+UnQBSClzrRs4eIqybEraL4edLN+OioubeLMQzQo=;
        b=Jo49xlqPOrcwAUXuHHALOWF6mkop+8KMKEOx9lT+wcQxosFhuFOGmFpgZMN5VmSGSC
         kbMGLTQGPB5kDvfiY3pRwk/4OfyYVcwaMBVbyekfysAkJ8GTfih6OVbl/Nuu6RICiYQB
         hvcpONZkrg2anuMnm4OzseGUb5r+Bs9qAC6d0aQgyF3WaaVaZ9TewW0AI3QnEb+QcDE2
         GkasLWXXXLyot13+u96aTtEFofVxvAapaO1RppqlP0Aulr/13RDZ3dDffiThKiupdIMn
         ixmdt2UCUKkyi76D8DPFrVv9zCktXtPtoeg4+xLojdTATqEEcLLG9k5ggUBAZNBjxs8i
         pURw==
X-Gm-Message-State: AOJu0YwUbupBbZ2a4Q7DMSGuRZFN9nUBoIELZgqQiWJ45Wi1bVFdLXQJ
	l6BXbvJS3ly8ULtzS6h34CbMOkUxcD+pJzEr+TV3HcBBr5CTpbAjqUOmGceBsV4bhkVowHfUAwr
	OLw3Y
X-Gm-Gg: AfdE7cn0peN0By+1gs/5fl7UIOn7tvDGDKLdjrj2v8g5OE1Wez8fwK2lEg6PYhntFwg
	7CYI9GXUvcZawPedP9lA216wz5NMHnOONjsP9PzuycCT0zzXPODfbegc6gPflqaAzAvEy2ZtL4U
	Ix/Rfg/k4UKxQKGW6xo2PsPLzq5XjDVfIKqF+xFWQLWVhN5dr4Il4tWF9x9ZiypFk00n1FAHxDo
	Gf9iNDobXSwhY9sqDEJjOO3RqnAJpHV+SgKIJZ7171ty6WBelpumpfbxU64Ci0GPTf0Q2voeQFx
	Aq5xzKaY35TbUFAQROXmP1PzANF0Bz8y74YYngWcWvqrtoMg/WaJ6k8Ec1R4r5wUif2W+o5sBa1
	VQ6COI32sY8iwenOwYnlYoVnfCkcGE+oFP4h65dKLmfRYwwv6ruKKBLYSB2DftvCTe2YpOpJknT
	RJ/+5uL1tSaJlDmgbHGg==
X-Received: by 2002:a05:600d:8444:10b0:493:c566:7bd6 with SMTP id 5b1f17b1804b1-493d159bae7mr47758635e9.18.1783264480733;
        Sun, 05 Jul 2026 08:14:40 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493c63ba97csm288187905e9.12.2026.07.05.08.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 08:14:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] pwm: Unify coding style of acpi_device_id arrays
Date: Sun,  5 Jul 2026 17:14:15 +0200
Message-ID:  <7a4d998e12ac6fa084d1ee29ecb29d51ab7a5e5c.1783263835.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1783263835.git.ukleinek@kernel.org>
References: <cover.1783263835.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=DpyejrDsvcPcaRnwy14yP9N6Ja2CpaXRdZysc/KIjBs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqSnTM072R4WujE0yPWH1GzVtQJXwSUV+mCkUo2 Y5bsBvRkvSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakp0zAAKCRCPgPtYfRL+ To2LCACgI5zfV6rUmKGWPx63X1CoDByPYQViPppBhiA92rlxksBS/hatCkjdv4MtVZuNszxp1Fd H+LqV5guDQuzY7LFyfoD+pZC9kfnuHkQgPeam9+9EYIpe2BKit1qvW6b8d8M13/x+K+3IBvI1kP PuTjW6bY1kUC4AfKdcIyG57Q8FVmQtRF6riN/GJ2moHtqQZE+o1hhU7ye0qjejVF+U4lTnSPGGI ggzRrZUG4WUs8tB4ER3gnBVuLkNRH5aEgAsWb67fC/V7z18N6XomsnBD3SlyTtmgy4KrBndG3DL SHmaMFvcBlfyPwI3JSAirIOiRfg0wo6+H9WFiRpvd491XHPv
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9575-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:from_mime,baylibre.com:email,baylibre.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 676B570A6E1

Use no comma after the array terminator.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-lpss-platform.c | 2 +-
 drivers/pwm/pwm-pca9685.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 0d4f8bf04e9f..529daec1cd3f 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -63,7 +63,7 @@ static const struct acpi_device_id pwm_lpss_acpi_match[] = {
 	{ .id = "80862288", .driver_data = (unsigned long)&pwm_lpss_bsw_info },
 	{ .id = "80862289", .driver_data = (unsigned long)&pwm_lpss_bsw_info },
 	{ .id = "80865AC8", .driver_data = (unsigned long)&pwm_lpss_bxt_info },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, pwm_lpss_acpi_match);
 
diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 0982ba4f566c..8babd29f161c 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -545,7 +545,7 @@ MODULE_DEVICE_TABLE(i2c, pca9685_id);
 
 static const struct acpi_device_id pca9685_acpi_ids[] = {
 	{ .id = "INT3492" },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(acpi, pca9685_acpi_ids);
 
-- 
2.55.0.11.g153666a7d9bb


