Return-Path: <linux-pwm+bounces-4346-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B8A9F1EA7
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 13:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0503167632
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 12:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C216C1922D4;
	Sat, 14 Dec 2024 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLJfW7r/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBF04C70;
	Sat, 14 Dec 2024 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734180630; cv=none; b=SF78cXdqDGuOqi2/n8Tmqqk/EFmQEC7Xb1JxhV2fmDPb1R6Y+35RvQ+FMgSwv2eOvIJZbtqysuDG8xX3b+UruJqgu133RRJ6SgFyxsXc3m/J/iZEOt+jauo6I1tDNGPi45iRGmRq8O3BJUatwe6oZ7zoIrYhTzPq+KInaCpwrks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734180630; c=relaxed/simple;
	bh=G3JX2JlTgHaPdN/e/HmSqFo0L1aTr6iDjh4V6VPY1y0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgBWJinmYrnnJzz2FvHVV1MHMPc29QZKd7Upqj732Yjs43VN0rWMsJv6yKtRlPpXJdY0bS7K8XobAaMmAYWsINnfQ789Er+V45Hl8PrvOCAKMQQ46pv+ee5DFv+uznsd+5srhyJJiPdTQuk9qlYUDdX/4Yw1+dJlqac8A5wW32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLJfW7r/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEE1C4CED1;
	Sat, 14 Dec 2024 12:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734180630;
	bh=G3JX2JlTgHaPdN/e/HmSqFo0L1aTr6iDjh4V6VPY1y0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DLJfW7r/guCH7FIvIn059dW1efzKplVoOvn+lvrUnTp7BZgx6iIwwwcPm/kjoNbZn
	 nLBp1dsOmavikyxVFPElrGlCO4gURGvQ/bU64k4XguPj0fzuoZW0ncuw/B2vqbzrES
	 E1MK6rdt5rIvoYGWHCBllr9kE48ArhqIH5ojsGLfXrDLg3cPVvAdtf/sfcH8AsKJat
	 H0XAXbfK39vUc6U7sfYGfHoCJNZ0YsBeU5H6zdqdXAD1S0zrxGmymHyv/2wIuvTdqx
	 r4TG4Qf+aFeVR8gBYyvhBupBH7flYY9Marj3J7OfQV3b3HC/dnYbs9iB8vKvMahzx4
	 /YjGy3l6xWwuA==
Date: Sat, 14 Dec 2024 12:50:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v8 3/8] iio: backend: add API for oversampling
Message-ID: <20241214125021.28acb1e2@jic23-huawei>
In-Reply-To: <ac529e7c-8655-4ef1-9bc8-9081d3c365c3@baylibre.com>
References: <20241213164445.23195-1-antoniu.miclaus@analog.com>
	<20241213164445.23195-3-antoniu.miclaus@analog.com>
	<ac529e7c-8655-4ef1-9bc8-9081d3c365c3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 17:10:58 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 12/13/24 10:44 AM, Antoniu Miclaus wrote:
> > Add backend support for setting oversampling ratio.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> > changes in v8:
> >  - pass oversampling ratio
> >  drivers/iio/industrialio-backend.c | 15 +++++++++++++++
> >  include/linux/iio/backend.h        |  5 +++++
> >  2 files changed, 20 insertions(+)
> > 
> > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> > index ea184fc2c838..e56b1e96652d 100644
> > --- a/drivers/iio/industrialio-backend.c
> > +++ b/drivers/iio/industrialio-backend.c
> > @@ -681,6 +681,21 @@ int iio_backend_data_size_set(struct iio_backend *back, unsigned int size)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, IIO_BACKEND);
> >  
> > +/**
> > + * iio_backend_oversampling_ratio_set - set the oversampling ratio
> > + * @back: Backend device
> > + * @ratio: The oversampling ratio

The 0 vs 1 as no oversampling debate has happened a few times.  Perhaps just
add to documentation here to say 1 is used to mean no oversampling.

Thanks,

Jonathan

> > + *
> > + * Return:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int iio_backend_oversampling_ratio_set(struct iio_backend *back,
> > +				       unsigned int ratio)
> > +{
> > +	return iio_backend_op_call(back, oversampling_ratio_set, ratio);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iio_backend_oversampling_ratio_set, IIO_BACKEND);
> > +  
> Needs quotes on "IIO_BACKEND" here.
> 
> With that...
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 


