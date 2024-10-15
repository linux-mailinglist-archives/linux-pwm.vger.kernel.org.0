Return-Path: <linux-pwm+bounces-3659-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5376B99F79D
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 21:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4A91F21ADD
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 19:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4231F5842;
	Tue, 15 Oct 2024 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnrM/xUu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E7C1F5834;
	Tue, 15 Oct 2024 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729022366; cv=none; b=DDQpI6gc7uS1rRAPA9qNCHv21eOYaj2ZuZQV2ukXjPJwS6TgJuXbVvcZHVUNwd4Q3yTaYCe8G9UgyHN+lsq2mqmeOodrjm2p/FIwgJ/JFiHriBm591857gkEJFNPumRu8kLB7RXgXkE4e6O6FNW5Fe/zFnH53jcXSjafyQ1eyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729022366; c=relaxed/simple;
	bh=EMfBa+kZ3Nwqgly7t1kejexdHZzYJ3YfJ+fRC7UKu0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkTxk4cwbMc4kDrgmvQR2bZ8NAHcUnw4tAlX2AkSTQYhAlqkSSxXFJlxNRSWHAZJzgBZ1+ylILIeOV/KJRm2687EJpd1x6+ALofxzwA9X9YC0zLnXyq06lx5YmLitNYnTWz4PwKDED6Nf/3mzAXSnF/sGNPV6qJd76fdTKWaURs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnrM/xUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C3BC4CEC6;
	Tue, 15 Oct 2024 19:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729022366;
	bh=EMfBa+kZ3Nwqgly7t1kejexdHZzYJ3YfJ+fRC7UKu0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MnrM/xUuog6hHfkqZzJwRbWtVg3sMCQ5DbWbGishz973zmU8BBrbYkfsvzdPTMCtp
	 AzZIr90aVIrFGZoDMXB90Zq0nUSInpwZu23vliTqKSfWRBJhtUlQ2gClKVdameMTdU
	 fLYy+uBj5+XfmzxDqbNzMp4lNZNJvsxXsURVgz/p4+JQA2wlRND+1f6soGksfO+Yon
	 d1cc64JRQXa3WrULBi1hV+shEu839J+8LHS/oHlB0ME6XlORlxazKAeAybv+bFGICC
	 FKE6jmHkx8qauLjY79aQ9kje2zgLxT/dYNsbX9HgDQ/4A9RctfyLzrG4RkZ092x3Es
	 DADvLz6ddUopg==
Date: Tue, 15 Oct 2024 14:59:24 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-mediatek@lists.infradead.org,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sean Wang <sean.wang@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pwm@vger.kernel.org, ansuelsmth@gmail.com,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v6 3/6] dt-bindings: pwm: airoha: Add EN7581 pwm
Message-ID: <172902236421.1701795.14798814698922784274.robh@kernel.org>
References: <20241013-en7581-pinctrl-v6-0-2048e2d099c2@kernel.org>
 <20241013-en7581-pinctrl-v6-3-2048e2d099c2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013-en7581-pinctrl-v6-3-2048e2d099c2@kernel.org>


On Sun, 13 Oct 2024 00:07:09 +0200, Lorenzo Bianconi wrote:
> Introduce device-tree binding documentation for Airoha EN7581 pwm
> controller.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/pwm/airoha,en7581-pwm.yaml | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


