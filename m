Return-Path: <linux-pwm+bounces-4047-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5956B9C0D1F
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Nov 2024 18:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD1F1F23309
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Nov 2024 17:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743AE215F72;
	Thu,  7 Nov 2024 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYryjZ2v"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4339C18FDD8;
	Thu,  7 Nov 2024 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001469; cv=none; b=Y3eRKysMB12hLMgrbRTMZckVrM6e3sQd+45zNw+4HKVcoAgpzXMeyeoJ2GDIcJeCm9Jbg5AX3rU5IXx5AneHZCyRqncSL6pqnstrmCK94/Xnu5KKWyA8K2EXN7gCsOlhA4tqWhoxhdWuEHJhBrpPQZxf4kaQzP3g2WU+HuVVI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001469; c=relaxed/simple;
	bh=ZCcYHD9NldfFUecQKEXCdOX00Q9f6uopH46x2Emxbag=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JhtVM3bVssv/EVCi+gUK8sCetzMeNFNDIw1rGDkyvxtd0ZQZSFKAw6hHs2XdTBbUN3bKp7KCtoR8SrpMh5Tn8iH/b6Vtcc1wsoDtI+NuRKMhqBoHqFJ9hV+zqk9Z0OCu33tGVLoCsRB04fXeOfJGktjetVetKJRB8eWqlnmGByw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYryjZ2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE18BC4CECD;
	Thu,  7 Nov 2024 17:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731001468;
	bh=ZCcYHD9NldfFUecQKEXCdOX00Q9f6uopH46x2Emxbag=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PYryjZ2vFdJeWw7012ySYdhQGo9ljvKN1JpTx5aNYRrd1K3DXKQZQloD+WQ+tWnQF
	 SauVK5TMHmCbD2/sNgGdPBsMVR7O9vet1I4RsGpj1m1z/r0F0YRXV7hysSubE0wsT3
	 8uUItd0jqtrZI192s1pUGwLWHH+W7Av69Vuji2HPqnTWwF/6YL6DSRlMFrALpSVuV9
	 xE+Fxd54e0060rXK9NogBbOJ/bK9zKOdACmYtrQGem1yz95aXrfWvKozkuzVsAnR3Q
	 V2i0f2fsdeN04osa4SHxVv3hpwxB6OE/dddwjkTGRalV/82mLDWCcezrCB0G4C+POU
	 aQ4Xi39er7pdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 345603809A80;
	Thu,  7 Nov 2024 17:44:39 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Fix period setting in imx-tpm driver and a
 maintainer update
From: pr-tracker-bot@kernel.org
In-Reply-To: <2m53n4ksfvepuke6uifkxwggepcyqs3vghrkgul5tlputpgva5@ch3o5sy6ekfb>
References: <2m53n4ksfvepuke6uifkxwggepcyqs3vghrkgul5tlputpgva5@ch3o5sy6ekfb>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <2m53n4ksfvepuke6uifkxwggepcyqs3vghrkgul5tlputpgva5@ch3o5sy6ekfb>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.12-rc7-fixes
X-PR-Tracked-Commit-Id: 517fb4d77c44c7519ae6937329c496894461f416
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80fb25341631b75f57b84f99cc35b95ca2aad329
Message-Id: <173100147781.2042501.5989487007360324686.pr-tracker-bot@kernel.org>
Date: Thu, 07 Nov 2024 17:44:37 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>, Erik Schumacher <erik.schumacher@iris-sensing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 7 Nov 2024 10:15:40 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.12-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80fb25341631b75f57b84f99cc35b95ca2aad329

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

