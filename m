Return-Path: <linux-pwm+bounces-1853-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B4B8962DD
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Apr 2024 05:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217C01F23E3C
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Apr 2024 03:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466411C6A6;
	Wed,  3 Apr 2024 03:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7NNhTlV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716521BF5C;
	Wed,  3 Apr 2024 03:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712114230; cv=none; b=U7xXwSQ6yRY3dC6UUvz/1GL7ZnykV9E98RQl0GLRig8f9xV8fdVKiVspXPe0nTSojJkcY3Uo4SyxMhJGaQRlVXYoTzpU1GqZ3NAEiIaCBF3nu13ItT8u7ps4xuwTOKZBwPfX3ts5qDZiavdLqYCwdavKLCs3uPuTXiZSBY6zlC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712114230; c=relaxed/simple;
	bh=yhQ+21CPCFYTMIUz2qCScIEhQV56wfigMKX3S42g66o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBlEhfFMMixgkw2UcUEkWVaKMDvLUG6lyfS2bmvPu6UHtZRfm/an0c3rjiHcsPU5g1PXuVIYnBerCmKAucEbLIVjUNV9DJ/bi43w5CRpidHlOgCzaPBt9tj6tkTHKdFh/xtNQ3Dw5bZfG78XKH4aYYZez5Q1Y7p/EyjeBWvLqFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7NNhTlV; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-611248b4805so58681987b3.0;
        Tue, 02 Apr 2024 20:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712114227; x=1712719027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxaRFGmx+WSsmKEhp791K8SdbyUX+9RouzVHok6AmNg=;
        b=U7NNhTlVS6uIwrGKE1wsPVuGVyfM6sszx8Mp9MGt2AXYgxvxzwN/yhki3j8FiTV8HP
         z7WtxzbrUpSCP+7WG7S/NVhXrHMnnlLcI/RBMQ1exyatoE9ElxdEQK6gZVgv+1pT513G
         u0EZ+X3xeEzzw0zp5bM8qzD7xPJhLWq8NliZAUZBEo5pe87oa08ctcx97+NZ6anAgTz0
         1NrEvcyhbgRv3fzrY6vjSFW5sPi+fJSv+jK35bHv9w3ycViuAZRZ4xkoTKiFDuklUg52
         xLHoUPNfTYVI78kYQATC8X7K2yPNBLcW0b89/MJJYUIghGGahWXCG7Ly6mqQWw5MsOm5
         xUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712114227; x=1712719027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxaRFGmx+WSsmKEhp791K8SdbyUX+9RouzVHok6AmNg=;
        b=Oink6vP/D8woRi4p7k4WnBoGJ2aPff19BON5DZV+mVq8/UNjxee6+KOpS3gmNpLqRd
         WVUYaTy8BCQ85IHYfC8IVsYt89EQSD+3vdUAqsTsgn7/42O0lK1T9nnp2dBx+Sptu2Ed
         OWy9w1864/XnjXnp2j0iJ+HtXqx67AGvjYsTNzws7m64IdwgxLyJGngFFetrNq0YETS3
         vkrkFK49sXixmBUI2W75FA1/S2oDhlUKU2SNFBzTmdz8IOijtMoh76D1Lmwf+sre1sAI
         HDx/fpniDZmAUWoCjmqDYkUk4eI74MtDLxHwVSuTNvjU4hzwjHVgl9sbETRWsF4Dwglc
         V97w==
X-Forwarded-Encrypted: i=1; AJvYcCWCdhGvg9Xbna9j0537w7fS9QTl4YPR+MVOazDX/Gy7RyY6buinFpShQ5h4Hw2GFn3ptnRDxcNpoLsEp1F878dL0n1Md+S3B6qQyeNsOODsh5nhx2tWQ7vNOFxQzpU69Xs7u/FumA==
X-Gm-Message-State: AOJu0Yy4eOs8OF0Iif2zGImgdnu4tUM8nSywNypi8HBLkNSqji8FCBb0
	L0AmPw9VsIFrZ7vwIfVOdtTlpPaG7ntlFz2OT5l8fL9r6+EDKvOVxcOP5elKyclqtmkg4KXXGMS
	/psLyQ+c3CziJqOPtDh1Rx2BLRZs=
X-Google-Smtp-Source: AGHT+IHWRC5LpLfu/wtnI0l/D2WZg+NDAOe9Kd128q9MD+uFGyISgzNo3A4sV+IzL6895DEl8uJ88vz2YXhGAdS5rNQ=
X-Received: by 2002:a0d:d544:0:b0:615:175f:ae2b with SMTP id
 x65-20020a0dd544000000b00615175fae2bmr1530729ywd.2.1712114227362; Tue, 02 Apr
 2024 20:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711953223.git.zhoubinbin@loongson.cn> <edad2bb5b0045c633734c1499fb163c3c6776121.1711953223.git.zhoubinbin@loongson.cn>
 <20240402174051.GA324804-robh@kernel.org> <CAMpQs4K_VSqdm7x=cSyMTBYQyOm=th0YrYKdZ74dp35hyRBXgQ@mail.gmail.com>
In-Reply-To: <CAMpQs4K_VSqdm7x=cSyMTBYQyOm=th0YrYKdZ74dp35hyRBXgQ@mail.gmail.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Wed, 3 Apr 2024 09:16:54 +0600
Message-ID: <CAMpQs4Ks2DLoDEg=wT8Vpc9MrSTV4WQsvC9jHv9d5maVw8WsdA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: pwm: Add Loongson PWM controller
To: Rob Herring <robh@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongson-kernel@lists.loongnix.cn, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 8:37=E2=80=AFAM Binbin Zhou <zhoubb.aaron@gmail.com>=
 wrote:
>
> Hi Rob:
>
> Thanks for your reply.
>
> On Tue, Apr 2, 2024 at 11:40=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> >
> > On Tue, Apr 02, 2024 at 03:58:38PM +0800, Binbin Zhou wrote:
> > > Add Loongson PWM controller binding with DT schema format using
> > > json-schema.
> > >
> > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > ---
> > >  .../devicetree/bindings/pwm/pwm-loongson.yaml | 64 +++++++++++++++++=
++
> >
> > Filename should match compatible.
>
> Emm... How about renaming it as loongson, pwm.yaml?
>
> >
> > >  MAINTAINERS                                   |  6 ++
> > >  2 files changed, 70 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-loongso=
n.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-loongson.yaml =
b/Documentation/devicetree/bindings/pwm/pwm-loongson.yaml
> > > new file mode 100644
> > > index 000000000000..d25904468353
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pwm/pwm-loongson.yaml
> > > @@ -0,0 +1,64 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pwm/pwm-loongson.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Loongson PWM Controller
> > > +
> > > +maintainers:
> > > +  - Binbin Zhou <zhoubinbin@loongson.cn>
> > > +
> > > +description:
> > > +  It is the generic PWM framework driver for Loongson family.
> >
> > That's describing the driver. Not really relevant to the binding.
> >
> Ok ,I will rewrite this part.
>
> >
> > > +  Each PWM has one pulse width output signal and one pulse input
> > > +  signal to be measured.
> > > +  It can be found on Loongson-2K series cpus and Loongson LS7A bridg=
e chips.
> > > +
> > > +allOf:
> > > +  - $ref: pwm.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - const: loongson,ls7a-pwm
> > > +      - items:
> > > +          - enum:
> > > +              - loongson,ls2k0500-pwm
> > > +              - loongson,ls2k1000-pwm
> > > +              - loongson,ls2k2000-pwm
> > > +          - const: loongson,ls7a-pwm
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  '#pwm-cells':
> > > +    const: 3
> >
> > Please define what is in each cell. If there's only 2 signals, then the
> > first cell defines the output or input (what value for which one?).

Hi Rob:

Sorry, the previous email did not answer this question.
The first cell defines the output signal, and its value is 0.

Thanks.
Binbin
> >
> > Really, the PWM binding is only for outputs, so is a cell even needed? =
I
> > suppose we could use it for inputs too, but that's really "input
> > capture" type operation that timers often have. I'll defer to the PWM
> > maintainers...
>
> Ok, I will try to add some description about it.
>
> If I understand correctly, the meaning of each cell in "#pwm-cells"is
> determined.
> The first cell specifies the per-chip index of the PWM to use, the
> second cell is the period in nanoseconds and the third cell is the
> polarity.
>
> >
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - clocks
> > > +  - '#pwm-cells'
> >
> > pwm.yaml makes this required already.
> >
> Yes, this is unnecessary. I will drop it in the next version.
>
> Thanks.
> Binbin
> > Rob
> >

