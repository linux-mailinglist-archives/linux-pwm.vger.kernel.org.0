Return-Path: <linux-pwm+bounces-2329-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5142A8D861D
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Jun 2024 17:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E607B23671
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Jun 2024 15:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B02130A47;
	Mon,  3 Jun 2024 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ur5A0KFX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7112D205;
	Mon,  3 Jun 2024 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428815; cv=none; b=p+48Mj4wm0LwMMH+8kDnsL6GRHAUbec9poqJzxjcE4yOtmOt0x+GscyovBMKuoohNvxoC81ePNaMMSZbQV1n640CIenGifhSr2hc82JMfqXyC1BRAOP6KNKeJBqO/Y6CPBPgmtcIiRaoqEplqlsHH4LQfItPzg+rpigrWrW3Tys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428815; c=relaxed/simple;
	bh=AwQ8yVhAqY20WiMCVkAokvNNrwqLytXdcjg5sm/le6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+r3VCPsIqPeYvKNBe6WfHQkOvJ270DqEJ4zs2UQ0qiTy1ZEhHT3U41KYoZEW6UJ7vXm3CONpKrm0DHlnKgYOVxtiojsL5Q7W8sd0DtQSQaT4/0LqG59pZ9YBmFnPu3fCdI6yJt0CBcHIN7vfA5OWgQ2UX6q8vzelQx/IvbwF1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ur5A0KFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A92C32781;
	Mon,  3 Jun 2024 15:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717428815;
	bh=AwQ8yVhAqY20WiMCVkAokvNNrwqLytXdcjg5sm/le6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ur5A0KFXhu6TwdUAKBs+Cnt8qnqvZTvaMEttX37GSaZyciv8CfeX8JbPN7k5LBIxS
	 xghjPV0WHX4mHOHAhNZ8H14eyztCLAtVLn9c0857rwxHotSQQmkkIadZE5wpfsCJLX
	 YoCLIuLz6SwyAZPNM0vY5Xfv6zUyVdbuYvGO/bd1c1rDbdzkGP/e1UVojoXR8f2T3x
	 1Ps+uDhp3iRcZqAT5LBAn5+bY3qugtdyUYzRr1qLzm7e26JWWzK4GDgGMeNJ5+RlXn
	 W0y6bcRc2bG+tqoNuF6ZBCQyMxqxpsL85HKyadRh0Hmcm2dB+3TNBMT6vtdfw+jCFP
	 nTWNx0whNAKfQ==
Date: Mon, 3 Jun 2024 10:33:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: krzk+dt@kernel.org, ukleinek@kernel.org, linux@roeck-us.net,
	linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, conor+dt@kernel.org, jdelvare@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: hwmon: adt7475: Deprecate
 adi,pwm-active-state
Message-ID: <171742880913.477528.1165389855068521999.robh@kernel.org>
References: <20240528225638.1211676-1-chris.packham@alliedtelesis.co.nz>
 <20240528225638.1211676-3-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528225638.1211676-3-chris.packham@alliedtelesis.co.nz>


On Wed, 29 May 2024 10:56:37 +1200, Chris Packham wrote:
> Now that we have fan child nodes that can specify flags for the PWM
> outputs we no longer need the adi,pwm-active-state property.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v3:
>     - New
> 
>  Documentation/devicetree/bindings/hwmon/adt7475.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


