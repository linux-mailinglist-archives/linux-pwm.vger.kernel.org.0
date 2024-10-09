Return-Path: <linux-pwm+bounces-3571-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3838A996E80
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 16:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696B41C22AA7
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 14:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBE319C54B;
	Wed,  9 Oct 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZPAIoH9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C78558B7;
	Wed,  9 Oct 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485145; cv=none; b=IT88Bzn1+eOWHtHr6keowi2Q11v63SWKQ2jSGdwPS85jMwEcd92d6GBDEg739cTMTUz/P59TJShx1uqu4kXbWFpvK7pye0vDgkwkgqXSosvB45gkmN2iw5yxDhjyK4N0TW+n65S109EX4JuuLTu2hDLfSHYr//7rbSzYdmF43zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485145; c=relaxed/simple;
	bh=z9giLuqh+16SRki7I+asllyvLxyx93m2RVSASHgNCqM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H+PstWT+d18YVkQnVQaMoTVw2ZjajvKuIbcgQT3TmDEmsvX/O4eoYQMyUYNLR54r1G3r+lD8aH/gnRalaMCUB4z0LEHKnSw5SzBj4BwdL2Ls8Fkf/XFuccxTUG3LY2sjrc5fw1mz4aJ755tgi62+WomyrHCJkacCjbBiX9hGgUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZPAIoH9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a991fedbd04so469512466b.3;
        Wed, 09 Oct 2024 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728485142; x=1729089942; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z9giLuqh+16SRki7I+asllyvLxyx93m2RVSASHgNCqM=;
        b=eZPAIoH9dOqou1h82T1wEeCFS6LiBeSrdVYdFbL9MESaBrywDMbe/TVxqKdKQdnkXH
         mo3bSe0PGa+we3t3KuMbWSBLCNp78snCRDgsyI6aPy4v7J6vdv6+o/cfUkJjm2pQH/pn
         vXn7zh5n/1N5mVtqBSRUG+hEQ2y+uTKMxZzQ1rC7UbtdMvaVpV1jibCj3ymcFOEqk/iS
         Me2CM9uPYrcE87u1xFYSESLUuoT0j3D5/RNHIduEgN6bBYUCfBQF9s/Bnk+pkEkwKrcF
         a/cNrDe5nkuu7JrpIWd2AM6TMCyEoQKGcWiBob4DBowyBKKBkN9EOACRM3RnAs28V91o
         jo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728485142; x=1729089942;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z9giLuqh+16SRki7I+asllyvLxyx93m2RVSASHgNCqM=;
        b=bNjH07u8xAxo5z+yb7wPWYb4VfjMO+sq3Xv4/f4PmpJUefehb8W0yB7GNahgPlIUCz
         G0HmqIfKYGH/+scBVxzFQT/yT2pwY7rljIBsYXdHk45Nd1dWMTmS3uRbsrk0WJPPwWbQ
         0wwXYeazLJJp5habpdXEZUKB+8qr9gOw6XmEaz4VLAbNVUNAAsSz5hn4X33ovS14jT/v
         D3OJIyDmzfAXGgYzp56G3h2kQwyOLPXeg6j4DKnZsmPjvbfiSLGesaWswUpWf91PoSCC
         wqGbrklI4G+liov9tzgU1cMz+kSTjSm6VycY7Op/zwzaEOM5fQ2XQVL7CKtBAT/ZH/3Y
         Ulcg==
X-Forwarded-Encrypted: i=1; AJvYcCU8++z6ij+iq9mJg/UA1DS0i1vc9rNCXcgWqanDLvOwKzV147v+EZi/nlMJh6hvxziVPMpKBk5UczWr@vger.kernel.org, AJvYcCUIoAMCIX8AJk7UuF6QdKdUX15doU46o0dJjNkTHGb9HeGUsMZzbL+xV3gVWNfW3kmlfUz2lSApM3Ho@vger.kernel.org, AJvYcCVFbDs+V6sCns1E5wKSHTkFqrEWSCzJW8aSyFGjKdI59HjGhN8LDSipDMVmsdc6kSDDWYgp1tUFp+684xYB@vger.kernel.org, AJvYcCVHubqXA5NLGATafsIac0hY4SONLiX3/ugulVXJIHm3Ld5Eb6a/hqFQXgl37N/djmgeNotFyHZaBsX0kKI=@vger.kernel.org, AJvYcCVkpNVE7ohx9QCKcgD6Zmf7dg+Jt2w81pZY5bR9G5jPx81q5nHGEQKsIS16O5CTs4UvD3GR2i232V6J@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2WVBCO1N4VUaVHJIxENodO6CAQ/9sKxfE/8wrcxYQ0guakz0U
	n9JkDicjMZ5DPk3tuL4q327N9y87ouf1AJNv13maRgbqjYHCP1Y3
X-Google-Smtp-Source: AGHT+IGk+GcMmuO86SrRgY1+Q2QlflBxWNF5bBi07sPlNbBqwIH3NgMDhUtp/UVsAj4mjY+cT9/v5w==
X-Received: by 2002:a05:6402:2808:b0:5c5:b7fd:170a with SMTP id 4fb4d7f45d1cf-5c91d624cffmr3578210a12.28.1728485142287;
        Wed, 09 Oct 2024 07:45:42 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05f4010sm5540116a12.93.2024.10.09.07.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:45:41 -0700 (PDT)
Message-ID: <bff897a52650dbd499a83d955645cbc2290f80ce.camel@gmail.com>
Subject: Re: [PATCH v4 8/8] iio: adc: ad7606: Disable PWM usage for non
 backend version
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Guillaume Stols <gstols@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com,  dlechner@baylibre.com, jstephan@baylibre.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 09 Oct 2024 16:45:40 +0200
In-Reply-To: <20241009-ad7606_add_iio_backend_support-v4-8-6971a8c0f1d5@baylibre.com>
References: 
	<20241009-ad7606_add_iio_backend_support-v4-0-6971a8c0f1d5@baylibre.com>
	 <20241009-ad7606_add_iio_backend_support-v4-8-6971a8c0f1d5@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 09:19 +0000, Guillaume Stols wrote:
> Since the pwm was introduced before backend, there was a mock use, with
> a GPIO emulation. Now that iio backend is introduced, the mock use can
> be removed.
>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---

Maybe this was agreed on the previous iterations but I wonder if we shouldn=
't just
bring PWM support in the same patch as backend support is added...

- Nuno S=C3=A1



