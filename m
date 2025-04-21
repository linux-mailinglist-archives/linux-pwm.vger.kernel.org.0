Return-Path: <linux-pwm+bounces-5631-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC17A9565A
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 20:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4C3172F96
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 18:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CD91EDA0B;
	Mon, 21 Apr 2025 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3kKkPAi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62B01EC006;
	Mon, 21 Apr 2025 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745261862; cv=none; b=kVbgfiFFEiGewrN8YbaC/DldmLD555wxxIloxcU2Qga6So7e95kora7Gh5nsOnfjJJaeA/4Pl9s4ioP1di7gDf1qjJBqvNAK1n6PW7koDSo9Ta3PnPUMVIq5QUBi5f3W1vVCOWWBW8lKqGKvbsLs3VDIo5GckvX4t5sZSma73cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745261862; c=relaxed/simple;
	bh=vprb6oeqf8O9HHvet3h/gJgvjG30Jn5t/vFsofylNH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ba2JA4kaP/pPOi3TigqrtGMQkG7dw19Fh3u+wN7DKS15fZRjRNAsjnISAu9dAvI0e5kLfvn4h6NdRZure/cFODIK7qNBqknbu5i/+SfAwXIdww9lnkr9uXh1vM/V/XWuT5sxw+PCplA+ROxESL5OGAcg834h+Jufrf1+WNshI7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3kKkPAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75A9C4CEEF;
	Mon, 21 Apr 2025 18:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745261862;
	bh=vprb6oeqf8O9HHvet3h/gJgvjG30Jn5t/vFsofylNH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3kKkPAi3qmN+OlPhhvVHKUxyb0/TxQgsBQe07qzxbYBNf0NvNqlNJ0riwn4mSB3a
	 403debNkR9dx/mMI1Q5vOHIndVq77Z+SKDBmy9+adMolH7ohUoaHOfl5OujxIGoeRo
	 kJFN/sTh9TjhGU3zZ1U4wdWYd1S/xHW5aQ0dmLTBX2L2z/XgIgJZdfHUFzS+62MW5V
	 Iksozf3cOMPHs2dVU7jrsz0ylngpBx7oXfpLLkmOuj0MCP1Lbv0KiWqi1vJJKW5LVu
	 cbxMT82a46PZGI9sHU7UBSsNuJkFMSaoy3dnmp6PnnEaHxjLMoJURDL3v4VuHkFaS9
	 ng1QSGZsK6j9g==
Date: Mon, 21 Apr 2025 13:57:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>, Liu Ying <victor.liu@nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-input@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 01/17] dt-bindings: mfd: adp5585: ease on the required
 properties
Message-ID: <174526185947.2620719.12213916045313095905.robh@kernel.org>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-1-3a799c3ed812@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-dev-adp5589-fw-v2-1-3a799c3ed812@analog.com>


On Tue, 15 Apr 2025 15:49:17 +0100, Nuno Sá wrote:
> It is not mandatory to use all the capabilities of the device. One can
> very well only use it as a gpio controller without the PWM support. This
> will be even more evident when support for the matrix keymap is added.
> Hence drop the requirements for PWM and GPIO.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  Documentation/devicetree/bindings/mfd/adi,adp5585.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


