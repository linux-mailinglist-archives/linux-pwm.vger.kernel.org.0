Return-Path: <linux-pwm+bounces-4343-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B3C9F19AE
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 00:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9367C18871F6
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Dec 2024 23:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B291194C7D;
	Fri, 13 Dec 2024 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YVTlMtk8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6161B219D
	for <linux-pwm@vger.kernel.org>; Fri, 13 Dec 2024 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131462; cv=none; b=qHC2qqzcmC+Rp7MoQajQkVwVGeOK0gKkFUq7agBrpiHzJsnksFWvy0rfkwv2YskIgaf/94NdVnMaAhtImBMOCd+iuGdWQ2aXrjj/GrOpfUq9yLWUb51ufX55kygqsSLUtC2mOk87XeDiWgazsGGXM2NrqJ2TLBnq2YPpzH5xo7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131462; c=relaxed/simple;
	bh=rmUX76AAhJtcbKbS/MKBhumEX3FZeF756LBDXcfM/+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=adt5BdCanSQjvNz9KvGE1LQt81XUVBQueQPQ+dXppK4gQJDqtS/IT9zK9qD4nkLFYpiUvHJI4Ud8sdbhfKvXUpHrkdS2GRdtqEWZC2cv7WjhP+/AzoRSU91uhW3sxtWhadZVE+Q4I1eGXlnoH9iTYNo01w+ZX0B7xVxkcoo7c9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YVTlMtk8; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71e19fee3b3so1771383a34.0
        for <linux-pwm@vger.kernel.org>; Fri, 13 Dec 2024 15:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734131460; x=1734736260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6wCKCByuAlAaTXDYVy4N76cFvOrIazxQnE0CZ0HL/Is=;
        b=YVTlMtk8/qddeqAYeD/4WSY4D5wB8+Vtzhp87Pwg2DeyD87QvTWYwv1uTZxAT73p+S
         CZCXI+B9QI7p3BlrqnbjejS5APvutEbap1uB2Ql/KAmIGwCDQLAn0pBnUjXjPyl2JzOX
         xDr/a3HJCGMe2nXvdf7+0h/OsCmZDoaUTspY73fiSE1MFWPiGcD1EjxjQ6I22094tq/P
         fO023AOZO7JJfbe30SHUK72hNcakDBFmReObO7M2NFLMJ1/Diw/Jc3w7b47Qzu/rOghL
         FDXFQgvBFqUyX3BkOblgZDTHMftzS5fe48sdyoYXvUPUxKIgUVN2UAD9MimTDpKkCFvz
         pziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734131460; x=1734736260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wCKCByuAlAaTXDYVy4N76cFvOrIazxQnE0CZ0HL/Is=;
        b=BR6puP1elr9b0o3WRTbSaASn3d3/NckwC5/cyUTWdoowWDiIh8CsDY9cHyQfqY7msC
         iaR2epUlKDm7ekrJ6KOfR4otFHgb5STTvwok+X0FgyzQH+KDhIGefvtFtMipoMPU21r0
         9sw17utqjd4lcshNgRRi/3wf6BXH7Vp254VVK0Jw4oqI7/Pg9kGHzFDeFc9W2utkUR54
         ZAb7/7E7AiESxfL7v9LigEgT/djLa62/3oAT9Va8st8CvGTk7Yv3pv5SgUk3HHIAPiTB
         H3Pbc4BetPPKNa725UOPq/y0sC9fibI3W+EaINWyphFFH3vhZotBdBuXRK7jiZ9IcXn+
         i8xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlfeVlCQSc8irJsBbOK15OWIwNk3zUah7JmgwX1ksXT/qge5I1ithxzr5QCZ+NwqmHhVGwFHPDkZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1LpySmkjbjeI+RORbeCO52YVR70c01q4n6a4aY8ejGhrlJkaP
	GEwJzaKcGrpWxvsIEWLfQPBr+9vqs6l+rWapEdNUvu0wgqleIqbz2SXV5xrEnU4=
X-Gm-Gg: ASbGnctHEXp09Jpa5frAnwxFIxsqUvtYI3pTBQZVZDjWWry1yhUcFteTIJAnQXPbXVj
	w/hNinD72lTGPBDwXQzr2nKLTAQSocNA8BARmYA46QbfRH5+Jim7iALP9OcGQM1Dd0OjDNY1eOL
	8gR7SLGm3ELTQfLi71aaggaEJ8yFuvOPPjS5oX2YAPGsdxGdizUrwfSK9SPWlcP5TC71v0wK+Rs
	DHeU1ZgVhE175bj52ahIhKBL2LB49qhfLgxB2rlyxYxmxq8SS5i8n0t7uyKN0r2tzFfzCl7FchJ
	iKFQUPmSJ/BryCpcIQ==
X-Google-Smtp-Source: AGHT+IF/HrkFYofu0XYPQ8FOsQdBFSwRshag+zqD1aQtDkwS7D9uEJpxpNj5EPvXNNnZAMQKCg6HNQ==
X-Received: by 2002:a05:6808:190a:b0:3eb:3d21:9cf1 with SMTP id 5614622812f47-3eba6bc2f20mr1744768b6e.13.1734131460011;
        Fri, 13 Dec 2024 15:11:00 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ebb48ce912sm119808b6e.40.2024.12.13.15.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:10:58 -0800 (PST)
Message-ID: <ac529e7c-8655-4ef1-9bc8-9081d3c365c3@baylibre.com>
Date: Fri, 13 Dec 2024 17:10:58 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/8] iio: backend: add API for oversampling
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241213164445.23195-1-antoniu.miclaus@analog.com>
 <20241213164445.23195-3-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241213164445.23195-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 10:44 AM, Antoniu Miclaus wrote:
> Add backend support for setting oversampling ratio.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v8:
>  - pass oversampling ratio
>  drivers/iio/industrialio-backend.c | 15 +++++++++++++++
>  include/linux/iio/backend.h        |  5 +++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index ea184fc2c838..e56b1e96652d 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -681,6 +681,21 @@ int iio_backend_data_size_set(struct iio_backend *back, unsigned int size)
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, IIO_BACKEND);
>  
> +/**
> + * iio_backend_oversampling_ratio_set - set the oversampling ratio
> + * @back: Backend device
> + * @ratio: The oversampling ratio
> + *
> + * Return:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_oversampling_ratio_set(struct iio_backend *back,
> +				       unsigned int ratio)
> +{
> +	return iio_backend_op_call(back, oversampling_ratio_set, ratio);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_oversampling_ratio_set, IIO_BACKEND);
> +
Needs quotes on "IIO_BACKEND" here.

With that...

Reviewed-by: David Lechner <dlechner@baylibre.com>


