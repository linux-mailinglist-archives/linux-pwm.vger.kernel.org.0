Return-Path: <linux-pwm+bounces-1181-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100258470FD
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Feb 2024 14:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0832870CB
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Feb 2024 13:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838AD45C14;
	Fri,  2 Feb 2024 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gadgetoid.com header.i=@gadgetoid.com header.b="k5uByrvI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B574232C88
	for <linux-pwm@vger.kernel.org>; Fri,  2 Feb 2024 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879994; cv=none; b=MY3P4EP6zMRU9aeASlNNIFl6z6JX/TgIF3DlEfNtS1yz8knjPYfw4t4wu8rXQHs+w0dn0TaJL1ErloEEZ3uePZbR9BYc3/Yf7figLlN6b9ywhew17hRjFGSieeNJW2u/dyWAe/4QYvV4fph7lpA8O/Th6ISh5JrH0nay05jScZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879994; c=relaxed/simple;
	bh=QzU2+6bJBCYf8775kUvnTYfKeQz7MvZNZSUSH6prFBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZuP2k5+pVPxL1mDPAurxVbzzunH2lteBqDoe4ByB0P2pydGi5AeY6E9qD3TXCAtESZFyRc4xV09OWfYPgOqhNWcTRZO3oYp2YqZTeoM9Ifz9odDhQ7kKpvDFWKWXqQ8EnKfbdXapOxBwGsKwzK/yBRf/RorIWcxkz0A5ja+LE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gadgetoid.com; spf=pass smtp.mailfrom=gadgetoid.com; dkim=pass (2048-bit key) header.d=gadgetoid.com header.i=@gadgetoid.com header.b=k5uByrvI; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gadgetoid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gadgetoid.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-21433afcc53so1237269fac.3
        for <linux-pwm@vger.kernel.org>; Fri, 02 Feb 2024 05:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gadgetoid.com; s=google; t=1706879992; x=1707484792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eQf5PfHC5tQoN+jcMOZd64SAvn2hq+16QHj88c38TUc=;
        b=k5uByrvI8QoFvcxH64ek8vvsU9vApiMOPFPtTrK1MZz98nT1wS1O68LtQvQNJX+MYG
         g3SWz3GbPKrslPfRNkQVEL2yVzhw3fKzDRVpFGs1lQ21MmoGNr7vQh6KP4DWCNniL7AK
         88jMHPI4c+cnz+hAr1Z8awlu8lA+Deww9HywAYq4zXmRf3FL12eX7f2C8SI1UkMTuKdG
         Y+M0Z0tSp4Vgxq+FyezXQljtALPvbUHBmynY+a78LGO3C1MKF2wfcj0gmh76AGFll4ng
         xaZFl4hpLvum3CZi8zoOXGvD7LKAyiunK5CRLr5iRnRPvXw0LPc9LD6GGktGHiTuL5qj
         N0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706879992; x=1707484792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQf5PfHC5tQoN+jcMOZd64SAvn2hq+16QHj88c38TUc=;
        b=gWfH0Dj2t8cyt4mie6AzjSYbSLdX6Fvifk+J1spy0e5YfNY0MzWTHk1Lb9hIDaKTl9
         coWTO6T936/HVVG82BV4EuWfii9pEBUC0bCsPEIw3uRO1M6+yL3c9mkqreUiomCbkY1F
         xDagLiw36/X/DMFe2VMsLLtKxtvRt/usNEXVBWMlifjPZM6rbRCkJpv0tM0Gxc8HKBzi
         sibpFabzALCxpGgEwxYzxKQaohi4LcJENQLlTV5IpWSLZN3Gzb02C8Rgt1o07inzVKha
         E/7NGTCPZSEUTNxMQcoppnmak+jgHzEvgbVpCHfNCU9Pcci8gpVb+qVHWkq7t79mduVQ
         5iqg==
X-Gm-Message-State: AOJu0YxdWKDqKkqP18dFD+8Sq0NHVm89o6lAhbXkBiKCVqT6r1UNXo+e
	1vPBUHOuxs92T24BfERpOV5VnLi2allWmvVMoEY+uA18KoPp/TDxYcUgjDCvzpZAy7cyXHh4vxk
	ZomL9DpipRBv/bwRmWrf5W/ca8X0y/xtFruTwhk5Brq4YLlbLMWb/OA==
X-Google-Smtp-Source: AGHT+IGj71Z6qTMXGLYc4dHSH4zFF7fZQYjeArgxrtyh7tp+4FcyBUw5qhhSYcLNsE1HzllPHBbZkh217Ks170E8QOI=
X-Received: by 2002:a05:6870:1684:b0:218:4626:93cc with SMTP id
 j4-20020a056870168400b00218462693ccmr1980169oae.34.1706879991771; Fri, 02 Feb
 2024 05:19:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240128163630.104725-1-wahrenst@gmx.net>
In-Reply-To: <20240128163630.104725-1-wahrenst@gmx.net>
From: Phil Howard <phil@gadgetoid.com>
Date: Fri, 2 Feb 2024 13:19:40 +0000
Message-ID: <CA+kSVo88y7n9dyo57fgjybC9=1b_dgTPA3u-_kUH9X_79HF4tA@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] pwm: Add GPIO PWM driver
To: Stefan Wahren <wahrenst@gmx.net>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	andy.shevchenko@gmail.com, Angelo Compagnucci <angelo.compagnucci@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 16:37, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> Add a software PWM which toggles a GPIO from a high-resolution timer.
>
> Recent discussions in the Raspberry Pi community revealt that a lot
> of users still use MMIO userspace tools for GPIO access. One argument
> for this approach is the lack of a GPIO PWM kernel driver. So this
> series tries to fill this gap.

*Thank you* for picking this up. I've been stuck down by covid but am aiming
to build and test this on a Pi 5 (with a gpio chip over PCIe) to see if it runs-
though I am fully expecting a PIO solution (using the Pi 5s RP1) to handle
PWM in this case, and hope to rely upon this gpio-pwm module for previous
iterations.

>
> This continues the work of Vincent Whitchurch [1], which is easier
> to read and more consequent by rejecting sleeping GPIOs than Nicola's
> approach [2].
>
> The work has been tested on a Raspberry Pi 3 B+ and a cheap logic
> analyzer.
>
> V3:
>  - rebase on top of v6.8-pwm-next
>  - cherry-pick improvements from Nicola's series
>  - try to address Uwe's, Linus' and Andy's comments
>  - try to avoid GPIO glitches during probe
>  - fix pwm_gpio_remove()
>  - some code clean up's and comments
>
> V2:
>  - Rename gpio to gpios in binding
>  - Calculate next expiry from expected current expiry rather than "now"
>  - Only change configuration after current period ends
>  - Implement get_state()
>  - Add error message for probe failures
>  - Stop PWM before unregister
>
> [1] - https://lore.kernel.org/all/20200915135445.al75xmjxudj2rgcp@axis.com/T/
> [2] - https://lore.kernel.org/all/20201205214353.xapax46tt5snzd2v@einstein.dilieto.eu/
>
> Nicola Di Lieto (1):
>   dt-bindings: pwm: Add pwm-gpio
>
> Vincent Whitchurch (1):
>   pwm: Add GPIO PWM driver
>
>  .../devicetree/bindings/pwm/pwm-gpio.yaml     |  42 ++++
>  drivers/pwm/Kconfig                           |  11 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-gpio.c                        | 221 ++++++++++++++++++
>  4 files changed, 275 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
>  create mode 100644 drivers/pwm/pwm-gpio.c
>
> --
> 2.34.1
>

