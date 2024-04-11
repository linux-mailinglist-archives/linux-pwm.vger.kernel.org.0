Return-Path: <linux-pwm+bounces-1891-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E994D8A126B
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Apr 2024 13:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE0F1F28CE9
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Apr 2024 11:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7022146D63;
	Thu, 11 Apr 2024 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XY/jGxzA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF931465BB;
	Thu, 11 Apr 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833285; cv=none; b=GTQU+J7ESTESx0LqTG7079x32A/oYxE8kQeZQvxtZ7fUOur+1SKKjzkS+vkC+Ho/w6MSdxq7dzs56oagz1i/iYGaQUkt+Uon7H11GvSxiE3jKupUWfeOTvQ9nIytIODqOuhBTncR/c/VxOjtqdiHr9oahFGrxofBn/DRU1cbIiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833285; c=relaxed/simple;
	bh=8OX6q7MjpcHjZYu08W8z4DDKi4PUGuD09lBZHS7rTJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oU7sYDzbt832xVVCxpcA0VF4Do0sL9d2IdQoaSlr0tl8K2FbydTsk/5UmJl1ByfgBeAZfG6cHURnNmEvEAHnFy6lqWfS40H12XJRTdKV+CohoEbUOqP8TVmrskU+b9d1WSaP2imwbWg1Lb/GiN7jSI79K9EvNbTEeyVY1VCX34I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XY/jGxzA; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61518d33293so90062127b3.2;
        Thu, 11 Apr 2024 04:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712833283; x=1713438083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKl13NXA6/90N+K49Hi60xZmTzWhFtfft19m5BrkabY=;
        b=XY/jGxzAVLw9Lho6mYzgzml1QkXOXrEFEGkisj1D31rnDbw48gcg5eE2mKQCDmyOCM
         CL3KrcL60ZQcPTjAffav/gQurTDd/ZB8+z84lT9I9yGCxAuCqd9t4B1p7Yz5cIuBQumO
         QteC4vj7CKzNRwCRz8t5isBl6W/u6RHI5MaFKyerPF0aiclNVTWll1qkfioKQB1DIRuA
         SszrcuK6ECts4Qgz4CgdAHGh1TenEMPuMvkd64C7XjwyrzRkeXDd/eGo6jc6/xUaYsMA
         b4BHd8BvseuYrRQw2ZKQbzs7Vf6gNeyNI2nINqKoup4hr+slfwsjIksz7szb6MA7dV1k
         D1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712833283; x=1713438083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKl13NXA6/90N+K49Hi60xZmTzWhFtfft19m5BrkabY=;
        b=T42hSIhDXMAw5xwAnPnTqTajHqHi5yAmi4AbYxKKTdoYxyDF7qeBoYMLZa/aBoKn6b
         JgbuJDcakbZP2ZxCK7/XNJYVZmfL/Q7tjjCn8HAfUKi3lrkGjH3l8c5Vb1xX53i2C29e
         Gyw0l/PN3+4bIkpzAh/y+VOY1cbcgD9tRVsUopSEdUtT7VXv4iAfyiuYxW7ydlDngOgx
         7XbtPa+o0iTOH9PZzAbCCxvte89d5RgF1VjhMwnCyl2Stzr0ti1bHIm5ZN90p6s614/K
         An9tYd1Gb7uaimnEnR2YMqw+a9kJIcMYNZnXQOObCd67odWb6p/k0+UIWPciMUgtpYKz
         /8xg==
X-Forwarded-Encrypted: i=1; AJvYcCVu02t4Y4s35CnvDZKLRXHxA4waDAQevhRD+9++HtnnDXr4TIHiWGdz8VyZ5Y7Zzt+UXgL3tKfSKEdNscBgKP7kRyjgdI/m1zxSy6jXT9Z53ghgWJVcJvjVysg2JNLWNiJZoPfDRA==
X-Gm-Message-State: AOJu0YzNiXxCaySxkkQJsWGYnDVkPHbgrQRcMjDGLViUfNZrDb7xMaKD
	+RqcVPqB30hf/VOv8mc9VqYZZUKGSKdR4bYUCnM2ihP6PNFgUGRs+6rk1H1T6RXDRysxXhdZkst
	VHgVVvQumiHXLe4vVc5ymUSlzRBA=
X-Google-Smtp-Source: AGHT+IER1z7+nq7PONq6o6cpKiyuPF0b+9nOSg0EqvakXGhHGl8OP2Uf/deOlH4QwcJoas8+kUHx+9XfKrZv9dLHZg0=
X-Received: by 2002:a81:91d0:0:b0:615:3d71:b0ed with SMTP id
 i199-20020a8191d0000000b006153d71b0edmr5490699ywg.12.1712833283126; Thu, 11
 Apr 2024 04:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712732719.git.zhoubinbin@loongson.cn> <38c234d548b4b9c334cda6e7664a803896b31f6f.1712732719.git.zhoubinbin@loongson.cn>
 <c1399191-6c6d-4eb4-b05b-f87a9f2b4152@linaro.org>
In-Reply-To: <c1399191-6c6d-4eb4-b05b-f87a9f2b4152@linaro.org>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Thu, 11 Apr 2024 17:01:10 +0600
Message-ID: <CAMpQs4JiLGJ-nBDmj1pe0SCqKeCnz5DrybJAKE8_6up293YNpw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: Add Loongson PWM controller
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	loongson-kernel@lists.loongnix.cn, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 4:26=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/04/2024 11:16, Binbin Zhou wrote:
> > Add Loongson PWM controller binding with DT schema format using
> > json-schema.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
>
>
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: loongson,ls7a-pwm
> > +      - items:
> > +          - enum:
> > +              - loongson,ls2k0500-pwm
> > +              - loongson,ls2k1000-pwm
> > +              - loongson,ls2k2000-pwm
> > +          - const: loongson,ls7a-pwm
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  '#pwm-cells':
> > +    description:
> > +      The first cell must have a value of 0, which specifies the PWM o=
utput signal;
>
> If you have always the same value in PWM phandle, why encoding it in the
> phandle in the first place? What's the benefit of passing 0?

Hi Krzysztof:

My thoughts are:
First of all, our pwm has only one output signal, so it can only be 0.
Also, as you know from the pwm xlate function, the first cell is the
pwm index, so I fixed it to be 0 here.

The xlate function:
https://elixir.bootlin.com/linux/v6.8/source/drivers/pwm/core.c#L106

Thanks.
Binbin
>
> > +      The second cell is the period in nanoseconds;
> > +      The third cell flag supported by this binding is PWM_POLARITY_IN=
VERTED.
> > +    const: 3
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +
> > +additionalProperties: false
> > +
>
>
> Best regards,
> Krzysztof
>

