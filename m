Return-Path: <linux-pwm+bounces-1896-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47158A1758
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Apr 2024 16:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43315280E0E
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Apr 2024 14:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D58749F;
	Thu, 11 Apr 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gp3S904r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F211C2E;
	Thu, 11 Apr 2024 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846139; cv=none; b=RVuqwaHKGVGgNUBJoV5TYfheL6Xr9xK81E8Ii1NWdFswDxMtDRaXEMD1R5aZtMWEQfT2G+okitv9Smc2AsPef4d2pCxbWn0UzVemYQ8bimBbaNr1zp/twY8TfILmFvbJHiJ0KH46A3L7gf8PGIXlZT5pGRqq/uHghbiCX9KgBxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846139; c=relaxed/simple;
	bh=y56pggh6v4u8JozsWax5N7kSFtvMWF/NKsPwxfg55Bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQb4pQxpL6AS1uLP0bUvO1U8oYXKNOVrnykyi3h6cRl4nqTz0hlBkUQWcSNMthCxkyU6g4IPL7VyozVESDv5i1EWyRzxlEq9FnbmaW1vwwKzgBjuFSy7F7ikinSq+iZdJMESe2BHVPHjRWTXDmpJd4zND/jdWfIBTaKTcgavm5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gp3S904r; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6151d79db7bso90456697b3.1;
        Thu, 11 Apr 2024 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712846137; x=1713450937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S38Xw7GZvbXl2KyYUbvZmsZk8xa1F0iUzqS2DgFhfso=;
        b=gp3S904rsGS62h69QmxxVfjmO8lyTkJhMlgdKawrgxlSWpfWAO61m+B46Q3RevDkeo
         4ja7R6swEEyRcXpr8Plh5ITkdh8dXX9zL5w2VwqDg8UpNUs3tx5ytoTnst5LPmtlnYbq
         0+6Un16MzTLMZ2r6RK19/ZMVVZN1hfQwc7XO8CGwzeTWSg9gOsUzJIiQIetL1gd582O+
         Vkne0k1+oll+OpLKUbch4RWsShpfguZW0XTZtRoc5nAoCO12Y/YxxV2NznZA0wZ0WpHE
         xqurEg+2LEfBx5KjU/fy/MRFrwDv5iepdmA6qdvAaee25Dyy98nImb5bJ6ZWQYV2wItc
         QQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712846137; x=1713450937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S38Xw7GZvbXl2KyYUbvZmsZk8xa1F0iUzqS2DgFhfso=;
        b=X6zg2jatAVp3UnUa+JinTeGSR2RP4bDernHqvW+s2IbDUcHP25TQe9d+QqvB2kV1pP
         zZ9ENvbhC9h8us5qvpMEZSL4WUG8PXozL92zMsEksh3mDAOyTKfnSBaP4IXamm+Z4mNO
         A5Sqo0ulnOPo/XOaCWdOF3fkQ3cNLvuvW+9ij69vm8bnsR/DCHEcpFx69k5s9k4BFTVx
         fx3NWfBT2a6WirZH/sJ1TUTRY2KrrnrgyNezsonRqHrAh0VpHJ+xg5DFkIJXmA+s+oTo
         l6zJVSqrRvt8rQISG7q/C1YWkyaBJ8ta/a1dbgy29T3HAP6jB080CzH/BBZ1O1ybRd+s
         1yPg==
X-Forwarded-Encrypted: i=1; AJvYcCVQvrEMWZEZPRoqfUqHvQ8GKCsC/23slZCNri5hSa043bMWf+oDyTf7ITCgmx6RXKXy+FLul1F9YfkncWUG0Toqx0fwSJuPKFCeAnMyg34t485L5pViY2l9jpfGAYtvNzvi6irUSg==
X-Gm-Message-State: AOJu0Yx+bcMr7LnEjHI0XcgwNfar/am+i6fAgRtDvjMOfpmefqtoNLJh
	R7q89FoCHREfx/Mekpf4mU2HNWEUSrDQLeN0qS6meCaQX2e74unYLbJyFR7n5uNgXZbjhBwHU9G
	NQnFyJD5RZHfFXjaJ4JF+oqTFaqU=
X-Google-Smtp-Source: AGHT+IGWZrzsyPJUo3DLr0SbGCnVytTgEOhJLFnDzSDxwXe4EdkJ3WD6rLMcDII9/iga5WZXIJdZ/lR9EXlYKZdttzA=
X-Received: by 2002:a81:4907:0:b0:615:4653:1c11 with SMTP id
 w7-20020a814907000000b0061546531c11mr6336072ywa.12.1712846136880; Thu, 11 Apr
 2024 07:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712732719.git.zhoubinbin@loongson.cn> <38c234d548b4b9c334cda6e7664a803896b31f6f.1712732719.git.zhoubinbin@loongson.cn>
 <c1399191-6c6d-4eb4-b05b-f87a9f2b4152@linaro.org> <CAMpQs4JiLGJ-nBDmj1pe0SCqKeCnz5DrybJAKE8_6up293YNpw@mail.gmail.com>
 <98d12a5e-e291-40f9-8334-3b5f53ed79a8@linaro.org>
In-Reply-To: <98d12a5e-e291-40f9-8334-3b5f53ed79a8@linaro.org>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Thu, 11 Apr 2024 22:35:25 +0800
Message-ID: <CAMpQs4KgzOjJe52BAhTb5P4t5ZynkW9AUEzPBkX_1h5XHuk5Ew@mail.gmail.com>
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

On Thu, Apr 11, 2024 at 5:07=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/04/2024 13:01, Binbin Zhou wrote:
> > On Thu, Apr 11, 2024 at 4:26=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 11/04/2024 11:16, Binbin Zhou wrote:
> >>> Add Loongson PWM controller binding with DT schema format using
> >>> json-schema.
> >>>
> >>> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> >>
> >>
> >>> +properties:
> >>> +  compatible:
> >>> +    oneOf:
> >>> +      - const: loongson,ls7a-pwm
> >>> +      - items:
> >>> +          - enum:
> >>> +              - loongson,ls2k0500-pwm
> >>> +              - loongson,ls2k1000-pwm
> >>> +              - loongson,ls2k2000-pwm
> >>> +          - const: loongson,ls7a-pwm
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  interrupts:
> >>> +    maxItems: 1
> >>> +
> >>> +  clocks:
> >>> +    maxItems: 1
> >>> +
> >>> +  '#pwm-cells':
> >>> +    description:
> >>> +      The first cell must have a value of 0, which specifies the PWM=
 output signal;
> >>
> >> If you have always the same value in PWM phandle, why encoding it in t=
he
> >> phandle in the first place? What's the benefit of passing 0?
> >
> > Hi Krzysztof:
> >
> > My thoughts are:
> > First of all, our pwm has only one output signal, so it can only be 0.
> > Also, as you know from the pwm xlate function, the first cell is the
> > pwm index, so I fixed it to be 0 here.
> >
> > The xlate function:
> > https://elixir.bootlin.com/linux/v6.8/source/drivers/pwm/core.c#L106
>
> You refer for xlate for PWM with three cells. You do not have three
> cells, as you have only on signal, so why insisting on using other
> xlate? Do you do the same for clocks? Or resets?
>
> I don't think you use appropriate argument in this discussion. We talk
> about hardware and your argument "I don't want to use my own xlate in
> the driver" is about driver.
>
Hi Krzysztof:

Thanks for your comments.

Emm... Indeed, I used to think about it from the driver's perspective.
From the binding perspective, two cells really should be more appropriate.
I try to make the following changes in the next version patchset:

  '#pwm-cells':
    description:
      The first cell is the period in nanoseconds;
      The second cell flag supported by this binding is PWM_POLARITY_INVERT=
ED.
    const: 2

Accordingly, the custom xlate function will be used in the driver.

Thanks.
Binbin
>
> Best regards,
> Krzysztof
>

