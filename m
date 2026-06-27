Return-Path: <linux-pwm+bounces-9438-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9gvrAhM9QGr5dwkAu9opvQ
	(envelope-from <linux-pwm+bounces-9438-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jun 2026 23:13:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9F76D2AD4
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jun 2026 23:13:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RMSUmFzw;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9438-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9438-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2EEA3018D2A
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jun 2026 21:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A8537F015;
	Sat, 27 Jun 2026 21:13:26 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D2437F8DA;
	Sat, 27 Jun 2026 21:13:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782594806; cv=none; b=tew/z+A4WNHdBF/cQNUNQ4eWvkZqfIRdVpWzAPQN9UysYqhIAzxGhyMz8Nf4yig8ViCbwbBVDELMVsFyEDsEfjjyjcjcoLlbMLid8AXYxgqqGyJO8Rgf6MOwzUnzKFpp4KJyveQr4kmYhHIvQeXQJagCYa7a+sT7fqFqw2Ww4uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782594806; c=relaxed/simple;
	bh=1Ve1lnWL8MqFDY6x1F0a+Cr5ERd75xeWjxCaFn1PWAo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sIf8/mNYA2M8X0zs+NKtBmsQP57fG1Z1VuVLOQ3y6UB/S0S3KGiSprWwCCNFWOiedBZKymByO4229GwWwhiw9GV8//O729qd0JOINLeupwcm1zN5MWYTbg5B9BvnojUv+QXx6rFihRlE5pSJTKWqIKGqwB6eQPQwjPxo8LUIyrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMSUmFzw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6DA1F000E9;
	Sat, 27 Jun 2026 21:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782594805;
	bh=tbvwOTEkP9njMWUj8fFRv724UgzF7XF26/BBC1EeU6Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=RMSUmFzw8LVPz6p8Sef/zUvD+yBk9bFCClCCp88pUO++14ES6C8Xd5wUjpPSI/vgp
	 H5qt4XkGt6oT4QeDU+m+sm2XMpPypVTASwJ2fxKsk6UDc60tNdpe74Bx4SbdPatpFt
	 cSICBOk4IExA8RUE4yqYITiH+RzuDnWrxQlcK2tePq++rGkhnTfOKUlt1DbLPDxhgA
	 Z/RvBdrltf/LSsBFQRrv3U+S8CKGEHI8jv12sBTlOOhs39NeHTu/zGPbRQmWvniM4T
	 su5oBzo8p7ZkcYbp+hapFU68Z/YmeA4cWcpLxxyezd2QtOSbkEnshTjGXHqEGmSYlK
	 /FWNhREXnVtQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A313938452;
	Sat, 27 Jun 2026 21:13:12 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for 7.2-rc1 (batch 2)
From: pr-tracker-bot@kernel.org
In-Reply-To: <akAWnuys9snFTiB_@monoceros>
References: <akAWnuys9snFTiB_@monoceros>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <akAWnuys9snFTiB_@monoceros>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-7.2-rc1-2
X-PR-Tracked-Commit-Id: 898ab0f30e008e411ce93ddf81c4099abd9d4e46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 780d569e6c4b422290f5cba319eb904b355d64be
Message-Id: <178259479117.1431938.5630421290545007329.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jun 2026 21:13:11 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:torvalds@linux-foundation.org,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:biju.das.jz@bp.renesas.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9438-lists,linux-pwm=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC9F76D2AD4

The pull request you sent on Sat, 27 Jun 2026 20:35:33 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-7.2-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/780d569e6c4b422290f5cba319eb904b355d64be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

