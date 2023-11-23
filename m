Return-Path: <linux-pwm+bounces-174-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064E57F6318
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 16:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A611C20B9E
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661CC2575A;
	Thu, 23 Nov 2023 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a11qGamB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DD322321;
	Thu, 23 Nov 2023 15:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CD4C433C7;
	Thu, 23 Nov 2023 15:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700753841;
	bh=ZdbFZ4KQ/gf4hgFpP8k5jG7CXEuPsV2YJfYQ0vTmdN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=a11qGamB38fsqxGOS7OuJ6lF776gt/BNyw5ful4ALHlC1dZQRGR9FBgmWDIwLJLxr
	 JbrvzdNMzZ57L2cE5WFSPe2moFLUPodUhhKQw5knlJboJqEvbg9d6efy7vQK0Jap0A
	 5gj6XNRBQvuoFMbn7YXuYcKiMA04ao9bLp3oHB1PHO8CauNDi3OHXQImFF/UraDy3s
	 gDFBLR0J4LLvH1qPfIrMf1hyPXCa6OJc24dyCvWOLlBIvoP1aP+yrx7D3ZzYdQIErt
	 yA0QONYPVSO1vLS1LgXd+PEN7uC8t8M0G4xJjhBMbUOlUrszdqqtoQzOCAFwzHneaV
	 9fex0165dtM2Q==
From: Lee Jones <lee@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Lee Jones <lee@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org
In-Reply-To: <20231117120625.2398417-1-alexander.stein@ew.tq-group.com>
References: <20231117120625.2398417-1-alexander.stein@ew.tq-group.com>
Subject: Re: (subset) [PATCH v3 1/1] backlight: pwm_bl: Use dev_err_probe
Message-Id: <170075383967.1388394.6437408799524247071.b4-ty@kernel.org>
Date: Thu, 23 Nov 2023 15:37:19 +0000
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Fri, 17 Nov 2023 13:06:25 +0100, Alexander Stein wrote:
> Use dev_err_probe to simplify error paths. Also let dev_err_probe handle
> the -EPROBE_DEFER case and add an entry to
> /sys/kernel/debug/devices_deferred when deferred.
> 
> 

Applied, thanks!

[1/1] backlight: pwm_bl: Use dev_err_probe
      commit: 58793f263abc8e5233fabf7466219202db09d048

--
Lee Jones [李琼斯]


