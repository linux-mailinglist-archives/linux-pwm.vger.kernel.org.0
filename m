Return-Path: <linux-pwm+bounces-4445-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B62F9F9AB1
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 20:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4A416C459
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 19:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2582236F8;
	Fri, 20 Dec 2024 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoW/iu+b"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A32220680;
	Fri, 20 Dec 2024 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724349; cv=none; b=ai1eC049WJtpfxBpB2PvOK0BhSRksVYlXldGXNUJ/Y04H0Pm7kzNK5eYjL44azU8oytCr1C1A3qXsOzhiD2ZtGQtl1F217I3JFe6pvh4vLXEzJ4SSrXysgKVn5+mBtgtHCMX2fumyRzWkA/ey+DdmKcCtZvsoTSwkS4zDs4Jp+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724349; c=relaxed/simple;
	bh=RmkDMXxieeNH/LFiW+kpfaHBX3nJ0eqQ88QDyohMCVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6cOOYcrL2p4S7WQjK8cSFeHArT/DE2MHY2fIh4doAU8F68/UJZpe5A8CtYdn0vktXJMJNacVlTE1lD4gCNkUoXohAQMrZQNNumCAg1iwpZDUOTl4rOtFPIm/Y9DtiLFA39vxFxjU6cRGRBYTGC/UxUKmiy/IK8LoKzeJqBn/4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoW/iu+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E90EC4CECD;
	Fri, 20 Dec 2024 19:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734724349;
	bh=RmkDMXxieeNH/LFiW+kpfaHBX3nJ0eqQ88QDyohMCVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FoW/iu+bx7MUux3jlpaihGRk0uXbkb6639ufmkwSKkH5Il6mWIqfgl2nuaOZMgCCK
	 ZY7+cTlP6ND8TdTSgjYzgDcrDLDzpT8dVpwHrQDE3XU1XsmmaldnTeJ95xx112lWvu
	 /Z4XL6eilwHkGQn7SCuetUzXOLT+RbLPTUC+INAPZUNcBHSuBY9/AlXDSFL9sNBvGp
	 mmcB4aU6fXIacV8av5EJ62yhX9jEN2KyfPG1dqFvYexfBwpHkVM5kCdRCzpA4gJdA7
	 3NOaCa1uwsmP91rOxLvAMRwZ4k0+POgWTMg6lIwlmWVV9rzCcYGDgsWwKc/ET1FCZa
	 Pp0b3emimQuMw==
Date: Fri, 20 Dec 2024 19:52:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adf4371: add refin mode
Message-ID: <20241220195220.1e1e1d6f@jic23-huawei>
In-Reply-To: <20241220095620.4918-2-antoniu.miclaus@analog.com>
References: <20241220095620.4918-1-antoniu.miclaus@analog.com>
	<20241220095620.4918-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 11:56:13 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for selecting between single-ended and differential
> reference input.
> 
> By default the single-ended input is enabled.
> 
> Input frequency boundaries are change based on the mode selected
> (single-ended/differential).
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v3:
>  - add option to select between refin-se and refin-diff
>  .../devicetree/bindings/iio/frequency/adf4371.yaml         | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> index 1cb2adaf66f9..f927d3af9f43 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> @@ -40,6 +40,13 @@ properties:
>        output stage will shut down until the ADF4371/ADF4372 achieves lock as
>        measured by the digital lock detect circuitry.
>  
> +  adi,refin-mode:
> +    description:
> +      Choose between single-ended or differential reference input.
> +      refin-se - Single-Ended Reference Input
> +      refin-diff - Differential Reference Input
> +    enum: [refin-se, refin-diff]

I think I've failed convey what I was suggesting in previous reviews.

Until now the binding has

  clocks:
    description:
      Definition of the external clock (see clock/clock-bindings.txt)
    maxItems: 1

  clock-names:
    description:
      Must be "clkin"
    maxItems: 1

Now you have a situation not dissimilar to what we do for clock where they may
be connected to either a clock source or a crystal.  There we provide
two clock names and depending on which one is set, configure the device
appropriately.

Here we have clkin. That will be whatever the default we have so far.
Now add a possible name of
clkin-se or clkin-diff depending on which one we are not considering the
default.  I think the default is single ended, so make our two possible clock
names

clkin and clkin-diff  with description explaining that clkin is a single ended
clocks signal.

Jonathan




> +
>  required:
>    - compatible
>    - reg


