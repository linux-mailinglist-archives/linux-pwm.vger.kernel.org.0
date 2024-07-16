Return-Path: <linux-pwm+bounces-2824-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E6A931E2A
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 02:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C430FB226C8
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 00:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6D7200AE;
	Tue, 16 Jul 2024 00:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5RpNAci"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C991F947;
	Tue, 16 Jul 2024 00:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721091117; cv=none; b=TDblFV/sdQatU0dhKJPHTm3/T1+7QPUe/rOiJtzqBuYkTZjC32H6AkCltP0rnp7Ehh+isQ1m/y+Ge39KWoTQ634qdZ7e0NvvL8osulXRtMZGOElVpw1AAR7cLlrT+5tcgjqfB7Sky6K1pq70JzXgmn/gKeiE09CHAVE4//bJgQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721091117; c=relaxed/simple;
	bh=5Dki7LrCz5ZbFjMAQiDW5pB2BRct8WLuHw46Df+Ok7c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=etD7S/vrhXHiDOmxnDzEHhSgmCru0EpHxByCBiVCu71HhKNmJssbGgNLjhVvdsUyaQHhenIJsT3UxMqdwpxFwBPFzl9wy7Yq0WFndA/5n+xFIH2CWyge0PEEc/eCl1xIdFdir/Suj+qZ0Sddw+H3fxN0B7eiFd9pIFOovgI3l2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5RpNAci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 286EBC32782;
	Tue, 16 Jul 2024 00:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721091117;
	bh=5Dki7LrCz5ZbFjMAQiDW5pB2BRct8WLuHw46Df+Ok7c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U5RpNAcic1fehak5PnDErFukEpxz18AKp+WOi9xX7OWjL36oxEasMgLqzOKDPtXMs
	 fE7LX9c9++F0wNq2jDkjpg8a4TpfYTgQT2ZD0I8oiXsxma/eB8ef2dZUgTk+udfnW/
	 VIknjSV/acpOErOjD1bFxuwrNEDebVCmSeyHiNFDPO2bxs+bAdKjVFMHCvyBPXs+C6
	 eUdJa48xB5feD2i7msk8TB4Eqr2ttFhmukzGL+7ZAyJEZxBp7NxSYi9/lJF6hb1ykj
	 LjEKwKRTOGvIiUtt3MbzSB/1TKlXd0rFsU8nrkB+3TD+O0RrNPDIeyf/eExO24LG49
	 c100wWk+eNlbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FF60C43443;
	Tue, 16 Jul 2024 00:51:57 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <lajhejp2frzxdzjj4zdw645uabt3y77rg6rmbk737cel4bytrp@wqr3zbdu6pg4>
References: <lajhejp2frzxdzjj4zdw645uabt3y77rg6rmbk737cel4bytrp@wqr3zbdu6pg4>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <lajhejp2frzxdzjj4zdw645uabt3y77rg6rmbk737cel4bytrp@wqr3zbdu6pg4>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.11-rc1
X-PR-Tracked-Commit-Id: 240b129d597cb8a8880eb3a381ff10eb98ca0c07
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6e63a9882c90f753b11c82db4308a9aba94e38d
Message-Id: <172109111712.26590.10312082468905064494.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 00:51:57 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, William Breathitt Gray <wbg@kernel.org>, Lee Jones <lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 01:55:57 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6e63a9882c90f753b11c82db4308a9aba94e38d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

