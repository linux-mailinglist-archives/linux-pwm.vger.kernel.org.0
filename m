Return-Path: <linux-pwm+bounces-3660-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A429699F7A1
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 21:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66DEA282D03
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 19:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B301F584B;
	Tue, 15 Oct 2024 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2ngDwqf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573C81F5834;
	Tue, 15 Oct 2024 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729022379; cv=none; b=hZ1SawunkDwsvK04SOfX/tjXW5G0tsKM+eV8PY6mMWcpLw8sEGcMEM5Ge9Eo5lverltPobmsjhyTAKGCvv/ujMVH+Vro1uOEuqoet3mBQoLSfn0Wf99iebvzA8AnNQthTpSiH7zZXU1+J7njZoIfsyMBpkOeqBE9rDUdb5vc55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729022379; c=relaxed/simple;
	bh=o5PDrtHObgP3OmjsttXcysEYMPEFODbevDbCa/VABeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIGq2vVZBbAvb8Y3fg4xfkWErrKzuGe/XxelSlRQIS1TxgQgAUkiCVa6effgxicBsSQ9sH8buJ2NZa2GPN+SfPtVvfQT/XbzCBCCbRj/v+Mi66f3ugdQG+RmWH2g1ANK2HqGj8vH9Ig4PTzuWKtNZ7xBJSUloqJgjWv2gjdb6ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2ngDwqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB59C4CEC6;
	Tue, 15 Oct 2024 19:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729022378;
	bh=o5PDrtHObgP3OmjsttXcysEYMPEFODbevDbCa/VABeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z2ngDwqftl2tK6JYPRqFTdIB9M3Nf7L2hWKvqlGo7FBf1hUaV2n2mhR9TGAPnkFoB
	 /+STaMSfjMjd1EaoMUh4X13/jOocGJb/dMHogYG09O2Po6cQmxsO3VO5mlLXhqLrsX
	 Uh5FqO1nuLwEhO9NzW+c/53QAjx6aVJfhMR485S4F5KXX7gregg/dzia1R2yLvjwg3
	 m0Yo25Rg6FC22Ys6FqTW6QxK4C5n/5mV21H53oI5Uf0vtSq+SFCVmkNIIlBq1ZZ1Yx
	 HcyB2lOZG8vdY7k77T5CjHFFKtkMJydkeFWVdJlv91NW7l5jLNYlxDG6PjYU2pGwiS
	 344t4ohLIpm/A==
Date: Tue, 15 Oct 2024 14:59:37 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	ansuelsmth@gmail.com, Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-gpio@vger.kernel.org, upstream@airoha.com,
	benjamin.larsson@genexis.eu, linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>, devicetree@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v6 4/6] dt-bindings: mfd: Add support for Airoha EN7581
 GPIO System Controller
Message-ID: <172902237741.1702164.15273097757598307405.robh@kernel.org>
References: <20241013-en7581-pinctrl-v6-0-2048e2d099c2@kernel.org>
 <20241013-en7581-pinctrl-v6-4-2048e2d099c2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013-en7581-pinctrl-v6-4-2048e2d099c2@kernel.org>


On Sun, 13 Oct 2024 00:07:10 +0200, Lorenzo Bianconi wrote:
> From: Christian Marangi <ansuelsmth@gmail.com>
> 
> Add support for Airoha EN7581 GPIO System Controller which provide a
> register map for controlling the GPIO, pinctrl and PWM of the SoC via
> dedicated pinctrl and pwm child nodes.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/mfd/airoha,en7581-gpio-sysctl.yaml    | 90 ++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


