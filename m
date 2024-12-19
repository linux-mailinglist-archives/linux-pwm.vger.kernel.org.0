Return-Path: <linux-pwm+bounces-4410-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DFB9F80FB
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 18:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C60E188D768
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 17:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477CF19D084;
	Thu, 19 Dec 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqtX2bdq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFC91993B7;
	Thu, 19 Dec 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627796; cv=none; b=ZoW1/vx+WkOy/4uZzlWJZejfBsRjUWQFW1QlNgvNh5Z+fvExk4dfQuOZ/jRXSoUwDpDG2JsWsdF+/22pPUx49ifK9is2H88Jj/b1JVviWZJN534RBvpmoI2LgIvVUn0dPnHeqQXrep6NoLujAm7Gc5nVyoozUw8OBgHdaCE2+Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627796; c=relaxed/simple;
	bh=tC8RKsGa5WLB7/xBFDtRxmIHTrM2V1tWu6OnXBO6f84=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hVteAH2hxuYuhnXZTG2jR7fzHcpbz82joXblH0/zKT749LqrMVd6D5ryYrobm4nS9zSvYvLHsxGxOgrAld6A6FMPANr48tczkeaxp/KfMiadbsKGIZ7OnyMzdwBRWjydCdtfNSvbwfBEeWPKxR9Jc7dLGXUf4Nt91Dq2R44EuB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqtX2bdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6721C4CECE;
	Thu, 19 Dec 2024 17:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734627795;
	bh=tC8RKsGa5WLB7/xBFDtRxmIHTrM2V1tWu6OnXBO6f84=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OqtX2bdqGdruIITitsRqmUYmclt/GiafZo9h2pnCrFD6oODv8p1epgFJFLjtv+4IU
	 PR7xEsZp5XufJzQQUg/RaCf8ntyL5P0daA3n0NALt1CtDg9A+mKpKiaeBm/oOSLVb6
	 ilwhK+aaH96cM9QgDkpL+fp+Ib+EGvqg3kt6C2yZO2I+Pyi9OrmMt8TfnV1NyPRNxF
	 J7XY+olQ7Eh1YQHvsaHW5G+wWYjRorjsdv+oidtzSIj4NJZiOGwx21XQrVrHphglfy
	 tgfs6FjDmsTEet8rzPmZgj9/1Q0AXDRfw9DS5BYuYspaUg1O/KdGixrEcdSd+MKnbv
	 51m+yxtz6bVwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5FC3806656;
	Thu, 19 Dec 2024 17:03:34 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Fix regression in pwm-stm32 driver when converting
 to new waveform support
From: pr-tracker-bot@kernel.org
In-Reply-To: <xzfckqs3o7trfrfpwzllviweimeohy4xvzy3oxnawm3mdpoe4z@vf2qqhvbgt3y>
References: <xzfckqs3o7trfrfpwzllviweimeohy4xvzy3oxnawm3mdpoe4z@vf2qqhvbgt3y>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <xzfckqs3o7trfrfpwzllviweimeohy4xvzy3oxnawm3mdpoe4z@vf2qqhvbgt3y>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.13-rc4-fixes
X-PR-Tracked-Commit-Id: edc19bd0e571c732cd01c8da62f904e6d2a29a48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0db71c7fe57bf08dcb46376237b78317c035b69
Message-Id: <173462781334.2314669.11727352708334919397.pr-tracker-bot@kernel.org>
Date: Thu, 19 Dec 2024 17:03:33 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Dec 2024 11:55:22 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.13-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0db71c7fe57bf08dcb46376237b78317c035b69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

