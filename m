Return-Path: <linux-pwm+bounces-9267-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5kZ/DdDdImpQegEAu9opvQ
	(envelope-from <linux-pwm+bounces-9267-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 05 Jun 2026 16:31:44 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FD7648DA7
	for <lists+linux-pwm@lfdr.de>; Fri, 05 Jun 2026 16:31:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=KGFPjTW4;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9267-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9267-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDE00307F887
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2026 14:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBDF37FF46;
	Fri,  5 Jun 2026 14:24:13 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFA118BC3B;
	Fri,  5 Jun 2026 14:24:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669453; cv=none; b=PyrQ7KMRycNxSqKEyJBXxbBc+zC4m+N9sJU02FbWE7V+Wmy1GGORGJjVDU649uZ9fQwNNCgCfZuYuhUoKe/17EKOCvGpJ93s0ZTdpARVpauMz3TQ8pmU0P8NRiuL1nlF4u4GK11yGyJ2drqFEGgM5eCHDtulGVEvi6oYBZSWpI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669453; c=relaxed/simple;
	bh=EEe5NKl6vbd7gtHnDF1Gg67pCp5EVIg4F5pvd17YJEc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=l54aVKyki9/YVF1v+Xb4QvZVqj58ibvVxDoJKRARXn3qIiYYuo1qjIpyl5dgfSgmuYLADZ91BPrC2+wyDb/IbMdiK63STdNKkpWQfGiqV/HRU+BfX0fHIF6IMORQ53ZIV8N680QrBGMgX2+O8ajLrLcRUCuNI+vHmJwmOCaDPq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KGFPjTW4; arc=none smtp.client-ip=212.227.17.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780669435; x=1781274235; i=markus.elfring@web.de;
	bh=jMb31p5S8MPxl/PghnBWSLp5AbK602IDBwnUpqS5Kr4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KGFPjTW4wKFNPimXTHzeXLC9fR5QSn/jiNTJlwUTVg4ViSZEP7O77KAx9tKkifmw
	 RDg6A36g3CUNATiMkIn0Bbqfftmuk9PptVeHQcmrzmoBkPF5BzUEZ+JPSJz6y9WIq
	 yshi9RPDtARYJqvU0W4wV8ZJNPYP+mKRVO/5NvpGDvmCoMaIn0QBNy0bpvfns+ckw
	 UbEWmtjtVBoOFkQR8b5XYB2iM5QQDoU4g+HRhPxWKoUQC9X8DFUovmwa7yXFwl+ka
	 60zOq8ePiQr4n8/kCX4xl/0HfFkRXXH299a9MTeXTcSXtIvX/Q2FjsgwpjTe+vJ8E
	 uvn+qcupWArsMNdfcA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjxiM-1wxzZy3Yc4-00c8kw; Fri, 05
 Jun 2026 16:23:54 +0200
Message-ID: <b854002b-08fd-476f-b2e3-631f1354623b@web.de>
Date: Fri, 5 Jun 2026 16:23:53 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] pwm: Simplify data output in pwm_dbg_show()
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-pwm@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <3e9f9238-a0e4-4a29-8a5b-27e4a5a0e1e2@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <3e9f9238-a0e4-4a29-8a5b-27e4a5a0e1e2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f/ubmAmCHVV/lDchAIn43a5F1mbUC77ARw74/La3wfot33erkuY
 0agTgap+UZ8b2K5jva8Y+VrI0yUpWXxgIpdHHrXrAuwcieDhMIiLSGedR6ivdsHlSQAXgzI
 Y4xCnUTe0LhrTnBIzCAnUp6N0qJyWW/lH692nzgqdp6jAN3kzqKAPOdAElNiU+YJ4D3wZfW
 kP7lNy6b2UW3OJqEtFZpQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wz5Er/0+4q4=;u4ud7isQb6p9Rl+1nwYi/CiybRf
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9267-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-pwm@vger.kernel.org,m:ukleinek@kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[web.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84FD7648DA7

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 5 Jun 2026 15:57:58 +0200

Move the specification for a line break from a seq_puts() call
to a seq_printf() call.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/pwm/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index be4885da85b6..1138b3ffbc12 100644
=2D-- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -2647,9 +2647,7 @@ static void pwm_dbg_show(struct pwm_chip *chip, stru=
ct seq_file *s)
 		if (test_bit(PWMF_REQUESTED, &pwm->flags))
 			seq_puts(s, " requested");
=20
-		seq_puts(s, "\n");
-
-		seq_printf(s, "  requested configuration: %3sabled, %llu/%llu ns, %s po=
larity",
+		seq_printf(s, "\n  requested configuration: %3sabled, %llu/%llu ns, %s =
polarity",
 			   state.enabled ? "en" : "dis", state.duty_cycle, state.period,
 			   state.polarity ? "inverse" : "normal");
 		if (state.usage_power)
=2D-=20
2.54.0


