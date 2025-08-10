Return-Path: <linux-pwm+bounces-6981-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF673B1FC33
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Aug 2025 23:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3FF1779EB
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Aug 2025 21:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7E322069F;
	Sun, 10 Aug 2025 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wf3MJIUh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43272247283;
	Sun, 10 Aug 2025 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860334; cv=none; b=G6rgmYFTMEHwnftWngOIQbYYkRk1vN8Lh+uimWR8w48g/B46rLmPjqBOY3J041zCrkOFnAqPdtpLw47OPkQ9tlzXW2VsfR33d8pcXhdwTcIdrX2LtnVYVzbDN85HFYYBroRpa0fcyFxR07f0blFhi99Nyx/EDMPjpxw5IWjQmXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860334; c=relaxed/simple;
	bh=q6uQBP3ytVwY6Xa0bc7ANWecbKEHgjOcdNbvPZv33Lk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DMh5JE54cH5zhidvE3vywQh8rokSw0lrqDMQ8fACO2nq78rJJZ+Zb4bpk9ZU/KxYGAt1tMgrTXPncpUaKIGqsZ4zlxBNKia2oFdTcrMSVYuL+G9Srcynfp/VHItRYwS3NPvj2tFMxfvvV5auKPDoYGa0pbLJ1/vG9YM+b8uyOW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wf3MJIUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2752C4CEEB;
	Sun, 10 Aug 2025 21:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860333;
	bh=q6uQBP3ytVwY6Xa0bc7ANWecbKEHgjOcdNbvPZv33Lk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wf3MJIUha+tL0qtzl5Xf6xljjvs+i5UNLAoJ/pUEkJv27IMfKaWGuIXYUnccTV8lu
	 4osP+GVHUZPCF4H7EpfE+/sASevvtCay7yT0WV2OQWZwF1oYCCXq7L44lWCr9wV2Iq
	 /CH6JRm1eFDYNfX9gpbUk8layqijyn9I3/iZ0rCgIKraHTzIEqFwkfYabLlGJZCQnz
	 XgrA2HMScZbJ9Kw2bPTQeQu06I/gHMONMQw5KKtdKdj5YOsDYAsurp7Zyj0exMXQCf
	 nX+MRQb0244NMTke6zPThALZixE0KJtKSh2zA3y17EAm8PQ9HfaF5/dOzdssGMYDR+
	 HTudqeXY+X3wA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDAD39D0C2B;
	Sun, 10 Aug 2025 21:12:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/8] pwm: Drop local locking in several drivers
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175486034649.1221929.797683482600200009.git-patchwork-notify@kernel.org>
Date: Sun, 10 Aug 2025 21:12:26 +0000
References: <cover.1750788649.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1750788649.git.u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40baylibre=2Ecom=3E?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
 claudiu.beznea@tuxon.dev, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 vz@mleia.com, conor.dooley@microchip.com, daire.mcnamara@microchip.com,
 wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
 linux-sunxi@lists.linux.dev

Hello:

This patch was applied to riscv/linux.git (fixes)
by Uwe Kleine-König <ukleinek@kernel.org>:

On Tue, 24 Jun 2025 20:15:36 +0200 you wrote:
> Hello,
> 
> some time ago the pwm core implemented additional locking to protect
> lowlevel driver callbacks against driver removal. A side effect is that
> .apply() and .get_state() are serialized. This allows to drop some
> locking that is now superfluous due to the core's locking.
> 
> [...]

Here is the summary with links:
  - [5/8] pwm: microchip-core: Drop driver local locking
    https://git.kernel.org/riscv/c/9470e7d11fe2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



