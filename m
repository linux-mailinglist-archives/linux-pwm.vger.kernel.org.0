Return-Path: <linux-pwm+bounces-6259-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D2FAD0914
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 22:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E044189EFE5
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 20:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE6421883C;
	Fri,  6 Jun 2025 20:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1L+5W1i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578DF219A80;
	Fri,  6 Jun 2025 20:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749241818; cv=none; b=HBwi2z92gBRE0zH38WwhprsGfoHdrF0H0UwQlPccsmWjYDj+DHaC9dz+53K7PP22+VEa86B+gtGu5kthFb5BOTkboU6oQuD5PkFD8cEe1dlg6Wbjt3JMTcxd9bVpKVnrdOu04couUTZubZBmX9vXbDmBvTmk7vloJmHZiUsGeXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749241818; c=relaxed/simple;
	bh=XxMbubhexh9kAk1xe21ppFti4Lj4G8QmL9rUFUSgl68=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TOvVDu0rqFj8D1633rqzJFKFQKBAxzEuN9HWB2lAdA4Ap243WGud1zeDkOxfMf9f5c5+FvVEQ5ygA2ka/6eE7Gri7l2yJANB99DVJdiGXq2U0Yfo0Diafb/ztGT4TfIDo4Egnr74MY+UIRAO2YAADRhWmrJL+hSlwsnC5mQcICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1L+5W1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE01C4CEEE;
	Fri,  6 Jun 2025 20:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749241818;
	bh=XxMbubhexh9kAk1xe21ppFti4Lj4G8QmL9rUFUSgl68=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q1L+5W1ioFsQbT2cRC7rVS3C9F6524Uamg+Ft+zI1266Jr1bVJdGAQcpQXhrgsROP
	 On18oPUobnnis8krCEBcFMU4R145yFsd1ShkmAyS7+N9rcAxGrqGJdu2ZaHOEnwQcc
	 5rpBH8pvzHBRWa17o3jHE+hKXPvpsDhXZKtMFXwYfa8uq7ycLQVmCqxJRLlThSjAHc
	 iPNAwW47esfh8Xlyez1VcxlsDiwZzccfv5L2+7Q0h/JkJ84Zt2mAl0Q0DPqGt/ZRo0
	 Yp+MZCNBHgRzx+rRTNISR6fyMJPIcvbNtyucDk4WxeYssSoIpXSj52vopT3P1I5HWB
	 gvll0OcvGg4EA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E9F6039F1DF9;
	Fri,  6 Jun 2025 20:30:50 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: axi-pwmgen: Fix handling of external clock
From: pr-tracker-bot@kernel.org
In-Reply-To: <jzbvo3ranrbpiaox6pzs73jmq5njkkmq7iqnme5z7krcugjdk2@6hy7myyjdji5>
References: <jzbvo3ranrbpiaox6pzs73jmq5njkkmq7iqnme5z7krcugjdk2@6hy7myyjdji5>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <jzbvo3ranrbpiaox6pzs73jmq5njkkmq7iqnme5z7krcugjdk2@6hy7myyjdji5>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.16-rc1-fixes
X-PR-Tracked-Commit-Id: a8841dc3dfbf127a19c3612204bd336ee559b9a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a2ba6f8ee7dd764ffec4484e4f4d5ad377f9a69
Message-Id: <174924184956.3981198.16330161061990733058.pr-tracker-bot@kernel.org>
Date: Fri, 06 Jun 2025 20:30:49 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Lechner <dlechner@baylibre.com>, Trevor Gamblin <tgamblin@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 6 Jun 2025 11:47:24 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.16-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a2ba6f8ee7dd764ffec4484e4f4d5ad377f9a69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

