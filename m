Return-Path: <linux-pwm+bounces-1998-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8C78A8B4F
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Apr 2024 20:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27296284F33
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Apr 2024 18:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A28111A8;
	Wed, 17 Apr 2024 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8/NxFmk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B7B79FE;
	Wed, 17 Apr 2024 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379399; cv=none; b=Hxt/r99feVe56WmptPiQPIAXmNQqnS1Z4oluYeXjcJPBNob0DDmAZy1PI/nPj1m/8Ft2X4UGV0J/l3qv7oGabcJ2YZ25qQw5/A2bL5baEc7Agzg0fsQfTTBwE2bZS99rWA+zsDMwreG4x7M+z6S9HLcc1TBr8y7Kb60agqgOlWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379399; c=relaxed/simple;
	bh=BrDXZHypVyb/MCOt1pJ3+elBTZD7Vim7YCL5kPx7fs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfvoNLNcWyjIiRdrENEKtfaW49PgzDBPORSjtA2frP70thtT9mgkTbHLkASl5z+VGP7koAW1071E+5rLjkgXWTQO0zwKwMImObzExQkG7Ltf7n6h+zdQiJAFuDBD7/2PwhmNHI1JLWPbpecnG5bkUOM1Y2JIXy5ZMZsM8tNvQSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8/NxFmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8CAC072AA;
	Wed, 17 Apr 2024 18:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713379399;
	bh=BrDXZHypVyb/MCOt1pJ3+elBTZD7Vim7YCL5kPx7fs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K8/NxFmkBzWm5APksMAcm8tYKwsLxDs125DaMHv/oVlIdccPmnUOv09IG7QjpSj4V
	 /7ZX2Q/6oxwM6Dw4COABbrfUMcsdjepBiu4ak1tbrPobJdCYUdvGY88zxOZIZDcJd8
	 jMCFKwTsLs02QVFKSrrApLO/X3IoxFHdhr9N+CEaUF6jUfu5bM9JhbnQr9l/y308Cf
	 4xa6GowlumK45jro3+seYpBVRhdeA5/9xqb0kVOGQ1LMgIcC4IYA5zocdJfNU91om2
	 lV6wzpJAvSpy9uwbEFczgBllP8q8eqSLpLmU9+pKGCq/xhee2/UcCQk6OCTwyYBlAw
	 o2SbgzLB9hh/Q==
Date: Wed, 17 Apr 2024 13:43:17 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Thomas Zimmermann <tzimmermann@suse.de>, linux-pwm@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Daniel Vetter <daniel@ffwll.ch>, Jitao Shi <jitao.shi@mediatek.com>,
	Maxime Ripard <mripard@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-mediatek@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	CK Hu <ck.hu@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	David Airlie <airlied@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/18] dt-bindings: display: mediatek: ccorr: add
 compatible for MT8365 SoC
Message-ID: <171337927792.3071773.4101646503948439735.robh@kernel.org>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-2-33ce8864b227@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-display-support-v2-2-33ce8864b227@baylibre.com>


On Tue, 16 Apr 2024 17:53:03 +0200, Alexandre Mergnat wrote:
> Document the display Color Correction on MT8365, which is compatible
> with that of the MT8183.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


