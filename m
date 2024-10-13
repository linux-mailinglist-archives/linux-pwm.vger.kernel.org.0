Return-Path: <linux-pwm+bounces-3624-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2AF99BBF9
	for <lists+linux-pwm@lfdr.de>; Sun, 13 Oct 2024 23:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BE6282808
	for <lists+linux-pwm@lfdr.de>; Sun, 13 Oct 2024 21:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEF77F48C;
	Sun, 13 Oct 2024 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="imWwclgL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D97139D0B
	for <linux-pwm@vger.kernel.org>; Sun, 13 Oct 2024 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728853942; cv=none; b=RrWzkMrKR1LpZi/g+xYaqmxmpHOj/eMPuH4D3Pe1TRMsHofrQdpvnaJXxvOjyU7S09710y1MuGExIbg6yIjJhdzWjLr6ORsV+oWussZRiTvln+eps91JJ7vptlvnyA0+lumBe9E05ugL/HlgobOIMRiKddjI99+fkyw0uAPLCQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728853942; c=relaxed/simple;
	bh=JpAsQjdO8xDgz+DjNBuDcK+8eQNAm/nQvmxK2hx0Obk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtRKvle7mXJ+OrfEHqrjVGwdnXGhi5UGrNvwHL66qGfoJt4Xk+v+DuSgArNsLfZWZAT13K9YNcFYdaMV3Zzo7ODa/C52iK0mputbElS257mthPfu87aXNG86jmt3AOPX3YUbvyQhEFVWHEpnp/X0uYTctK11mRzwDIjNecRHt10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=imWwclgL; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e8607c2aso1123082e87.3
        for <linux-pwm@vger.kernel.org>; Sun, 13 Oct 2024 14:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728853937; x=1729458737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwQ+0QBqpruUrAoix4rKJMBSmDvfPtsp4gDbiv475pg=;
        b=imWwclgLmB1f33vAaYTs6COSLkFQRzbULOw6bmbLGIGroYsr4RrIVw1nMMcNsL12Bj
         2bT2ae735QKR5hs8oI22iVYc3cvKcsat6IDzmmKLcl21Ev8wxM2cftrVQX3d6pBYmwdl
         5BCEzAMRylWPc1sWfi41WXg9U7mZdLZNSP316fLtguQMr4iADRdDpPHgyZwMpMcELJgR
         rra5Q5Ud8KrP4Cj8jsZy4S+zv7RafFAs1/VytOBhO+Rr3Lq+oBxzZxBDFaGPlHje6BoX
         dq3r97aZIaspDXqwemmkyuvCMU+F77MAASCPGZbtPtBTx7GH6TwWkyQDcQg2rTndTLbD
         +KxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728853937; x=1729458737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwQ+0QBqpruUrAoix4rKJMBSmDvfPtsp4gDbiv475pg=;
        b=bVCBpgoEyXSbaNXLuQfxWh8pnzTjMOVsRzpvCKBN4zYg70pOrS5RzMGygCRmLhGfsY
         BbLuD3BdvKzny1PG415h6eRxEtrowEgmladT7GqXaZSr7H/kxrLfiM3czSjbuRTOP40C
         3hLKbhWm8Btf1R6fTZo2Q+J4X9MI/vVgFvTvI4mRmv7Vkfl6BNwSyWpVmKVWmKjpt7e5
         4hDvNQx4uH3Rb3rnz+uSySNnykIeNOc4kr0Y/bz0NUiheQljPMA+nlGW371rsOJEaT2+
         UyHgmCTOyKdsrBS8SynzPnd6Rmq8JDCK5I7RJhXWTHoY/dpMUudP3wvquOu0Knf7A3yM
         lEWw==
X-Forwarded-Encrypted: i=1; AJvYcCWxOXR4xA0FuXoJwPWSOsn7cbMam4ZlcakDuYncuSwwYUFVKmtfczCPYSPQfnas5zQJedr1s+7/EzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnEOTCdVY+39gabegyIPtcGy02uvvJlRsYKTM6gH0LpSnkrU7c
	2g1pIftLA0pXXQWQFXopMWovtF8ZwdjbKsU7taB4vsLiE4QDa6PsbvO4gruKUbmFVPh0AQNNp7g
	kpuZl0AvdELO+WU8H8s9NRXc9Cx6K/rkZY0kRJQ==
X-Google-Smtp-Source: AGHT+IG22JRYupZ1fLsDed6hOclviXUZ6gkDKTz/1J3tmXWEWFDaDkSBlGmH4CesWUEdr/RrovlO1A4TEXMMoyRsCbs=
X-Received: by 2002:ac2:4e16:0:b0:536:554a:24c2 with SMTP id
 2adb3069b0e04-539da3c5ee1mr4707787e87.13.1728853937291; Sun, 13 Oct 2024
 14:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013-en7581-pinctrl-v6-0-2048e2d099c2@kernel.org> <20241013-en7581-pinctrl-v6-5-2048e2d099c2@kernel.org>
In-Reply-To: <20241013-en7581-pinctrl-v6-5-2048e2d099c2@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 13 Oct 2024 23:12:06 +0200
Message-ID: <CACRpkdZKkv=CKkA1WS4ZwSj8vXzzZFM-uv6eiMeij+fL_cvTzQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] pinctrl: airoha: Add support for EN7581 SoC
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee Jones <lee@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 12:08=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.o=
rg> wrote:

> Introduce pinctrl driver for EN7581 SoC. Current EN7581 pinctrl driver
> supports the following functionalities:
> - pin multiplexing
> - pin pull-up, pull-down, open-drain, current strength,
>   {input,output}_enable, output_{low,high}
> - gpio controller
> - irq controller
>
> Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Co-developed-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Nitpicks follow:

I would have changed the below:

+       pinctrl->gpiochip.data =3D gpio_data_regs;
+       pinctrl->gpiochip.dir =3D gpio_dir_regs;
+       pinctrl->gpiochip.out =3D gpio_out_regs;
+       pinctrl->gpiochip.status =3D irq_status_regs;
+       pinctrl->gpiochip.level =3D irq_level_regs;
+       pinctrl->gpiochip.edge =3D irq_edge_regs;

Can't you just use e.g.

chip->data =3D ... etc in the top section?

+       chip->parent =3D dev;
+       chip->label =3D dev_name(dev);
+       chip->request =3D gpiochip_generic_request;
+       chip->free =3D gpiochip_generic_free;
+       chip->direction_input =3D pinctrl_gpio_direction_input;
+       chip->direction_output =3D airoha_gpio_direction_output;
+       chip->set =3D airoha_gpio_set;
+       chip->get =3D airoha_gpio_get;
+       chip->base =3D -1;
+       chip->ngpio =3D AIROHA_NUM_PINS;

I always call that varible "gc" rather than chip, but no big deal.

+       chip->irq.default_type =3D IRQ_TYPE_NONE;
+       chip->irq.handler =3D handle_simple_irq;
+       gpio_irq_chip_set_chip(&chip->irq, &airoha_gpio_irq_chip);

I usually declare a local variable
struct gpio_irq_chip *girq;

girq =3D &chip->irq;
girq->default_type =3D...

Yours,
Linus Walleij

