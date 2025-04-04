Return-Path: <linux-pwm+bounces-5329-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D668A7B808
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Apr 2025 08:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53673176C13
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Apr 2025 06:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A21F1714C0;
	Fri,  4 Apr 2025 06:58:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F12944E
	for <linux-pwm@vger.kernel.org>; Fri,  4 Apr 2025 06:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743749932; cv=none; b=JjWBqsnx4T5sXrXTP5trk6bRJdta/1cUxutqYZtW0x9lfUrK8QQlZlP/7ewYM8kaimnzFV9EDqKF1Ur8QUvoldU4sKFj0BEkr2hYqU5Njw2jHcBlK9Sm9dOVHcF8wTbqaIvHqpgUau2oBkM/r4Y4WvC/lVXzIubs7QmcOGYS2O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743749932; c=relaxed/simple;
	bh=9tOxa/rZ7YVt3BebjNRvp+ToVpSFOJukuIcC/d3KCJk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YhHDTKBAqNjEPICp/oTL+biNlwr/vcxwHDrdVR2VjbdX99zh9qeC6MSd6X/sOBkg0my2oET6eRo/7b7LIflFzhSYbJHQNsA1SkZ9/OlxkXa2XRuNasPJATKj7GKFlTD/QTVKvILAPlLwobIZds2YP0Cea1VkCgo5LJ0xWcCwH0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4ZTTj45z57z4wwd0
	for <linux-pwm@vger.kernel.org>; Fri, 04 Apr 2025 08:48:56 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:feab:4a0f:f647:d53a])
	by andre.telenet-ops.be with cmsmtp
	id Yuoo2E00147k7R301uoo1e; Fri, 04 Apr 2025 08:48:48 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1u0ar9-0000000H3ZV-3yEI;
	Fri, 04 Apr 2025 08:48:47 +0200
Date: Fri, 4 Apr 2025 08:48:47 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
    Simon Horman <horms+renesas@verge.net.au>, 
    Thierry Reding <thierry.reding@gmail.com>, Ingo Molnar <mingo@kernel.org>, 
    linux-pwm@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH 2/3] pwm: rcar: Improve register calculation
In-Reply-To: <ab3dac794b2216cc1cc56d65c93dd164f8bd461b.1743501688.git.u.kleine-koenig@baylibre.com>
Message-ID: <f8d83f02-4a9b-22d4-bfbd-4949f2010007@linux-m68k.org>
References: <cover.1743501688.git.u.kleine-koenig@baylibre.com> <ab3dac794b2216cc1cc56d65c93dd164f8bd461b.1743501688.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-281601639-1743749327=:4065284"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-281601639-1743749327=:4065284
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 1 Apr 2025, Uwe Kleine-König wrote:
> There were several issues in the function rcar_pwm_set_counter():
>
> - The u64 values period_ns and duty_ns were cast to int on function
>   call which might loose bits on 32 bit architectures.
>   Fix: Make parameters to rcar_pwm_set_counter() u64
> - The algorithm divided by the result of a division which looses
>   precision.
>   Fix: Make use of mul_u64_u64_div_u64()
> - The calculated values were just masked to fit the respective register
>   fields which again might loose bits.
>   Fix: Explicitly check for overlow
>
> Implement the respective fixes.
>
> Fixes: ed6c1476bf7f ("pwm: Add support for R-Car PWM Timer")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

This is now commit b41a4921d409c909 ("pwm: rcar: Improve register
calculation"), and has the missing include.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
--8323329-281601639-1743749327=:4065284--

