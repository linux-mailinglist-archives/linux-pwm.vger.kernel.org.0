Return-Path: <linux-pwm+bounces-3043-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9574B9571C5
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2024 19:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463801F20F2F
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2024 17:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDCD186E2E;
	Mon, 19 Aug 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvt+CIbR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39E186E25;
	Mon, 19 Aug 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087627; cv=none; b=WxXSDQ9bdXso/2U3pq7z9D0rKxYKjN4WBlpT/ybMOi3kywjruVqbA2rgFfSMgyL2ebshnMsx7zIAW8uL49L6vump+fL5jm71zLnBStpx0z9C64miBeVUB2eVDsbaKSuezFAiVjFOGANclbGUT3arBB7Y+m5aLunlAClYmStTiZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087627; c=relaxed/simple;
	bh=napo6BfmJMdbvolQhaKJC1m2XKrao4NNuQMOueQKJe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwnPewlNe2CBWB23fX0EP5eUqaASoUzm2Iy1A7F3MDIH5ceAkT7Z/7fEtBov+FvyVD/ggrOp/HcOy3cAceISVuzrIr01bDpz3tLgdiBtOYTwSkDur/5X28YaF/FPuRp3zvsEBVUIFNKyYmwi8nZTZyXEc4m9dULU5JgnjR0G/Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvt+CIbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29D7C32782;
	Mon, 19 Aug 2024 17:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724087627;
	bh=napo6BfmJMdbvolQhaKJC1m2XKrao4NNuQMOueQKJe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvt+CIbRuYPq99FdwovQL657EePeIzf8voBnDOoTLjjjkhlfdocfplR85n4D0q+GI
	 dFflu2mcRON3EvaIHUAhC/KDN/EB9hgdk+scHJypVy4ht8lJRpnWUWk5FAXfARhw7q
	 I5kNFRNpys6uFY0ZavKWqSy2mA8KNgN1xlU+jJIav08SbSJdCZgVKG/IY/ZfwJAFZF
	 dM3sRjtk/oSWI+pYnEgRCGRfQ9EdBcIUxGh0wJEV81Q/mIK2lFKkW50O/sKtBsZ4EO
	 9lNBzgdJw6ZibdiAfeejK4j8KZ2H1r5F/TFjUz6Kg6m1iCio5RTdV2Sm22cnKM6KYs
	 zsD9+3wBIKYLg==
Date: Mon, 19 Aug 2024 11:13:44 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: allwinner,sun4i-a10-pwm: add top-level
 constraints
Message-ID: <172408762413.1696811.7492411750766259030.robh@kernel.org>
References: <20240818172828.121728-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818172828.121728-1-krzysztof.kozlowski@linaro.org>


On Sun, 18 Aug 2024 19:28:28 +0200, Krzysztof Kozlowski wrote:
> Properties with variable number of items per each device are expected to
> have widest constraints in top-level "properties:" block and further
> customized (narrowed) in "if:then:".  Add missing top-level constraints
> for clock-names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


