Return-Path: <linux-pwm+bounces-5977-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A01AAB6601
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 10:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAD6B7B5A74
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 08:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699B622170A;
	Wed, 14 May 2025 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnS+CFTX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356F521E0BD;
	Wed, 14 May 2025 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747211161; cv=none; b=XWBHTXunR1UKcr/5qjSvaC/0YcW6slb2g7UHsijB8ftnroPSyYhEVqyUR6ASBAO54zcI+sYgX/gYtYvWqlyYj91eqHdorouK7pKX26+qk2WrSx3j2sgMnBa7AMPtcnd+1PIjx8x6eQWG60pITSnet9S29ydCi3M3Iqy4rgZsvDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747211161; c=relaxed/simple;
	bh=EQlzhgK8hYT+vlKLW5TJxTbodWSCb22tA9s2LNb3ffQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QErHPNooPCO5ckC0c6AgJxbChyKz4ngrwb3zMnGStTNNjPm6LAQpG6VkSjRzs088pCntjSxFBJoAC+/XbnVn1NPykxjTeRYuWMGZO1bQFb0MvSuq2aybsdKgJHZki9JQKJgbe4UM8Xyih9VlZ21Mh7gY75kxCzhKshDu50yo1a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnS+CFTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84094C4CEE9;
	Wed, 14 May 2025 08:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747211160;
	bh=EQlzhgK8hYT+vlKLW5TJxTbodWSCb22tA9s2LNb3ffQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BnS+CFTXcJXpm4tPPGgnhaaB6YgFzpNZ/mS6Bp9Lr9Qk9lVQuxAakxWZCMYQApL2J
	 pnBUHS69xG3KTj+caAZXFGU7PkFSwCRx+jX/oAhrEdlAK0Cs2uJMTWxEZeBGlR35o+
	 ty36NBSL68aFHLnhP1Yjdcx4wmBzEr39mR4icO1+f/rtzXsIdUp90ztyFiz0EE/bZL
	 Bn3R5ZEzmv6thYasOGsYdSK2mLkZpyqBVtg0EY706q9gK4ZUzuZUhGJ2p51Zs1+kGW
	 Y6cIPuZVmtklvUbVi8OyGGeGrE73TNjMenbmDlU8RPh37IJcsUTctiN9UpkSoFp8wB
	 6+F8GG1aQk6lQ==
Date: Wed, 14 May 2025 09:25:54 +0100
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
Subject: Re: [PATCH v3 00/22] mfd: adp5585: support keymap events and drop
 legacy Input driver
Message-ID: <20250514082554.GY2936510@google.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>

On Mon, 12 May 2025, Nuno Sá via B4 Relay wrote:

> Hi all,
> 
> Here it goes v3. There was some major refactoring in this version due to
> Lee's and Laurent's feedback. There are some splits (and some explicit
> requests) resulting in new patches being added. The biggest change is the
> effort in trying to minimize the usage of specific child device bits in
> the top level device (mainly stuff related to the keymap). I think now
> it's fairly self contained and the only thing that we really need to
> handle in the top device are the unlock and reset events as those can be
> supported through both the input and gpio devices (via gpio_keys). This
> results in a bit of more runtime complexity but well, that's life...
> 
> Another change is Lee's suggestion of making use of templates (for
> regmap and chip specific data) and fill things up at probe.
> 
> I also refactored a bit the event handling so it's more generic now.
> There were lot's of changes so odds are that I might have forgotten some
> feedback and so, my apologies in advance :).
> 
> I also dropped the tags in:
> 
> patch 16/22 ("gpio: adp5585: support gpi events") as it has some
> significant changes (replacing .init_valid_masks() with .request() and
> .free())

Please run this set through checkpatch.pl before submitting again.

Not sure if we've discussed this, but W=1 wouldn't hurt either.

-- 
Lee Jones [李琼斯]

