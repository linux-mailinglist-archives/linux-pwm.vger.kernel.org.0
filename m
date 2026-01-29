Return-Path: <linux-pwm+bounces-8010-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bbdjJZ8Be2kBAgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8010-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Jan 2026 07:43:43 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A90A6AC4CF
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Jan 2026 07:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9B033004C96
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Jan 2026 06:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F99B37107E;
	Thu, 29 Jan 2026 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwyCfy2g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA02E888A;
	Thu, 29 Jan 2026 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769669018; cv=none; b=ewwzrxMeSQzajKkM8wcAYOYKCUJtvHIui2E+YCL8RqlHDox7PpzNfY2UTTMczbKpk7xktJkDSzJ4L2ptM5+JGeWQKvntJsSiFHtsyVNeJxmBIjjq3RdIjZNdspD1PpxGRRzlW/LP7ZsbuCtFfu7Gh4D9d5ozt99uO/FC8YqxAFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769669018; c=relaxed/simple;
	bh=CMjtTTUatcT7K+NpjWC4jF/hJ/aoTIExTcNHTL8lV7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TO7F+bxnwFgyup0KezHA9tLHN+8HYMqB2IJGgABCTyGZ9lyZCoTbXlBPBj3hkhHilMjqsl9P6i4d2pV7iUhKYJqXCZPLkyOm2p1SZy9cYbOB2/578hSnMdAV5BfHu31JBhNp8u6hokhXq0nxkcR9tvvm6myXGjGiPYJOyQYrYTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwyCfy2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0FDBC116D0;
	Thu, 29 Jan 2026 06:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769669017;
	bh=CMjtTTUatcT7K+NpjWC4jF/hJ/aoTIExTcNHTL8lV7w=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=AwyCfy2gBB22iA851qaspo6i0erYZXgxJ3DS++tgYkx8BrKFowEw3DbMBirGb77dE
	 Fk58B9hk29UdD8kofrDIBtNNssiD4BrgolVvvwizkOZHaJeJUeq2apicp1O7oUIIrq
	 DZ4vj6LNf5TZHdv6c995Ua5PVB2/KfY9IZba+2vqHLiJSbnao42z2pnP10Ks+yvhme
	 Zm/GZdu00a6YZNHmSN3huZsNmkeWE0sZiEtUpSyCj7HKKx+KiRmyAoKz8XGjXi16iF
	 0P3ZNZ1/iax7ZnyrtDN1EMO9HIOdLRHOjIlwlUnHQkaKIVP+EedGLeEKhdvcuz+qQa
	 RN1FrGUcR3mug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECF3D358CF;
	Thu, 29 Jan 2026 06:43:37 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Date: Thu, 29 Jan 2026 14:43:34 +0800
Subject: [PATCH] drivers: pwm: remove redundant check in pwm_ops_check()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-fix-pwm-ops-check-v1-1-6f0b7952c875@andestech.com>
X-B4-Tracking: v=1; b=H4sIAJUBe2kC/yXM0QqCQBCF4VeRuW5gXWnFXiW6sPGkU6TLTmUgv
 rubXX5wzr+QISmMTsVCCR81ncaM8lCQDO3Yg7XLJu98cKVv+KZfjvOTp2gsA+TBAVUQuKarjy3
 lX0zIo715vvxt7+sd8vqFaF03ID1zUnUAAAA=
X-Change-ID: 20260129-fix-pwm-ops-check-6e36ce09d75a
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769669016; l=921;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=a9RiAo/8R5Tlj69Vgjm25sELpahOvVfSyEKanqMOV6w=;
 b=Nrmpy0YBi+qTZA1mdEGrL7qlV12ahfdGG6oB2rJsfhbhY+RsXosr35fGWTQ+l0Rvj4JIorvaq
 8X+fdBpMZ+uAxJorkkke1Cq+oZDPY755nr65xlhmsLXz9wfMI4X5oxz
X-Developer-Key: i=ben717@andestech.com; a=ed25519;
 pk=nb8L7zQKGJpYk0yvrYKjViOZ34A36g1ZIsCmCsP518s=
X-Endpoint-Received: by B4 Relay for ben717@andestech.com/20260120 with
 auth_id=610
X-Original-From: Ben Zong-You Xie <ben717@andestech.com>
Reply-To: ben717@andestech.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8010-lists,linux-pwm=lfdr.de,ben717.andestech.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[ben717@andestech.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,andestech.com:replyto,andestech.com:email,andestech.com:mid]
X-Rspamd-Queue-Id: A90A6AC4CF
X-Rspamd-Action: no action

From: Ben Zong-You Xie <ben717@andestech.com>

Drop the redundant check for the existence of 'ops->write_waveform'.

Fixes: 17e40c25158f ("pwm: New abstraction for PWM waveforms")
Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 drivers/pwm/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ec8731515333..450aedd32c81 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1699,8 +1699,7 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 
 	if (ops->write_waveform) {
 		if (!ops->round_waveform_tohw ||
-		    !ops->round_waveform_fromhw ||
-		    !ops->write_waveform)
+		    !ops->round_waveform_fromhw)
 			return false;
 
 		if (PWM_WFHWSIZE < ops->sizeof_wfhw) {

---
base-commit: 63faf32666e03a78cc985bcbae196418cf7d7938
change-id: 20260129-fix-pwm-ops-check-6e36ce09d75a

Best regards,
--  
Ben Zong-You Xie <ben717@andestech.com>



