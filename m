Return-Path: <linux-pwm+bounces-6446-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6E9AE08A7
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Jun 2025 16:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E1118913ED
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Jun 2025 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4422B21D3F6;
	Thu, 19 Jun 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9UurjIV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1578C21A43D;
	Thu, 19 Jun 2025 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750343026; cv=none; b=B6bSYocZ1uqLCSWD/N5JG0JMVypGmh30PEO7cAI1zy/aLM1BGie0NG1Uh2AdlUB16kSkhMGuy+z958/IcqdQO1SS6Axcb64wejMLO+yh5nBH/yJnd130GeHlQfHHBijwLZvjKl67fPMUUO258cw1S/OldvNebTOgGP65205XGz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750343026; c=relaxed/simple;
	bh=ujz4WdiT5pNH0VMHgde3DOK3OwOr/UQcYBIuD4DdIcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bu96UTpiWI3UNy664gDzzpyjjS076dIlP0iCkzMU94BD87UcXlSvhzP+E0NTq0QKZ9Ufcve6ZGOIlgu+mo3WaB5moVcjhyA1Tw/IYzhuQ/GE2T1vX6POGKLZg5LqxPAd2vOm4gWeXGNM+SjNQmTOW15tOKvwKEFoHwRdbwQytcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9UurjIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB6EC4CEEF;
	Thu, 19 Jun 2025 14:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750343025;
	bh=ujz4WdiT5pNH0VMHgde3DOK3OwOr/UQcYBIuD4DdIcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I9UurjIV3oCDBKjgvN4CJe0PdiPE52wjHbJMS1Bf9R9dcHfglSfDuUwOT67OqpzjW
	 iVrGdJnTOk7jiOJvujiRvT3ghUy3Yt8fnDt8gfCPB7KBpYcvhV00hwZ9IlXU6q4F04
	 mu1iMZgiOH/eCTMApsvUPJsGHXdZ660ZEcQTpDJM1PijCxnT4hZpCNUvl7upnCFucT
	 5w1qbpG26L4Ca1rDPHcVq8p/TYUE/jwD2GLib+yGbb1PHdThxcjD1MyLCUwMjlPY/I
	 3ZoBOSzK/pk0G4CUkB++fhD+mbH34iOB/beSfMa2BJv+J1QbsvQUUa9XEGF2qKeykF
	 shAw3VeTbWF0g==
Date: Thu, 19 Jun 2025 15:23:39 +0100
From: Lee Jones <lee@kernel.org>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Liu Ying <victor.liu@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 00/20] mfd: adp5585: support keymap events and drop
 legacy Input driver
Message-ID: <20250619142339.GF795775@google.com>
References: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>

On Sat, 14 Jun 2025, Nuno Sá via B4 Relay wrote:

> Hi all,
> 
> Here it goes v4. Main changes is to drop chip info based struct and
> directly use an enum in the FW .data pointer, use the notifier API for
> dispatching events and multiple calls to mfd_add_devices().
> 
> Regarding the last point, I think I could have used multiple calls to
> devm_mfd_add_devices() and avoid those gotos in adp5585_add_devices()
> but I do not feel that would have been "correct".
> 
> Thanks!
> - Nuno Sá
> 
> ---
> Changes in v5:
> - Patch 2:
>   * Use the existing devm_mfd_add_devices().
> - Patch 3:
>   * Remove TODO comment.
> - Patch 4:
>   * Mention in the commit message the Copyright update.
> - Patch 6:
>   * Return a struct regmap_config pointer in
>     adp5585_fill_regmap_config();
>   * Just leave a blank entry in the adp5585_regmap_defaults array.
> - Patch 13:
>   * Improve comments for pin6 (row5) validation;
>   * Don't use magic numbers;
>   * Drop some odd line breaks;
>   * Initialize vartiable when declaring.
> - Patch 14:
>   * Drop double spaces;
>   * Don't use magic numbers;
>   * Improve some comments.
> - Patch 16:
>   * Fix missing semicolon.
> - Patch 20:
>   * DS -> datasheet. 
> 
> - Link to v4: https://lore.kernel.org/r/20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com
> - Link to v3: https://lore.kernel.org/r/20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com
> - Link to v2: https://lore.kernel.org/r/20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com
> - Link to v1: https://lore.kernel.org/r/20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com

Okay, that's it from me.

Please respin those nits, then you should be good to go.

-- 
Lee Jones [李琼斯]

