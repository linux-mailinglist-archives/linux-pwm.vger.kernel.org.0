Return-Path: <linux-pwm+bounces-9266-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ivG2BcjbImr7eQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9266-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 05 Jun 2026 16:23:04 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A6333648CE8
	for <lists+linux-pwm@lfdr.de>; Fri, 05 Jun 2026 16:23:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b="Tg//vhh2";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9266-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9266-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 206CB3005AAB
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2026 14:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC64336493F;
	Fri,  5 Jun 2026 14:23:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF3B275848;
	Fri,  5 Jun 2026 14:22:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669380; cv=none; b=Np2aNpAy25YCrkWQYrW+pB2ZgKY3Z+oUY3tkTRBKjatXv7wNF6YIFw7gE6xqTdFPuHV7H+eVO1mcpUnOyxnN71Xi3JzbD6+4TbnC4MxURBfB5IV3LC6ibwyTKgrWHkgaFyt4C7JoJEvhVcarLDObbezcpbAoj1Q1JvKoPlT5xD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669380; c=relaxed/simple;
	bh=UhXSXCTS91OEr5Y9MPDcg52tyXKLJlS9ncPHO4FPQ4Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fb+iCKl0YgdcXJ4wRrfjgQeaKa144JUdEdkZ35Hud/2vssaiZwyVkl8l4FzOXM+NY9w7ekRTM4fPG0G947KKuaQLJyrm546zyU/ODcYUC3y3pnDVPYNHQyDXZ7kKPM4i1aNGYoD9Fs6QBcqGoK6NOA353PW1kopMcKy9DL4L6qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Tg//vhh2; arc=none smtp.client-ip=217.72.192.78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780669360; x=1781274160; i=markus.elfring@web.de;
	bh=2FsHXkMxPfvNt1lCf8UDgjGV1ThtNG+JbcEUeuOzp0k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Tg//vhh2aa0t8GSeuRRpAgcU1DjEdaY50rUeeFAHSO7NiCumQ9NPxyW6i8qnqXBr
	 K615FYSmEGKvh+W6uoqCAQKkLS2H5NfJVo0DXXj4NrO3mRZ3IuQK5nJhTfg+9qmR6
	 L/CrQSZGO8AXcOYAgR4N/FR9Kxy85uxM/yXfYS1VO6+t7FBoD7DjXnea/w/aqWHyY
	 rrtPDfE4gKwcWKX0pYnhghGyVZ6715wCOvDfwcSvT07VD/bieMVA/J5gY5MXh0xt1
	 L3c/lkApi09IGOdBfeBd460GdXZj0IR5l3tiRPcnqpVRLMNUvlV+rpqA8HV9B3E08
	 TYDSj7XLHrBlG3uVBg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGgNU-1wQZU22rII-004Rkb; Fri, 05
 Jun 2026 16:22:40 +0200
Message-ID: <3e9f9238-a0e4-4a29-8a5b-27e4a5a0e1e2@web.de>
Date: Fri, 5 Jun 2026 16:22:39 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-pwm@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] pwm: More efficient data output in pwm_dbg_show()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JdjB+uPWGGpBDIsp4E+C3hhM0O8t0cooTi1pOB4ONaVcv5RZuln
 GO5WtUxjn7dtke6Y3R5nO4Qf8RnUocJ+FDyuA6jcENBZv8cd+/0DTbAfxOURiXRlnDhpT8S
 w0g+lXeGmZOVtv/SVTi+qdImr/ZPecbVGeD4aSJxYMLItF17T1gWwRDyWIYiTjNVzCiz6nz
 lABTqeOW7lqXp9G4DCGzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H9IrqXLLOqM=;xU/NKnfFI7/ihQVDfEs9SFNbDQZ
 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
 ctiLXJh3eexT0CKdtAC5bqrUN3U=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9266-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6333648CE8

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 5 Jun 2026 16:18:19 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Simplify data output
  Use seq_putc() calls

 drivers/pwm/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

=2D-=20
2.54.0


