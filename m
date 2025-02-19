Return-Path: <linux-pwm+bounces-4943-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E32A3CCBD
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Feb 2025 23:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3381189896A
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Feb 2025 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED6925B691;
	Wed, 19 Feb 2025 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQpr6j3T"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2125825B674;
	Wed, 19 Feb 2025 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005691; cv=none; b=jumy27e6btE6uxI9UCR0ilaerTfGe0v2YBL/Mxm4NTtrFzAkrPLKe7mtxr9+5EZ1K5JpECMG5DdtOEqBCbUPVdPILJFa3J+Avj1QFuqHr0UsFSOSx/CHMtvSzDhIUXm0a05dWQfWCSfBljIe1YLJ24kapHvsdS8M8aDXDEyAHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005691; c=relaxed/simple;
	bh=DH4hbs5EerBNAJz2J89fIqkhJwMcOqyn2uGY2e8uQmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3tdCYuf+9lByp6Qy27ENlas3i91roSWpBlK4N43JeNK5ZTQifYC2dwypEzMwLia+44dgFBqca3+xZSNVRysuCzaPKwpLBNU8J8YrbSU4SpQ9MT752AVusaJa0jh2IlA1EnbP7sk6qO4KyoHcnfuENGniNNvYpRq7/L46dXFCI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQpr6j3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA164C4CED1;
	Wed, 19 Feb 2025 22:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740005691;
	bh=DH4hbs5EerBNAJz2J89fIqkhJwMcOqyn2uGY2e8uQmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQpr6j3Tp6tnVuvGFrQvbYy5hPtdLQMcWArX742TesOPv0KWfA/gA185MREQaS92f
	 ajMn2Di2ssaP2WEwdPww7TmHrwH+ZYhw1LL58qmi3pbzRgu7WI9+rWKE9CR0p6HTdr
	 5+gNTFF7pe2PiXUMyoACNp60IBXAQJGa+8zCoSAoq1UpL8w0HW9UbcSSlKBVhq1D3j
	 4KOP+kLAlOxT4+V9lvQhqtgmpaU/EBVtYh1hABjJl8omrJxNjxW/1hl76rr19Dk4k2
	 0HzPz1nJWioFv93Coo1RpHNpsp0Dv9/wuIQ5Sse9biYYLKX4U3b3MScrURvKrMnRnb
	 bYi1PU6zA4RbA==
Date: Wed, 19 Feb 2025 16:54:49 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	jic23@kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v13 5/9] dt-bindings: iio: adc: add ad485x axi variant
Message-ID: <174000568921.3121156.5629879811490736248.robh@kernel.org>
References: <20250214131955.31973-1-antoniu.miclaus@analog.com>
 <20250214131955.31973-6-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214131955.31973-6-antoniu.miclaus@analog.com>


On Fri, 14 Feb 2025 15:19:51 +0200, Antoniu Miclaus wrote:
> Add a new compatible and related bindigns for the fpga-based
> AD485x AXI IP core, a variant of the generic AXI ADC IP.
> 
> The AXI AD485x IP is a very similar HDL (fpga) variant of the
> generic AXI ADC IP, intended to control ad485x familiy.
> 
> Although this is not preffered, the wildcard naming is used to
> match the published firmware under the same name.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v13:
>  - adjust commit body and add comment on wildcard matching the published
>    firmware.
>  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


