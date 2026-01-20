Return-Path: <linux-pwm+bounces-7978-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uImVN6Xmb2lhUQAAu9opvQ
	(envelope-from <linux-pwm+bounces-7978-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 21:33:41 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCA04B5B9
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 21:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF9FB8ABFDE
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 18:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C01444D02B;
	Tue, 20 Jan 2026 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV6QWeeF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817844CF2F;
	Tue, 20 Jan 2026 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934250; cv=none; b=RaBN/a6MOb/WGc6BwZAitE/ZFpqUqVXj3cq1oiCZ/M+sjez4wIn2yhlPrQFE5ss5bBzkWQ/f8KhUeJB46/u4FsqU1COqJrFEU+jJdjOsZW9TFuwD3qhsVnKfVGOqKYVT/MDF6tLBxIKGqP3cg0nlfeHdhD3QB29GQ8aHPbo967g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934250; c=relaxed/simple;
	bh=ub4jSQ34mq+qTT+ILljidxJit465wa4ZIOh3O3yYW6E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mzAyeoMtZil2piJdNm5MY/QCv6w68mNCosWtQEDXSA04U7yvBjhS6y8fQgmvPAdHZYQYXGVppvxwrerDzAzGdNdy4v1jLmiPeVghbrgk9y7s1IN81ZMhTXbuE7plDFL9oUd5y8X67fE6dWFuZHjAgviIiGoKSCv1jCvhw3lgxMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV6QWeeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF251C16AAE;
	Tue, 20 Jan 2026 18:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768934249;
	bh=ub4jSQ34mq+qTT+ILljidxJit465wa4ZIOh3O3yYW6E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BV6QWeeF1jsnWWHIp74whSzgy2G7iHNNMDT+WbEG7pDhni2kIbtD59TyRGhZxXHtQ
	 vghdbBcYDc/DlxIXvBBYMLg53KHOEqlC/RNvrWcsHFWPg1qoTIloT3JABKNIDNJVtm
	 3lpi96JTLiWx7cluD0WXD8ZNMKbSa/Ow8cCIEQOmaFasByWKzI4j9hSst6OdpbC3il
	 VoiKZUO136QJ+i5g7+xku8kLwr7T8OD7l261Oef8S0UgXKnHsV36Dx8fGdnBrqhXiZ
	 /hHF+nOqsayJy8MWjP6v482MCG/1Gb/ynwdhNEs9B4Z+m7tFD7mwediwabpJ1cJxzk
	 0X3WM2nygYNLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8C0BC3810935;
	Tue, 20 Jan 2026 18:37:28 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Two fixes and a maintainer update
From: pr-tracker-bot@kernel.org
In-Reply-To: <ahytfwrx6d7nvddjviqt6wyit6f7flh5vmiuuzdet44unjdbwp@cktsraaj56au>
References: <ahytfwrx6d7nvddjviqt6wyit6f7flh5vmiuuzdet44unjdbwp@cktsraaj56au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ahytfwrx6d7nvddjviqt6wyit6f7flh5vmiuuzdet44unjdbwp@cktsraaj56au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.19-rc7-fixes
X-PR-Tracked-Commit-Id: 0a155a8a24ddc647aaf28ce7cdb14af7270c158f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f7537efbe5636a798cf885ea2fa0e4889995fa9
Message-Id: <176893424716.562471.5970388282256942551.pr-tracker-bot@kernel.org>
Date: Tue, 20 Jan 2026 18:37:27 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>, Richard Genoud <richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7978-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-pwm@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7BCA04B5B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Tue, 20 Jan 2026 10:32:26 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.19-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f7537efbe5636a798cf885ea2fa0e4889995fa9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

