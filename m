Return-Path: <linux-pwm+bounces-5879-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C260FAB1A38
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 18:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7501C47BAF
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 16:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE79B2356B8;
	Fri,  9 May 2025 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wi2eOpED"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0E91EEF9;
	Fri,  9 May 2025 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807229; cv=none; b=dSDjTCzxpmCGnStXlm3XUhZnUKm1wrvmdA1vRXQN1l+ahoIpJQqesYujj3IHQ0SDvarnFLbz7okZC3BKTALoAfx0D9x2NowlP8SB+wFFjLFkc4ds7ddwul5BltoDrKDYbtR70rV+69VaHbE9khlIw031nHmNNwyE+C4gDaNr7r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807229; c=relaxed/simple;
	bh=uFFdv/hSTyJmM0f7WK/XFsk1+vMgNlfUpcrghzEP2XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCplkAyDtmfy2JhHCz3q6TeCtIkOgSSjv8zEGMZevjavMNPjmCM+RTqCl2J1tRCTodtgB+k187mpkjjY1IkeGNN+kI0QPMxYFxBw0K2KAId0gbj9J/hn7BfNSGKcuPRBbGNsW5hB8Abtl9r8WVzOaiXRQG8AE+lLZoEdB/fO6Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wi2eOpED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23388C4CEE4;
	Fri,  9 May 2025 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746807229;
	bh=uFFdv/hSTyJmM0f7WK/XFsk1+vMgNlfUpcrghzEP2XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wi2eOpEDOyXzvkIhsnn6NHqrfcEmbeGXEIQxGP06AbyFg/9w52FzuVFmEtkHfPv6H
	 5VtwnQEdkojBMjZsp0GqNcfFVJd01ZHPOyzNHL4Af363bJ5W+9x8FNRHtEOzb9Mzf3
	 PzglM4ThFEKfd3wNua8iWe1ofWa9gay+WcN4iCcLHAskN/s6VLjwvJ84SGw7GRNMEI
	 eyLBeBpNYr9S1GEuN7Lv40NzLZM6MiL3ExOw/EXTxXnH9aR3JsfkjhIpx1YdAmonjc
	 K+v2fHcIwz9v7stgsf2iSmpxG0x84tBxx7WopbrxrnHH2Vnvht7W8NxYeV0Ptt7Vyp
	 yFBh/VKdsV3xg==
Date: Fri, 9 May 2025 11:13:47 -0500
From: Rob Herring <robh@kernel.org>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v8 1/2] dt-bindings: pwm: sophgo: add pwm for Sophgo
 CV1800 series SoC
Message-ID: <20250509161347.GA3649553-robh@kernel.org>
References: <20250509-pwm_sophgo-v8-0-cfaebeb8ee17@bootlin.com>
 <20250509-pwm_sophgo-v8-1-cfaebeb8ee17@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-pwm_sophgo-v8-1-cfaebeb8ee17@bootlin.com>

On Fri, May 09, 2025 at 11:45:43AM +0200, Thomas Bonnefille wrote:
> From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> 
> Add devicetree binding to describe the PWM for Sophgo CV1800 SoC.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>

As the sender, you have to add your S-o-b as well.

Rob

