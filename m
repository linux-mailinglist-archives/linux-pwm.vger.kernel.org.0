Return-Path: <linux-pwm+bounces-4115-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46939D4356
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Nov 2024 22:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A584284505
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Nov 2024 21:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407851C8315;
	Wed, 20 Nov 2024 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnyZhraS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155921C7292;
	Wed, 20 Nov 2024 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732136439; cv=none; b=NlUlrpsXC5ck/1qHFi6zmEGTpWgkTM5X8mZFVxV/TuK+EUIztibjPdcrj+nChVRVl+RTCxZHOYfHqVypBOJPdMhni7kORz/x+TZuUQPiTq4ylUYl85yKmJJebQ91HupCaBEY8q0vdze0trJhCxegD0sjG8WZBJegKxk+ChgSCp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732136439; c=relaxed/simple;
	bh=Aar+rMe2XDpsaPwWjVbO5VTQZZPRLvVOjL3ZNAaND2g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gPsxycpzrt1I2EiYFpOdACJLaqI8bo9dCKNQIoChxydc9PxJMadDhNq/z9PV50TgOG5XOsL3LJJDVjZHf/rc1uja/9m8E6Msl7NKGHhEjNjmor1ZDbtAtZmWx6TPK8KWRO+Ldu3hQfzQBM5k9fJPY00DD8lF1OoqpyZEeHrYfI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnyZhraS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E3EC4CED2;
	Wed, 20 Nov 2024 21:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732136438;
	bh=Aar+rMe2XDpsaPwWjVbO5VTQZZPRLvVOjL3ZNAaND2g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GnyZhraSFmJormOndTekNN6Cc+SzdxeUTkz+kotUct038uNlwfO6umHdHhM/3KrAz
	 rBZuh1rIPlNdPbpKBG2gjZqY4R51oLJh2V4C2hRPgasFyBxsw4VRN2Y+RkEBElenMI
	 Ej5w0IicYbGc7pS1RQxjtY5ym4Z654vYklPJuzzcYQk+o//n2iT/ZcnYQ7ort2zr3i
	 nOTQJb/qA28n6Fp9Jy8ixDYEF1zmwpJiXL4oz3UbTGjvmIl/FGSTTY+8fxWHh2qqqh
	 7N81KkdIGB+WW2AqccuPfBNFfhT6PSOu8HUxVCMzMS0AJFZa2mgqzyeMlwhV4pTM73
	 AtYKz+X5Ip1cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE52E3809A80;
	Wed, 20 Nov 2024 21:00:51 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <karzhndxysg5whnrp5pby3ulvmircl76a7dkcbinkdyuyx5flg@6al4vimzwjhc>
References: <karzhndxysg5whnrp5pby3ulvmircl76a7dkcbinkdyuyx5flg@6al4vimzwjhc>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <karzhndxysg5whnrp5pby3ulvmircl76a7dkcbinkdyuyx5flg@6al4vimzwjhc>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.13-rc1
X-PR-Tracked-Commit-Id: b2eaa1170e45dc18eb09dcc9abafbe9a7502e960
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d7560666515855f67df6b0a78fecf2007d35dcc
Message-Id: <173213645019.1349927.13540234015412705848.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 21:00:50 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 11:06:12 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d7560666515855f67df6b0a78fecf2007d35dcc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

