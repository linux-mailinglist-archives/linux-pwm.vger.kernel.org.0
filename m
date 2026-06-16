Return-Path: <linux-pwm+bounces-9300-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ws0SF7QwMWpwdgUAu9opvQ
	(envelope-from <linux-pwm+bounces-9300-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jun 2026 13:17:08 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D7F68EB8F
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jun 2026 13:17:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=ZmZIxiyz;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9300-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9300-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 317CA307A3CB
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jun 2026 11:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764DB43C041;
	Tue, 16 Jun 2026 11:13:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51687436358;
	Tue, 16 Jun 2026 11:13:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608409; cv=none; b=qWFrCWq35dxP1Gic+0E0z+nRHdQ1+9BuKFK2X8sl2J33X1XXP8SyIxvzGV/Znsj5JOMdNkW00BMdmaXklKL5Yz4btl5FvRwqEpG/73vGhSEQv1Kv+8eyrG0TY70XfLKif6sEWvzeIFFifPlc3CZdUMAprs8L6/ymLmgCnIHBigk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608409; c=relaxed/simple;
	bh=wuQLvZe5ZnxbCDNi2S87UD72UC7CkBtYW73zX/3xjkE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KgzRr/I4kbWSWFmilnem8Dv2hmnKrpxeW2yr7+4z3uh4l+4TrhXck71TUgKzLKYjH1+B0nkeD+AqE8GScxJ5S4mKz95W8N2y7MYnWb8lHGS9wshGtieqf0XKU6bcMlwIvdvi/dOhVSLufMzuPvt5lswoUSAs/HyhL20D7RdurTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmZIxiyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECC07C2BCB7;
	Tue, 16 Jun 2026 11:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781608409;
	bh=wuQLvZe5ZnxbCDNi2S87UD72UC7CkBtYW73zX/3xjkE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ZmZIxiyzqwyFLf4idOuSAMR8pslKyZUIHez+YgxA3Ap1IYOC8pwPUOL3e2oI8Rege
	 bPSnYK511mxuxgaScCQARBq3fgzyiXvoJxWqOerNc9PE3mQznqztpBen0/W9umBm2X
	 FaHdPtcRpPTkMSEzl/lXkZaw4pPt1Luk0Lgkg3wXTkZyiSbwojNasrEVcIXM7Tk3Gq
	 Zn50wY5gGBnugeqKXbTn5488/mfgyqE+cvdZqvJtH5PT1B/k82FZTFJeLKjFSeEZ3R
	 JKlVryMMHGo5CTzcGKAY0RtoQ6L4UGVx3MToggPj+MFx6x90x1H/SPiamM72ypW7QE
	 VA0kNC4TYVYOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30D7CD98E1;
	Tue, 16 Jun 2026 11:13:28 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Subject: [PATCH 0/2] pwm: loongson: Fix PWM configuration handling
Date: Tue, 16 Jun 2026 19:13:16 +0800
Message-Id: <20260616-pwm-loongson-fix-v1-0-491dbf260a7f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMwvMWoC/x2MWwqAIBAAryL73UJq2eMq0UfUVgulolCBdPekz
 xmYSRApMEXoRYJAF0d2NoMsBMz7ZDdCXjKDKpUpjVTo7xMP5+wWncWVH5Stboyuakmdhpz5QFn
 /y2F83w+ABRyVYgAAAA==
To: Binbin Zhou <zhoubinbin@loongson.cn>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781608406; l=874;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=wuQLvZe5ZnxbCDNi2S87UD72UC7CkBtYW73zX/3xjkE=;
 b=P6nXzVQ3Rr4Vmsu2R58w0DdbZMAGG2y6jgHUrxA1leF0wRppAiH4ABDw8SXWfn36qrjn4QkPm
 M3+zOvHdtJCCK1/PCWgf6b0sLJZDuxrEEZ0BfE/3sGu6QSBE9MnkfJr
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
	TAGGED_FROM(0.00)[bounces-9300-lists,linux-pwm=lfdr.de,keguang.zhang.gmail.com];
	FORGED_RECIPIENTS(0.00)[m:zhoubinbin@loongson.cn,m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:keguang.zhang@gmail.com,m:keguangzhang@gmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
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
X-Rspamd-Queue-Id: E3D7F68EB8F

This series fixes two issues in the Loongson PWM driver:

- Fix the handling of the Low Pulse Buffer Register, which was
  incorrectly treated as a duty-cycle register.

- Ensure that PWM configuration updates take effect immediately by
  resetting the PWM counter to reload the updated settings.

The fixes were verified on LS1B, LS1C, and LS2K0300 boards.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
Keguang Zhang (2):
      pwm: loongson: Fix low pulse buffer register handling
      pwm: loongson: Reload PWM configuration through counter reset

 drivers/pwm/pwm-loongson.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)
---
base-commit: 8d6dbbbe3ba62de0a63e962ee004afb848c8e3ac
change-id: 20260612-pwm-loongson-fix-183763451e93

Best regards,
-- 
Keguang Zhang <keguang.zhang@gmail.com>



