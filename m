Return-Path: <linux-pwm+bounces-3076-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFEF96A18F
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Sep 2024 17:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900F91C241B0
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Sep 2024 15:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D478416C6B7;
	Tue,  3 Sep 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRIRAocq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D562AE66;
	Tue,  3 Sep 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375935; cv=none; b=SPr48Ar8qGcAJ2osSLRE/80b3yMeqRAy63KZEQkQUbus4VRdpNgBChyId7cXhQi/q6S63IOfnmdI/kA8GZPWAl4k9upfD39YTEJ3Bxp32Ucwg0tFbGD7e0eYNDWd2HUryJI2IydmAMzkRr20AlB4eIywMNLpqsCMQr8bMLjtc18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375935; c=relaxed/simple;
	bh=KL0RQRwssSJZNsqC3FsLLADFxblDIjhPUl1YLEacyms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSUw611KMdZMvkfMvb3pvp36JfMYPeOZswvB5XLshWhb0D2rqHRR0m8pSmau/Uev+SyG54pocc4xSjiMNeRvQcoqyMOO7bH+XlAbhqoE7PRbQl08tgBUvfqaWZ8BonL+4BcG4Aww7G0coCvVeYbtU1T7AH5dP2aITHVkN7Ll1A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRIRAocq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E00C4CEC4;
	Tue,  3 Sep 2024 15:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725375935;
	bh=KL0RQRwssSJZNsqC3FsLLADFxblDIjhPUl1YLEacyms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRIRAocqMOoyi0rW8os/xYVVD6vNIkBzoAlQ6hS2tSqR1dB70Nr3njU0wCyg3zgwu
	 LacEso3uef9loUUnpQphxgtcE7qUvZSzFxL7C3t7jDK9reXbttX+aQ7Qz35fAggN0o
	 lkn8P30kt6mxExCkPfIH18o2hQZhMeslMjkRnbqR8pQsmFuB9RGfxWBbFN/O/EzPo8
	 6hw5ms6StC7SwGIY5PlV2myw4czbRwVcF3KNidbGniUstdvQJ458e83ikt7ISlZ3uL
	 Onbf/nglN5e3FjWS9Wl8N/NCX9+JzjhDjF3IRsS9zdcTZ+i35Mg31/jZ7zmq7UHmGQ
	 cgsEf0ky6UuxQ==
Date: Tue, 3 Sep 2024 10:05:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: devicetree@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-mediatek@lists.infradead.org,
	upstream@airoha.com, Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-gpio@vger.kernel.org, benjamin.larsson@genexis.eu,
	ansuelsmth@gmail.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/5] dt-bindings: arm: airoha: Add the chip-scu node
 for EN7581 SoC
Message-ID: <172537593271.1018147.17791430767383351676.robh@kernel.org>
References: <20240831-en7581-pinctrl-v3-0-98eebfb4da66@kernel.org>
 <20240831-en7581-pinctrl-v3-1-98eebfb4da66@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831-en7581-pinctrl-v3-1-98eebfb4da66@kernel.org>


On Sat, 31 Aug 2024 16:27:46 +0200, Lorenzo Bianconi wrote:
> This patch adds the chip-scu document bindings for EN7581 SoC.
> The airoha chip-scu block provides a configuration interface for clock,
> io-muxing and other functionalities used by multiple controllers (e.g.
> clock, pinctrl, ecc.) on EN7581 SoC.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/arm/airoha,en7581-chip-scu.yaml       | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


