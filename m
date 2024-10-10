Return-Path: <linux-pwm+bounces-3590-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49698999268
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2024 21:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA047285A49
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2024 19:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7991C1CF2A3;
	Thu, 10 Oct 2024 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SGOLSQT2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDBA1CEAD2
	for <linux-pwm@vger.kernel.org>; Thu, 10 Oct 2024 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588882; cv=none; b=L0xX/G/w7ch6vyWTz0XvlnVX5QppWNX9r9MOoi28v9ug1FLU+0Ce2u61b7dT2SvIY+yhyp5qUxtRg7Q+zt4jwJETu0mo9D/hXN+/T3ftF72SF3opfVEK4C3YVhe7WzHUDlOZDLfUwnAGKFBYIYOgIA6mnSMMlGQZl2B56feF9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588882; c=relaxed/simple;
	bh=ZeN5bSUi0fQKL/SQ+c6h3kEmojKWQrnugrTlqOAnHnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HruARZCTzvQOuVX9N3HGqtdqnHpAzoe3HmZC1bKmCJYMqjZuT2msYdQx25790qHFEtnKkrv4tc5GS4yR9RHisAYeCh9g/2WpdVjAzB6dICxbc2fvYlw+2zL6ofzqIM8yUcj77D96gdQA+G3luE0u2p+JwOvnoZgeJZGG7xbXlBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SGOLSQT2; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2facf48166bso14499871fa.0
        for <linux-pwm@vger.kernel.org>; Thu, 10 Oct 2024 12:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728588879; x=1729193679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQq6z3ygsMPz3YqMkjOj9nbopV+BNnluNPMVMs2m49Q=;
        b=SGOLSQT2i7tz2l9ossAFDIOauiT0TZvMKygVgvdyljMbyJACFSMdUgh3tzVDF+0uay
         9GzJW0IRU5WuJvGSDz943CtpLaDeEX1b/q/8TNm3SlykGqdCznxRiW4LJEHjMsMczlhb
         LgiBBLDZ5e81m6k9+/cD4cEbkfVYxh+tkAg4uvENkjyMgv7bUr+BBO1nyrlLTaqWCXJi
         eafs0yQW2ctqmsbGXXAmmP2/LWf8WD9pZPzSzKyZFZybo+4GiTmNuBqCqCqOTTQyi3ly
         3sqGuXtNExudN2Dft6gEgLkRz6E3Ur+xqlOQyKbKWBNI7tc+7ZswMMTz3v2kwvYK9Oz2
         dBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728588879; x=1729193679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQq6z3ygsMPz3YqMkjOj9nbopV+BNnluNPMVMs2m49Q=;
        b=dy8t+ctUVJ+RDbB7kD+amiPN/w0kh8mELJXq7PuzksLF0gvR70Fo/w5jb/OL6X5qzZ
         fp/jqd1ZF1HbTjlPlPlRaShd5ZmXljjwHxWzX7CyalNwAE+/jH7M9u4zRNCUMw8fnUhK
         hla9TZVICBN0b7LO/dU0YwmTrFfgl1lFHez4VOV/TZpXGOQTXdzMKmsCEaNdd7Wx0sq4
         JigNSvgcDnc9W2yotixWvI6ejVP3TL15PM1a5mtrxxjwetUvsXigSEpnKXr4Qo4oCLsU
         k4si8TFM3FB8yjn8Pz14vKPNaPdyMAvLv3fC+UAx8985KuGoBLO8f9+2Kl7XtYMjLhh4
         3voQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKWsauZgTw/5eU2/2Qhlw2lfevRY5rc2RTq1CuJ2c5Za57MVc7g66QEjImyiSCtO0Jnvsl1NMFhbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywng84iqPhKfxWglHi8wdEdptqV08z/oJF2YU2nNfbazGdNANIH
	pMPszpvqOMvXrY6NA/RmlwfZQd/TkixPOiRvpnmWGxol5uTGkt1IHkw9rJ/jcTIh7MIGfIdvWuv
	k7Yl7fkx6kZw0tnOTxMYhCQRGSe8V0BQifwz2Ww==
X-Google-Smtp-Source: AGHT+IGzJnKBr8EbYHzKmabwtIiY3NDZ6btpJ38bRunXPDbntBAO6WkgR8iAwZj51AAJj3L9eS8HKDnSVkvHZFdWbzY=
X-Received: by 2002:a05:651c:2126:b0:2fa:e7f2:764b with SMTP id
 38308e7fff4ca-2fb187ac0d8mr49847661fa.33.1728588878809; Thu, 10 Oct 2024
 12:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org>
 <20241001-en7581-pinctrl-v5-3-dc1ce542b6c6@kernel.org> <20241002132518.GD7504@google.com>
 <ZwWscWk5axQI9H1t@lore-desk> <20241009104821.GF276481@google.com>
 <20241009105550.GG276481@google.com> <6707a8ec.df0a0220.376450.293e@mx.google.com>
In-Reply-To: <6707a8ec.df0a0220.376450.293e@mx.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 21:34:27 +0200
Message-ID: <CACRpkdanpA-wq0sYv9HRF=uVeAX_mW4LaKhE8i6TgC9+0d7bCg@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] mfd: airoha: Add support for Airoha EN7581 MFD
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	upstream@airoha.com, benjamin.larsson@genexis.eu, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 12:14=E2=80=AFPM Christian Marangi <ansuelsmth@gmai=
l.com> wrote:

> mfd: system-controller@1fbf0200 {

Drop the mfd: thing, you probably don't want to reference the syscon
node directly
in the device tree. If you still give it a label just say
en7581_syscon: system-controller...

>         compatible =3D "syscon", "simple-mfd";
>         reg =3D <0x0 0x1fbf0200 0x0 0xc0>;
>
>         interrupt-parent =3D <&gic>;
>         interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>
>         gpio-controller;
>         #gpio-cells =3D <2>;
>
>         interrupt-controller;
>         #interrupt-cells =3D <2>;
>
>         gpio-ranges =3D <&mfd 0 13 47>;

I think you want a separate GPIO node inside the system controller:

  en7581_gpio: gpio {
         compatible =3D "airhoa,en7581-gpio";
         interrupt-parent =3D <&gic>;
         interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;

         gpio-controller;
         #gpio-cells =3D <2>;

         interrupt-controller;
         #interrupt-cells =3D <2>;

         gpio-ranges =3D <&en7581_pinctrl 0 13 47>;
};

So users pick GPIOs:

foo-gpios =3D <&en7581_gpio ...>;

Notice that the gpio-ranges should refer to the pin controller
node.

>
>         #pwm-cells =3D <3>;

Shouldn't this be inside the pwm node?

         en7581_pwm: pwm {
                 compatible =3D "airoha,en7581-pwm";
                 #pwm-cells =3D <3>;
         };

So PWM users can pick a PWM with pwms =3D <&en7581_pwm ...>;

>         pio: pinctrl {

I would use the label en7581_pinctrl:

>                 compatible =3D "airoha,en7581-pinctrl";
>
>                 mdio_pins: mdio-pins {
>                         mux {
>                                 function =3D "mdio";
>                                 groups =3D "mdio";
>                         };
>
>                         conf {
>                                 pins =3D "gpio2";
>                                 output-high;
>                         };
>                 };
>
>                 pcie0_rst_pins: pcie0-rst-pins {
>                         conf {
>                                 pins =3D "pcie_reset0";
>                                 drive-open-drain =3D <1>;
>                         };
>                 };
>
>                 pcie1_rst_pins: pcie1-rst-pins {
>                         conf {
>                                 pins =3D "pcie_reset1";
>                                 drive-open-drain =3D <1>;
>                         };
>                 };
>         };
>
>         pwm {
>                 compatible =3D "airoha,en7581-pwm";
>         };
> };

This will make subdevices probe and you can put the pure GPIO
driver in drivers/gpio/gpio-en7581.c

Yours,
Linus Walleij

