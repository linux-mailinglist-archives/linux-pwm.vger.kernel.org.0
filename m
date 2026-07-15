Return-Path: <linux-pwm+bounces-9742-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WJwTB25qV2o8NQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9742-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 13:09:34 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C8675D60F
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 13:09:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=JmQe+TrM;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9742-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9742-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 644F23015E0C
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 11:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1FA442131;
	Wed, 15 Jul 2026 11:05:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974263546FA;
	Wed, 15 Jul 2026 11:05:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113529; cv=none; b=Aftd4HMq9bi1IjsM94JJHyYjUfZi/ENpmP+j6vulaOBLK3ktqSJxBMQW5W/pYgDrsilhRNpDwsNxUu3vdue+dCPY+OOedIxEENAzEqosUD4Pnpsm9sZxN7LaiqBcqbcomJM2ut+aiXeSivV4rIDIpHpLEBCRfguEjMtQKFX0xaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113529; c=relaxed/simple;
	bh=FUOvUmj3ObiKDADM819etyhdJNDhRItkgYTkrK29MCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=el9BNAKj1fI27qrn4ppsPY3lYskjhgsCYY9KSKAr8GYCkEZUiJEob3WEmR/jEkKtKHxFBr3Ss3IIxfNRhx59J6KPBt98LCrNr5HwL1vc1K37mcZ3Apeo9dnB6rfKSoIrO50cX4Ihts1DrGhP6aTisVsrv5Q7BErAqGWo3Pvt8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmQe+TrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 559B3C2BCF4;
	Wed, 15 Jul 2026 11:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784113529;
	bh=FUOvUmj3ObiKDADM819etyhdJNDhRItkgYTkrK29MCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JmQe+TrMtmR5nBFkX4eTmdm8CawtVbzU/ieMhp/AylsdITXpXzbjQ/6NM151DG3KC
	 guyPPi7ebNhBSorYZmSXVPVckVCNtsQFGnKGauLjoCI9Tcbb931CH/Jf3UZqMnPlhY
	 o3ATXcEyBwy5WSwJNYAXKUVXJzt5kH9cIXtmJnKUbxJT9aFbwQ8sFhS+y7UJ7WJbPM
	 GpEBi7f99oVyhn+dtHvPnrFiIpKGV3B91k/akBIYWofkNiYs4DGF8XajxdAF/prQ3p
	 AohZ1wZ3Q+Q3jj/jMZBWv2ekEBZP9vG0TUshK8+RZlbhxUCHDy1pdrraZYN661X3NZ
	 OAxLgSYymheHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3910AC4450E;
	Wed, 15 Jul 2026 11:05:29 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Wed, 15 Jul 2026 19:05:24 +0800
Subject: [PATCH v3 2/2] pwm: loongson: Reload PWM configuration through
 counter reset
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-pwm-loongson-fix-v3-2-0aab2847eaa7@gmail.com>
References: <20260715-pwm-loongson-fix-v3-0-0aab2847eaa7@gmail.com>
In-Reply-To: <20260715-pwm-loongson-fix-v3-0-0aab2847eaa7@gmail.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784113526; l=1594;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=biFtvzcfE9GMfI0AelNWdMjYeCU43VSlkKbfLk28ODs=;
 b=PClAz4w6153hlGuTdMEpO1CayKm0GYsVyst61lz/k7k+AG5yBqA5h4oZzJVTPI+2rWjb9kIP0
 0u7G12YgEo4Ddg0fbyq1Waxxj9DdT4elzY+gciVYqBRVMbYRIfdcfG5
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9742-lists,linux-pwm=lfdr.de,keguang.zhang.gmail.com];
	FORGED_RECIPIENTS(0.00)[m:zhoubinbin@loongson.cn,m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:keguang.zhang@gmail.com,m:keguangzhang@gmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	HAS_REPLYTO(0.00)[keguang.zhang@gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3C8675D60F

From: Keguang Zhang <keguang.zhang@gmail.com>

The Loongson PWM controller latches the LOW and PERIOD registers only at
the start of each PWM period. After disabling and re-enabling the PWM,
the controller resumes from the previous counter value and completes the
current period before re-latching the updated LOW and PERIOD values.

Reset the PWM counter when disabling the PWM and release it when
enabling the PWM so that the updated LOW and PERIOD values are latched
before the PWM starts running again.

Fixes: 2b62c89448dd ("pwm: Add Loongson PWM controller support")
Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/pwm/pwm-loongson.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
index e703217a6d5e..c317d62fe813 100644
--- a/drivers/pwm/pwm-loongson.c
+++ b/drivers/pwm/pwm-loongson.c
@@ -103,6 +103,7 @@ static void pwm_loongson_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
 
 	val = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
+	val |= LOONGSON_PWM_CTRL_REG_RST;
 	val &= ~LOONGSON_PWM_CTRL_REG_EN;
 	pwm_loongson_writel(ddata, val, LOONGSON_PWM_REG_CTRL);
 }
@@ -113,6 +114,7 @@ static int pwm_loongson_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
 
 	val = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
+	val &= ~LOONGSON_PWM_CTRL_REG_RST;
 	val |= LOONGSON_PWM_CTRL_REG_EN;
 	pwm_loongson_writel(ddata, val, LOONGSON_PWM_REG_CTRL);
 

-- 
2.43.0



