Return-Path: <linux-pwm+bounces-7598-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A7CC3CA8B
	for <lists+linux-pwm@lfdr.de>; Thu, 06 Nov 2025 17:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7A01894B42
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Nov 2025 16:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269B0339717;
	Thu,  6 Nov 2025 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQiUFSZO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB80D2E7F2C;
	Thu,  6 Nov 2025 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448353; cv=none; b=uOXquqRPCGwgmzNgKNZiYVtMGeQGYEtdHBChIpLhObI+vOJ8ps3mZJ7ASOymRpoLlBhUpzDWwmz0QYi7I6mLhChdvJb0ZhsZ6sQFMXsiSbgb/UnLHXoXf7ChJTCERlmpx0DIe5yLIyzdL/I5bRjgm5Uw9LGaEKGlXgZS+DT7GDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448353; c=relaxed/simple;
	bh=snXPP2sPZlmwx9IoETc7vmai7mDjCry6M8ACC/gwYNI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XdQbnrToNzbDYDo+WAo81tsABlyA9bpjgWbN1KvNOGpfxCGjVKi4Af3yBeBCiDI1e3T25n4Nii3kUGG+gXcndnEvoJl3BHS3BOLkG9PV6/IkPWSvK2F4eUs54UVaLgeTHL6uxhWId4XMoN/UUf1uclvwnOYsDCzapQa4m//BTZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQiUFSZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DA6C116C6;
	Thu,  6 Nov 2025 16:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762448352;
	bh=snXPP2sPZlmwx9IoETc7vmai7mDjCry6M8ACC/gwYNI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RQiUFSZO7/QYncXJmZBRx8p0ksrpFY9UIbQeVlQC51Vea6u2Z6tiP4bxPv7CPT9Jw
	 4jFx3C1xwNnfOoaWobWvvu3bNHIzzdIBefPkAgLg/lc6z5MLZ4huiiK1ozZO1/r0Ce
	 Rl+NanvmpPu2eNPtLh+p8+HRbAWJ9MRlKz9rTYptV9vpnfwztVmxBsQxq5WNFEwEBZ
	 dc9tVrfNnh3jFKmFLyNYje3sZrNpPtKf480rykGJ2DBlBQKTC7wyiGldPmrbD4G3T3
	 27nTDDSbhrH1qttQJ3Mf/xHGQv5xyufINHRjqsZrGFem6x2EBtJXXuAd3qZ5/8Xbr9
	 TIwh4Irf+32vA==
From: Lee Jones <lee@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Pengutronix <kernel@pengutronix.de>, linux-pwm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250731-blpwm-v1-1-0171fd31bff9@pengutronix.de>
References: <20250731-blpwm-v1-1-0171fd31bff9@pengutronix.de>
Subject: Re: (subset) [PATCH] backlight: pwm_bl: apply the initial
 backlight state with sane defaults
Message-Id: <176244834994.1961871.13787969990090168625.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 16:59:09 +0000
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Thu, 31 Jul 2025 10:47:18 +0200, Michael Grzeschik wrote:
> Currently when calling pwm_apply_might_sleep in the probe routine
> the pwm will be configured with an not fully defined state.
> 
> The duty_cycle is not yet set in that moment. There is a final
> backlight_update_status call that will have a properly setup state.
> However this change in the backlight can create a short flicker if the
> backlight was already preinitialised.
> 
> [...]

Applied, thanks!

[1/1] backlight: pwm_bl: apply the initial backlight state with sane defaults
      commit: c596a53cb0c607ccff34aac30ada774aa28b7dc0

--
Lee Jones [李琼斯]


