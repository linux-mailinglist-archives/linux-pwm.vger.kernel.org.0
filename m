Return-Path: <linux-pwm+bounces-1840-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0CA8946B5
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Apr 2024 23:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40BB01C20CEE
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Apr 2024 21:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3AE54F87;
	Mon,  1 Apr 2024 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgiOzZ2N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B471C2E
	for <linux-pwm@vger.kernel.org>; Mon,  1 Apr 2024 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008213; cv=none; b=rMRjJqLDLxVMlUBY2VJBA2NWu8dm+wRWzzhwOSNrxPW5QM7CICq20c/LdV69whnCVrIUpjqeGCLx9CgkR+X5FAN7083ub+uLnFfHfAt9X8Kz5SjXo/cvXt5IgTYfPwdoZV53fq1behlDwWS+u46p2yfc/yuytFZu3vmWoWL3c7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008213; c=relaxed/simple;
	bh=rYp3mDYhtAkvxjd0deY2SsGIeT4d5O98WHUIz6BU474=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mQgL9NObpTkkkEwl1MeqAl1O/+PC1nS8XIoz+44CWEB6VzmIHAgRNrBSm+6a28mxKXYGc1DWU0agRldIC7a4elQpO+8eTxzibyEy5VvENhmV2NQ9N8wkC4gc99SqcMZenaMs9g5s69CZPqb5ZVoHgfbBF8a0aoooD/AdcoaTWlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgiOzZ2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15F14C433C7;
	Mon,  1 Apr 2024 21:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712008213;
	bh=rYp3mDYhtAkvxjd0deY2SsGIeT4d5O98WHUIz6BU474=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GgiOzZ2N0jv3fugOQlmYkBMYKC72OQJO6rPhfsprt4vjW9HItis4ArozHGXuRFOuz
	 qmh4/3VShFVuJ0UUT4VmC/K5dP048cvZ9Vi/1Az+BYbALhx2GDYYWPH1tK9lRfydRP
	 5cvrluA9gk9T3s4HZjWSkTS3tbM6z2f/pSE2fRSkDgtB3vgXa/Wx42/9Hgyg4d5mbs
	 X9XKprS/XbV1ddfcDU+Se4pqkPg0We2KfEOAO+oDAkPZxXFJXY58m8VjJRlAnFdpQg
	 5gPrJLj4hL/xIjHCIrUkwIzLOh/kcUT57bBBLcd5uk7xvY1riiVOBdX7w9dZ6r2IxW
	 ogfXvrq4td+ZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07A5BD9A150;
	Mon,  1 Apr 2024 21:50:13 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: A fix for v6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <sflouhdi5i4ekqxhpi4z5vriwnwxd6jobrwazhlpg77avn22qz@2f54bed3yu6v>
References: <sflouhdi5i4ekqxhpi4z5vriwnwxd6jobrwazhlpg77avn22qz@2f54bed3yu6v>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <sflouhdi5i4ekqxhpi4z5vriwnwxd6jobrwazhlpg77avn22qz@2f54bed3yu6v>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.9-rc3-fixes
X-PR-Tracked-Commit-Id: 73dfe970c038d0548beccc5bfb2707e1d543b01f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 026e680b0a08a62b1d948e5a8ca78700bfac0e6e
Message-Id: <171200821300.18451.13751543489448846900.pr-tracker-bot@kernel.org>
Date: Mon, 01 Apr 2024 21:50:13 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, kernel@pengutronix.de, Karel Balej <balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 1 Apr 2024 09:09:22 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.9-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/026e680b0a08a62b1d948e5a8ca78700bfac0e6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

