Return-Path: <linux-pwm+bounces-7236-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AA5B3FCA3
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Sep 2025 12:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24F0188EA7F
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Sep 2025 10:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A257A2ECD1B;
	Tue,  2 Sep 2025 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ge/vBJEE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACE828466E;
	Tue,  2 Sep 2025 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809329; cv=none; b=c/J/jRG3xhBv4j3tNL3pIPbcRJpOeBTkPC7dBnZ7cEBcF62o9bTGdy44vaeEO1ar1jaRwTEXnuZlgAGH+IkHrZWXqmcWK/pYlF4SFeCDC5SLbu+1jpVk+pLSULwuARVIA6ybOQFOXKCSWc8ODBGBBJw8JGBkmyzibAhPRY369Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809329; c=relaxed/simple;
	bh=ewTMDBnFC3Bj3uUkfd7Vs2zp5IWf3pYNW449G/NTT+s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qG+OkaTQKIXgO4IlR+uWBH6NA/xgjBfipdSaXMslExnnluPcnkdNyUeqD3aMnBNxd0S4rR2V7cUaI9nQYi3eYPU9vOLEZb3SvZw6k22u0rqEtuSPLKIMkpeoqZyvtsru68hr56OlisyBl/Oi5fo1zENDxvGp6SiZ2OKQiHphvW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ge/vBJEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE59C4CEED;
	Tue,  2 Sep 2025 10:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756809329;
	bh=ewTMDBnFC3Bj3uUkfd7Vs2zp5IWf3pYNW449G/NTT+s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ge/vBJEEPNDmVdpjuuNKQbpn8yfW511J/UMo4xnzwKEEoZ7YkUloyr8yldklUkTii
	 lUb4V+WAZZSvguadgxqX2XOcoaips7vi8DMZCCFZ9jJV9B3QW+X/YnpEE/cqxQx6Yt
	 egRzqn3PaR6nAHUVjUdqQRcsHSD+0oVlm3p2/gsUUYkLdN8ePtV5YkGTCYblYtM5BL
	 9pb3ML3Wn+QFkcZtqOepe6BdYrO2D7d6GiHT653/tPZx1oF30Cnh0ISQOYeuvQSaKI
	 YMDslAlmEWThzqbnJvKxYzzMal/HtO4TBKUBZr4uaGbeBtsQ9eT5BtIEiP6Hh+bH4I
	 UvnpmDgaHJapA==
From: Lee Jones <lee@kernel.org>
To: Flavio Suligoi <f.suligoi@asem.it>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-pwm@vger.kernel.org
In-Reply-To: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
References: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH 0/2] backlight: mp3309c: Drop pwm_apply_args()
Message-Id: <175680932706.2261091.9987211835426797993.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 11:35:27 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Tue, 01 Jul 2025 11:22:35 +0200, Uwe Kleine-König wrote:
> the first patch of this series is what I really care about: There are
> hardly any drivers left that use pwm_apply_args(). When all of them are
> converted to not use it any more, I intend to drop that function.
> 
> The 2nd patch is just a change that I noticed while editing the driver
> that is IMHO nice. If you don't agree and only apply the first patch, I
> won't argue. It's an alternative approach to what Daniel Thompson did in
> commit 7ee6478d5aa9 ("backlight: mp3309c: Fully initialize
> backlight_properties during probe").
> 
> [...]

Applied, thanks!

[1/2] backlight: mp3309c: Drop pwm_apply_args()
      commit: d22caa15de3a11b503157aec079cad4bf305ff47
[2/2] backlight: mp3309c: Initialize backlight properties without memset
      commit: 71ca0594c11b4030c6dece9ba9b080d652a82473

--
Lee Jones [李琼斯]


