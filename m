Return-Path: <linux-pwm+bounces-3226-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8935A976EF8
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 18:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4740A2827D2
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134F91BBBDC;
	Thu, 12 Sep 2024 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fITLn6YD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA36F1B1429;
	Thu, 12 Sep 2024 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726159401; cv=none; b=C5XEfE7qwLDraphydcmZPNgKEzqpr2tWzCYxdfvu6nP1ySdEMwa0fRl+0mYqHCmnXFPfz9Hy0lcPRcnINuXeOZ7DRsFaxYNk1M6ax6Nur4I853mZ0DVqFui5HXMo/THmLUg8l9U0iyHJpWhyvuESGk+aNGtUZDET4an781YTXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726159401; c=relaxed/simple;
	bh=jAOZmLaS86bj9s5j3+eO3YVYQkX0MvMiHQnL9QbBzJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDnTP2EnHz45TWU9uUafOFS8b+7d5G4hmZBzDcEj5UyiAC2Mw3Ny+aFn1P0CKLgBNADFyZD+/EtCMVLr2VzkcNbbyNVSS8eGeOnwb2oHALMAARV89zx6XRd7yrMpzCc6VRJNWkei3/86EvTszBS94nCh3h/yWI4HyoTMuxctMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fITLn6YD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C84C4CEC4;
	Thu, 12 Sep 2024 16:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726159400;
	bh=jAOZmLaS86bj9s5j3+eO3YVYQkX0MvMiHQnL9QbBzJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fITLn6YDWhfp6bpfzsNr1JXfMoSPjzBm3aRD/hH7VamK3QUvyqd7puHy+Bq67h//v
	 v7/8bNGawMiC76RnwwHhGuA24TmAbQLT7jVdFU8TiejH0pWgakwdbME4NMpFyckM+U
	 LPXMKuMgi/Bfon9sxpR8UJPA7rJ7MzMwUfSAWk9rMnbwQHJj7tg6YEPQ3q0wk5eU4c
	 ZIqoKFhCWDY+PlV5iQ7YLs6B28rgvr+YtWemR0yoszDvx1Gj+1yk1iBpaI8tAVEUPB
	 BOQFKIMn69zn/V151F0J60p5a+Bpo0cEEG94nIobU+Ik1KMSPXOxo7QYv37bNPuPHY
	 50jFR/ceI5FJQ==
Date: Thu, 12 Sep 2024 11:43:19 -0500
From: Rob Herring <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-gpio@vger.kernel.org, Sean Wang <sean.wang@kernel.org>,
	upstream@airoha.com, ansuelsmth@gmail.com,
	linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	benjamin.larsson@genexis.eu
Subject: Re: [PATCH v4 1/5] dt-bindings: arm: airoha: Add the chip-scu node
 for EN7581 SoC
Message-ID: <20240912164319.GA3907493-robh@kernel.org>
References: <20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org>
 <20240911-en7581-pinctrl-v4-1-60ac93d760bb@kernel.org>
 <172608915149.1388705.7137335166206916411.robh@kernel.org>
 <ZuIPo8BMBVGuaGMI@lore-desk>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuIPo8BMBVGuaGMI@lore-desk>

On Wed, Sep 11, 2024 at 11:46:11PM +0200, Lorenzo Bianconi wrote:
> > 
> > On Wed, 11 Sep 2024 21:50:01 +0200, Lorenzo Bianconi wrote:
> > > This patch adds the chip-scu document bindings for EN7581 SoC.
> > > The airoha chip-scu block provides a configuration interface for clock,
> > > io-muxing and other functionalities used by multiple controllers (e.g.
> > > clock, pinctrl, ecc.) on EN7581 SoC.
> > > 
> > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  .../bindings/arm/airoha,en7581-chip-scu.yaml       | 42 ++++++++++++++++++++++
> > >  1 file changed, 42 insertions(+)
> > > 
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > 
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240911-en7581-pinctrl-v4-1-60ac93d760bb@kernel.org
> > 
> > The base for the series is generally the latest rc1. A different dependency
> > should be noted in *this* patch.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit after running the above command yourself. Note
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > your schema. However, it must be unset to test all examples with your schema.
> > 
> 
> Hi Rob,
> 
> before posting the series I run make dt_binding_check:
> 
> $ make dt_binding_check DT_SCHEMA_FILES=airoha

Technically, you have to run it without DT_SCHEMA_FILES as sometimes 
there is interaction with other schemas.

>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   CHKDT   Documentation/devicetree/bindings
>   LINT    Documentation/devicetree/bindings
>   DTC_CHK Documentation/devicetree/bindings/arm/airoha.example.dtb
>   DTEX    Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.example.dts
>   DTC_CHK Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.example.dtb
>   DTC_CHK Documentation/devicetree/bindings/clock/airoha,en7523-scu.example.dtb
>   DTC_CHK Documentation/devicetree/bindings/net/airoha,en7581-eth.example.dtb
>   DTC_CHK Documentation/devicetree/bindings/net/airoha,en8811h.example.dtb
>   DTC_CHK Documentation/devicetree/bindings/gpio/airoha,en7523-gpio.example.dtb
>   DTC_CHK Documentation/devicetree/bindings/spi/airoha,en7581-snand.example.dtb
>   DTC_CHK Documentation/devicetree/bindings/phy/airoha,en7581-pcie-phy.example.dtb
> 
> $yamllint --version
> yamllint 1.35.1
> 
> dtschema is at the latest version.
> Is it a false positive or am I missing something?

Looks like something went sideways. Will look into it. You can ignore 
this.

Rob

