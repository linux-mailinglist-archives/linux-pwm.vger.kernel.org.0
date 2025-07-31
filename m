Return-Path: <linux-pwm+bounces-6922-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9D6B17757
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Jul 2025 22:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5EE548F7E
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Jul 2025 20:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7FA261393;
	Thu, 31 Jul 2025 20:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjwbOB29"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC425FA3B;
	Thu, 31 Jul 2025 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753994991; cv=none; b=TPD43ed8pxSOyKybx5LGXVpt7JpEQWSTTIOxmo2qnTn/zvKRWkcTV2Y+SqkNKE5JAX0qvgvvHhS0UWcttz7bZRavEgVdi5nE/t4WC+blosUzflyDEY0O0N29GxGZZNriigiOgRRC4gxhuepO8XoqDeP7nJu4D0XzppAr6vBrnjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753994991; c=relaxed/simple;
	bh=kTNBUYX1UK++0qqVgJa2GwpQcqyGrCOMrh7HKbGswGk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=I1MxYO4DZcipjbYh8LY+dljYyT3LAgLjZ0upU564bx/PbBGyvJQ+skjsVDMJ4Lpz7i8iTJr1GySeFBEecGvEfou1yqF/hmnjQUCnsD72MYxmDMiUq9kK2MjbCKyVcU2Sun45n/bfGePZzQ/PDn6xk2SQJa13SB7jDFxo35ujulU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjwbOB29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6229C4CEF4;
	Thu, 31 Jul 2025 20:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753994990;
	bh=kTNBUYX1UK++0qqVgJa2GwpQcqyGrCOMrh7HKbGswGk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GjwbOB29PlrY1eTtgqbrVdyxatldL7PF7yrOqF6kGUPHzsyig8fGzf8VmumfNn4Mg
	 7ZEMuYB/kh/byh5lci0rZ5Wi/ISnoXN9ogvyBTFKw+4lo1XujidfnByg8MY+jB1vPN
	 HkbAQksV8R5qwP6kh0jidMKtDxn3NVfp+QFUXl3hKJ/BqtDZTXn/qMOlKC6evUNMYv
	 2I3RFjMfIrJe29OF4on13ND2thSntMjtqXhqbIsUNk+HRDBxU/s35GPanjrQjtWeSB
	 cmVJuLdnovgtm74aLtnUxvSyHSxe8iEE/bNNwO+vKuMZjDlYNL3g+akg9xV6Mjjsqi
	 pf17hnClan2Kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF4B383BF51;
	Thu, 31 Jul 2025 20:50:07 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Two fixes for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ljulzcaas5usyyqjzcnhjtgrv7loxz5hgabdjso237kwzndwln@5zfghmq3kqjt>
References: <ljulzcaas5usyyqjzcnhjtgrv7loxz5hgabdjso237kwzndwln@5zfghmq3kqjt>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <ljulzcaas5usyyqjzcnhjtgrv7loxz5hgabdjso237kwzndwln@5zfghmq3kqjt>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.17-rc1-fixes
X-PR-Tracked-Commit-Id: 65c6f742ab14ab1a2679fba72b82dcc0289d96f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 602a0672869499fefa31b7f1e22f9d32c35fc7fe
Message-Id: <175399500615.3294421.6592111465987539110.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 20:50:06 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 31 Jul 2025 11:38:29 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.17-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/602a0672869499fefa31b7f1e22f9d32c35fc7fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

