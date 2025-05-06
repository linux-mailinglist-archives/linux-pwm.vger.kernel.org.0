Return-Path: <linux-pwm+bounces-5836-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC99AABA97
	for <lists+linux-pwm@lfdr.de>; Tue,  6 May 2025 09:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A01CC7B0B94
	for <lists+linux-pwm@lfdr.de>; Tue,  6 May 2025 07:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E561828983C;
	Tue,  6 May 2025 05:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1z5dUuD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF95289354;
	Tue,  6 May 2025 05:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746508448; cv=none; b=jLNJ1kdSRImIYdp7nRZ2EFp8WB36bJIX+ipq6lt/APUGkoC0f+Sh1L49yHZ4U7mK93VEz+wzjN6YIrraVQwN1Alz1S/ccC2UzBTWJwwss9jze3mxFvFSWU4SEi/2cdedu7VRunQalYUYTtR+PNaYkrFHL6h92j8EtTIuxGucdhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746508448; c=relaxed/simple;
	bh=g/w1LWrilKqP38kQb6pooTCkIt2thHowZ54k63vIR2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHyvPDxTSvD5XEFX0gAjUjsBuo6CUk0Cdq+RWRTErWKu5ucyEIlRsekQwWke+jssPTiejqVGmnY4dQb5B7ZFhZIG6Tb6I3IcN8Lp5PmVzdNuXS9ESzjJPA9jIb9eYWYBIAQvShf4RKbBkRJXuGOMm9F8lUNOi6gUIW1iHuNSZzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1z5dUuD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-73c17c770a7so7474459b3a.2;
        Mon, 05 May 2025 22:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746508446; x=1747113246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pS0iuNnDrfN5JuPKmxY9SUCg0BKAF7oXTwP02sXXN2Q=;
        b=G1z5dUuDPp1vFrrK4Y+z/CMdeiedNCN01GDN4PBqouTsvYpOiFHxSct5XFqWwqp1UJ
         C3Tlj43BINfeUkOczVO4GrwKHfENGmIFSK+N1w0VVD/9KHa4Qgd709nbEC2T58q2Xrjs
         Vas8tLDpXigaz0QqRptTmdYqtj6zipn1YyruM51vzhEy9PBWUYQSzk4tevThQIGnw7kj
         Se9jN1lOUuATkXC7Hur0MXzCB+I8WnMDxjp6cEkK+l0mmovLvtVl/TkcdrxPIcPmlMMM
         Vl4QnLr1p2K0A4N/ZgcyEWT4YARSJ7bDgbS3OIF8x2g78NLevqmyVurdFX+nYmKS4UfG
         qw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746508446; x=1747113246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pS0iuNnDrfN5JuPKmxY9SUCg0BKAF7oXTwP02sXXN2Q=;
        b=BwNAApf5hbnzM4f1SmN1V7/mKI98Mr77TLiBC9tzj8GpcvbK79g1/ByDEvDBP/YAl9
         zN2dC8PuxXEM673ot+p0y9fXn7rkX8RDgVdlMgC/MzkFSwbKFoKtT435j7cWBjbFbcYA
         muMPt5rK/LkWaIQu59+8XRBXHG0FsgRdyAp6k4rBTzOcQjuO2MoyGVoKxJzrUQlbaV4k
         4wgtOevGr3nZozz6/Z2g4OdHyRYdjZr4TA0M1o49t7P+CTkmNvEjdfJHLr070z6qhT1Q
         mBJmorEpd6lU0VyI26sb3R92s/5XzcjVMHqBpm1xGpoAxrNAocactN7PdBHmoGap7i4k
         OezA==
X-Forwarded-Encrypted: i=1; AJvYcCUTwHZ8c84YrhPbVt5lI4bFkv99AAdlavrBWzUE4ItD0iy9K5Ky2fB7nCtG+YCB4GFwvRx10sCMJRzk@vger.kernel.org, AJvYcCUhtCZ7eb4V/vJx/VU4U5WEEWyGIqOfgU6GfnI2EMI0MxQHWMG/mocQ9uRfHwjo+z+vMJPYoDzZh5STSwQ=@vger.kernel.org, AJvYcCUxuLG7Ty6qOJy6WrdvllsRDeAEVS7whLhGTjtIYRJmAHqGh4DQyNe3oiehalrLm+nc02Ygdn9Fh4eA@vger.kernel.org, AJvYcCWjpO8N5f+jGwy2s/QTbmf1bSVzbWNCqfO+P1+nWYdJgkH3ty0UNHLiFcy9gB74W6eMsNAg1to7ze/rBA==@vger.kernel.org, AJvYcCXNbiiEdJAzN4ySCqiS41YWjVt7aZMKaO8KXjk2T6lk06qHjPYTaO3ozsO+L+tlkJQg03rGCxmVuEcwrKZn@vger.kernel.org
X-Gm-Message-State: AOJu0YzzMHUU7J6R8tHGcKcS+cJ0R7MTJ1YMfCGfIBBlIHOvkXRaQbKr
	BNIc/hjSvYuz0PBbYtCyxuzB2WG49ht+IYoKIV6stkOqiOF7g3wj
X-Gm-Gg: ASbGncuVqs5N8lNbjH1TPPoHFTEfSL7mlyPnuzfsk+9kLnIjnwtDa3Og3gRLUHGVR4D
	w/hPhmYejGscFzAYN7dJwdJudsnngZmxMkd3VZRrSzGvhTn0rnQhYUwT7Qgh5t3hsJnXFUPNN3n
	JZKFbFEgkB24TJLfKixDNJ9de2sc946SthYJdFbFf57izlzETFhlCA9ylS5RzkecEzbNZ5qjMsq
	0QjJVybEeXXyenih3LAbeMmzzd0zEXd8KKuPRStbTYgkTsK3IbBHcpAm2GGYu1W1JKsCqYC6B5q
	k4Jwa9kd5JPRVI9tPZLB/tbLbx6SZx7ukh5iSPP4G+9IemXUqhF2
X-Google-Smtp-Source: AGHT+IEjUJofINkDZHEFOImlgP4FAtwJXz6KioPdAiI2880/99Nh8quz4k0gej+fzJl4Qyzl3HFAxw==
X-Received: by 2002:a05:6a00:f0a:b0:737:6fdf:bb69 with SMTP id d2e1a72fcca58-7406f0ebf2amr14738585b3a.13.1746508446572;
        Mon, 05 May 2025 22:14:06 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:17ab:9e47:29ba:57e6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059021483sm8156840b3a.93.2025.05.05.22.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 22:14:06 -0700 (PDT)
Date: Mon, 5 May 2025 22:14:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	=?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 09/11] input: keyboard: Add support for MAX7360 keypad
Message-ID: <aggrss4doko5scdlmyzdsujkifryzuzqdnpkh6sd33rg5ibqmm@aiikzv732rkq>
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-9-4e0608d0a7ff@bootlin.com>
 <aBSii0rHox72GM5Y@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBSii0rHox72GM5Y@smile.fi.intel.com>

On Fri, May 02, 2025 at 01:46:35PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 28, 2025 at 01:57:27PM +0200, Mathieu Dubois-Briand wrote:
> > +	error = matrix_keypad_build_keymap(&keymap_data, NULL,
> > +					   max7360_keypad->rows, max7360_keypad->cols,
> > +					   max7360_keypad->keycodes, max7360_keypad->input);
> > +
> > +	return error;
> 
> 	return matrix_...(...);

Because that function has multiple failure points please

	if (error)
		return error; // or return dev_err_probe()

	return 0;

Thanks.

-- 
Dmitry

