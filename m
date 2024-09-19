Return-Path: <linux-pwm+bounces-3297-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FFE97CAF6
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Sep 2024 16:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC94B285273
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Sep 2024 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76101A01DB;
	Thu, 19 Sep 2024 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tejh5jOt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250D219E7F0;
	Thu, 19 Sep 2024 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726756111; cv=none; b=Fi+p56tSc8t8iaPA12mfBu5j3PURp4VRZ3EA7AYZj03eh0Shp0LMJmePYenKNfDAjqST73mvGtjCBA4CyO9c3zoheODchyTGMxOcmPA2DwYxzIhS0AMTW1MWElpwKtRiA+JiBwHRbIKh1+uCn2Dgxxe5K/myHGXT4UVYgqDzr9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726756111; c=relaxed/simple;
	bh=Lv99Rd2xF1eeQ1uPXvtn6uzDKVYNGbOgwen3TkJJj/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzM0cozH4tTebYFT35w0+pzU1gQqWlMWo7a4UMlDvqbI6OYVlKrFazxoNFM5hsepP8E+Aw+AY4E9n59TIzQc5/DC6JfPcF+v47kiFJot//8Gt3BBcZ3Eqg+JAjcGDtJbufveiYii5+kO/sq+dYmP5gqgt2I8Cx3wW3e5qG8zZA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tejh5jOt; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-710d5d9aac1so503886a34.3;
        Thu, 19 Sep 2024 07:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726756109; x=1727360909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lv99Rd2xF1eeQ1uPXvtn6uzDKVYNGbOgwen3TkJJj/k=;
        b=Tejh5jOtpaLgQGq7sJ8XfmGP73YeaqnQ6T+HAyH7wGLGriFBCAfH8OR6gHjLoG1UjS
         Ef3cUWJ07bbklFjxeqPXA/flIu2xFGGZKbZds97InJqOib+u+UMvnmDh/tjhrlvVT0bo
         YRLvkF5SEWQ7PDs303vTUs7ZlS8GjHZVQPNo29zCTW29th7ZcmRqy3HxG2VKT8j5Y/Eu
         hnxkm7yloK6VHE6C68aLcAp9i8msEuGY8AnUvDsf89teZlZ3eoY8b8Ho1ctgHiy3SZlJ
         7pXKyITYwgvXS/tnuqgPW/n9NxjmWijcjeB/f2dBp42ztGxfCl2GkiRlIKiKEid/nhtP
         vyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726756109; x=1727360909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lv99Rd2xF1eeQ1uPXvtn6uzDKVYNGbOgwen3TkJJj/k=;
        b=OGsmlA2cjBNYsixK1/mW3JKL85pmhlzmM4E8pQ8yjDLEaOMmr5WY8XFSI8+kSeUNep
         x7AZlAFaG9aTq2T+xD0RkHu86Y+rRDRz0woM1i3iVVVG6d2dafuQnDouKEJu8WgnpOrz
         47HG1yWGuLljLQMRwHTmBJTVt+Io15rFGJNIL9z+jb8Lee872eqwLX/QTH8Z/4vqFv0z
         +QZ7XDpI1lRL3+AyCH/dPG0UVtlrttt0dI03as6nDBLw//6VGcLkWiGscrOY5hmo9qhU
         PGjlQvKPEsIdHs+3J+JvdEMjCmD5KkAZs9WyOfX4D2B8U47WIZb24iPOy1c1QgjaECIU
         124w==
X-Forwarded-Encrypted: i=1; AJvYcCU2rwerUuAjwj6u6pP7shQqn74Ji0b1MAvWQwsOdwBTOgd+ICIHW+EujyZQw2kV4OJi3beh1BmHKHVx@vger.kernel.org, AJvYcCUUITYjE97gFuqeF+XnMRGx7b8SRDvRfNfLfPmRg2LcpFkRZhKnZcFwg4q79zfymk8x8vs5JUVUFkWH9eSM@vger.kernel.org, AJvYcCUmWLy0s7ZReBh3e4U5pWGrELMQ4e4qHIrb0E+nJ8Si8GsJV/wRMT4x80soagF3sSxPEXsTIYI12RL4pQ==@vger.kernel.org, AJvYcCUnsGik155Z1mO9cS8QpoSy+qXenO5tUObtTn4bI4C3PZeh86VnP65kJ2uULla3AxTBsJK0K/2MICDLfC97q4qhT8M=@vger.kernel.org, AJvYcCVyeTrO+D+5/KfrJXT5T8CapXPwS4bE+P8r5Q+Z9UOoVBuuZZU75nHcw+Qra1dgoaUS67ZtBC6uvWo=@vger.kernel.org, AJvYcCWOn0i0NByVxJd8MeXB/9Z1+9vexSfN9TRWbbuJHnpDlVv6c+Bf/acudTAFd37jLHW/Lf3c8DI9/Y5zdThw1Q==@vger.kernel.org, AJvYcCWkwDQqwaag/5QB3XvDNRXHOXZByT+MaP/SgnE1qr3SaGhIPVuEgfViWoDz4FONtLqrV2eQzAi62pWb@vger.kernel.org, AJvYcCWwG3sJh5vRZo9WptqlL7YPOKgQ0X7lZ+A7dja1uExgvqWCUpZRdeeHAnNv90zJ5bRUsol1nnxcK40vzDQ=@vger.kernel.org, AJvYcCXb/xSqk1zSGTiQjVH5Ay8fYZGN/XK5bXCm9TTuremSsHY+2hP7sw/BtkNpKu8GrtmIo89bl/Jyla00@vger.kernel.org
X-Gm-Message-State: AOJu0YwsIeDaGzavVTSec5fqqm+PtJ3BIU64EgbwXW2v0cWQayTkvNw9
	81luEAP0atsv5C9gITxRu+94BfOUZ4uvIZDVDtKdZf7+cn3zP6BiOzmWxZshVsnco8MLpXvz+oy
	WUf0sWte/RuGKm0iM8n/ioeM5JYQ=
X-Google-Smtp-Source: AGHT+IGwBKKGWJh9wIKK61DdnRwd23qorQxP1cJCpH4kAY5YZpY1WQqWwNfbOqxU7M8iB6BuEvF3r+xT5muishtD3hk=
X-Received: by 2002:a05:6358:7e8c:b0:19f:4967:4e8f with SMTP id
 e5c5f4694b2df-1bb23dd5df8mr730499455d.22.1726756109157; Thu, 19 Sep 2024
 07:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
 <20240913-starqltechn_integration_upstream-v4-15-2d2efd5c5877@gmail.com> <35liocltjuxv3gjueuvpaytx44crebbc4c63atztakuq5dfpax@bquve7tkrvtx>
In-Reply-To: <35liocltjuxv3gjueuvpaytx44crebbc4c63atztakuq5dfpax@bquve7tkrvtx>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 19 Sep 2024 17:28:17 +0300
Message-ID: <CABTCjFCNuMKTeF8YyqCHGQ2CCQ76C1djL_3rja7itLfBM5vogQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/27] regulator: add s2dos05 regulator support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Simona Vetter <simona@ffwll.ch>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konradybcio@kernel.org>, 
	Simona Vetter <simona.vetter@ffwll.ch>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > diff --git a/include/linux/regulator/s2dos05.h b/include/linux/regulator/s2dos05.h
> > new file mode 100644
> > index 000000000000..2e89fcbce769
> > --- /dev/null
> > +++ b/include/linux/regulator/s2dos05.h
> > @@ -0,0 +1,73 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
>
> Are you sure that here (and other places) you want any newer GPL? This
> is quite odd. Does original code (from which you took 2016 copyrights)
> have this as well?
>
Original code permits redistribution under 2+ license [1].
Is 2+ preferable over 2 only?

[1]: https://github.com/klabit87/twrp_android_samsung_kernel_sdm845/blob/android-8.0/include/linux/regulator/s2dos05.h#L9

