Return-Path: <linux-pwm+bounces-5285-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 189FCA70FBC
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Mar 2025 05:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955C3189114B
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Mar 2025 03:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C39915CD55;
	Wed, 26 Mar 2025 03:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aha64bWo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766F7154BFE;
	Wed, 26 Mar 2025 03:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742961562; cv=none; b=p7VFngQfX3evyyJklRHkkaTeDBQjKds12FBMoOX0n/8eePlElYQXDUH1qGaY5eCIciWtoYY4C6luyclmy0fANyW/LdSl3gzYi0UXQSkFNmd4rg6A7YbK92q7+IUTPisyKGtNiFHdCTKc+r+/4SgfndPjEFnAARzVJKkvr2eJ8tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742961562; c=relaxed/simple;
	bh=+gKNZhDBBub8Mc03Ib+rWKgitJfiIdRbhh84BI/8IZ8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pj3rdmSt/1Qm77Gbm9+0kNwqdfuCJ+APOE/OSRU3xW+4m0nFE3x6AVFFFnOtKW6/nlMdecI6jmjqlknRRh8eKNCG8V4NG3HX8GXmg/XvEhUK6jaMSF2lE9Fm3MChnA6+Xk7VPHEh4NKm78XOHUP/oP7LgIPeSBlHqUNEcWO+2vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aha64bWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5114C4CEE2;
	Wed, 26 Mar 2025 03:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742961561;
	bh=+gKNZhDBBub8Mc03Ib+rWKgitJfiIdRbhh84BI/8IZ8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aha64bWonkvm4gIjlE+Rr++hrJ6I9xxbpmzlIvnVRdwVAMO84KFGLat9veDI48StV
	 qh5S5bmvFtu8tSIwIAjMmO0UCeTpy/CJYdIAtBbtFunciUH1uzt3t+YIn0y4vzeB2W
	 uXaYOttfeB/z8Qv79CfQ07M603cp9+thYTCbMrs1R8Qh668ii2zzsIrVw5u++Y/uEa
	 gsM5VEDIaKdvq4jtJ3sCc42OQ2uWOQyiFTjlIuw1ed2RybTcC2Qz+VoxS1Z/AccFmG
	 txoA9rS0EKDgQvd0zU+nz9+ZKZ2lvj6cLbCvSiTs8KJK/yrkl5HYEhaKHI3SpDTldY
	 iYpm8GAcedBOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BAD380DBFD;
	Wed, 26 Mar 2025 03:59:59 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for 6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <gwhcc5df76untpl5ko4mqbt7vtxo3z4zdbqn4ehkenktt6untv@eng6ov2jmlwb>
References: <gwhcc5df76untpl5ko4mqbt7vtxo3z4zdbqn4ehkenktt6untv@eng6ov2jmlwb>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <gwhcc5df76untpl5ko4mqbt7vtxo3z4zdbqn4ehkenktt6untv@eng6ov2jmlwb>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-6.15-rc1
X-PR-Tracked-Commit-Id: 6df320abbb40654085d7258de33d78481e93ac8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e0c2cc4c35283e2ae7a0602d1fe85acf8ae6ccc
Message-Id: <174296159814.837738.3604533389354993055.pr-tracker-bot@kernel.org>
Date: Wed, 26 Mar 2025 03:59:58 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 24 Mar 2025 18:08:52 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e0c2cc4c35283e2ae7a0602d1fe85acf8ae6ccc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

