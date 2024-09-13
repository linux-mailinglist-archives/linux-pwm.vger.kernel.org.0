Return-Path: <linux-pwm+bounces-3231-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70999782F7
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 16:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A44BB255D5
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 14:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04582629F;
	Fri, 13 Sep 2024 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPmJL5L+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA8EED6;
	Fri, 13 Sep 2024 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239129; cv=none; b=mkHnxxFjk93CUWTkFt0vGgtz93cZOCDJgz52vDxcErCsjvU5VdXbnfdsqjng/jWlPx/4JOB6npId4GQ+HnfOS/biAsbZVVXCPKMPAz4q4u0rdo9q8ekeXMKo2WukSDPvok9c7gordTi3QiGC0F1nFmeZ7+eTsGeNyH8RSwVDYis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239129; c=relaxed/simple;
	bh=N/xGBp+Akf2x8w+9/94FGQTZDsqfmxwzez4y1UP+/QE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCFhJpkvD5KwwpdrsSdffP6atYvisomz0OrGH3DDpTDJvDHrKYGcRedN9+3dNa4Ln+RxC7QCPnN/05cWnlm8BCDZ/6rIP1wT7J3tB3/0mXuhPcRE6KNk3erUmweg3wi33DVnDN4Z95qYeJd29wxduigjxiur2ip9iG3goMPX/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPmJL5L+; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-49bc13c3a47so431440137.3;
        Fri, 13 Sep 2024 07:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726239127; x=1726843927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC7Qi9CJ/UlqMx5HJFGorczxcYiMNzmkMF/PjtSiNQc=;
        b=IPmJL5L+04gC83EmJWm29rUNtery4irTfv6Xk/zS5n3eowIaa6CsvTTkBV2WkWek8V
         Y0wXGApYmUf6Q/EWvW7wUdjYaM7VdYsJlGh3dtnTlPbHyJ7JBhaGdYGMIpg7Th/HdOrq
         LYBrutaaXAz3fIw3veyEemYw0rUpN/ew84Ey0fi6y0L6ECopep0KZAmFCezMwQBUtV6k
         nXegm6dmXfFZd/VtJIjdoZRrPrhdgGvko46y2QvQI01UIi6aA/piykwN6xXArhyxmg1w
         b0jMfVloZVpd8EVfgqAC9o3tR/PNrwyCTFZnVpOkuGnp3CE9+pm7wdgZsFCog2M4TUal
         uu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726239127; x=1726843927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SC7Qi9CJ/UlqMx5HJFGorczxcYiMNzmkMF/PjtSiNQc=;
        b=H6c11HRDRwFOV4HLKNU9jAUKt+dua81y0GOyk5blz6vG+l0qg+hlFTMFGx3i7PCFNW
         EqRaEZy8ZAItkRsVcVLUTKhScAslqkxEfRMzA48GWtRfq5R7Q/v+ynsj6herKiKXzljm
         KuvtlIf1YSQ57LiXLXyhNEHXXyJsCmjfyIlzutu/U2CU5BmB/6pONchFN38LxedZTsrG
         eqaEmCeqExX+V8GBrXnj6RKGaaErnduFzwNBhTNwtBmiCyl3RKeb1NnPFd4ZUs42ia9Q
         KKU6Ghmn/tO5WsCKswg75u1SqNYzz7w7t9AKQaep7jQtByM+qoj2GnC+uNeiMJLua/7k
         a1gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPokIGQIq/NAJsD1Gpkp/6TscdctQ9pnU48LLOFTVQ+9ZDcIhKtC5kD3wYu94zj/TaJgtr1pbHBzsu@vger.kernel.org, AJvYcCUYMiAz5tZBawjr5X4ZK8N9AMmo47YPfyUGCcU8D1vL0P0w8cfX2gULw8U8zxwATGnFWtvX2jAEDFHyC0RP@vger.kernel.org, AJvYcCUomohpmDVKMEesmL81cfkFZZ2vW5wPQsYH6LkVOVPo6eda88qhKJoer5Bi+RBkpDxiTIzcGmGd875e@vger.kernel.org, AJvYcCUqG/6J9y2M/mr6bZeCtHGcyjIE1fL5ZnhD0pekNAQA0Off0F5D7ODSjNbKctV9Fyg7Ok4PjBWcy0Zr@vger.kernel.org, AJvYcCUuV1TE0NfbDttYSLJMYiRssi0fzXzrGLs/5vKClypYaF2X1Krq4noR0RknvloiML04QgvOvDpW2kKiL9i+eBYaSA0=@vger.kernel.org, AJvYcCVjHeGDvMz5cACO+5y2pcLPE2fP02QIIzbJJRZ9Fxz/Yy3QEGgBhazHYwa1ZsTKIy1grpFxNjMntse5qGU=@vger.kernel.org, AJvYcCVjo5ulMq6V0AumAXef8nCmLmZ0ETTOQmOtEBZZnIYDJuEi4Lz4azHYIp2Dm7eFKBqh8WVo2nRQFFhdMg4=@vger.kernel.org, AJvYcCVpE9w8kQ//h/aJ3E5xsEUzmzYfWbMeto/At0C8gj7+2VWt18bnV7Lw4eidhTLUZ+oKBB8VoWi2nE0=@vger.kernel.org, AJvYcCXnxOGyyjk1ffPSZ0jU9lbdoESo5JGGp/eaIyjz4AUYqrdOJHVH+RAJAL9BF7ZyRT+F3jdLF4YnvQZl7F4OIg==@vger.kernel.org, AJvYcCXtHPOAWmKj0dkr
 upoB5srGsNVHjupE0Qr1+FSjQtSnJMcRejmxnPrXCJuQz8bvBvRk1vLfg+4ITHOOCw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8F6z+yyfgnP8PtHBXPYFCB/v8g60xniBP7lnisolRABExAdF4
	+/aVgMhtFL2fqMPhAJUxQ9YfjZAF8SSsjomyd0nDu8fK8shyrZPErDcMcQ0Qadd3YmDOt4XdQGd
	AGeLHvcOtGa9puniCDDyjZ1uwYD0=
X-Google-Smtp-Source: AGHT+IFzt77B+UQvTyXWnWYICtP+/AmJJ5rq6JqNXDt5n+hgGmGESoN8kaR8YY1ZG0wjobVeQOsHMwrHDFFr4Mg31HU=
X-Received: by 2002:a05:6102:e14:b0:49c:1bc:1eff with SMTP id
 ada2fe7eead31-49d4f6fafc6mr2074878137.28.1726239127329; Fri, 13 Sep 2024
 07:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
 <20240618-starqltechn_integration_upstream-v3-4-e3f6662017ac@gmail.com> <13a650f4-7ca7-4c95-b536-9814a22f00ff@kernel.org>
In-Reply-To: <13a650f4-7ca7-4c95-b536-9814a22f00ff@kernel.org>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 17:51:56 +0300
Message-ID: <CABTCjFCOTd5V5WyRbD1OCS9Hatk0mOCtNy5WWfp0KkUBgqXs+A@mail.gmail.com>
Subject: Re: [PATCH v3 04/23] dt-bindings: mfd: add maxim,max77705
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
	phone-devel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 20 =D0=B8=D1=8E=D0=BD. 2024=E2=80=AF=D0=B3. =D0=B2 18:46, Krz=
ysztof Kozlowski <krzk@kernel.org>:
>
> On 18/06/2024 15:59, Dzmitry Sankouski wrote:
> > maxim,max77705 is MAX77705 pmic binding part
> >
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > ---
> >  .../devicetree/bindings/mfd/maxim,max77705.yaml    | 112 +++++++++++++=
++++++++
>
> Your patch order is totally messed. Not tested by automation. Only
> limited review follows.
>
Hmm, not sure what was wrong. I sent version 4 to myself with `b4 send
--reflect`, the order looks good.

--=20

Best regards,
Dzmitry

