Return-Path: <linux-pwm+bounces-2529-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996B290D5D6
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C411C237CF
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF21159207;
	Tue, 18 Jun 2024 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uO7n9x0g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F1413A899;
	Tue, 18 Jun 2024 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721223; cv=none; b=hVlFV316ueF2EzNOGA5bKAk86JWjyyoBv8cI5DxKLFic/WtD4O6tla/k+WDKQGu8Cr/tYKjecPoS1vgMYYpA5RQ3f+pla87351Rqk1lHS3avWTLHgSbuFRhsq3I6FMG+3hWVUTWw30oasa1ia7VQq1aVisgOVM6e/m7gNVGNiFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721223; c=relaxed/simple;
	bh=tzWbw4BvxNiCK+3ZnGzIylZzOfkjpcbGq5j/2kPM9AY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+5RiyuKYwLaCqIvdSFN7SulWcXKApPfn04byHpDhIjGSNw02iKRTF5bPhPcNn6u9OStrJdyQGGXFi+K6dWaMNui6ExHNXW1xzoNFA2/L3Leyn0+U19cq1JBgWSdb9rnquG/HbWaHR608CuW6xPzpZGBcJeu6oRGfhQbh9PQ01E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uO7n9x0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53526C3277B;
	Tue, 18 Jun 2024 14:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718721222;
	bh=tzWbw4BvxNiCK+3ZnGzIylZzOfkjpcbGq5j/2kPM9AY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uO7n9x0g7aT8cCA2KEaBUwuVI+XS9v0l8dlQhVj/cj7XPwvNBjPqQbQZrafsjVHxQ
	 lu6K/HynzDDaQeuL1cSFaFQ4Pi/hLDgqS8QJYyIuUCBwXUMceTIsVC6kXOSQ4zfz+4
	 AvPsJKyZyGncRfYjB9OLoCheN8wNBYTVgXqcx4f0Y1lPzvFIvo3AuRHi8/bgweKANC
	 aYmtsUytKiFOHJe+QZTrUUlqvE2AcarrATOyBiqFYxmIJsyeJPCCSPDBoMcVksy8T4
	 x26eFo6wz6cUehmy5k6wA2QjU3sNbnqyGfaioRPn0qX3tGnc6xupSq6lsyZ1KopdBk
	 tmvnb9z/ncj3A==
Date: Tue, 18 Jun 2024 07:33:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikita Shubin via B4 Relay
 <devnull+nikita.shubin.maquefel.me@kernel.org>
Cc: nikita.shubin@maquefel.me, Arnd Bergmann <arnd@arndb.de>, Hartley
 Sweeten <hsweeten@visionengravers.com>, Alexander Sverdlin
 <alexander.sverdlin@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Lukasz Majewski <lukma@denx.de>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Thierry Reding
 <thierry.reding@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Damien Le Moal <dlemoal@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Ralf Baechle <ralf@linux-mips.org>, "Wu, Aaron"
 <Aaron.Wu@analog.com>, Lee Jones <lee@kernel.org>, Olof Johansson
 <olof@lixom.net>, Niklas Cassel <cassel@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
 netdev@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-ide@vger.kernel.org, linux-input@vger.kernel.org,
 linux-sound@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v10 00/38] ep93xx device tree conversion
Message-ID: <20240618073339.499a7fd2@kernel.org>
In-Reply-To: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 12:36:34 +0300 Nikita Shubin via B4 Relay wrote:
> The goal is to recieve ACKs for all patches in series to merge it via Arnd branch.

Why? The usual process is for every subsystem to accept the relevant
patches, and then they converge during the merge window.

