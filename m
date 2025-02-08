Return-Path: <linux-pwm+bounces-4830-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EFEA2D736
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Feb 2025 17:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A803A7351
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Feb 2025 16:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC0C1F17EF;
	Sat,  8 Feb 2025 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXgGwo8x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A2A1F17E0;
	Sat,  8 Feb 2025 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739031738; cv=none; b=MKakvaOuOOAm5xy0OgMxroAmHWz0MyvYQM4SKUbedDs7jaWBfLXJ3erA1cgVRUfwSk+LyaI/oC9k5fiwROxmFq6bLLOktxYYZsIrSiXSl1PtD+wjQKOQ/44o7o5MkAYBap/MROzdX3icGjsVn641s9LAwAuEAO6TZqtbGbKGYbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739031738; c=relaxed/simple;
	bh=97IBzO1CWx4oZDvKx6jxFk8hLWZKDM/8QmlyBbbKBvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9T0EVGeGMV0QmRmHbxtYDBnbvfI7q/ur4zL9Sh0Bh8vpfhnbRRbsBHlrJopSoUE2Qi9oxcGQEftJIstoiC5gFkh2UXDtyUBPyU2npAp7arGkQr1Wt3PecE2LOFDSpT8sNdxN0+qDzRDQqNXE0R6SRL3V4HqJAddrz/vuE40124=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXgGwo8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E4AC4CED6;
	Sat,  8 Feb 2025 16:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739031738;
	bh=97IBzO1CWx4oZDvKx6jxFk8hLWZKDM/8QmlyBbbKBvU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FXgGwo8xpaF6cUoUPyxO+5wdzcN4EGvpD9tFK1VhXhm4CF/YDOKUlfttMBFw3Un1K
	 930pz/tysCFaKs8Y/xS0gygZtI00i+lqxFTO6gwdIFq4iMi25TT6pBT27zx405wsZa
	 7OUMOVCzK97zDxMMQeYhJLnmq3x6gz1SPPtobrptBVyYZaoY+TxLFAOwt/COB9s5zz
	 G0MZo+rkRy1KBtcLRECHJF6hIG9hE8fbbHs09AcOaHG//EAB7yYyhEuacHxE6OuoHe
	 x0jV/5drtrUurUG5HEqGMTmecYx0gXGY7mAxK9VB0nM14cRTUDuelzW7xKZ/qWyLvH
	 6U5MjmjEr+yMQ==
Date: Sat, 8 Feb 2025 16:22:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v12 6/9] iio: adc: adi-axi-adc: set data format
Message-ID: <20250208162209.2d43bae3@jic23-huawei>
In-Reply-To: <20250207140918.7814-7-antoniu.miclaus@analog.com>
References: <20250207140918.7814-1-antoniu.miclaus@analog.com>
	<20250207140918.7814-7-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Feb 2025 16:09:15 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for selecting the data format within the AXI ADC ip.
> 
> Add separate complatible string for the custom AD485X IP and implement
> the necessary changes.
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v12:
>  - add separate compatible for ad485x AXI IP core.
>  drivers/iio/adc/adi-axi-adc.c | 99 +++++++++++++++++++++++++++++++----
>  1 file changed, 90 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index d2e1dc63775c..272d82c6e887 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -45,6 +45,12 @@
>  #define ADI_AXI_ADC_REG_CTRL			0x0044
>  #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
>  
> +#define ADI_AXI_ADC_REG_CNTRL_3			0x004c
> +#define   AD485X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(1, 0)
Sorry I missed this until now, but normal IIO thing is no wild cards
in naming (been bitten too often!)

So I'd like to see these named after a specific part.




