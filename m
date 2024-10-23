Return-Path: <linux-pwm+bounces-3774-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6909ACB5A
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 15:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80ACDB2333F
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 13:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C1F1AC8AE;
	Wed, 23 Oct 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="HTXRV5JQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779CA2914;
	Wed, 23 Oct 2024 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690642; cv=none; b=izUZWSbHWQYik+GRmeHATN0W4idw76sUXut+vxbh2n6wtYkEIBltNdmzy5cnDXdV+xzJnpf6jaljuXp+i4HcNzLEJSm+ag23ihr2t9EHirWEKnprSoF2k184JSUwWGj0nBe5UGwp9EemhVFxLhGaWwn78SM6mTrpBQFCpYv4W/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690642; c=relaxed/simple;
	bh=wL9KCqJ/ruF83veiEKHat5EaBIz1miOELOH//btIfic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUqw5SWHUFj8sa6g2HUr7tgohlCvVLYgRFb9Lg5NBQMk+RXtW7atUrcNBzUkp3ibIUX2TqY952n7cRcGMYXfgWLDjk1fJvoIhd1H4WxdQsEY2XhSyXIRw7sZsiwGof2fMaTjx5uypffc4uGsKgaBSECc3csa+g+uELkquxJYBwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=HTXRV5JQ; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1729690635; bh=wL9KCqJ/ruF83veiEKHat5EaBIz1miOELOH//btIfic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HTXRV5JQgKGOf1v9LUtq+XEsgO9sRPakP/OsGDD8ujiWoK3vUyyQJu4HtnsKphmZN
	 r1YB3kgnhOfSawJfKoFj3bariYpERnl0DTVJeEcboZu6gBvFReynnSZOtsSs7N2bOQ
	 vhVKSMXHpEjo6bms12P99JIrFkAlrBDimm5DRzYf66u0QadFnBB2joEHUmJm7qd8hu
	 zyuwgx1EmJNj0x2vYBFhs1XdtdKJozqO83Zgz2EBc0ZxlhtfapMmzHBkuS+KGT02Vk
	 hDOYPC3F+PpJgwDT5Gfs6ORZfqiV1j9um+VFeiYlVj/9QH0rQcS5ve6EIJlhrBZLEn
	 JtWcCr/G1jqkw==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 6535E1000E1; Wed, 23 Oct 2024 14:37:15 +0100 (BST)
Date: Wed, 23 Oct 2024 14:37:15 +0100
From: Sean Young <sean@mess.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Chi-Wen Weng <cwweng.linux@gmail.com>, ukleinek@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, ychuang3@nuvoton.com,
	schung@nuvoton.com, cwweng@nuvoton.com
Subject: Re: [PATCH v2 2/2] pwm: Add Nuvoton MA35D1 PWM controller support
Message-ID: <Zxj8C46QeSt3sboN@gofer.mess.org>
References: <20241023111841.158049-1-cwweng.linux@gmail.com>
 <20241023111841.158049-3-cwweng.linux@gmail.com>
 <1087f21b-d56b-4ab0-bb56-96096c23f0d8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087f21b-d56b-4ab0-bb56-96096c23f0d8@linaro.org>

On Wed, Oct 23, 2024 at 02:02:14PM +0200, Krzysztof Kozlowski wrote:
> On 23/10/2024 13:18, Chi-Wen Weng wrote:
> > This commit adds a generic PWM framework driver for Nuvoton MA35D1
> > PWM controller.
> > 
> > Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Sean Young <sean@mess.org>
> > Reviewed-by: "Uwe Kleine-Konig" <ukleinek@kernel.org>
> 
> NAK.
> 
> Stop adding fake tags.

I never sent a Reviewed-by either.

Please re-send without those tags.


Sean

