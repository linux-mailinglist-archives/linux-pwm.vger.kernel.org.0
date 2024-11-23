Return-Path: <linux-pwm+bounces-4127-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B159D69E9
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Nov 2024 17:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0201617C6
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Nov 2024 16:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80F186AE3;
	Sat, 23 Nov 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrlrFsPX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A304D8D0;
	Sat, 23 Nov 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732378429; cv=none; b=XJsmj9/zvPY7hF1nvnfJK2g/ILnqQ4z0KeyIKnwTu98cI9FSVZ1UDigVcVAAoHwOiVwYqrzVvaPIIQwr5io3RQ5qddHAHs/BnIUTJNZmCQptcGXhupMzZ2kN4O6JRDQaKJQesvX7qFx6vT94d3N8zm/DdkfL/g8vuv68EyZdlxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732378429; c=relaxed/simple;
	bh=QW1sglxsrkcGK+O4SS6T/kq6QuJj9k5GRbXNxF6HJKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9SofTLRB2AbGoeLoJmI/a+vHrd+B1c28TTChwhJLuRR/Q1WM4fv9AYEB08nNDPAPJN22Mwh6P4++w6mKJXQTkXuMJeEcvPNzvDwsTUlLwMf5zWj627zCB2wYeESsmhHaTWh20EOe2YXgt2M3PsCQkTyPtcyD5N72eu9eYOKzmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrlrFsPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7948CC4CECD;
	Sat, 23 Nov 2024 16:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732378429;
	bh=QW1sglxsrkcGK+O4SS6T/kq6QuJj9k5GRbXNxF6HJKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nrlrFsPXCKoH5MgV7FKK9fSS6nqJzv78J2TlZ+v4T89MC9VTIMUlNUBJd61q0FirG
	 K+iOq2au5SiS7reNDDNAchu6jIIYKzzpoGV92vSP8EO7BOoAropGL0l/P/a5PM9L6x
	 E8B0mwVsHqE3x4JGczSGmqOMtj0BP4J0iyj4wEwFAPIBJ/IVML/PDJ8ntf54H2ztBh
	 JNaDy/3wVJIeiwHub/RMbgX+Fn1utyZskgdSAM+aANrocgvyb7ygJ4Uvlrl1ZKxqTn
	 OzaG1dHjahavzFLz6tGXr5PxnM+Q81vldlACl/AAjRDWSY1ZFkc0/dSpmJM3ozMMku
	 +e1alM69Mk9OQ==
Date: Sat, 23 Nov 2024 16:13:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adf4371: add rdiv2 and doubler
Message-ID: <20241123161341.56d2e9bb@jic23-huawei>
In-Reply-To: <20241122113226.49346-1-antoniu.miclaus@analog.com>
References: <20241122113226.49346-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 13:32:13 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for reference doubler enable and reference divide by 2
> clock.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

why are these not things that are derivable from the required output
frequency vs the clock frequency that comes in?

Would have been good perhaps to have a cover letter with some description
of how these features are used in practice.

Thanks,

Jonathan


> ---
>  .../devicetree/bindings/iio/frequency/adf4371.yaml    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> index 1cb2adaf66f9..ef241c38520c 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> @@ -40,6 +40,17 @@ properties:
>        output stage will shut down until the ADF4371/ADF4372 achieves lock as
>        measured by the digital lock detect circuitry.
>  
> +  adi,reference-doubler-enable:
> +    type: boolean
> +    description:
> +      If this property is present, the reference doubler block is enabled.
> +
> +  adi,adi,reference-div2-enable:
> +    type: boolean
> +    description:
> +      If this property is present, the reference divide by 2 clock is enabled.
> +      This feature can be used to provide a 50% duty cycle signal to the PFD.
> +
>  required:
>    - compatible
>    - reg


