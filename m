Return-Path: <linux-pwm+bounces-7646-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D83E3C707E7
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Nov 2025 18:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A74B4F6F66
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Nov 2025 17:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573F3217736;
	Wed, 19 Nov 2025 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1SZnK+L"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8730364EB3;
	Wed, 19 Nov 2025 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763573347; cv=none; b=LJpft8mYbEA6PIfpD5oW7E0uHTtc5MIgrRUvVmLkv4mX5C7pKskmZH4Bo5bSE+kkQxeeXeWWOf6K3q3qqbofy+65V5Lgu6iGJWD250ywbhMifT3NwMFqS3DIGlCJk0HQSziI5FWKAO6wnf7tAKVftZNdHy7LRJ1UOTsRrpc8pkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763573347; c=relaxed/simple;
	bh=cOq9cjCoRNULlZcFgtRUxdHYAIC4GBWIgpYrIHx1+FU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IcPqYMemNlfjgPSwJUqd1PKk5F5YGbQQq4mZ7TWUSSjbxmBVCG48AFQgf3TaQKYf8otKWtD7HV4eE4kWmgaIVDbMMjNk/d+zIFvmGle9Z5Yb/nRhBzM3lsu+c2GwdudKN7D/y+ACi4OFRnEJmxCVo+nh2aCvkn8XOCm1UkRkPHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1SZnK+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C56C4CEF5;
	Wed, 19 Nov 2025 17:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763573343;
	bh=cOq9cjCoRNULlZcFgtRUxdHYAIC4GBWIgpYrIHx1+FU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=s1SZnK+Ldqtpedo1Yhx12JZz3K4QDqjm1Fb9D69MjBbMA55f638AGi+C4xAwqE4KS
	 u7ssN7lNxRoBs1GOmy1HKeesAb5OldUiWD+mjD6wTOA/iGOMDTq8HNWg4fG8hIBJFd
	 5LYhI4XxEIgxlEpE1r/u6c+vSX3TDer8mevUpaouLilf0brxdkMT7IiJtaj3KGdJPN
	 IUi4l2RFY4TMuAYFK6vPRlLgmCjJMV4XJ8pbMTiZNPRYaDQ0dsDyUU1KPEA9NqQ/VQ
	 MKn0GGbF6mz1hrwfzWkN8WNOwHeswBQ7AG2MijtXhEij3WQF+w0feJ4nlQ5arlc04A
	 ZPv49mVmc+MSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34103380A944;
	Wed, 19 Nov 2025 17:28:30 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: adp5585: Correct mismatched pwm chip info
From: pr-tracker-bot@kernel.org
In-Reply-To: <envt2p43cxalzvnvakjq5m4vjvejkxb3c34rcw2eyicq6ehimf@dfmihw6e7uz2>
References: <envt2p43cxalzvnvakjq5m4vjvejkxb3c34rcw2eyicq6ehimf@dfmihw6e7uz2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <envt2p43cxalzvnvakjq5m4vjvejkxb3c34rcw2eyicq6ehimf@dfmihw6e7uz2>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.18-rc7-fixes
X-PR-Tracked-Commit-Id: f84fd5bec502447df145f31734793714690ce27f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fdeee1cc7f3568235e9bd89421e757ba1c49cc83
Message-Id: <176357330880.892447.13158239551392941902.pr-tracker-bot@kernel.org>
Date: Wed, 19 Nov 2025 17:28:28 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Luke Wang <ziniu.wang_1@nxp.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Liu Ying <victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 19 Nov 2025 12:12:49 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.18-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fdeee1cc7f3568235e9bd89421e757ba1c49cc83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

