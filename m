Return-Path: <linux-pwm+bounces-3227-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1E4976EFE
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 18:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E451C23B09
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 16:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D97B1B9B24;
	Thu, 12 Sep 2024 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmbP61qR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC8F1865E6;
	Thu, 12 Sep 2024 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726159499; cv=none; b=GfXH9YrTGg7zJnUVYvzQB9HzfnnWs7bR1ucqI+nxfMYZJlGSO7FyGwcDEg/MwxLZwfsGkEREARMaeCcmXmPoCM1vep1+Tk/wGzwAF9LBtSZFFNPlxmqvWwTQbNWwlaKm8aDr3kOBzgKKwBCB0KR+i+sFpXaQLqqu064ayA6apNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726159499; c=relaxed/simple;
	bh=cQOBR1RFFJm2nw3OSuvbO0QAyXdcXwsUsCSGIOSeBZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mL+ERoRryAHFcSK/rU7+6rBEsK5RyHXE0wFBJL6fg4es2hD07cAXMwujHUeF/X09HMYAp7U2FshzQociBDYtD1Cow9SJI2VGP45ZSKmNuW6HWPXEzSbk2PafyCVsk79qTwtFKxol3vDzOruH+Kwibjbi3W8IfYsGoZTs46yQSUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmbP61qR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87591C4CEC3;
	Thu, 12 Sep 2024 16:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726159498;
	bh=cQOBR1RFFJm2nw3OSuvbO0QAyXdcXwsUsCSGIOSeBZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QmbP61qR54CqLXNE72/2T1Gh09yTKcsW6iN6O2WsmjMFmrZdDHukqG9VR5ZFS/ZES
	 86oR8afTlD8zvpqzrQ7T71KSeYdkDjxwdEtY2AfoVv2qIsIoXkszp3gvpDdDa3jSki
	 AEa2e05nQrqpVBso9AH5DmyfG5uGHRqAbW9XVJIyB8XfojTKxwsOpsddwi//yuvm1I
	 IV0dlHj3LLObqExc0wi7Z5etE5TIUvLf682w3JxBz2N2TeN34HdUXxtjcfburwcC/o
	 dOstkNvb8xwlR2rUW9J9adWEY/E6EbnX22a+7jahFJG3QXIxvBAYosSkU4k6VZCq7q
	 9QopKYXzChmLg==
Date: Thu, 12 Sep 2024 11:44:56 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pwm@vger.kernel.org,
	ansuelsmth@gmail.com, Matthias Brugger <matthias.bgg@gmail.com>,
	benjamin.larsson@genexis.eu, linux-gpio@vger.kernel.org,
	Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-mediatek@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	Lee Jones <lee@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: mfd: Add support for Airoha EN7581
 GPIO System Controller
Message-ID: <172615949582.3911596.4077414513470594513.robh@kernel.org>
References: <20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org>
 <20240911-en7581-pinctrl-v4-2-60ac93d760bb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-en7581-pinctrl-v4-2-60ac93d760bb@kernel.org>


On Wed, 11 Sep 2024 21:50:02 +0200, Lorenzo Bianconi wrote:
> From: Christian Marangi <ansuelsmth@gmail.com>
> 
> Add support for Airoha EN7581 GPIO System Controller which provide a
> register map for controlling the GPIO, pinctrl and PWM of the SoC.
> 
> Schema define cells for both gpio/interrupt controller and PWM.
> Moreover it provides a dedicated pinctrl node for pins and config
> definitions.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/mfd/airoha,en7581-gpio-sysctl.yaml    | 433 +++++++++++++++++++++
>  1 file changed, 433 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


