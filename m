Return-Path: <linux-pwm+bounces-9268-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x5mINl/cImoaegEAu9opvQ
	(envelope-from <linux-pwm+bounces-9268-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 05 Jun 2026 16:25:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FF3648D35
	for <lists+linux-pwm@lfdr.de>; Fri, 05 Jun 2026 16:25:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=rMz3ZKtT;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9268-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9268-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0541E3001A50
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2026 14:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F99937472D;
	Fri,  5 Jun 2026 14:25:25 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8BA36D503;
	Fri,  5 Jun 2026 14:25:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669525; cv=none; b=ueBOqy4T2nfGPUBkQMtJCPsse0JGGqUypE7wWRLUJooJwoAYRSxsYxryRXut1+LriWLWnpCw6ojaENMrrcNvXYH2FQLAH0ysEHsdgQ7uAAHWRkkD2SskYvCQqyU2v59QD2dY7CJHI1tNo+nahrU1FyKLHyR/P+CvJm20s+BjWmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669525; c=relaxed/simple;
	bh=OSNh1GLMJHbZJ3HrLDbqv7b0SpBlGuT1LBid01cd128=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lIg2gWGLW+xJPdft2QSPgb34JDMA4cgBi0bZfvy3FZytFsaYPMJRxYujF5wOoPG+NhAgMv5Xi1oxBgorq1FS5R6l/xMczT/KqpkPNGFQLCu/kGIK97os2wUq8xM9kemf/gJUj8dD1BXQbC6kLPkS6Gn7P7uMBhfUkmum/tHE5Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rMz3ZKtT; arc=none smtp.client-ip=212.227.17.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780669521; x=1781274321; i=markus.elfring@web.de;
	bh=nf7jaCj6qR8JVFJHfxdDxeDIz0Z8mEYru80PWIxAq9c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rMz3ZKtTu3avtA/v2rMx8A8G/5oEcmuiH5NQNnVLtN9hjLu9DYC+YwdtDAYEiCqH
	 9ryRJt86vBsUHL+idTrOIPCNEwCxibYNaSJoxpBfIwndABDh0jyBb1ZJNHh+PEsIY
	 3vBADTunWmVSMoVgRazmw6G/Rx+sa9eFbZ1/2QvOIuY9rmQdJnTh+MY+r/ycOQ3dP
	 calOWE+9qmjCdxmj8GfBJ6J4f/Af5nVyRkbtDVQQeO+73Yx5VUuO4huthJrFKYxpf
	 2wS/MMcnwj8/muVyKY4QcBmCduQ54H7cmISQQM1qQyviPRaicYrUQeWZsqa+KDsVH
	 VbINOvb6/83kMPTnLA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9qd5-1wbGFA1F3d-00F8Hj; Fri, 05
 Jun 2026 16:25:21 +0200
Message-ID: <5cc95f1d-a9f4-4ba4-8411-56cfb16d996a@web.de>
Date: Fri, 5 Jun 2026 16:25:20 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] pwm: Use seq_putc() calls in pwm_dbg_show()
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-pwm@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <3e9f9238-a0e4-4a29-8a5b-27e4a5a0e1e2@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <3e9f9238-a0e4-4a29-8a5b-27e4a5a0e1e2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ub9ijdE66mr427fyCeV4yKf8DNtrTUlvnLBdrqEdox5iR69ocu9
 /jovyyLJUKxGH0//YZM20YlwEGweGfeIV9O1mmvS3e2UwMcDq7edfwDZGepcY0GcCzR/+fX
 Mn4TsMAQMOH0lDQY0J75/X0oDyhzcL4GGGywPhTJ7gASYSxkMgPkBehuNGcM31NPxDFhE8i
 Kp/PlFZzDC5OKWBRGRUUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xgcuO5pWcfg=;0yoDd/c8zvKVCKeLsMVd5JsJpAC
 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
 O1zeY+DYuJGKGJDxkG8ojGkFrJo=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9268-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0FF3648D35

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 5 Jun 2026 16:12:53 +0200

Single characters should occasionally be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/pwm/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1138b3ffbc12..41b02a4a94f3 100644
=2D-- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -2652,7 +2652,7 @@ static void pwm_dbg_show(struct pwm_chip *chip, stru=
ct seq_file *s)
 			   state.polarity ? "inverse" : "normal");
 		if (state.usage_power)
 			seq_puts(s, ", usage_power");
-		seq_puts(s, "\n");
+		seq_putc(s, '\n');
=20
 		if (pwmchip_supports_waveform(chip)) {
 			struct pwm_waveform wf;
@@ -2675,7 +2675,7 @@ static void pwm_dbg_show(struct pwm_chip *chip, stru=
ct seq_file *s)
 				seq_printf(s, "  actual configuration: read out error: %pe", ERR_PTR(=
err));
 		}
=20
-		seq_puts(s, "\n");
+		seq_putc(s, '\n');
 	}
 }
=20
=2D-=20
2.54.0


