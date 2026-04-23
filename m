Return-Path: <linux-pwm+bounces-8679-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBTUBTtK6mkhxgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8679-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2026 18:35:07 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCD2454F54
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2026 18:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A158C30A5A60
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2026 16:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908BC3A960A;
	Thu, 23 Apr 2026 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDWlEX5Z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6A7383C9D;
	Thu, 23 Apr 2026 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961132; cv=none; b=aqsdH+KphaB2jHolyUafT7PvQFK8U4vp7WiK2jKa/8aY8+gJBdKXfDUhaZwj2CPfsh90IAejAVjzq1wkSZIhj2RfpomCtxSHeMziT/7foyehsSe9UsnOk8FjTm3fYE4wEThvkiN3VKjI/2R66KmowJevVRRydC59fUohIWSE9zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961132; c=relaxed/simple;
	bh=eBdUOVKo6ZL8i+19XwabM7riZf4WohDfjQkm4msazVc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A5b5xGxYPFy44OZPQHgvsanYj4FrsBFScDe2IXxgDP0zOHXZyy2erf7iUJ3svSAR+cywtV/DngOJvXQWKv/g4Sdb6KBDV9OF9L7TUndT32VKRw2jPojSQKXZqiPbpAe57Q9H4dez9nMHrJVgZ5yCVP6YaP0TNQzT6ZLpzzYfdUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDWlEX5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A1BC2BCAF;
	Thu, 23 Apr 2026 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776961132;
	bh=eBdUOVKo6ZL8i+19XwabM7riZf4WohDfjQkm4msazVc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BDWlEX5ZpkBS354JaoBNIM06ZnWMaWsBNmi6JWR1y6Ag1/j7U7TF4QTiShuVzSlj4
	 t05iyb9pTUPJlhWPGwgIkxI+ZMgM2rd4z78+Fd2ka5bMDORn5DLqiBL3Wr472MC4O8
	 I6JPC3bD7AxUtJf2T01CNNyv+++nz8IFGh1pAa+7aUIbkXM2VZuOTLLpDTjjFFvWf6
	 F/l4xYHAnk5ydYA2peXge9kZzwi0XWip1jY77EV+kTzVlV28XGHD+MPyzr9a16LfZV
	 z39V6OOnjEX67QUxFQj/X1yxSqXL13EHC56U5BBfWa3XS5kfEXzFYkir/3IgOxvtfE
	 zKPcpLcATgq0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E6338111CE;
	Thu, 23 Apr 2026 16:18:15 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for 7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aenGN5inmayPlloE@monoceros>
References: <aenGN5inmayPlloE@monoceros>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <aenGN5inmayPlloE@monoceros>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/fixes-7.1-rc1
X-PR-Tracked-Commit-Id: 68637b68afcc3cb4d56aca14a3a1d1b47b879369
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8841842cc9be68e0f670323e697c9b3214831d6a
Message-Id: <177696109356.655676.11368998251067623189.pr-tracker-bot@kernel.org>
Date: Thu, 23 Apr 2026 16:18:13 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Sangyun Kim <sangyun.kim@snu.ac.kr>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8679-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-pwm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FCD2454F54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Thu, 23 Apr 2026 09:32:44 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/fixes-7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8841842cc9be68e0f670323e697c9b3214831d6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

