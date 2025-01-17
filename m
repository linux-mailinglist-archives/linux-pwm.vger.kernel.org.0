Return-Path: <linux-pwm+bounces-4663-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 953ACA153FF
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 17:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3BF16336D
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 16:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6D5199EAF;
	Fri, 17 Jan 2025 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5ccEAON"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5039913AA20;
	Fri, 17 Jan 2025 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130637; cv=none; b=lV9TtklEwl+UPRh/rE+IvZ6Pa2x9OAtVerxCqUQVF0BR8Gp/8dauvmylNMVdZpLBCA+k7Mx2+2CizN+KyPKj7PPhEcgHzyTs91DjpXeQgQza+c8l+/GcCii8+0JLY4h6sDo5v6EKi3cjZRU5zB5POLF/jCRiS1yDU91xyJVtJHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130637; c=relaxed/simple;
	bh=EIFm573qjQFYPTtpjfgKr8Z9H0Qzu80JEeU0ole3puE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uWW0kp25Su1tt4++p3VUGkj72DeVXgQG8hvB0XM1oumi67T7uIkgBYXnY5NC5yDY3sy50L86I92rrlvhHyoWVEhHAYtVrXyQLLWR3XbUoCXVYIumNCv8hm9naretqaJ9UIRKkrJv0Qdt6kAFXqFMtjOOUIr507EO3lZryPibxrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5ccEAON; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so1299970f8f.1;
        Fri, 17 Jan 2025 08:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737130633; x=1737735433; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZO7c6QKP3n7UrTlvKpzaDegMh+1KSou8Ur1Lk2dOBS0=;
        b=f5ccEAONXcZh2L/GT6lXZ+PwLL9m7BOXdWk7gGpkITh1iJ9V8xR/oKq+MQpaS4K97b
         HjI+azGH1z60N3ooHHtYOevxV36eGeu1GL3xFgtXvuwwi5d7FodEFlNW/AgSQQkKBKPA
         unfA+s5GvXc1SlnBW+rjop4mz3ZbjCbq6UgEeB44+0Z8UpGKfuQ6QZAdno3Qo8qoSV3u
         0gSVnPMQK1Zn8lXNfvPex6ChkBVqIa+JyXgagnyHH/TgLUc7KwKo4k8Q1/YSb3B7q5Yz
         tAYIJFKJWoaRsL6dq5dc+uEn95VUpM2PmivudQvbQYESa7QZ2VwzrXHB257ewOATSEZd
         FHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737130633; x=1737735433;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZO7c6QKP3n7UrTlvKpzaDegMh+1KSou8Ur1Lk2dOBS0=;
        b=ZUk/Cz7cP2BRzgSne8CG7RKq4s/VeKUIJmtyYV3WrqCMi3tUIdem+2FQosih4RlXvJ
         UiFqe8h0cIEl/OtWrrbfgtDn7gHm+Ni6oPyCdUp4y+TSSOv5wXLcDRRBrSk5cO7PjJIp
         EwgJUXh6EuYrODNSJD6ocp+pKg631GTN79aIZ2WmA0t92P6UoGwXXqCmMr73tSKsTQZd
         jW4dqgkJEnHsomhA3kqLagMMuWbe3a+4IJux9Uo8x50DQyQS6G+PnnskTpOWq+vg96VC
         7XXydccGAm3oFX5cm8BoPckjAjBhIJd9ahF7I16T75BVoKnYEQBnRY92W+AerDYJirE5
         jP4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNoTiSJh/xf4qgoWHrP0L8QgZ1LT0va6mrxb2qs1Z/G3+U3LMOOhe/n5WcRU5CHAM6LafvgL1Cx1Gj@vger.kernel.org, AJvYcCUTrQK7nVoOAAjOpCIOT5c5NZWWJeisEbx6W9n3o3ncun7Be19918m0rF2lKfP8SKTuoPe4rgl5G4vC@vger.kernel.org, AJvYcCUagdSNTYtjQOCAIjKI9QYr8r5Pw1w3b3lvz/jnyRlBvaUGkUiuds881dNJbZ8bF4L4rZA//WDAr5A7xlFc@vger.kernel.org, AJvYcCWyjlRbM5Pty8h4dvWbJh4dsx/JvmqFGHlRzGOJuazAsEUy5iyOgFf5b7wEfRyCY8ropcaZ470IUMhj@vger.kernel.org
X-Gm-Message-State: AOJu0YwlkfaOutRbYPZq9COcmDU8sdqOqYaUQqRO/UE92Jayxy+3WbXB
	GDjOwJTCQzzyGsMjtgwlIzk2aeFnNeLGW6OeCMcemQMHVEpfAejY
X-Gm-Gg: ASbGncuEcDsbxkwvwHyE1cWtAtaTTJtXB2608Z6DYmEf5C14BVamUheWMdMubHZGFpt
	MDhUefpIOPOMY5g+3lIYgTFD7GQkVsMwx7tGnEyZq41/Wc8WqDnxaHSPPg0K8mrt3lrO47DM5z3
	WBgTwIZtfwV+kMbHDoIdLszFCqManD+qxSk1tS6OzklwjoLC96iwGmMqmGWRIzXUMPah3FSIQya
	hbfpycAbiCJ1tLJvT/0p8Sbb/LFHFUgL1Jg64Ia5d04ULjRX37ni348D1u+/S6Yq6T6ZV/ikJCl
	FxZ1TuKzwMKTVRnSJNbqCXuusZza
X-Google-Smtp-Source: AGHT+IF0mlebPsnuiGvpM3yrpjt/JDf74jsdmGpEaknPt+gbxZpiJuCUCLi1Zyn6P1QfFce8sDyAXg==
X-Received: by 2002:a5d:6d88:0:b0:38a:41b6:d685 with SMTP id ffacd0b85a97d-38bf564d621mr3471231f8f.3.1737130633515;
        Fri, 17 Jan 2025 08:17:13 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890367b48sm38108975e9.0.2025.01.17.08.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:17:13 -0800 (PST)
Message-ID: <fb7fe85ad22d778bf462231e693285c7b3d33b98.camel@gmail.com>
Subject: Re: [PATCH v10 3/8] iio: backend: add API for oversampling
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>
Date: Fri, 17 Jan 2025 16:17:13 +0000
In-Reply-To: <20250117130702.22588-4-antoniu.miclaus@analog.com>
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
	 <20250117130702.22588-4-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-17 at 15:06 +0200, Antoniu Miclaus wrote:
> Add backend support for setting oversampling ratio.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v10.
> =C2=A0drivers/iio/industrialio-backend.c | 15 +++++++++++++++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 5 +++++
> =C2=A02 files changed, 20 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index 2088afa7a55c..d4ad36f54090 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -681,6 +681,21 @@ int iio_backend_data_size_set(struct iio_backend *ba=
ck,
> unsigned int size)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, "IIO_BACKEND");
> =C2=A0
> +/**
> + * iio_backend_oversampling_ratio_set - set the oversampling ratio
> + * @back: Backend device
> + * @ratio: The oversampling ratio - value 1 corresponds to no oversampli=
ng.
> + *
> + * Return:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_oversampling_ratio_set(struct iio_backend *back,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ratio)
> +{
> +	return iio_backend_op_call(back, oversampling_ratio_set, ratio);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_oversampling_ratio_set, "IIO_BACKEND");
> +

Hmm, I'm very late to the party so don't bother in sending another revision
unless you have too. But if you do, I would prefer to have this through a
write_raw() interface. Meaning we would only have write_raw() as a backend =
op
and  then you could add this as a convenient inline helper built on top of
write_raw(). So this would be inline with what happens with read_raw(). Any=
ways,
we can clean it up afterwards since we already have a .set_sample_rate() op=
 that
could use a similar approach.

- Nuno S=C3=A1



