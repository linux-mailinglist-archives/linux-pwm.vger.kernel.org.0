Return-Path: <linux-pwm+bounces-3658-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A67299F798
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 21:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F00C280CC7
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 19:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7541F583C;
	Tue, 15 Oct 2024 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJxWtuvN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7E1F5834;
	Tue, 15 Oct 2024 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729022317; cv=none; b=thgz8XQlm7WqzxMRc7jdZKfCDsMxF4CXAZ7h9vQOBQKJAv/kD/WA4JQoUGeDPcZ+S3A8fbZ/4VSDMrPq2NptpVIpbOwmnIOpcuEUsaDCV7YVHD+QYa32D7a2ryBftrPu6GiD7UE+raVL6KjcPqvzIwAtfsJ0nxAiIZkKPid0p/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729022317; c=relaxed/simple;
	bh=EjPsWgAbg+UEUmMgAu5NLa7fLl0gTr0MHFf4N9ocwHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzVrKfp5elNR+LmqHVxqu8tgANMHYmW/7mh+nrb4LWOnkt7dCGQntu+Hap9A1TtwZEdPR0evifGpRjRO1SJmqxYJKGP1ZJ3F8yzafkz87HvHpBGYI72ui3GtLCfsHogR5ICWObuwxbybjVxe2EmGonxGHNm160gD8zQpXvYfj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJxWtuvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A19C4CEC6;
	Tue, 15 Oct 2024 19:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729022317;
	bh=EjPsWgAbg+UEUmMgAu5NLa7fLl0gTr0MHFf4N9ocwHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJxWtuvN2iv48dz6CnEJBhsbL/G7fN+OGZ4cQpm/dsCkCaYRU12+DzaGVCHjRMph9
	 2fcFi9ghE84ehws1OHwNg7lfW9BbNfVlmi0ZLZ1lay6doGelKXH3wzdS/URuJVcE4E
	 2XnaZxm3osz2Q9zzLrx1R5rBgazYdxm7H8cJl2ttBMpnuZXpIh68lwROSkoAQ6r0fz
	 xNTWHfqjHxryup2v+vYCUTOZFoMopfyRPOolKYKUC7uAEbdfR3Up5aAeMlaIZBwwns
	 zQJeLVh+mtpA5IP3cmcMSsXeLDcVGfB5ivSBI0KXKUFtq+yQe4dS610mLVL0Kv8YCd
	 viQz6V70NE4eA==
Date: Tue, 15 Oct 2024 14:58:35 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, Sean Wang <sean.wang@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
	benjamin.larsson@genexis.eu,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	ansuelsmth@gmail.com, linux-pwm@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v6 2/6] dt-bindings: pinctrl: airoha: Add EN7581 pinctrl
Message-ID: <172902231337.1700754.4934935169511405807.robh@kernel.org>
References: <20241013-en7581-pinctrl-v6-0-2048e2d099c2@kernel.org>
 <20241013-en7581-pinctrl-v6-2-2048e2d099c2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013-en7581-pinctrl-v6-2-2048e2d099c2@kernel.org>


On Sun, 13 Oct 2024 00:07:08 +0200, Lorenzo Bianconi wrote:
> Introduce device-tree binding documentation for Airoha EN7581 pinctrl
> controller.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/pinctrl/airoha,en7581-pinctrl.yaml    | 400 +++++++++++++++++++++
>  1 file changed, 400 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


