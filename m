Return-Path: <linux-pwm+bounces-4861-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACDAA31621
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 20:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF781660AC
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 19:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5C326563A;
	Tue, 11 Feb 2025 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnUrUTwd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED9426561B;
	Tue, 11 Feb 2025 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303734; cv=none; b=SuumyQaE9Gf/HuSvKe9xtxZ330l60xjTIkiMc4xEkw9HO9z2cPlG+XnUNfLgyrCi81PUbIg8Z7Bsw3pkSJ7axD0lIMx1rLiuAYZwPl7Tz2OQbd/7tID7GrFFAuxu3j+dZjxXIHm5egZHdT+RcIgT2+m+CVJzFGKHc/Q/gBOXrHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303734; c=relaxed/simple;
	bh=YGBeiYvY6N2eP4tvuDNUETpII967sPU2WGuLJGNSh2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhocRANJWfJ0sbNArXVohrHqPAi4Je2cEvXGvYIuTjPttz8Z/wx3TpV8WJwBBN+oHdtL2FPnNo7UC/m5/46n5mFREdeid4RWBeI7F3bpDn/pJJhvAc/3vSOHbqgd7uJPv5guQ4DEbawhfgfEAGBGjvUtRnvVPQKKJ8+NDDkXpp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnUrUTwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29610C4CEDD;
	Tue, 11 Feb 2025 19:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739303734;
	bh=YGBeiYvY6N2eP4tvuDNUETpII967sPU2WGuLJGNSh2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jnUrUTwdUq0tunyCQMWU7mEttGn6BiLTOrCWBHEMkRmGTnauyS1HYPMYwcWYzhTcp
	 LnnFJdQpgcLjt1xYZZDHELBDAr61kHyLwNvteUH42uMAlx1dNmZdvqGNvOTRNbRURp
	 2exb/6WJGwEeAslt5nuRoAhxlzF5veEd7K5MIH+w04cAQqgceoISNwyPL+RkB6fSfW
	 jLPx2ba08oI8pNJHM/K441C6ZdLA7/d2Q6PQhRtr1zRhjvBmjvg7AW93sUOBMptYl6
	 8DXVVyipI8IJ0LCpGYROGVxnZS4495oDXOFUKFdzugWiYzBsACi6mBINVgE2WCi2+0
	 dpswlQxmHAXyA==
Date: Tue, 11 Feb 2025 19:55:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v12 6/9] iio: adc: adi-axi-adc: set data format
Message-ID: <20250211195526.4e04c875@jic23-huawei>
In-Reply-To: <20250208162209.2d43bae3@jic23-huawei>
References: <20250207140918.7814-1-antoniu.miclaus@analog.com>
	<20250207140918.7814-7-antoniu.miclaus@analog.com>
	<20250208162209.2d43bae3@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Feb 2025 16:22:09 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 7 Feb 2025 16:09:15 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> 
> > Add support for selecting the data format within the AXI ADC ip.
> > 
> > Add separate complatible string for the custom AD485X IP and implement
> > the necessary changes.
> > 
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> > changes in v12:
> >  - add separate compatible for ad485x AXI IP core.
> >  drivers/iio/adc/adi-axi-adc.c | 99 +++++++++++++++++++++++++++++++----
> >  1 file changed, 90 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> > index d2e1dc63775c..272d82c6e887 100644
> > --- a/drivers/iio/adc/adi-axi-adc.c
> > +++ b/drivers/iio/adc/adi-axi-adc.c
> > @@ -45,6 +45,12 @@
> >  #define ADI_AXI_ADC_REG_CTRL			0x0044
> >  #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
> >  
> > +#define ADI_AXI_ADC_REG_CNTRL_3			0x004c
> > +#define   AD485X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(1, 0)  
> Sorry I missed this until now, but normal IIO thing is no wild cards
> in naming (been bitten too often!)
> 
> So I'd like to see these named after a specific part.
Having realized this is named after the IP naming (which
indeed uses the wild card), maybe we could
prefix with AXI_ perhaps to make that association more obvious?


> 
> 
> 
> 


