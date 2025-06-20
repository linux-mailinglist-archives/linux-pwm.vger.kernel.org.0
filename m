Return-Path: <linux-pwm+bounces-6453-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C67AE109F
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jun 2025 03:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E557AC235
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jun 2025 01:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B9F2D613;
	Fri, 20 Jun 2025 01:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRkyWuXd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096192F2E;
	Fri, 20 Jun 2025 01:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382099; cv=none; b=Ph9V6CPUE3UXNI8YDvkMrXKADf0/C6eRwnm6P9Fhd5pLXWRyXYNKnyKS3Pme9JkDvLOLZrg3Wxw1Ify3pLqVOP9M/oTLjyNDvcYUhYVC3H9XbiXbflk+Ei8+HFpWAVy6CNE3eTRMk2RryudP7HK9YtRgnxjFgTGzeqbVxNEFXiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382099; c=relaxed/simple;
	bh=G4ujzP/dPw7+GoetK5wz/3x0jwN+CZkcpzODpFK1ZvE=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=Lm/yqAzbPHNGte8eu5tHe3lt6hgMTKsbPq7HcrKDyN8q/ZLN01v3etsMOoGFgiDwvH0DkY5fjOGx5c/QTq//irTN1i27tKQm0yh8AZHUFo6S8ESsm64jU6sjMZQJZ288nHzv/Y/Sjrc8Zn4ZaqtU2xhGh2j9OPd3RLynHx/p5Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRkyWuXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E12C4CEEA;
	Fri, 20 Jun 2025 01:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750382098;
	bh=G4ujzP/dPw7+GoetK5wz/3x0jwN+CZkcpzODpFK1ZvE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=mRkyWuXdzuD3esnLRNmMEQQrfrLuwcxVpRqfOdt1JSPNlExetVoxnUXoPVoHH93tD
	 BXn1qR6HuohhRd2ytqlGzFg1sUeNYfunlwREvHcZ4svOeSFkNd30wRiFYUG+nBF0E9
	 7hT4M4GC9/hBSZ+3FnfohF9d4kuGbDBRx1L36ZCGo6SVdFTeygTwl70r5qlzbqswIk
	 i29x4xMOYtybeew/9+S/UGm6A9NAsIOjg1wNqcQYY9sUDSJ4cXvxYJ8YEQqU5aSujV
	 qFO+WTsANVhv/Y1GmfC9NzbkBaeYkZxu45mN7t2yCGH6K0OY6FECBECdZqWBgcVnu+
	 4rWYhEekUGMoA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d2f748101194409fb410711380ea52ed33260644.1746006578.git.ukleinek@baylibre.com>
References: <cover.1746006578.git.ukleinek@baylibre.com> <d2f748101194409fb410711380ea52ed33260644.1746006578.git.ukleinek@baylibre.com>
Subject: Re: [PATCH 4/4] clk: pwm: Make use of non-sleeping PWMs
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Date: Thu, 19 Jun 2025 18:14:56 -0700
Message-ID: <175038209643.4372.10708532167477002743@lazor>
User-Agent: alot/0.11

Quoting Uwe Kleine-K=C3=B6nig (2025-04-30 02:57:49)
> For some PWMs applying a configuration doesn't sleep. For these enabling
> and disabling can be done in the clk callbacks .enable() and .disable()
> instead of .prepare() and .unprepare().
>=20
> Do that to possibly reduce the time the PWM is enabled and so save some
> energy.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

Applied to clk-next

