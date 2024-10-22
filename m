Return-Path: <linux-pwm+bounces-3752-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA349AB833
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 23:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99EED1C225FF
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 21:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5839E1CC89F;
	Tue, 22 Oct 2024 21:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aklXZcYz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246FE1C9EB3;
	Tue, 22 Oct 2024 21:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631340; cv=none; b=E0on7tT3GFQia1KmKkMoPthysEO6PoY/5AvGQmrcpBDULRiF6slNIeOEAwnqhNIe07SAnhGlintgLJHWYpchbiu+zMwT8oYUY0TqgUx1UyIiOKuQDoKGhKzMQggyxjga+lcsaYk1P932a2XEFpmroJnyl3bnWco26RFxuEnko94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631340; c=relaxed/simple;
	bh=3tpcmpalVrPV8Hg6tU9RLZ1k32epHZFxnCWMpj022Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gV4mtHuSgJrLMJ99QmXUlIO3VQT/UL+l/vikCcp8fXbxQSwbHaDuw3J14EVrweKrQr6eY0MFqcJH0Xwrjtf85EXUMCYqURe+W6KII655i9sxiJ/S5btfdckVxqu+1yVuNbzCKY616T45C4WmYqoOCalavwqw6F1JW075reqg3Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aklXZcYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9FAC4CEC3;
	Tue, 22 Oct 2024 21:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729631339;
	bh=3tpcmpalVrPV8Hg6tU9RLZ1k32epHZFxnCWMpj022Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aklXZcYzsQPUs90EoImnG92rb8PpiTTghNdIwWNOjrmdMXYMbKFjcOQMM4yNUguPY
	 tXGaeOkr1Xzh55frYU0k9YEzCtiT2PU31C0s394+63eOJhT+gkBYseBKB8Gy6c0FZJ
	 8JN9dsdw8jqi3L3JfvZusSQS+G3PkzahqSzqN5Nf6+PLyUttzvx/wYmtmkoW0xsXy8
	 71g8t44aOdqW7+7rdsA/SjEjdPLC7nctEzGoaTRWNzPwqPyuefF3dvyMkb2rzcWxeI
	 cqM+xxn50PpPxNWvYdXSS55ZAKDAOnLo4fydoOqhOp0d1t99Q04E3GaoGhIba5MPxf
	 i6h5P91zPkdaQ==
Date: Tue, 22 Oct 2024 16:08:58 -0500
From: Rob Herring <robh@kernel.org>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, ansuelsmth@gmail.com,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v8 3/6] dt-bindings: pwm: airoha: Add EN7581 pwm
Message-ID: <20241022210858.GA1565063-robh@kernel.org>
References: <20241018-en7581-pinctrl-v8-0-b676b966a1d1@kernel.org>
 <20241018-en7581-pinctrl-v8-3-b676b966a1d1@kernel.org>
 <20241021190053.GA948525-robh@kernel.org>
 <2da79425-0cfc-4c73-8fb9-bd3c92aa28d7@genexis.eu>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2da79425-0cfc-4c73-8fb9-bd3c92aa28d7@genexis.eu>

On Tue, Oct 22, 2024 at 10:02:05PM +0200, Benjamin Larsson wrote:
> On 21/10/2024 21:00, Rob Herring wrote:
> > > +  airoha,sipo-clock-divisor:
> > > +    description: Declare Shift Register chip clock divisor (clock source is
> > > +      from SoC APB Clock)
> > Where is the clock source defined?
> > 
> By measurement the clock was found to be 125MHz.

What I mean is the clock input should be a 'clocks' property. Assuming 
this is a clock input to the PWM which I'm not so sure about given the 
other replies.

Rob

