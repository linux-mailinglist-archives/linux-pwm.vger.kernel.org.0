Return-Path: <linux-pwm+bounces-4763-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 835EEA26387
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Feb 2025 20:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20153A32B4
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Feb 2025 19:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E9A2116E6;
	Mon,  3 Feb 2025 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IA6wl1kD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4714021149C;
	Mon,  3 Feb 2025 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610130; cv=none; b=EoYiQJLFOfMsWMt6lAtE0lNZmwwqdduFKrHa0ii2P9R1TBCvmlFM+uueaSZl1MVScydm1bITPs7QS32h92wVtRh0E1IbykdA22RPktyxA2Vot6jrSBymfPWqIJUls58xSG/whvY5orbgFCDh+hY1YxhTkF+pY9UEI2U19w8qBZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610130; c=relaxed/simple;
	bh=DNa/v4L4GNkBFQVY6p5fPmrvgQMyAR2FediJooOHzq8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bUl9smtCwnSYg3EJTRqeVblSVJsGo3cm0NxvUhrUa7Dni7KABTM0M3HI9ABOp6ZKlr8A+RmtHhwy31pdklyld3dJ2p4t21dey86NOFDiiq2yyToaL3uY78BC+ApbGF6Go0iu59OiAIkf7kXbz7XFwhPJQJUYZTgFs+AViLkA9qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IA6wl1kD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268D0C4CED2;
	Mon,  3 Feb 2025 19:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738610130;
	bh=DNa/v4L4GNkBFQVY6p5fPmrvgQMyAR2FediJooOHzq8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IA6wl1kD76UaA590vQjC8DR1CxUfDIk/wXotpFrZMhwfiIHpu4XETt1RNAgo7S9qZ
	 lVLQOJu21i2CVWA+BqV0mnF3y6EV4mcsaOXCBha9CcL1XG/sHlsZ16oVfZBay9LSd+
	 /4OSY7xiAEnSp67jxsmUGmOrjJ0w8RSvjaM++jzAVVNNugicDQOaAETQwJUwdOiEgB
	 RvrmH3rdOg0RTni1PpklIpJf0ELAlaoq0FWqNmKj7SQkQILXjTqQ9Ry5BbiYHkS+Id
	 yISPT3zKVcUp+/9ptx3WeWzRv3ZMnhjZ7YRZvtXWgG5tFSP9F8P3+iFerrAmNCzchK
	 vEsIxFrxEdW2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D61380AA67;
	Mon,  3 Feb 2025 19:15:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] pwm: microchip-core: fix incorrect comparison with max
 period
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173861015701.3409359.18144530519616995351.git-patchwork-notify@kernel.org>
Date: Mon, 03 Feb 2025 19:15:57 +0000
References: <20250122-pastor-fancied-0b993da2d2d2@spud>
In-Reply-To: <20250122-pastor-fancied-0b993da2d2d2@spud>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
 conor.dooley@microchip.com, stable@vger.kernel.org,
 daire.mcnamara@microchip.com, ukleinek@kernel.org, thierry.reding@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Uwe Kleine-König <ukleinek@kernel.org>:

On Wed, 22 Jan 2025 14:42:56 +0000 you wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> In mchp_core_pwm_apply_locked(), if hw_period_steps is equal to its max,
> an error is reported and .apply fails. The max value is actually a
> permitted value however, and so this check can fail where multiple
> channels are enabled.
> 
> [...]

Here is the summary with links:
  - [v1] pwm: microchip-core: fix incorrect comparison with max period
    https://git.kernel.org/riscv/c/752b6e3af374

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



