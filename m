Return-Path: <linux-pwm+bounces-472-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B13B480AD74
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 21:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40E46B2089C
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 20:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C15C56463;
	Fri,  8 Dec 2023 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQc0zuJV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C9A563BE
	for <linux-pwm@vger.kernel.org>; Fri,  8 Dec 2023 20:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E9BCC433C8;
	Fri,  8 Dec 2023 20:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702065625;
	bh=vEIvW4gM6hDdnIFS2ru500jDM1EzKm3oNFvR/S3NoGs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OQc0zuJVQiFlEnavqx6ZoJhdihq3YxanNxnU1zdgBv67hrDJGiVs+mwT4p8nDOVIP
	 9qVFMvAYT/jRw6udsgvH1Aqvs1r+QSmV5to0hWvDKBg0TDxieUBBlih0r1SyzeKSra
	 b8mF1JRViHubSseJJ5kqciPAfxrYT4bBUHXnW88FoGkYChYaamdBc4L8iJXNAukIzI
	 pY8ffBoxJRbxUPPPME2qfSdopIFiXJNvNnSk0fQK89XmGa84UZ+v/5YNZX8qa7EcRH
	 qhfcO1p5HtPQ+XXHLXM6tYBk43Cqy6YBvcEzZFHzMWhy+dvDOeOgHW/j86t4TbmazY
	 0Hcr19eEhXy3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C90DC04DD9;
	Fri,  8 Dec 2023 20:00:25 +0000 (UTC)
Subject: Re: [GIT PULL] pwm fixes for 6.7-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231208140253.m6lpundvnvtfsloh@pengutronix.de>
References: <20231208140253.m6lpundvnvtfsloh@pengutronix.de>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231208140253.m6lpundvnvtfsloh@pengutronix.de>
X-PR-Tracked-Remote: https://git.pengutronix.de/git/ukl/linux tags/pwm/for-6.7-rc5-fixes
X-PR-Tracked-Commit-Id: 4e7a8dbd2bc0aec4605a5069df7a779bd9e64db1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d650b3beff76bd0d1eaba6c706f9fbac52137339
Message-Id: <170206562511.13365.10899769030412218451.pr-tracker-bot@kernel.org>
Date: Fri, 08 Dec 2023 20:00:25 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Florian Fainelli <florian.fainelli@broadcom.com>, kernel@pengutronix.de
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Dec 2023 15:02:53 +0100:

> https://git.pengutronix.de/git/ukl/linux tags/pwm/for-6.7-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d650b3beff76bd0d1eaba6c706f9fbac52137339

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

