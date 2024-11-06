Return-Path: <linux-pwm+bounces-4039-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B6D9BEF62
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2024 14:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417E91F21639
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2024 13:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6761FBF73;
	Wed,  6 Nov 2024 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z+cJjoeQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE3F1FBF59
	for <linux-pwm@vger.kernel.org>; Wed,  6 Nov 2024 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900737; cv=none; b=hg+W6atLfderBCZVy/WutsVjCc4i+XN2Zkn5UlbvwYqx+3S2PVXEKG+uRYfZ0m2BXn7uR5yej0TgYdADq3GBxtSbTMgTP98Im+QVNLtm0Udwsy2MfnQQ5jMhDcf+eyWo/WaEwF45rz40zbXluQuF2amZd4uMFWuw2Csrbc5Uoc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900737; c=relaxed/simple;
	bh=oe4ysEbOGugDdM+rEZI4gTDxZGKfGa+ZNN+0xqDf504=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNyYg/3xVfIg/ZydvL4XBzbbjfGe/KNealpO5gQO1fnfyqYYu8BpUGAO3ul7uOs2vf+TbXsWCvxMGtboXSdk9JcnpahotfGtqZTeDU44hqeq9p/hQHmO8MmEPqk5ewWXRgtvTXS4zsNyTu5LMQsGC7RCdhDEzxJOsqqCRsi/iBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z+cJjoeQ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb3110b964so56306721fa.1
        for <linux-pwm@vger.kernel.org>; Wed, 06 Nov 2024 05:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730900733; x=1731505533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ns1m01mlBn0TEXlYPEz7IqH4BJxD81zb8MxCwYwjObU=;
        b=Z+cJjoeQqf2SQFRLbSVXXzb4oAx36HxhUJ0ZApUEO40/TpA3i3YbMpVB67u3ZuoI3I
         QLxECA1i1pkCLsqZ+EeBrgbI/coK13307FMpRWZAaV8mYGcjeauTjd8G6CNlL5QIAdmh
         g+D8gNKVBxsGoPjWWmIne0LLchn5oJ4X2XswTwDlXvrtKgeQI/3jlA+xJ0htoq7U0GN4
         962txxxBA93/Wd7qz2npkI7TbNcwJpgpqw/sdq4M45cSzv6RSMUeIyLscQMHqpW6W/h7
         LzHaVtSk76nvzBtMe5EF0WJDGbmsMkgeajHkyZeoOa4JnmPyv+IRKRa5qj3Jh5gLfZ/r
         qAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730900733; x=1731505533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ns1m01mlBn0TEXlYPEz7IqH4BJxD81zb8MxCwYwjObU=;
        b=EQCYC79uFODiPMEGItdvJdYl6JQm0G+tBD9crQxK6wrkYYonfUaYd4UAsKzdgJlEmp
         mrvWhyFCQXua7oo+yjRlnDRsOn2RQ4KiUqpoiJoebvZs8lMkbE4pgsvQXwwFiCnXKLKn
         ZcqJfyQiGlf43/Frm3MrCCrZ0/LEzRmkpC+XT6SFCGM29a1iDg/0jSeniVjSzR4XJsPM
         6V02NRxyCBdBSs3uHEYtM1AtZLbe77owjmoEew1AMeodYoV7u4IcxBO8UnopqBpXHP/K
         dO0pFNYbOki/JMUT38I1EJ6f8GanGm4Yvkl5wncwlSN86G+z+FAdSen7xfASEhhuMreQ
         YzBw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ6nLIruvHdwwj8nE9CJO10xjmyRMT3Up4ad3TBZ8o3irlxqCxR6jL3021UugLXQKgTJZs70DKDKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn3bD+lQojrwm02bK485LrH5gGVlw+hMxfv7bY9ggoFULQiYA5
	YSjNANDC6IxtGXozgnFk05s6Rg1eXGDPwpXYUD4xmmQ8dkHFIukinyZvj19XbJELSOCgMrzVMwl
	f1yDEJroAVWVYamIW3d2cqX0ySLFpFpnt/+rxpA==
X-Google-Smtp-Source: AGHT+IHvynIL7AAsGHjP0xg8VCy9NFb8IBkKD896d3DxIuwUkQ972HHVN3qYlfPKYVhD5LyxxH0ykk/nP4raab/ulSQ=
X-Received: by 2002:a05:651c:19ab:b0:2ef:243b:6dce with SMTP id
 38308e7fff4ca-2fedb770dfdmr103418931fa.10.1730900733100; Wed, 06 Nov 2024
 05:45:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
 <20241023-en7581-pinctrl-v9-4-afb0cbcab0ec@kernel.org> <173088099542.3237297.18018729158887853624.b4-ty@kernel.org>
 <ZyssJpR7xwbMzUsm@lore-desk> <20241106110046.GR1807686@google.com>
In-Reply-To: <20241106110046.GR1807686@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Nov 2024 14:45:21 +0100
Message-ID: <CACRpkdbf4Pb+n-F-K-JaUvytwCGUHHh8d2rYP4A9KgVTzqSnGw@mail.gmail.com>
Subject: Re: (subset) [PATCH v9 4/6] dt-bindings: mfd: Add support for Airoha
 EN7581 GPIO System Controller
To: Lee Jones <lee@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 12:00=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
> On Wed, 06 Nov 2024, Lorenzo Bianconi wrote:
>
> > On Nov 06, Lee Jones wrote:
> > > On Wed, 23 Oct 2024 01:20:04 +0200, Lorenzo Bianconi wrote:
> > > > Add support for Airoha EN7581 GPIO System Controller which provide =
a
> > > > register map for controlling the GPIO, pinctrl and PWM of the SoC v=
ia
> > > > dedicated pinctrl and pwm child nodes.
> > > >
> > > >
> > >
> > > Applied, thanks!
> > >
> > > [4/6] dt-bindings: mfd: Add support for Airoha EN7581 GPIO System Con=
troller
> > >       commit: f49f37f3cfe1482d4dc77d26f3e8c38eab630d52
> > >
> > > --
> > > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> > >
> >
> > Hi Lee,
> >
> > according to my understanding this patch has been already applied by Li=
nus
> > here:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.gi=
t/commit/?h=3Ddevel&id=3D50dedb1eb1e6755ccab55f6140916c2d192be765
>
> An interesting choice.  Linus?

Yes I suggested that I merge patches 1-5 on oct 29 and applied the
day after:
https://lore.kernel.org/linux-gpio/CACRpkdYshPusdA7bDW2y8H_wp-Fm3N-YCsY1_Qn=
=3DdZqRiFy12w@mail.gmail.com/

It's because the bindings are dependent on each other, this one patch has:

+  pinctrl:
+    type: object
+    $ref: /schemas/pinctrl/airoha,en7581-pinctrl.yaml
+    description:
+      Child node definition for EN7581 Pin controller
+
+  pwm:
+    type: object
+    $ref: /schemas/pwm/airoha,en7581-pwm.yaml
+    description:
+      Child node definition for EN7581 PWM controller

Those refs will explode unless the two others are merged at the same
time.

Usually we merge the whole shebang through MFD but this one felt
different because there is no actual MFD driver, just using simple-mfd.

In hindsight I should probs not have been so trigger happy and give
some more time for this to settle... Merge window stress I guess. :/

It's fine to apply textually identical patches to two trees though as
git will sort
that out so technically it's no big deal, you can keep it applied if you
want.

Yours,
Linus Walleij

